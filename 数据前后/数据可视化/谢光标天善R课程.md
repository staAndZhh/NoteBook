# 初级：R快速入门
+	教材
	+ R语言与数据挖掘
	+ R语言游戏数据分析
## 大纲
+	常用数据分析工具对比
+	R&Rstudio&Rattle的安装
+	R语言基本介绍
+	数据输入输出
+	R语言绘图基础
+	R语言描述性统计分析
##	常用数据分析工具对比
+	excel spass matlab R
+	商业：SAS SPSS Clementine
+	开源：R ,R Data Miner, weka （Rweka调用）
### 起源
+	s语言的一种实现
+	数据处理，建模，模型评估
### 优势
+	开源
+	多平台
+	多数据源导入导出
+	内置多种统计和数据分析功能
+	顶尖制图功能
### 缺点
+	基于内存：速度慢
+	R包比较混乱
##	R&Rstudio&Rattle的安装
+	R官网
+	RStudio官网
+	Rattle 可视化数据挖掘工具
	+	Rattle使用RGtk2包提供的Gnome图形用户界面
	+	install.packages("RGtk2")
	+	install.packages("rattle")
+	使用 library(rattle)
+	调用界面：rattle()
##	R语言基本介绍
+	区分大小写
+	赋值： <- 
+	help ?	
+	help.search ??
+	工作控件
+	ls()
+	rm(list=ls())
+	查看包的位置 .libPaths()
+	library() require()
+	runExample()
+	runEXample("xx")
##	数据输入输出
+	向量：c()
	+	length()
	+	mode()
	+	数值,字符，逻辑
+	向量化操作
##	R语言绘图基础
##	R语言描述性统计分析

----------

# R数据对象&基本管理
## 数据类型
+	区别：存储类型，创建方式，结构复杂度，定位和访问个别元素的标记
### 基本数据类型
### 日期类型
+	Sys.Date() as.POSIXlt() ISOdate()
+	Sys.time() strptime()
+	data() strftime()
+	as.Date() format()
+	difftime()
### 查看对象类型
+	methods(as)
+	methods(is)
+	mode()
+	class()
+	typeof()
+	which()
+	which.min()
+	which.max()
## 数据结构
### 向量
### 矩阵
### 数组
### 数据框
### 因子
+	factor(x,levels,labels,exclude,ordered,nmax)
+	levels()
+	gl(n,k,length,labels,ordered)
### 列表
+	unlist()
## 数据管理
+	library(DT)
+	datatable(xx,rownames=F)
### 创建新变量
+	<-
+	attach detach
+	transform
+	ifelse()
+	within()
### 变量哑编码
+	library(caret)
+	dumyVars()
### 变量重命名
+	library(reshape)
+	rename()
+	names()
+	edit()
### 数据整理：粘贴数据结构
+	paste()
+	rbind()	cbind()
+	merge()
### 数据转换函数：transform
### 数据排序：sort order rank
+	order
+	sort
+	rank
### 选定特定的行或者子集：subset
+	subset(xx,xx>0,select(xx,xx))
### 另外的数据操作：sqldf
+	library(sqldf)
+	
### 循环语句
+	for
+	while
+	repeat
### for语句
### if语句
+	if else
+	switch

----------

# R数据导入导出
## R键盘输入数据
+	edit()
+	fix() : x<-edit(x)
## Rstudio导入数据
## 导入文本文件数据
### csv
### excel
+	xlsx
+	XLConnect
## 导入数据库数据
+	RODBC
## 爬取网络数据
+	金融数据 quantmod
+	网络数据表 XML
+	RCurl
----------
# R数据描述性统计&数据抽样
## R数据描述性统计
### 统计指标&位置度量
+	mean() rowMeans()
+	weighted.mean()
+	median()
+	quantile()
### 统计指标&离散程度分析
### 描述性统计分析
### 分组计算描述统计量
### 频数统计
## 数据抽样
### 数据抽样必要性
### 类失衡问题处理SMOTE方法
+	构造人工数据样本的方法：SMOTE方法
+	DNwR包的SMOTE()函数
### 数据随机抽样 sample，createDataPartition函数
+	等比抽样
+	sample()
+	library(caret)
+	createDataPartition():提取百分比子集的下标
### 交叉验证的样本抽样
+	createFolds()
+	createMultiFolds()
+	createResample()
+	数据标准化&缺失值查补： preProcess()

----------
# 数据绘图基础

----------
# 数据高级绘图

----------
# 高级数据探索
## 数据质量分析
### 脏数据
+	缺失值
+	异常值
+	不一致的值
+	重复数据&特殊符号
## 缺失值处理高级方法
+	信息无法获取，获取难度大
+	信息被遗漏
+	属性值不存在
### 影响
+	失去大量有用信息
+	模型不稳定
+	模型准确性
### 缺失值分析
+	简单统计分析
	+	缺失值变量个数据
	+	每个变量的未缺失数
	+	统计变量的缺失数以及缺失率
+	缺失值处理
	+	识别缺失数据
	+	检查数据缺失原因
	+	删除包含缺失值的实例或者用合理的数值（插补）替换缺失值
+	具体处理
	+	识别：is.na() complete.cases() VIM包
	+	删除
		+	删除无效行：na.omit()
		+	有效实例：配对删除法；一些函数有可用选项
	+	最大似然估计 mvmle包
	+	插补缺失值：
		+	单个插补：Hmisc包
		+	多重插补：Mi包 ，Micc包，ammelia包，mitools包
		+	模型插补
+	识别
	+	is.na 
	+	is.na
	+	is.infinite
	+	table(complete.cases(xx))
	+	sum(is.na(xx))
+	列表探索缺失值模式
	+	mice包的 md.pattern() 矩阵或者数据框形式展示缺失值模式的表格
+	图形探索缺失数据
	+	aggr()
	+	library(VIM) 
	+	aggr(sleep,prop=FALSE,numbers=TRUE)
+	缺失值处理方法
	+	删除缺失值个案
	+	主观数据不推荐插补
	+	客观数据插补
+	回归模型查补
	+	插补数据为y，其他数据为样本，线性模型
+	随机森林插补
	+	library(missForeast)
	+	z = missForeast(xx)
	+	xx = z$ximp 
## 异常值监测
+	检验数据是否有录入错误以及不合理的数据
+	样本中的个别值，其数值明显偏离其他的观测值：离群点
+	异常值分析方法：简单统计量分析，3sigma原则，箱型图分析（IQR=Q3-Q1，下界=Q1-1.5IQR,上界=Q3+1.5IQR)
+	qcc包
	+	qcc()   
+	单变量异常值检测
	+	boxplot.stat()
+	聚类分析查找异常值
	+	kmeans()
## 不一致数据
+	矛盾性&不相容性
+	散点图&散点图矩阵
	+	plot
	+	pairs 
	+	library(car):: scatterplotMatrix()
	+	library(lattice)::splom()
+	数值型变量相关系数
+	相关系数可视化
	+	Pearson相关系数据
		+	cor()
		+	cor.test()
		+	library(psych)::corr.test()
		+	library(corrgram)::corrgram()
		+	library(corrplot)::corrplot(cor(data))
		+	library(ellipse)::plotcorr(cor(data))
	+	Spearman秩相关系数
	+	判定系数

----------
# 数据挖掘：统计模型篇章
## 线性回归
+	判定系数
### 简单线性
+	lm()
### 多项式回归
### 多元线性&逐步回归
### 回归诊断
### logit回归
### logit病患识别
### logit信用评分卡
## 降维技术
### 主成分分析
### 主成分demo
### 主成分分类
### 股票指数
### 因子分析
## 聚类算法
### 聚类知识
### 聚类实现
### kmeans
### kemansDemo
### 层级聚类
### 层次聚类
## 关联规则
### 原理
### 可视化
### 关联demo
----------
# 数据挖掘：机器学习篇章
## knn
### 算法
### 实现
### 鸢尾花分类
### 乳腺癌诊断
### 汽车类别识别
## 朴素贝叶斯
### 算法
### 实现
### 糖尿病识别
### 垃圾短信识别
## 决策树
### 算法
### ID3
### demo
## 组合算法
### 原理&adaboost
### bagging
### 随机森林
----------
# 数据挖掘：模型评估
----------

# tips
+	Rattle使用