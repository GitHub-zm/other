## 简介
本文主要介绍一下Spring 3.2.x 升级到 Spring 4.3.x的内容。

## 版本变化
1. Spring 3.2.9.RELEASE -> 4.3.18.RELEASE
2. spring security 3.2.5.RELEASE -> 4.2.7.RELEASE
2. javax.ws.rs-api 2.0.m10 -> 2.0.1
3. cxf 2.7.10 -> 3.1.16
4. jackson2 2.4.4 -> 2.6.7

## Spring版本升级
Spring 3.x和4.x模块划分无变化，修改版本号即可。但是部分依赖的其他组件需要升级。

## Spring Security
Spring升级后，Spring Security相应的升级到新的匹配版本。

* 关闭CSRF功能

	由于升级Spring Security 4.2.x 默认开启CSRF，导致请求报错。解决方式，显式的关闭csrf功能,配置如下：

		<sec:http auto-config="true">
		  <!-- 省略其他配置 -->
	      <!-- 关闭csrf功能 -->
		  <sec:csrf disabled="true"/>
		</sec:http>

	[参考：升级到Spring Security 4.2的坑及解决办法](https://blog.csdn.net/yiifaa/article/details/71744120)

    [参考：Spring Security4 CSRF 如何关闭CSRF功能](https://blog.csdn.net/zeroso/article/details/78007790)


## Java RS接口版本升级
RS服务接口需要升级到2.0.1,因为Cxf版本3.x需要新版本。

      <dependency>
        <groupId>javax.ws.rs</groupId>
        <artifactId>javax.ws.rs-api</artifactId>
        <version>2.0.1</version>
      </dependency>

注：不能最新的2.1，因此此版本JDK 1.8+

## CXF版本升级
cxf 2.x 到 3.x变化比较大。

* groupId和artifactId发生了变化。
* 客户端和服务单分开。

原依赖：

	<dependency>
	  <groupId>org.apache.cxf</groupId>
	  <artifactId>cxf-bundle-jaxrs</artifactId>
	  <version>2.7.10</version>
	</dependency>

新依赖：

	<dependency>
	  <groupId>org.apache.cxf</groupId>
	  <artifactId>cxf-rt-frontend-jaxrs</artifactId>
	  <version>3.1.16</version>
	</dependency>

	<dependency>
	  <groupId>org.apache.cxf</groupId>
	  <artifactId>cxf-rt-rs-client</artifactId>
	  <version>3.1.16</version>
	</dependency>

### XML原配置
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	  xmlns:jaxrs="http://cxf.apache.org/jaxrs"
	  xsi:schemaLocation="
	http://www.springframework.org/schema/beans 
	http://www.springframework.org/schema/beans/spring-beans.xsd
	http://cxf.apache.org/jaxrs
	http://cxf.apache.org/schemas/jaxrs.xsd">
	
	  <jaxrs:client id="hdpos-qianfan.rs.service.shopService"
	    address="${hdpos.qianfan.service.url}" serviceClass="com.hd123.hdpos.qianfan.rs.shop.RsShopService">
	    <jaxrs:providers>
	      <ref bean="qianfanJsonProvider" />
	    </jaxrs:providers>
	    <jaxrs:inInterceptors>
	      <bean class="org.apache.cxf.interceptor.LoggingInInterceptor" />
	    </jaxrs:inInterceptors>
	    <jaxrs:outInterceptors>
	      <bean class="org.apache.cxf.interceptor.LoggingOutInterceptor" />
	      <bean class="com.hd123.orchid.trace.cxf.TraceOutInterceptor" />
	    </jaxrs:outInterceptors>
	  </jaxrs:client>
	
	</beans>

### XML新配置
主要改变schema定义路径“http://cxf.apache.org/jaxrs-client”。

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	  xmlns:jaxrs="http://cxf.apache.org/jaxrs-client"
	  xsi:schemaLocation="
	http://www.springframework.org/schema/beans 
	http://www.springframework.org/schema/beans/spring-beans.xsd
	http://cxf.apache.org/jaxrs-client
	http://cxf.apache.org/schemas/jaxrs-client.xsd">
	
	  <jaxrs:client id="hdpos-qianfan.rs.service.shopService"
	    address="${hdpos.qianfan.service.url}" serviceClass="com.hd123.hdpos.qianfan.rs.shop.RsShopService">
	    <jaxrs:providers>
	      <ref bean="qianfanJsonProvider" />
	    </jaxrs:providers>
	    <jaxrs:inInterceptors>
	      <bean class="org.apache.cxf.interceptor.LoggingInInterceptor" />
	    </jaxrs:inInterceptors>
	    <jaxrs:outInterceptors>
	      <bean class="org.apache.cxf.interceptor.LoggingOutInterceptor" />
	      <bean class="com.hd123.orchid.trace.cxf.TraceOutInterceptor" />
	    </jaxrs:outInterceptors>
	  </jaxrs:client>
	
	</beans>

## jackson2 版本
由于新的Spring要求jackson至少2.6。
