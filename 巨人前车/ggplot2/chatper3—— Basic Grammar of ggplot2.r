##《R语言商务图表与数据可视化》
##课程讲师——杜雨
##课程机构——天善智能


##第三章——ggplot2图层语法基础


########3.2 几何图层（美学映射与位置参数）###############

###系统全局环境配置
options(stringsAsFactors = FALSE) #防止数据导入时字符型变量强制转化为因子
setwd("C:/Users/RAINDU/Desktop/R语言数据可视化与商务图表基础/R语言数据可视化与商务图表案例/第三章——ggplot2图层语法基础")
# 锁定本地路径

library("showtext")
library("ggplot2")
library("magrittr")
library("reshape2")

#1、关于参数共享的三种常见情况：


mydata1<-data.frame(x=1:10,y=runif(10,0,100))
mydata2<-data.frame(x=1:10,y=runif(10,0,100))
mydata3<-data.frame(x=1:10,y=runif(10,0,100))
mydata1$class<-sample(LETTERS[1:3],10,replace=T)
mydata1$x1<-runif(10,0,100)
mydata1$y1<-runif(10,0,100)
mydata1



#全部共享：
ggplot(mydata1,aes(x,y))+
  geom_point(size=5,shape=21,colour="black")+
  geom_line()

ggplot()+
  geom_point(data=mydata1,aes(x=x,y=y),size=5,shape=21,fill=NA,colour="black")+
  geom_line(data=mydata1,aes(x=x,y=y))

#只共享数据源：
ggplot(mydata1)+
  geom_point(aes(x=x,y=y),size=5,shape=21,fill=NA,colour="black")+
  geom_line(aes(x=x1,y=y1))

ggplot()+
  geom_point(data=mydata1,aes(x=x,y=y),size=5,shape=21,fill=NA,colour="black")+
  geom_line(data=mydata1,aes(x=x1,y=y1))


#不共享任何成分：
ggplot()+
  geom_line(data=mydata1,aes(x=x,y=y),colour="black")+
  geom_line(data=mydata2,aes(x=x,y=y),colour="red")+
  geom_line(data=mydata3,aes(x=x,y=y),colour="blue")

#2、关于美学映射参数写在aes函数内部与外部的区别：


ggplot()+
  geom_point(data=mydata1,aes(x=x,y=y),colour="black",size=5)

ggplot()+
  geom_point(data=mydata1,aes(x=x,y=y,colour=x1),size=5)


###ggplot2所支持的数据源：

ggplot(data=NULL)+geom_point(aes(x=1:10,y=1:10,size=1:10))     
ggplot(data=NULL)+geom_point(aes(x=1:10,y=1:10,size=1:9))       
ggplot(data=NULL)+geom_point(aes(x=1:10,y=5,size=1:10))       



#3、关于几何对象与统计变化的差异：

x <- c(rnorm(100,14,5)) 
y <- c(rnorm(100,14,5) + rnorm(100,0,1))

#散点图：

#使用geom_xxx几何对象构建散点图形：
ggplot(data= NULL, aes(x = x, y = y)) +  
  geom_point(color = "darkred" , stat = "identity")

#使用stat统计变换几何对象构建散点图形：
ggplot(data= NULL, aes(x = x, y = y)) +  
stat_identity(color = "darkred" , geom = "point") 

#柱形图：

x <- sample(LETTERS[1:5],size = 20,replace = TRUE )
y <- runif(20,1,50)

#频率图
ggplot(data = NULL , aes(x =x)) +
  geom_bar(stat = "count")

ggplot(data = NULL , aes(x =x)) +
stat_count(geom = "bar")

#类别求和：

ggplot(data = NULL , aes(x =x , y = y)) +
  geom_bar(stat = "identity")

ggplot(data = NULL , aes(x =x , y = y)) +
  geom_bar(stat = "sum")

ggplot(data = NULL , aes(x =x , y = y)) +
  geom_col()  

###4、位置调整参数（position）:
###位置参数调整：

data<-data.frame(
  Conpany = c("Apple","Google","Facebook","Amozon","Tencent"),
  Sale2015 = c(5000,3500,2300,2100,3100),
  Sale2016 = c(5050,3800,2900,2500,3300))

library(reshape2)

mydata <- melt(data,id.vars="Conpany",variable.name="Year",value.name="Sale")	

#多序列保持不变：
ggplot(mydata,aes(Conpany,Sale,fill=Year))+
  geom_bar(stat="identity",position="identity",alpha=.5)
#多序列簇状柱形图：		 
ggplot(mydata,aes(Conpany,Sale,fill=Year))+
  geom_bar(stat="identity",position="dodge")
#多序列堆积柱形图：		 
ggplot(mydata,aes(Conpany,Sale,fill=Year))+
  geom_bar(stat="identity",position="stack")
#多序列百分比堆积柱形图：		 
ggplot(mydata,aes(Conpany,Sale,fill=Year))+
  geom_bar(stat="identity",position="fill")


###3.6 分面系统：

###分面案例：
data<-data.frame(Name = c("苹果","谷歌","脸书","亚马逊","腾讯"),Conpany = c("Apple","Google","Facebook","Amozon","Tencent"),Sale2013 = c(5000,3500,2300,2100,3100),Sale2014 = c(5050,3800,2900,2500,3300),Sale2015 = c(5050,3800,2900,2500,3300),Sale2016 = c(5050,3800,2900,2500,3300))
mydata<-melt(data,id.vars=c("Name","Conpany"),variable.name="Year",value.name="Sale")

ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="dodge")


###按列分面
ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="dodge")+
  facet_grid(.~Year)   

###按行分面
ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="dodge")+
  facet_grid(Year~.)   

###使用封装分面
ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="dodge")+
  facet_wrap(~Year) 






