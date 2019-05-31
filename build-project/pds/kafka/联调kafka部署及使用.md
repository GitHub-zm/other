

## Centos7下安装docker
### 查看系统版本

	lsb_release -a

### 防火墙状态

	systemctl stop firewalld.service    # 关闭防火墙
	systemctl disable firewalld.service  # 禁止开机启动

### 编辑SELINUX
1. vi /etc/selinux/config # 编辑

		# SELINUX=enforcing # 注释掉
		# SELINUXTYPE=targeted # 注释掉
		SELINUX=disabled # 增加

2. setenforce 0 # 使配置立即生效

### 安装docker
  
	yum -y install docker  # 安装docker

### 重启Linux服务器（不重启可能存在docker启动报错的情况）

	reboot

### 启动docker服务

	service docker start                          # 启动docker

### 加入开启启动

	systemctl enable docker.service # 设置docker服务开机自启动


## 镜像安装
### 增加hosts
	
	vi /etc/hosts

	118.178.164.30  harbor-storage.oss-cn-hangzhou-internal.aliyuncs.com #新增

### 登录千帆私服

	docker  login harborka.qianfan123.com

### 下载zookeeper镜像

	docker pull harborka.qianfan123.com/component/zookeeper:dly_3.4.6


### 下载kafka镜像

	docker pull harborka.qianfan123.com/component/kafka:2.11



## 配置

### zookeeper命令
1. 创建容器（首次创建后，如启动参数、版本等无变化情况下无需再次创建），创建后，自动运行。

	docker run -d --restart=on-failure:3 --restart=always -p 2181:2181 -v /data/heading/zookeeper/config/zoo.cfg:/opt/zookeeper-3.4.6/conf/zoo.cfg -v /data/zkdata:/data/zkdata -v /data/zkdatalog:/data/zkdatalog --name zookeeper harborka.qianfan123.com/component/zookeeper:dly_3.4.6

* 说明：
	* 数据目录：/data/zkdata
	* 日志目录：/data/zkdatalog
	* 配置文件目录：/data/heading/zookeeper/config/zoo.cfg

2. 启动容器

	docker start zookeeper

3. 停止容器

	docker stop zookeeper

4. 移除容器（如果启动参数、版本等有变化，先移除，后创建。）

	docker rm zookeeper

## node：master
### kafka命令
1. 创建容器（首次创建后，如启动参数、版本等无变化情况下无需再次创建）

	docker run -d -p 9092:9092 -p 7203:7203 --restart=on-failure:3 --restart=always -m 1g -v /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime -e JAVA_RMI_SERVER_HOSTNAME=172.17.230.209 -e JMX_PORT=7203 -v /data/kafka-data/master:/data/kafka-data -v /data/kafka-logs/master:/opt/heading/kafka/logs -v /data/heading/kafka/master/server.properties.template:/opt/heading/kafka/config/server.properties.template --name kafka-master harborka.qianfan123.com/component/kafka:2.11

* 说明：
	* kafka数据目录：/data/kafka-data/master
	* kafka日志目录：/data/kafka-logs/master
	* 配置文件目录：/data/heading/kafka/master/server.properties.template

2. 启动容器

	docker start kafka-master

3. 停止容器

	docker stop kafka-master

4. 移除容器（如果启动参数、版本等有变化，先移除，后创建。）

	docker rm kafka-master

## node：slave
### kafka命令
1. 创建容器（首次创建后，如启动参数、版本等无变化情况下无需再次创建）


	docker run -d -p 9094:9092 -p 7205:7203 --restart=on-failure:3 --restart=always -m 1g -v /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime -e JAVA_RMI_SERVER_HOSTNAME=172.17.230.209 -e JMX_PORT=7203 -v /data/kafka-data/slave:/data/kafka-data -v /data/kafka-logs/slave:/opt/heading/kafka/logs -v /data/heading/kafka/slave/server.properties.template:/opt/heading/kafka/config/server.properties.template --name kafka-slave harborka.qianfan123.com/component/kafka:2.11

* 说明：
	* kafka数据目录：/data/kafka-data/slave
	* kafka日志目录：/data/kafka-logs/slave
	* 配置文件目录：/data/heading/kafka/slave/server.properties.template

2. 启动容器

	docker start kafka-slave

3. 停止容器

	docker stop kafka-slave

4. 移除容器（如果启动参数、版本等有变化，先移除，后创建。）

	docker rm kafka-slave
