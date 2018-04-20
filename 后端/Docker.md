#	base
##	概念
1.	容器能干啥
	+	简化配置
	+	整合服务器
	+	代码流水线管理
	+	提高开发效率
	+	隔离应用
	+	整合服务器
	+	 调试能力
	+	多租户
	+	快速部署		
2.	热门技术
	+	Docker
	+	![](https://i.imgur.com/1jTfB1y.png)
	+	![](https://i.imgur.com/Jo9gqmG.png)
	+	Kubernetes(K8s)
		+	容器编排工具（调度运营）
## 目录
1.	容器技术&Docker简介
2.	Docker环境搭建
3.	Docker镜像和容器
4.	Docker网络
5.	Docker持久化存储和数据共享
6.	Docker Compose多容器部署
7.	容器编排工具 Docker Swarm
8.	DevOps体验：DockerCloud 和Docker企业版
9.	容器编码Kubernets
10.	容器的运维和监控
11.	Docker&DevOps实战：过程和工具
12.	总结
13.	流程

# 内容
## char1
###	容器技术
+ old:物理服务器：部署慢，成本高，资源浪费，难于迁移和扩展，限定的硬件厂商 
+	容器（集装箱）解决了开发和运维之间的沟通
+	定义
	+	打包app可以运行在任何环境
	+	软件和其依赖的标准化打包
	+	应用之间相互隔离
	+	共享一个OS Kernel
	+	可以运行在很多主流操作系统中
### 虚拟化技术
+ 优点
	+	物理机：虚拟机：虚拟层
	+	一台物理机部署多个app，每个app独立运行在一个VM中
	+	资源池：一个物理机资源分配不同虚拟机
	+	很容易扩展：加物理机或虚拟机
	+	容易云化，AWS，阿里云
+	缺点
	+	虚拟机是完整系统，资源耗费
	+	人的矛盾
### 区别
+	容器是APP层面的隔离
+	虚拟化是物理资源层的隔离
### 历史
+	Docker 2013 内部项目
+	 企业版，社区版
## char2
### 安装版本
+	社区版/企业版
+	版本号 年+月份
+	[https://docs.docker.com/docker-for-windows/install/](https://docs.docker.com/docker-for-windows/install/)
### Win
+	要求：win10 64位或WinServer2016 & Hyper-V
+ 	docker version
+	方式1：win10开启 Hyper-V
+	方式2：安装dockerToolbox
+	[http://get.daocloud.io/#install-docker-for-mac-windows](http://get.daocloud.io/#install-docker-for-mac-windows)
+  打开Docker Quickstart Terminal
+	自动下载，或者从DockerToolBox安装路径复制iso文件到C盘文件
+	vbox启动失败
	>	那是因为vboxdrv服务没有安装或没有成功启动，
64位的系统经常这样，
找到安装目录下的vboxdrv文件夹，
如D:\Program Files\Oracle\VirtualBox\drivers\vboxdrv，
右击VBoxDrv.inf，选安装，然后重启。

+ docker info
### Mac
+ 安装docker docker图形界面Kitematic
+ docker --version
### Linux
#### vagrant
+	Mac或Win10
+	VirtualBox虚拟机安装
+	Vagrant创建虚拟机
+	安装VirtualBox & Vagrant
+	vagrant --version
+	vagrant init centos/7
+	vagrant up
+	vagrant ssh
+	exit
+	vagrant status
+	vagrant halt
+	vagrant destory
#### docker
+	sudo apt-get remove docker docker-engine docker.io
+	sudo apt-get update
+	sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
#### docker-machine 
+	docker-machine version
+	docker-machine creat demo
+	docker-machine ls
+	exit
+	docker version
+	docker-machine start demo
#### docker-machine 阿里云
+	安装阿里云的ecs的第三方driver
#### docker playground
## char3
### Docker Platform
+	提供一个开发，打包，运行app的平台
+	DockerEngine把app和底层infrastructure隔离开来
+	DockerEngine:后台进程dockerd，RestAPIServer，CLI接口Docker
+![](https://i.imgur.com/uwtxPWC.png)
### 底层技术
+	Namespace:隔离pid,net,ipc,mnt,ut
+	control groups:资源限制
+	Union File System:container和image的分层
### Image
+	![](https://i.imgur.com/Nvp9ru4.png)

### dockerImage获取
+	配置文件
![](https://i.imgur.com/9Vfphyt.png)

+	从仓库获取（官方/非官方）
![](https://i.imgur.com/d34CBTs.png)

+ Linux配置不加sudo运行
+	sudo docker image ls
+	sudo groupadd docker
+	sudo gpasswd -a vagrant docker
+	docker version
+	sudo service docker restart
+	exit
+	vargant ssh
+	docker version

### container
+	通过image创建
+	在iamge layer上建立一个container layer(可读写）
+	类和实例
+	image负责app存储和分发，Container负责运行app

+	docker container ls
+	 docker container ls -a