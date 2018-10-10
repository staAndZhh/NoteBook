# Hadoop实战
##	base
+	项目
+	体系
+	分布式
+	MapReduce
+	数据管理
+	集群安全

## 简介
+	HDFS&MapReduce（bigger than 1T)
+	分布式存储&数据整合
+	可靠，扩展，高效，容错

### hive
+ hadoop基础上的数据仓库
+ 结构化数据的机制，类似于sql
### hbase
+ 类似于bigtable的非结构化数据库
### hdfs
+ 一个namenode 和多个datanode
+ namenode:hdfs元数据的管理者
+	datanode:存储数据
+	分布式文件
+  每个节点都是一台普通的计算机，底层数据切割为block

### mapReduce
+ JobTracker和TaskTracker
+	分布式计算和任务处理
+	利用一个输入的key/value对集合来产生一个输出的key/value对集合。
+ DataNode既是计算节点也是数据存储节点

### 任务颗粒度
+ 小于或等于64M
## 安装运行
+ 运行方式：单机，伪分布式，完全分布式