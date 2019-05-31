
问题：当实体指定的表名或字段名为SQL关键字时，hibernate建表失败。

解决方法有三种：

### 一、将表名或字段名用方括号（[]）括起来。
xml配置：

	<property name="desc" type="string" >
	<column name="[DESC]" length="255" not-null="true" />
	</property>


注解：

	@Column(name = "[DESC]", nullable = false)   
	public String getDesc() { return this.desc; }  



### 二、将表名或字段名用两个重音符号（`）括起来

重音符号键即是键盘上“1”键左边的、“Tab”键上边的那个键。此符号亦被称为“反向引号”。

xml配置：

	<property name="desc" type="string" >   
	<column name="`DESC`" length="255" not-null="true" />   
	</property>  



注解：

	@Column(name = "`DESC`", nullable = false)   
	public String getDesc() { return this.desc; }  


### 三、将表名或字段名用双引号（"）括起来
xml配置：

	<property name="desc" type="string" >
	<column name='"DESC"' length="255" not-null="true" /> 
	</property>


注解：

	@Column(name = "\"DESC\"", nullable = false)
	public String getDesc() { return this.desc; }

