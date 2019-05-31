## catalina.out日志输出关闭

* 文件路径：tomcat/bin/catalina.sh
* 修改配置如下：

		if [ -z "$CATALINA_OUT" ] ; then
		#  CATALINA_OUT="$CATALINA_BASE"/logs/catalina.out
		   CATALINA_OUT=/dev/null
		fi