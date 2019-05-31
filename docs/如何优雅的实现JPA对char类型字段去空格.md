### 一、引言
作为程序员，不可避免的会接触到遗留系统，表字符串字段类型定义成char的情况。通常情况下，对应定长的char字段的数据，需要程序进行去空格，但是每个char字段都进行trim操作，程序结构不够优雅。那么如何优雅的实现char字段的trim呢？

### 二、去空格常见的写法
当Hibernate/JPA遇上char类型时，典型的写法是在实体类的get()方法中进行处理。假定name字段对应表字段类型char。那么看一下常见的去空格写法，示例如下：

	@Entity
	public class PExampleEntity {
	
		private String id;
		private String name;
	
		@Id
		public String getId() {
			return id;
		}
	
		public void setId(String id) {
			this.id = id;
		}
	
		public String getName() {
			if (null != name) { //此处对char字段进行去空格。
				return name.trim();
			}
			return name;
		}
	
		public void setName(String name) {
			this.name = name;
		}
	
	}

看完上述例子，如果遗留表比较复杂，在每一个get方法上增加一段相识逻辑是很折磨的事。

### 三、如何优雅的去空格
在寻找解决方法时，在网络找到了多个不同版本去空格方式，经过验证均存在一些副作用或者隐患(后续专写一篇验证过程)。通过查看Hibernate源码，总结了自己的解决方法，虽然还存在小瑕疵。接下来说说解决思路：即仿照Hibernate对String类型的处理，通过注解@Type指定字段类型，进行去空格。

具体实现如下：

1. 定义TrimString的Java类型的描述符处理器。
	
	* 复制StringTypeDescriptor代码，将类名改成TrimStringTypeDescriptor。

	* 修改wrap方法，对字符串类型进行trim()去空格。


			public class TrimStringTypeDescriptor extends AbstractTypeDescriptor<String> {
			
			  public static final TrimStringTypeDescriptor INSTANCE = new TrimStringTypeDescriptor();
			
			  public TrimStringTypeDescriptor() {
			    super(String.class);
			  }
			
			  public String toString(String value) {
			    return value;
			  }
			
			  public String fromString(String string) {
			    return string;
			  }
			
			  public <X> X unwrap(String value, Class<X> type, WrapperOptions options) {
				//... 此时省略点代码
			  }
			
			  public <X> String wrap(X value, WrapperOptions options) {
			    if (value == null) {
			      return null;
			    }
			    if (String.class.isInstance(value)) {
				  // return (String) value; // 修改前
			      return ((String) value).trim(); //修改后
			    }
			    if (Reader.class.isInstance(value)) {
			      return DataHelper.extractString((Reader) value);
			    }
			    if (Clob.class.isInstance(value) || DataHelper.isNClob(value.getClass())) {
			      try {
			        return DataHelper.extractString(((Clob) value).getCharacterStream());
			      } catch (SQLException e) {
			        throw new HibernateException("Unable to access lob stream", e);
			      }
			    }
			
			    throw unknownWrap(value.getClass());
			  }
			}


2. 定义TrimStringType类型映射char/varchar与String。

	* 复制StringType代码，将类名改成TrimStringType。
	* 修改TrimStringType构造方法，将StringTypeDescriptor.INSTANCE修改为TrimStringTypeDescriptor.INSTANCE。
	* 修改getName()方法。


			public class TrimStringType extends AbstractSingleColumnStandardBasicType<String> implements
			    DiscriminatorType<String> {
			
			  public static final String TYPE_NAME = "net.geektao.jpa.hibernate.TrimStringType";
			
			  public TrimStringType() {
				// 此处，TrimStringTypeDescriptor.INSTANCE
			    super(VarcharTypeDescriptor.INSTANCE, TrimStringTypeDescriptor.INSTANCE);
			  }
			
			  public String getName() {
			    return "trimString";
			  }
			
			  @Override
			  public String objectToSQLString(String value, Dialect dialect) throws Exception {
			    return '\'' + value + '\'';
			  }
			
			  public String stringToObject(String xml) throws Exception {
			    return xml;
			  }
			
			  public String toString(String value) {
			    return value;
			  }
			}


3. 配合Hibernate注解@Type在方法或属性指定类型。

		@Entity
		public class PExampleEntity {
		
			private String id;
			private String name;
		
			@Id
			public String getId() {
				return id;
			}
		
			public void setId(String id) {
				this.id = id;
			}
		
			@Type(type = TrimStringType.TYPE_NAME)
			public String getName() {
				return name;
			}
		
			public void setName(String name) {
				this.name = name;
			}
		
		}

	提示：由于@Type注解参数type需要指定完整类名，在TrimStringType中增加常量方便使用。



4. 参考资料
	* https://stackoverflow.com/questions/5725491/trim-string-field-in-jpa
