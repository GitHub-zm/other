## IntelliJ IDEA介绍
IDEA全称IntelliJ IDEA（JetBrains公司旗下的产品），是Java编程语言开发的集成环境。“Capable and Ergonomic IDE for JVM”[官网](https://www.jetbrains.com/idea/),适用于JVM的功能强大且符合人体工程学(Human Engineering)的IDE（Integrated Development Environment-集成开发环境）。


## IDEA安装

* [下载](https://www.jetbrains.com/idea/download/#section=windows) ![旗舰版](img/1.png)


* 安装

![忽略文件关联](img/2.png)

* 目录结构

![idea安装目录结构](img/3.png)

	bin：容器，执行文件和启动参数等
	help：快捷键文档和其他帮助文档
	jre64： 64 位 java 运行环境
	lib： idea 依赖的类库
	license：各个插件许可
	plugin：插件

其中：bin目录下

![bin目录下文件](img/4.png)

调整VM配置文件

![VM配置文件](img/5.png)

	-Xms128m， 16 G 内存的机器可尝试设置为 -Xms512m
	(设置初始的内存数，增加该值可以提高 Java 程序的启动速度。 )
	-Xmx750m， 16 G 内存的机器可尝试设置为 -Xmx1500m
	(设置最大内存数，提高该值，可以减少内存 Garage 收集的频率，提高程序性能)
	-XX:ReservedCodeCacheSize=240m， 16G 内存的机器可尝试设置为
	-XX:ReservedCodeCacheSize=500m
	(保留代码占用的内存容量)

* 设置目录

![设置目录](img/6.png)

这是IDEA保存各种配置的目录。 这个设置目录有一个特性，就是你删除掉整个目录之
后，重新启动 IntelliJ IDEA 会再自动帮你生成一个全新的默认配置，所以很多时候如果你把
IntelliJ IDEA 配置改坏了，没关系，删掉该目录，一切都会还原到默认。

	1. config目录
	config 目录是 IntelliJ IDEA 个性化化配置目录，或者说是整个 IDE 设置目录。此目录可看成是最重要的目录，没有之一，安装新版本的 IntelliJ IDEA 会自动扫描硬盘上的旧配置目录，指的就是该目录。这个目录主要记录了： IDE 主要配置功能、自定义的代码模板、自定义的文件模板、自定义的快捷键、 Project 的 tasks 记录等等个性化的设置。

	2. system 目录
	system 目录是 IntelliJ IDEA 系统文件目录，是 IntelliJ IDEA 与开发项目一个桥梁目录， 里面主要有：缓存、索引、容器文件输出等等，虽然不是最重要目录，但也是最不可或缺的目录之一。
	

## 启动后简单配置

* 是否导入已有设置

![是否导入已有设置](img/7.png)

* 激活

	将破解补丁JetbrainsIdesCrack-3.4-release-enc.jar（或其他版本对应的破解补丁）放在idea的bin目录下

	编辑文件idea64.exe.vmoptions，在其末尾增加：-javaagent:D:/IntelliJ IDEA 2018.3/bin/JetbrainsIdesCrack-3.4-release-enc.jar

	在idea对话框中此时选择“Activation code”选项，然后在下方输入框中再次输入刚才添加的文本：-javaagent:D:/IntelliJ IDEA 2018.3/bin/JetbrainsIdesCrack-3.4-release-enc.jar

	![激活](img/8.png)

* 设置主题

![主题](img/9.png)

* 设置插件

![插件](img/10.png)

## 创建Java工程

* 创建Java工程

![初始界面](img/11.png)

	Create New Project:创建一个新的工程。

	Import Project:导入一个现有的工程。

	Open:打开一个已有工程。

	Check out from Version Control:可以通过服务器上的项目地址 check out Github
	上面项目或其他 Git 托管服务器上的项目。

* 设置显示常见的视图

![Toolbar](img/12.png)

* 工程界面

![工程界面](img/13.png)

* 在 IDEA 里要说的是，写完代码，不用点击保存。 IDEA 会自动保存代码。

* **创建模块（Module）**

	在 Eclipse 中我们有 Workspace（工作空间）和 Project（工程）的概念，在 IDEA 中只有 Project（工程）和 Module（模块）的概念。这里的对应关系为：
	**Eclipse 中 workspace 相当于 IDEA 中的 Project；Eclipse 中 Project 相当于 IDEA 中的 Module。**

	IntelliJ IDEA 是无法在同一个窗口管理 n 个项目。 IntelliJ IDEA 提供的解决方案是打开多个项目实例，即打开多个项目窗口。 即： 一个 Project 打开一个 Window 窗口。

	在 IntelliJ IDEA 中 Project 是最顶级的级别，次级别是 Module。一个 Project 可以有多个 Module。目前主流的大型项目都是分布式部署的， 结构都是类似这种多 Module 结构。

	![module1](img/14.png)

	![module2](img/15.png)

	![module3](img/16.png)

之后，我们可以在 Module 的 src 里写代码，此时 Project 工程下的 src 就没什么用了，可以删掉。

* **删除模块（Module）**

![module4](img/17.png)

![module5](img/18.png)


* 查看项目配置

![module6](img/19.png)

## 常用配置

![idea配置界面](img/20.png)

> Appearance & Behavior(外观和行为)

* 设置主题

![设置主题](img/21.png)

* 设置窗体及菜单的字体及字体大小 (可忽略)

![](img/22.png)

* 设置编辑区主题（可忽略）

![](img/23.png)

* 通过插件（plugins）更换主题

![](img/24.png)

> Editor-->General

* 设置鼠标滚轮修改字体大小（可忽略）

Ctrl + 鼠标滚轮 快捷键来控制代码字体大小显示

![](img/25.png)

* **设置鼠标悬浮提示**

![](img/26.png)

* **设置自动导包功能**

Add unambiguous imports on the fly：自动导入不明确的结构;
Optimize imports on the fly： 自动帮我们优化导入的包

![](img/27.png)

* **设置显示行号和方法间的分隔符**

![](img/28.png)

* **忽略大小写提示**

取消勾选，match case

![](img/29.png)

![](img/66.png)

* **设置取消单行tabs的操作**

在打开很多文件的时候， IntelliJ IDEA默认是把所有打开的文件名Tab页单行显示的。

![](img/30.png)

> Editor --> Font

* 设置默认的字体、字体大小、字体行间距

![](img/31.png)

>  Editor –-> Color Scheme

* 修改当前主题的字体、字体大小、字体行间距( 可忽略)

![](img/32.png)

* 修改当前主题的控制台输出的字体及字体大小( 可忽略)

![](img/33.png)

* 修改代码中注释的字体颜色

Doc Comment – Text： 修改文档注释的字体颜色;Block comment： 修改多行注释的字体颜色;Line comment： 修改单行注释的字体颜色。

![](img/34.png)

> Editor --> Code Style

* 设置超过指定import个数，改为* ( 可忽略)

![](img/35.png)

>  Editor –-> File and Code Templates

* **修改类头的文档注释信息**

![](img/36.png)

	/**
	@author dongtangqiang
	*/

> Editor --> Copyright

**设置版权**

![](img/68.png)

![](img/67.png)

	版权所有(C)，上海海鼎信息工程股份有限公司，$today.format("yyyy")，所有权利保留。

	项目名： $module.name
	文件名： $file.fileName
	模块说明：
	修改历史:
	$today.format("yyyy-M-d") - dongtangqiang - 创建。

> Editor --> Inspections

**快捷键生成serialVersionUID**

![](img/69.png)

鼠标点击类，按alt+entry

![](img/70.png)


> Editor –-> File Encodings

* **设置项目文件编码**

Transparent native-to-ascii conversion 主要用于转换 ascii，一般都要勾选，不然 Properties 文件中的注释显示的都不会是中文。

![](img/37.png)

*  设置当前源文件的编码( 可忽略)

对单独文件的编码修改还可以点击右下角的编码设置区。如果代码内容中包含中文，则会弹出如上的操作选择。 其中：①Reload 表示使用新编码重新加载，新编码不会保存到文件中，重新打开此文件，旧编码是什么依旧还是什么。②Convert 表示使用新编码进行转换，新编码会保存到文件中，重新打开此文件，新编码是什么则是什么。③含有中文的代码文件， Convert 之后可能会使中文变成乱码，所以在转换成请做好备份，不然可能出现转换过程变成乱码，无法还原。

![](img/38.png) 


>  Build,Execution,Deployment

* **设置自动编译**

![](img/39.png)

* 设置为省电模式(可忽略)

省电模式会关掉代码检查和代码提示等功能。

![](img/40.png)

* 设置代码水平或垂直显示

![](img/41.png)

## 设置快捷键(Keymap)

* 设置快捷为 Eclipse 的快捷键

![](img/42.png)

* 通过快捷键功能修改快捷键设置

![](img/43.png)

* 通过指定快捷键，查看或修改其功能

![](img/44.png)

* 导入已有的快捷键设置

![](img/45.png)

## 关于模板(Templates)

Editor – Live Templates 和 Editor – General – Postfix Completion

* Live Templates( 实时代码模板) 功能介绍

它的原理就是配置一些常用代码字母缩写，在输入简写时可以出现你预定义的固定模式的代码，使得开发效率大大提高， 同时也可以增加个性化。最简单的例子就是在 Java 中输入 sout 会出现
System.out.println();
官方介绍 Live Templates：https://www.jetbrains.com/help/idea/using-live-templates.html

* 已有的常用模板

Postfix Completion 默认如下：

![](img/46.png)

输入一个后缀后就可以自动补全（例如：数组名.for）:

![](img/71.png)

Live Templates 默认如下：

![](img/47.png)

二者的区别： Live Templates 可以自定义，而 Postfix Completion 不可以。同时，有些操作二者都提供了模板，Postfix Templates 较 Live Templates 能快 0.01 秒。

* 修改现有模板:Live Templates

![](img/48.png)

* 自定义模板

定义一个模板的组

![](img/49.png)

定义模板

![](img/50.png)

1. Abbreviation:模板的缩略名称
2. Description:模板的描述
3. Template text:模板的代码片段
4. 应用范围。比如点击 Define,进行选择.

![](img/51.png)

![](img/52.png)

## 安装插件

* Eclipse Code Formatter

![](img/72.png)

![](img/73.png)

![](img/74.png)

* RainBow Brackets（彩虹括号）

* Maven Helper


* ignore
	
生成各种ignore文件，一键创建git ignore文件的模板。

* lombok

通过该插件可以生成实体的GetXXX和SetXXX方法。lombok的注解(@Setter,@Getter,@ToString,@@RequiredArgsConstructor,@EqualsAndHashCode或@Data)，需要在项目中添加依赖。

* FindBugs-IDEA

检测代码中可能的bug及不规范的位置。

* GsonFormat

根据json文本生成java类。

* VisualVM Launcher

运行java程序的时候启动visualvm，方便查看jvm的情况。

* GenerateAllSetter

一键调用一个对象的所有set方法并且赋予默认值。

* Grep console

自定义日志颜色，idea控制台可以彩色显示各种级别的log，安装完成后，在console中右键就能打开。

* Restfultookit

可以根据web访问的url找到对应的controller类，还可以生成测试数据，不用postman来组装数据。

## 创建 Java Web Project 或 Module

* 创建的静态 Java Web

![](img/53.png)

![](img/54.png)

* 创建动态的 Java Web

![](img/55.png)

![](img/56.png)

* 添加Tomcat

![](img/57.png)

![](img/58.png)

* 添加jar包

![](img/59.png)

* 添加datasource

![](img/60.png)

## 版本控制

![](img/61.png)

## 断点调试

Shared memory 是 Windows特有的一个属性，一般在 Windows 系统下建议使用此设置， 内存占用相对较少。

![](img/62.png)

## 配置Maven

![](img/63.png)

Import Maven projects automatically：表示 IntelliJ IDEA 会实时监控项目的pom.xml 文件，进行项目变动设置。

![](img/64.png)

创建对应的Module

![](img/65.png)
