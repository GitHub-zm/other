
## Tomcat配置JMX
配置JMX用于远程JMX监控tomcat运行状态（内存使用率等。）,以及可以结合zabbix进行监控。


* lib下增加jmx支持的catalina-jmx-remote.jar包。[Tomcat7.0.90下载地址](https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.90/bin/extras/catalina-jmx-remote.jar)

	jar包存放路径：tomcat/lib

* 文件路径：tomcat/bin/catalina.sh
               
	JAVA_OPTS中增加配置项：
	-Djava.rmi.server.hostname=【所在机器IP】 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false

* 修改server.xml配置，路径：tomcat/conf/server.xml  

		<Server port="8105" shutdown="SHUTDOWN">
		...
		<Listener className="org.apache.catalina.mbeans.JmxRemoteLifecycleListener"
		rmiRegistryPortPlatform="【注册端口，客户端连接用】" rmiServerPortPlatform="【服务端口】" />
		...
		</Server>



## 参考
* [官网Enabling_JMX_Remote](http://tomcat.apache.org/tomcat-7.0-doc/monitoring.html#Enabling_JMX_Remote)