1. 项目代码迁移，参考:[使用subgit进行svn迁移至git(branch,tags)](./使用subgit进行svn迁移至git(branch,tags))
2. 检出代码，配置.gitignore

	样例：
	
		# .gitignore for maven
		target/
		*.releaseBackup
		
		# IDE support files
		/.classpath
		/.launch
		/.project
		/.settings
		/*.launch
		/*.tmproj
		/ivy*
		/eclipse
		/.svn

3. 修改pom文件
	1.	修改scm。

		    修改前：
			 <scm>
			    <connection>scm:svn:http://hddenv/svn/zjlh/scm/src/hvd/server/trunk</connection>
			    <developerConnection>scm:svn:http://hddenv/svn/zjlh/scm/src/hvd/server/trunk</developerConnection>
			    <url>http://hddenv/svn/zjlh/scm/src/hvd/server/trunk</url>
			  </scm>

			修改后：
			  <scm>
			    <connection>scm:git:http://github.app.hd123.cn:10080/smd/hvd-server.git</connection>
			    <developerConnection>scm:git:http://github.app.hd123.cn:10080/smd/hvd-server.git</developerConnection>
			    <url>http://github.app.hd123.cn:10080/smd/hvd-server.git</url>
			    <tag>HEAD</tag>
			  </scm>

	2. maven-release-plugin插件配置修改

			<plugin>
			  <groupId>org.apache.maven.plugins</groupId>
			  <artifactId>maven-release-plugin</artifactId>
			  <version>2.5.3</version>
			  <configuration>
			    <checkModificationExcludeList>.project,.classpath,.mymetadata</checkModificationExcludeList>
			    <tagNameFormat>@{project.version}</tagNameFormat>
			  </configuration>
			  <dependencies>
			    <dependency>
			      <groupId>org.apache.maven.scm</groupId>
			      <artifactId>maven-scm-provider-gitexe</artifactId>
			      <version>1.9.4</version>
			    </dependency>
			  </dependencies>
			</plugin>


4. 修改环境更新脚本。