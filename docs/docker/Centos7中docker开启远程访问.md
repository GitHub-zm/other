首先，centos中docker的配置不同于ubuntu，在centos中没有/etc/default/docker，另外在centos7中也没有找到/etc/sysconfig/docke这个配置文件。
参考了网上的文章，配置好了centos7的docker远程访问，配置过程如下。

在作为docker远程服务的centos7机器中配置：

1. 在/usr/lib/systemd/system/docker.service，配置远程访问。主要是在[Service]这个部分，加上下面两个参数
	
		# vim /usr/lib/systemd/system/docker.service
	
		[Service]
		ExecStart=
		ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock

2. docker重新读取配置文件，重新启动docker服务

		# systemctl daemon-reload
		# systemctl restart docker
3. 查看docker进程，发现docker守护进程在已经监听2375的tcp端口

		# ps -ef|grep docker
		root 26208 1 0 23:51 ? 00:00:00 /usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock