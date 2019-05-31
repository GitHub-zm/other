<h1 align = "center">项目docker镜像构建集成</h1>

- **主&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：**  项目docker镜像构建集成
- **版&nbsp;&nbsp;本&nbsp;&nbsp;号：**  1.0
- **日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期：**  2018年7月30日

## 简介
本文主要讲解如何在Maven项目中集成docker镜像制品的构建及发布。


## 正文
### 1. maven插件配置

	<project>
	  // ... 省略其他配置
	  <properties>
	    // ... 省略其他配置
	    <heading.docker.registry>harborka.qianfan123.com</heading.docker.registry>
	    <docker-maven-plugin.version>0.4.10</docker-maven-plugin.version>
	  </properties>
	  // ... 省略其他配置
	  <profiles>
		// ... 省略其他配置
	    <profile>
	      <id>docker-all</id>
	      <activation>
	        <property>
	          <name>docker-all</name>
	        </property>
	      </activation>
	      <build>
	        <plugins>
	          <plugin>
	            <groupId>com.spotify</groupId>
	            <artifactId>docker-maven-plugin</artifactId>
	            <version>${docker-maven-plugin.version}</version>
	            <configuration>
				  <!-- docker服务器相关信息，配置在setting.xml中 -->
	              <serverId>heading-hd123-dockerhub</serverId>
	              <registryUrl>https://${heading.docker.registry}</registryUrl>
	            </configuration>
	            <executions>
	              <execution>
	                <id>build-image</id>
	                <phase>package</phase>
	                <goals>
	                  <goal>build</goal>
	                </goals>
	                <configuration>
					  <!-- Dockerfile位置 -->
	                  <dockerDirectory>${project.basedir}/src/main/docker</dockerDirectory>
					  <!-- 镜像名 -->
	                  <imageName>${heading.docker.registry}/smd/${project.artifactId}</imageName>
					  <!-- 镜像tag -->
	                  <imageTags>
	                    <imageTag>${project.version}</imageTag>
	                  </imageTags>
	                  <forceTags>true</forceTags>
	                  <labels>
	                    <label>VERSION=${project.version}</label>
	                  </labels>
	                  <resources>
	                    <resource>
	                      <targetPath>/</targetPath>
	                      <directory>${project.build.directory}</directory>
	                      <include>${project.build.finalName}.jar</include>
	                    </resource>
	                  </resources>
	                </configuration>
	              </execution>
	              <execution>
	                <id>push-image</id>
	                <phase>package</phase>
	                <goals>
	                  <goal>push</goal>
	                </goals>
	                <configuration>
	                  <imageName>
	                    ${heading.docker.registry}/smd/${project.artifactId}:${project.version}
	                  </imageName>
	                  <retryPushCount>3</retryPushCount>
	                  <retryPushTimeout>60</retryPushTimeout>
	                </configuration>
	              </execution>
	            </executions>
	          </plugin>
	        </plugins>
	      </build>
	    </profile>
	
	    <profile>
	      <id>docker-build</id>
	      <activation>
	        <property>
	          <name>docker-build</name>
	        </property>
	      </activation>
	      <build>
	        <plugins>
	          <plugin>
	            <groupId>com.spotify</groupId>
	            <artifactId>docker-maven-plugin</artifactId>
	            <version>${docker-maven-plugin.version}</version>
	            <configuration>
	              <serverId>heading-hd123-dockerhub</serverId>
	              <registryUrl>https://${heading.docker.registry}</registryUrl>
	            </configuration>
	            <executions>
	              <execution>
	                <id>build-image</id>
	                <phase>package</phase>
	                <goals>
	                  <goal>build</goal>
	                </goals>
	                <configuration>
	                  <dockerDirectory>${project.basedir}/src/main/docker</dockerDirectory>
	                  <imageName>${heading.docker.registry}/smd/${project.artifactId}</imageName> <!-- 镜像名 -->
	                  <imageTags>
	                    <imageTag>${project.version}</imageTag>
	                  </imageTags>
	                  <forceTags>true</forceTags>
	                  <labels>
	                    <label>VERSION=${project.version}</label>
	                  </labels>
	                  <resources>
	                    <resource>
	                      <targetPath>/</targetPath>
	                      <directory>${project.build.directory}</directory>
	                      <include>${project.build.finalName}.jar</include>
	                    </resource>
	                  </resources>
	                </configuration>
	              </execution>
	            </executions>
	          </plugin>
	        </plugins>
	      </build>
	    </profile>
	
	  </profiles>
	</project>

### 2. maven setting.xml配置

setting.xml路径一般在C:\Users\[用户名]\\.m2。 找到servers节点，增加以下配置：


	<server>
		<id>heading-hd123-dockerhub</id>
		<username>hdkadev</username>
	    <password>Hkd201806</password>
		<configuration>
			<email>[请填写个人公司邮箱]</email>
		</configuration>
	</server>


### 3. Dockerfile编写
1. 基于tomcat示例

		FROM harborka.qianfan123.com/base/tomcat7:jdk1.7
		LABEL PROJECT="zjlh tobacco" \
		      AUTHOR="xietao@hd123.com" \
		      COMPANY="Shanghai HEADING Information Engineering Co., Ltd."
		WORKDIR /opt/heading/tomcat7/webapps
		ADD zjlh-tobacco-web-*.war zjlh-tobacco-web.war
		RUN mkdir /opt/heading/tomcat7/webapps/zjlh-tobacco-web \
		    && unzip  zjlh-tobacco-web.war -d /opt/heading/tomcat7/webapps/zjlh-tobacco-web \
		    && rm -rf zjlh-tobacco-web.war
		ENTRYPOINT ["/opt/heading/tomcat7/bin/catalina.sh","run"] 
		CMD ["-?"]


2. 基于springboot示例

		FROM harborka.qianfan123.com/base/jre-alpine:8
		
		LABEL PROJECT="pds-kafka-server" \
		      AUTHOR="xxxx@hd123.com" \
		      COMPANY="Shanghai HEADING Information Engineering Co., Ltd."
		
		WORKDIR /opt/heading

		ADD pds-kafka-server-*.jar pds-kafka-server.jar
		
		ENTRYPOINT ["java","-Dspring.config.location=/opt/heading/pds-kafka-server/application.properties","-jar","pds-kafka-server.jar"] 
		CMD ["-?"]
