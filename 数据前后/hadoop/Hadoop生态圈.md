# base
## 特征
+ 规模，多样，高速，价值
## 概述
+ 数据采集
+ 数据存储
+ 数据处理，分析，挖掘
+ 可视化
## 挑战
+ 数据库管理
+ 数据多类别
+ 数据实时性
+ 网络架构，数据中心，运维挑战
## 解决
+ 存储 gfs
+ 读写 bigtable
+ 计算 mapreduce
## hadoop生态圈
+ 2.x
### hdfs
### yarn
### MapReduce
### 项目
### 集群搭建
### spring使用
### spark生态圈
# 初识hadoop

## 概述
+ 开源的分布式存储和分布式计算
+ 组成：comon，hdfs，yarn，mapredue
+ 大型数据仓库，pb级别数据存储，处理，分析，统计等业务
+ 搜索引擎，商业智能，日志分析，数据挖掘
## 核心组件
+ 谷歌gfs论文2003年10月
+ hdfs是gfs的克隆版
+ 扩展性，容错性，海量数据存储
+ hdfs
+ 文件切分成指定大小的数据块并以多副本存储在多个机器上
+ 数据切分，多副本，容错等操作对用户透明
+ yarn 
+ yet another resource negotiator
+ 资源的管理和调度
+ 扩展性，容错性，多框架资源统一调度
+ mapreduce
+ 谷歌的论文mapreduce，2014年12月
+ mapreduce 是谷歌的mapreduce 扩展板
+ 扩展性，容错性，海量数据离线处理
+ demo：input，splitting，mapping，shuffing，reducing，final result
## 优势
+ 高可靠性
	+ 数据存储：数据块多副本
	+ 数据计算：重新调度作业计算
+ 高扩展性
	+ 存储计算资源不足，可以横向线性扩展机器
	+ 一个集群中可以包含数以千计的节点
+ 其他
	+ 存储在便宜的机器上，降低成本
	+ 成熟的生态圈
## 发展史
+ 狭义的hadoop：hdfs，yarn，mapreduce（离线批处理）
+ 广义的hadoop：生态系统
+ 广义hadoop:hdfs,mapreduce/yarn,hive(hiveql，sql查询，离线分析），r conectors，mahout，pig，oozie（工作流），zookerper（分布式的协调服务），
+ flume（日志收集框架），sqoop(数据交换扩展）
+ hbase（hadoop当中的一个数据库） 
## 生态系统
+ 特点：开源，社区活跃
+ 囊括了大数据处理的各方面
+ 生态系统完善
## 发行版本
+ apache hadoop（安装可能有冲突）
+ cdh：cloudera distributed hadoop (集成安装:hadoop2.6.0-cdn5.7.0,hive1.1.0-cdh-5.7.0) 生成环境 6-70%
+ hdp：hortonworks data platform（开源，原装的hadoop，安装升级添加节点比较麻烦）
## 案例
+ 预测式发货（存储在仓储物流）
+ 零售大数据
# hdfs
## 概述&设计目标
+ hadoops实现的一个分布式文件系统
+ 源于谷歌的gfs论文
+ 论文发布于2003年，hdfs是gfs的克隆版
+ **设计目标**
+ 非常巨大的分布式文件系统
+ 运行在普通廉价的硬件上
+ 易扩展，为用户提供性能不错的文件存储服务
## 架构
+ 一个master 附带n个slave
+ 一个namenode 多个datanode
+ 一个文件被拆分为多个block，block 128M
+ namenode：客户端请求的响应；元数据（文件名称，副本系数据，block存放的dn）的管理
+ datanode：存储用户的文件对应的数据块（block）；定期向nn发送心跳信息，汇报本身及其所有的block信息，健康状态
+ 典型架构
+ namenode+ n个datanode
+ 建议nn和dn部署在不同的机器上
##副本机制
+	副本系数，副本因子:副本的份数
+ 一个文件所有的block，除了最后一个，其他的大小都一样
+ block：文件名，副本系数，序列号
+ 存放策略
## hdfs搭建
+ hadoop260 cdh570
+ 前置软件：java ，ssh
### jdk
+ 解压
+ tar -zxvf jdk -C ~/app
+ 环境变量配置
+ vi ~/.bash_profile
+ export JAVA_HOME= /home/hadoop/app/jdk1.7.0_79
+ export PATH=$JAVA_HOME/bin:$PATH
+ source ~/.bash_profile
+ echo $JAVA_HOME
+ java -version
### ssh
+ sudo apt-get install ssh
+ ssh-keygen -t rsa
+ 回车，回车，回车
+ cd .ssh
+ cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
+ ssh localhost
+ sudo apt-get install rsync
### 安装cdh网站的hadoop
+ 直接去cdh网站下载
+ tar -zxvf hadoop.xx -C ~/app
+  编辑etc/hadoop/hadoop-env.sh
+ export JAVA_HOME= /home/hadoop/app/jdk1.7.0_79
+  更改配置
+ core-site.xml：hdfs：//hadoop：8020
+ core-site添加节点：
<property><name>hadoop.tmp.dir</name><value>/home/hadoop/app/tmp</value></property>
+ hdfs-site.xml：value改为1
+ 配置slaves
+ 启动hdfs
+ 第一次执行时格式化文件系统，客户端操作
+ ./hdfs namenode -format
+ sbin/start-dfs.sh
+ jps
+ 浏览器启动
+ localhost：50070
+ sbin/stop-dfs.sh
## hdfs shell
+ vi ~/.bash_profile
+ export HADOOP_HOME= /home/hadoop/app/hadoop
+ export PATH=$HADOOP_HOME/bin:$PATH
+ source ~/.bash_profile
+ echo $JAVA_HOME
+ hdfs
+ hdfs dfs
+ 基本使用
+ ls
+ mkdir
+ put
+ get
+ rm
+ demo
+ hadoop fs
+ hadoop fs -ls /
+ hadoop fs -put hello.txt  /
+ hadoop fs -text hello.txt  /
+ hadoop fs -mkdir /test
+ hadoop fs -mkdir -p /test/a
+ hadoop fs -ls -R /
+ hadoop fs -copyFromLocal hello.txt /test/a/b/h.txt
+ hadoop fs -ls -R /
+ hadoop fs -cat hello.txt  /
+ hadoop fs -get hello.txt  /
+ hadoop fs -rm /test
+ hadoop fs -rm  -R /
## java api 操作hdfs
### idea & maven 创建java工程
+ 基于maven开发
### 添加hdfs相关依赖
+ 配置文件添加依赖
+ 添加hadoop的对应的url依赖
### 开发javaapi操作hdfs文件
+ 编写测试用例
## hdfs 文件读写流程
### 文件写入流程
+ 客户端-nn-dn
+ 发起请求-blocksize，副本因子-
### 文件读取流程
## hdfs优缺点
### 优点
+ 数据冗余，硬件容错
+ 处理流式数据访问
+ 适合存储大文件
+ 廉价的机器
### 缺点
+ 低延迟的数据访问
+ 小文件存储
# yarn
+ hadoop1.x架构：master/slave 架构
+ 一个jobtracker多个jobtracker
+ 心跳机制
+ jobtracker：负责资源管理和作业调度
+ tasktracker：定期向jt汇报本节点的简况状态，资源使用，作业执行情况；接受来自jt的命令，启动任务/杀死任务
+ 问题
+ 单点故障&节点压力大不容易扩展&不支持其他框架
+ 资源利用率&运维成本
+ yarn
+ 不同计算框架可以共享同一个hdfs集群上的数据，享受整体的资源调度
+ xxonyarn与其他计算框架共享集群资源，按资源需求分配，提高资源利用率
## 背景
+ 通用的资源管理系统
+ 为上层应用提供统一的资源管理和调度
## 概念
+ recoursemanager：rm
+ 整个集群一时间提供服务的rm只有一个，负责集群资源的统一管理和调度
+ 处理客户端请求：提交/杀死一个作业
+ 监控nm，一旦一个nm挂了，那么该nm上运行的任务需要告诉am
+ nodemanager：nm
+ 整个集群中多个，负责自己本身节点资源的管理和使用
+ 定时向rm汇报本节点的资源使用情况
+ 接收并处理来自rm的各种命令：启动container
+ 处理来自am的命令
+ 单个节点的资源管理
+ applicationsmaster：am
+ 每个应用程序对应一个mr，spark，负责应用程序管理
+ 为应用程序向rm申请资源（core，memory），分配个内部的task
+ 需要与nm通信，启动/停止task，task，am运营在container中
+ container
+ 封装cpu，memory 等资源的一个容器
+ 是一个任务运行环境的抽象
+ client
+ 提交作业
+ 查询作业运行进度
+ 杀死作业
## 架构
+ 提交作业
+ rm-nm-am
## 流程
## 环境搭建
+ yarn-site.xml
+ mapred-site.xml
+ 启动yarn相关的进程
+ 验证
+ 停止
# mapreduce
## 概述
+ 源于谷歌论文，2004年12月
+ 谷歌mapreduce的克隆版
+ 优点：海量数据离线处理&易开发&易运行
+ 缺点：实时流式处理
## 编程模型
+ wordcount
+ 分而治之
+ 作业拆分成map阶段和reduce阶段
+ map阶段：map tasks
	+ 准备map处理的输入数据
	+	mapper处理
	+	shuffle
	+ reduce处理
	+	结果输出
+ reduce阶段：reduce tasks
### 核心概念
+ split：交由mapreduce作业来处理的数据块，是mapreduce中的最小计算单元
+ hdfs：bolcksize是hdfs中的最小存储单元 128m
+ 默认情况下，两者一一对应，也可以手工设置两者对应关系
+ inputformat： 输入数据进行分片，outputformat
## 结构
## 编程