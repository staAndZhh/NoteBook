##	特征选择
### PCA
>		//PCA方案1：用SVD实现
		pca1<-prcomp(USArrests, scale = TRUE)
		//PCA方案2：采用线性代数中的实对称均值的对角化实现
		pca2<-princomp(USArrests,cor=T)
		summary(pc1)
### 特征选择
+	卡方
>		library(vcd)//加载vcd数据包
		//准备进行卡检验所需的数据，提取患者性别与治疗效果
		mytable<-xtabs(~Improved+Sex,data=Arthritis)
		//对mytable进行卡方检验
		chisq.test(mytable)
### WOE&IV(证据权重和信息量）
+	WOE概念
	+	原始自变量的一种编码形式
	+	变量进行分组处理（也叫离散化、分箱）
	+	当前分组中响应客户占所有响应客户的比例”和“当前分组中没有响应的客户占所有没有响应的客户的比例”的差异,是用这两个比值的比值，再取对数来表示的。
+ 	IV概念
	+	分组i，也会有一个对应的IV值
	+ ![](https://i.imgur.com/BX5SIox.jpg)
>		//安装和加载woe包。
		install.packages("woe")
		library(woe)
		//计算数据集mtcars中，cyl这一列对目标变量am的woe值和iv值。
		woe(Data=mtcars,"cyl",FALSE,"am",10,Bad=0,Good=1)
###	信息熵
+	信息熵
>		install.packages("entropy")
		library(entropy)
		y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
		//使用max likehood方式计算熵值
		entropy(y,method = "ML")//输出值为：2.327497

+	信息增益
>		y<-c(6,7)
		entropy(y,method = "ML")//输出值为：0.6901857
		2.327-0.69901
### 基尼系数
>		install.packages("ineq")
	library(ineq)
	y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
	Gini(y)//输出结果为：0.3055556
### 相关性
+	协方差与相关系数
>		//计算两列数据之间的相关系数
	cor(mtcars$cyl,mtcars$disp,method = "pearson")//输出值为：0.9020329，表示两列数据正相关
	cor(mtcars$mpg,mtcars$disp,method = "pearson")//输出值为：-0.8475514，表示负相关
	//计算两列数据之间的协方差
	cov(mtcars$cyl,mtcars$disp,method = "pearson")//输出值为：199.6603
	cov(mtcars$mpg,mtcars$disp,method = "pearson")//输出值为：-633.0972

+	偏相关
>		library(ggm)
	data("marks")//加载marks数据集
	var(marks)//计算marks数据集的方差矩阵
	//计算固定analysis,statistics时，vectors和algebra的二阶偏相关系数
	pcor(c("vectors", "algebra", "analysis", "statistics"), var(marks))//输出结果为：0.388203
	pcor(c(2,3,4,5), var(marks))//与上一句代码意义相同
	//偏相关系数的显著性检验，入参分别为：偏相关系数，固定变量个数，样本量
	pcor.test(0.388203,2,dim(marks)[1])//输出值p=0.0002213427，p<0.01，因此，在固定analysis,statistics时，vectors和algebra两个特征存在明显偏相关性

+	Lasso
>		data(diabetes)//加载数据集diabetes
		//使用lasso进行特征选择
		lars(diabetes$x,diabetes$y,type="lasso")
		data<-lars(diabetes$x,diabetes$y)
		summary(data)
## 决策树
>	
### 概念
+ base
	+	
+	信息熵
	+	sum([p*log(1/p) for each p])
+	条件熵
	+	基于 X 的 Y 的信息熵H(y|x)
+	互信息(信息增益）
	+	H(y)-H(y|x)
+	联合熵
	+	两个元素同时发生的不确定度
+	基尼系数
	+	数据集合随机抽2样本，标记不一致的概率
### C3
+	信息增益调整
### C4.5
+	信息增益率调整