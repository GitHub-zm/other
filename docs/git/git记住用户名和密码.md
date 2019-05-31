转自：https://blog.csdn.net/qq_28602957/article/details/52154384

在使用git时，如果用的是HTTPS的方式，则每次提交，都会让输入用户名和密码，久而久之，就会感觉非常麻烦，那么该如何解决呢？

### 方式一：Git Credential Manager for Windows
* 下载及安装Git-Credential-Manager-for-Windows安装包  
* 首次git克隆检出项目代码时输入访问git的用户名和密码即可  

另附：可在“控制面板”-“凭据管理器”-“普通凭据”模块查看记录的git用户名及密码，后期更改密码在此位置更改。  
svn存放路径：  
http://hddenv02/svn/hdposedu/0.环境/0.入职软件/Git-Credential-Manager-For-Windows-1.16.2.exe  

### 方式二：使用SSH，添加ssh key。
### 方式三：在全局中存储用户的账号密码，方式如下
在%HOME%目录中，一般为C:\users\Administrator，也可以是你自己创建的系统用户名目录，反正都在C:\users***中。创建.git-credentials文件。

Windows中创建以.开头的文件的方法：

1：新建test.txt记事本，然后另存为.git-credentials

示例

![git记住用户名和密码](./images/git记住用户名和密码.png)

2：使用git bash

	touch .git-credentials

创建完成后，在该文件中输入：

	https://username:password@github.com

注：username对应你的用户名，password对应你的密码

然后再进入git bash中

	git config --global credential.helper store

store为永久存储，当然也可以设置临时的

	git config –global credential.helper cache

默认为15分钟，如果想设置保存时间的话，可以输入：

	git config credential.helper ‘cache –timeout=3600’

这样就设置了一个小时的有效时间。

执行完后查看%HOME%目录下的.gitconfig文件，会多了一项：

	[credential]helper=store

重新开启git bash会发现git push时不用再输入用户名和密码

### 方式四：单独对某个项目免密
如果还未添加远程地址，可以输入一下命令：

	git remote add origin https://username:password@git.oschina.net/diligentyang/ysy107lab.git 

如果已添加远程地址

最为简单的方式就是，直接在.git/config文件中进行修改，按如上格式，添加用户名和密码