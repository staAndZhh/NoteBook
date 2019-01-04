# base
+ 浏览器
+ 前端:集群
+ 后端：集群redis集群
+ mysql：集群

# 要求
+ 硬件：内存8g，磁盘40g
+ 软件：wmware虚拟机，docker虚拟机
+ jdk,mysql,redis,nginx,node.js
+ nginx-前端-nginx-后端-redis高速缓存-mysql
# 基本安装
+ 人人网开源项目www.renren.io
+ 前后端分离的项目
## 前后端项目下载与配置
+ Springboot，shiro，redis
+ ssm，swagger(后台api调试)，jwt
###  maven环境
+ apache maven是要软件工程管理和整合工具
+ maven+pom --java工程
+ 下载renrenfast后端文件
+ 在eclipse文件汇总import
+ 导入maven文件后
+ 导入mysql数据库库文件
+ datagrid软件或者navigator
+ mysql执行数据库创建生成文件
+ 更改java项目的数据库配置
+ 修改application-dev-yml文件
+ run as springboot app
+ 测试接口
### 前端项目
+ vue：mvm框架，elementui：组件，nodejs：动态运行环境
+ 安装nodejs
+ npm install
+ npm run dev
## linux系统构成和基本操作
+ 跨平台硬件支持
+ 丰富软件支持
+ 多用户多任务
+ 可靠安全性
+ 良好的稳定性
+ 完善的网络功能
#docker
+ 共用内核
+ docker 创建的所有虚拟实例共用一个linux内核，对硬件占用较小，属于轻量级虚拟机

## 云计算
+ 基于docker的云平台
+ saas，paas
+ 镜像是用来创建容器的
+ 容器是从镜像中创建出来的虚拟实例
+ 容器是用来运行程序的，是读写层
+ 镜像是用来安装程序的，是只读层
## 安装
+ 先更新yum软件管理器，然后安装docker
+ yum -y update
+ yum install -y docker
## 管理
+ service docker start
+ service docker stop
+ service docker restart
+ ![](https://i.imgur.com/aFM22OJ.png)
## 常用指令
+ 镜像
+ docker search java
+ docker pull docker.io/java
+ DaoCloud配置国内镜像加速
+ docker images 查看镜像名字
+ docker save java>/home/java.tar.gz  导出镜像
+ docker load </home/java.tar.gz  导入镜像
+ docker images 查看镜像
+ docker rmi java 移除镜像
+ 容器
+ docker run -it --name myjava java bash
+ docker run -it --name myjava -p 9000:8080 -p 9001:8085 java bash
+ docker run -it --name myjava java -v /home/project:/soft --privileged java bash
+ java -version
+ cd /soft
+ touch hello.txt
+ echo thanks > hello.txt
+ exit
+ 容器暂停
+ docker puase myjava
+ docker unpause myjava
+ docker stop myjava
+ docker start -i myjava
+ docker rm myjava 
# 数据库集群
+ Replication，pxc
+ ![](https://i.imgur.com/xs1r1NJ.png)

## pxa集群
+ percona xtradb cluster
+ 每一个集群都是可读可以写的
+ 建议使用perconaserver
+ 数据同步是双向的，任何一个结点都是可以同时读写的
+ pxc分发数据是同步复制，事务在所有集群结点要么同时提交，要么不提交
+ replication采用异步复制，无法保证数据一致性
### 安装
+ 可以linux直接安装，可以docker安装
+ docker pull percona/percona-xtradb-cluster
+ docker load < /home/soft/pxc.tar.gz
+ docker tag xxx pxc 修改镜像名字
+ docker rmi xxx
+ 创建内部网络
+ docker network create net1
+ docker network inspect net1
+ docker network rm net1
+ docker network create --subnet= 172.18.0.0/24 net1
+ docker inspect net1
+ docker network rm net1
+ 目录映射
+ pxc不能映射目录
+ 使用docker数据卷
+ docker volume create --name v1
+ docker inspect v1
+ docekr volume rm v1
+ 创建pxc容器
+ 需要向pxc镜像传入运行参数就能创建出pxc容器
+ ![](https://i.imgur.com/x0abX5S.png)
## haproxy数据库负载均衡
+ ![](https://i.imgur.com/Vey8K5k.png)
+ ![](https://i.imgur.com/uqwUQh8.png)
+ docker pull haproxy
+ touch /home/soft.haproxy.cfg
+ 配置文件详情 https://zhangge.net/5125.html
+ 创建haproxy容器
+ ![](https://i.imgur.com/V7dUcAB.png)
+ docker exec -it h1 bash
+ haproxy -f xx/xx.cfg
## haproxy数据库负载均衡双击热备
+ 虚拟ip地址
+ 利用keepalived实现双击热备
+ docker exec -it h1 bash
+ apt-get update
+ apt-get install keepalive
+ 配置文件是 /etc/keepalived/keepalived.conf
## 数据库热备份
+ 冷备份
+ 热备份
+ mysql常见的热备份有lvm和xtrabackup两种方案
+ lvm属于linux的分区备份技术，会加锁表，只读的
+ 建议使用xtrabackup热备份mysql
+ 开源免费，支持全量和增量备份都支持
+ 备份不锁表，快速可靠
+ 不会打断正在执行的事务
+ 基于压缩等功能节约磁盘空间
+ 数据库第一次全量备份，后面的可以增量备份
+ 一周一次全量备份，一天一次增量备份
+ 数据可以热备份但是不能热还原
+ 采用空白的mysql还原数据，然后再建立pxc集群
# 高速缓存
+ 减少i/o操作，降低io压力
+ redis是wmware开发的开源免费的kv型nosql缓存产品
+ redis很好性能，最多提供10万次/s读写
+ 部署方案
+ rediscluster：官方推荐，没有中心节点
+ codis：中间件产品，存在中心节点
+ twempproxy：中间件产品，存在中心节点
## rediscluster
+ 数据是被分片存储，可读可写的，每一个数据节点都不同，所以需要设置冗余节点
+ 管理方便，自行添加或者删除新的节点
+ 主从同步
+ 应该含有奇数个master，至少应该有3个
master
+ redis集群中每个master都应该有slave
+ 还要实现redis负载均衡
## 使用
+ 安装镜像
+ 创建容器
+ 使用集群