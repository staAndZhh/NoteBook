##《R语言商务图表与数据可视化》
##课程讲师——杜雨
##课程机构——天善智能


##第一章——R语言基础数据操纵


########1.1 数据处理基础——R语言基础之向量与数据框###############

###系统全局环境配置
options(stringsAsFactors = FALSE)


#1.1 基本数据结构

#向量

var1 <- c("A","B","C","D","E")         #字符型
var2 <- c(21,34,56,54,32)              #数值型
var3 <- c(TRUE,FALSE,TRUE,FALSE,FALSE) #逻辑型

#几种快速生成目标向量的快捷函数：

1:10                  #连续整数序列

rep(1:3,each = 4)     #按照单个序列每一个元素重复指定次数
rep(1:3,times = 4)    #按照单个序列每一个元素重复指定次数

seq(from = 1,to =100 ,by = 5)      #起点-终点-间隔
seq(from = 1,by = 5,length = 20)   #起点-间隔-长度
seq(to = 100,by = 5,length = 20)   #终点-间隔-长度


rev(1:5)  #次序颠倒

letters #内置小写字母字符串对象
LETTERS #内置大写字母字符串对象

sample(1:10,size = 10,replace = FALSE)  #可放回抽样
sample(1:10,size = 10,replace = TRUE)   #不放回抽样

#在R语言中快速生成百分比：

sprintf("%.2f%%",1:10)
sca::percent(seq(0,0.1,0.01),d=2,sep = "")
scales::percent(runif(10,0,1))


#矩阵

martx1 <- matrix(1:40,nrow = 8 ,byrow = FALSE);martx1
martx1 <- matrix(1:40,nrow = 8 ,byrow = TRUE);martx1

martx1 <- matrix(1:40,ncol = 8 ,byrow = FALSE);martx1
martx1 <- matrix(1:40,ncol = 8 ,byrow = TRUE);martx1

#数组

array(1:100,dim = c(10,10))   #dim参数长度为2时，输出结果即为矩阵（矩阵即是数字的二维呈现）
array(1:100,dim = c(4,5,5))   #dim参数是一个数字向量，分别为行-列-第三维度

#数据框

mydata1 <- data.frame(
  name1 = c("A","B","C","D","E"),
  name2 = c(21,34,56,54,32),
  name3 = c(TRUE,FALSE,TRUE,FALSE,FALSE)
)

dim(mydata1)

#列表

mylist <- list(
  object1 = c("A","B","C","D","E"),
  object2 = matrix(1:20,nrow = 4 ,byrow = FALSE),
  object3 = array(1:27,dim = c(3,3,3)),
  object4 = data.frame(
              name1 = c("A","B","C","D","E"),
              name2 = c(21,34,56,54,32),
              name3 = c(TRUE,FALSE,TRUE,FALSE,FALSE)
           )
 )


####1.2 变量格式转换与因子变量####

# 1.2.1 变量格式

#向量内部类型

var1 <- c("A","B","C","D","E")    

typeof(var1)
mode(var1)
class(var1)

var2 <- c(21,34,56,54,32)      

typeof(var2)
mode(var2)
class(var2)

var21 <- c(21.5,34.6,56.3,54.9,3.2)      

typeof(var21)
mode(var21)
class(var21)

var22 <- c(21L,34L,56L,54L,32L)      

typeof(var22)
mode(var22)
class(var22)

var3 <- c(TRUE,FALSE,TRUE,FALSE,FALSE) 

typeof(var3)
mode(var3)
class(var3)
is.vector(var3)


#矩阵

martx1 <- matrix(1:40,nrow = 8 ,byrow = FALSE);martx1

#查看类型
typeof(martx1)
mode(martx1)
class(martx1)

#使用is._函数查看独享符合的类型

is.integer(martx1)
is.numeric(martx1)
is.matrix(martx1)
is.array(martx1)

#matrix to vector
as.numeric(martx1)

#数据框

mydata1 <- data.frame(
  name1 = c("A","B","C","D","E"),
  name2 = c(21,34,56,54,32),
  name3 = c(TRUE,FALSE,TRUE,FALSE,FALSE)
)

#查看类型

typeof(mydata1)
mode(mydata1)
class(mydata1)

is.list(mydata1)
is.data.frame(mydata1)

#数组

myarrary1 <- array(1:100,dim = c(4,5,5))

typeof(myarrary1)
mode(myarrary1)
class(myarrary1)

#列表

mylist <- list(
  object1 = c("A","B","C","D","E"),
  object2 = matrix(1:20,nrow = 4 ,byrow = FALSE),
  object3 = array(1:27,dim = c(3,3,3)),
  object4 = data.frame(
    name1 = c("A","B","C","D","E"),
    name2 = c(21,34,56,54,32),
    name3 = c(TRUE,FALSE,TRUE,FALSE,FALSE)
  )
)

typeof(mylist)
mode(mylist)
class(mylist)


#1.2.2 因子变量的生成与转化：

#由字符型向量生成因子

fact1 <- factor(
      x = rep(LETTERS[1:5],each = 3),
      levels = c("A","B","C","D","E"),
      ordered = FALSE
      )

str(fact1)

typeof(fact1)
mode(fact1)
class(fact1)

is.factor(fact1)


fact1 <- factor(
  x = rep(LETTERS[1:5],each = 3),
  levels = c("A","B","C","D","E"),
  ordered = TRUE
)

str(fact1)

typeof(fact1)
mode(fact1)
class(fact1)

is.factor(fact1)
is.ordered(fact1)

#由数值型变量生成因子

fact2 <- factor(
  x = rep(1:5,each = 3),
  levels = 1:5,
  labels = c("婴儿","儿童","少年","青年","老年"),
  ordered = TRUE
)

str(fact2)

typeof(fact2)
mode(fact2)
class(fact2)

is.factor(fact2)
is.ordered(fact2)

#自定义区间分箱生成因子：

#使用自定义区间分箱
fact3 <- cut(
  x = sample(1:100,size = 100, replace = TRUE),
  breaks =c(0,20,40,60,80,100),
  labels = c("0~20","20~40","40~60","60~80","80~100"),
  include.lowest = TRUE,
  ordered = TRUE
)

#使用分位数作为分箱区间
value1 = sample(1:100,size = 100, replace = TRUE)

qa <- quantile( 
  x = value1,
  probs = seq(0, 1, 0.2)
  )

fact3 <- cut(
  x = value1,
  breaks = qa,
  labels = c("0-20%", "20-40%","40-60%","60-80%", "80-100%"),
  include.lowest = TRUE,
  ordered = TRUE
)

####1.3 数据索引与切片、聚合####

#索引向量：
variable1 <- 1:100

variable1[1:10]            #索引前10个值
variable1[c(4,6,8,9)]      #索引第4、6、8、9个值


variable1[sample(x = c(TRUE,FALSE),size = 100 , replace = TRUE)]      #布尔索引
variable1[variable1%%2 == 0]                                          #条件索引（偶数）实质上是一种特殊的布尔索引


#索引数据框：

mydata1 <- ggplot2::mpg
head(mydata1)
str(mydata1)


#列索引：
mydata1[,c(2,3)]
mydata1[,c("model","displ")]

#行切片：
mydata1[1:5,]
mydata1[c(1,4,6,8,9),]
mydata1[c(1,4,6,8,9),c("model","displ")]

#条件索引
mydata1[mydata1$model=="audi" | mydata1$manufacturer=="mercury",]  #或条件
mydata1[mydata1$model=="a4" & mydata1$manufacturer=="audi",]       #且条件

#使用内置的subset函数来实现基本的切片索引
subset(mydata1,model=="audi"| manufacturer=="mercury",select=c("model","manufacturer","year"))
subset(mydata1,model=="a4" & manufacturer=="audi",select=c("model","manufacturer","year"))

#使用dplyr包里面的更为高效的函数实现切片索引

library(dplyr)
mydata1 %>% filter(model=="audi"| manufacturer=="mercury") %>% select(model,manufacturer,year)
mydata1 %>% filter(model=="a4" & manufacturer=="audi")     %>% select(model,manufacturer,year)

#数据聚合计算

iris1 <- iris
head(iris1)

#transform函数只能基于已有变量进行计算，无法基于新生成的变量进行计算
iris1 <- transform(
     iris1,
     dek=Sepal.Length/Sepal.Width,
     pek=Petal.Length+Petal.Width
  )
head(iris1)
#mutate函数实现了基于新生成的变量进行计算的需求

iris1 <- dplyr::mutate(
  iris1,
  dek=Sepal.Length+Sepal.Width,
  jek=sqrt(dek)
 )

head(iris1)
#within函数

mydata <- data.frame(
  Name = sample(LETTERS[1:20]),
  old  = runif(20,5,65) %>% round(0)
)

mydata <- within(mydata, {
  agecat <- NA
  agecat[old > 55] <- "Elder"
  agecat[old >= 35 & old <= 55] <- "Middle Aged"
  agecat[old < 35] <- "Young"
})

#ifelse
mydata$old_n <- ifelse(
  mydata$old > 55,'Elder',
  ifelse(
    mydata$old >= 35 & mydata$old <= 55,'Middle Aged',"Young"
  )
)

#aggregate聚合函数（只能实现一个聚合指标）

aggregate(Sepal.Length~Species,iris1,mean)
aggregate(Sepal.Length~Species,iris1,sum)

#group_by+summarize实现了基于分组的自由聚合（与SQL中的标准聚合语法group by + 聚合函数如出一辙）

iris1 %>% 
  group_by(Species) %>% 
  summarize(
    means=mean(Sepal.Length),
    sums=sum(Sepal.Length)
    )

#tapply专门用于聚合变量，但也只能聚合一个
tapply(iris1$Sepal.Length,iris$Species,mean)

#plyr包里面的ddply函数是一个极其高效的向量化聚合函数

library("plyr")
ddply(
  iris1,
  .(Species),
  summarize,
  means=mean(Sepal.Length),
  sums=sum(Sepal.Length)
  )

####1.4 数据合并、联结与长宽转换####

#1.4.1 数据合并
data1 <- data.frame(
  name1 = c("A","B","C","D"),
  value = c(34,65,43,76)
)

data2 <- data.frame(
  name1 = c("E","F","G","H"),
  value = c(34,21,78,65)
)

#数据纵向合并
rbind(data1,data2)
dplyr::bind_rows(data1,data2)

#数据横向合并
cbind(data1,data2)
dplyr::bind_cols(data1,data2)

#1.4.2 数据联结

#数据连接在sql中属于一类相当常用的高频数据处理技巧，特别是其中的左连接、内连接等。
#以下介绍R语言内置的数据联结语法merge和dplyr包中连接语句left/right/inner/full_join

TableA <- data.frame(
  id   = c(1,2,4),
  name = c("t1","t2","t4")
)

TableB <- data.frame(
  id = c(1,2,3),
  age = c(18,20,19)
)


merge(TableA,TableB,by = "id" ,all = FALSE)    #内连接
merge(TableA,TableB,by = "id" ,all = TRUE )    #外连接
merge(TableA,TableB,by = "id" ,all.x = TRUE )  #左连接
merge(TableA,TableB,by = "id" ,all.y = TRUE )  #右连接


library("dplyr")

inner_join(TableA,TableB,by = "id") #内连接
left_join(TableA,TableB, by = "id") #左连接
right_join(TableA,TableB,by = "id") #右连接
full_join(TableA,TableB, by = "id") #全连接


TableC <- data.frame(
  id   = c(1,2,4,5),
  name = c("t1","t2","t4","t5")
)

TableD <- data.frame(
  name = c("t1","t2","t4","t4"),
  age  = c(23,54,32,12)
)

semi_join(TableC,TableD, by = "name")
anti_join(TableC,TableD, by = "name")

#向量的交并补集运算

intersect(1:10,6:15)  #交集
union(1:10,6:15)      #并集
setdiff(1:10,6:15)    #差集


#1.4.2 数据长宽转换

library("reshape2")
library("tidyr")

mydata  <-data.frame(
  Name = c("苹果","谷歌","脸书","亚马逊","腾讯"),
  Conpany = c("Apple","Google","Facebook","Amozon","Tencent"),
  Sale2013 = c(5000,3500,2300,2100,3100),
  Sale2014 = c(5050,3800,2900,2500,3300),
  Sale2015 = c(5050,3800,2900,2500,3300),
  Sale2016 = c(5050,3800,2900,2500,3300)
);mydata


#宽转长——melt

mydata1 <- melt(
  mydata,                       #数据集名称
  id.vars=c("Conpany","Name"),  #要保留的主字段
  variable.name="Year",         #转换后的分类字段名称（维度）
  value.name="Sale"             #转换后的度量值名称
);mydata1


#长转宽——dcast
dcast(
  data = mydata1,         #数据集名称
  Name+Conpany ~ Year     #x1+x2+……~class 
  #这一项是一个转换表达式，表达式左侧列       
  #是要保留的主字段（即不会被扩宽的字段，右侧则是要分割的分类变量，扩展之后的       
  #宽数据会增加若干列度量值，列数等于表达式右侧分类变量的类别个数
)

#宽转长——gather

mydata1 <- tidyr::gather(
  data=mydata,             #待转换的数据集名称
  key="Year",              #转换后的分类字段名称（维度）
  value="Sale" ,           #转换后的度量值名称
  Sale2013:Sale2016        #选择将要被拉长的字段组合
);mydata1                  #（可以使用x:y的格式选择连续列，也可以以-z的格式排除主字段）

#长转宽——spread
tidyr::spread(
  data = mydata1,   #带转换长数据框名称
  key =  Year,      #带扩宽的类别变量（编程新增列名称）  
  value = Sale      #带扩宽的度量值 （编程新增列度量值）
  )   

####1.5 字符串处理与正则表达式基础####

#1.5.1 字符串格式化

#paste

myword <- sample(LETTERS,10,replace=FALSE);myword

paste(myword,collapse="-")
paste0(myword,collapse="-")

url<-"http://study.163.com/category/400000000146050#/?p="

num<-1:20
myurl<-paste(url,num,sep="");myurl
myurl<-paste0(url,num);myurl

#str_c
library("stringr")
str_c(url,num,sep = "")  #str_c用法与原生的paste没什么区别

#sprintf()

#%d 整数    %02d   d代表整数；2代表长度；0代表不足长度用0补齐
#%f 浮点数  %4.2f  第一个数字代表总位数；第二个数字代表小数点位数 
#%s 字符串 
#%% 百分比


sprintf("%d%%",1:10)                            #遍历百分比
sprintf("%d-%d-%02d",2001,12,1:30)              #遍历日期
sprintf("有%.1f%%的人评价变形金刚5较差",30.77)
'有30.7%的人评价变形金刚5较差'   
sprintf("%s是阿里巴巴的%s","马云","老板")
'马云是阿里巴巴的老板'

#字符串高阶内容——像在Python中操纵字符串一样在R语言中控制字符串
#包项目主页
#https://github.com/Ironholds/pystr
devtools::install_github("nicolewhite/pystr")

library("pystr")

#顺序参数
sprintf("Hello %s, my name is %s.", "World", "RainDu")
pystr_format("Hello {1}, my name is {2}.", "World", "RainDu")

#灵活强大的字符串传入形式：

pystr_format("Hello {thing}, my name is {name}.", thing="World", name="RainDu")
pystr_format("Hello {thing}, my name is {name}.", c(thing="World", name="RainDu"))
pystr_format("Hello {thing}, my name is {name}.", list(thing="World", name="RainDu"))

#批量化格式化字符串：
supers <- data.frame(
  first=c("Bruce", "Hal", "Clark", "Diana"),
  last=c("Wayne", "Jordan", "Kent", "Prince"),
  is=c("Batman", "Green Lantern", "Superman", "Wonder Woman")
);supers

pystr_format("{first} {last} is really {is} but you shouldn't call them {first} in public.", supers)


#字符串打印print vs cat：

for (i in 1:10){
  print(sprintf("我今年%d岁了！",i))
}

for (i in 1:10){
  cat(sprintf("我今年%d岁了！",i),sep = '\n')
}

#1.5.2 字符串合并与拆分

myword <- c("fff-888","hh-333","ff-666","ccc-666")
result <- strsplit(myword,"-")

#初级方法
mydata <- data.frame(
  word   = myword,
  first  = NA,
  second = NA
)

for(i in 1:length(myword)){
  mydata$first[i]   <- result[[i]][1]
  mydata$second[i]  <- result[[i]][2]
};mydata


#高级方法
do.call(rbind,result)  %>%  cbind(myword,.) %>% data.frame %>% dplyr::rename(name = "V2",value = "V3")
rlist::list.rbind(result) %>%  cbind(myword,.) %>% data.frame %>% dplyr::rename(name = "V2",value = "V3")

#如何在数据框中批量实现合并拆分字符串

myyear<-sprintf("20%02d",sample(0:17,10))
mymonth<-sprintf("%02d",sample(0:12,10))
myday<-sprintf("%02d",sample(0:31,10))
mydata<-data.frame(myyear,mymonth,myday)

#合并
mydata1 <- unite(
  mydata,
  col="datetime",
  c("myyear","mymonth","myday"),
  sep="-",
  remove=FALSE);
mydata1

#拆分
separate(
  data = mydata1,
  col = "datetime",
  into = c("year1","month1","day1"),
  remove = FALSE
  )
tidyr

#1.5.3 字符串替换、抽取与强大的字符串处理工具——正则表达式

length()                    #字符串长度
grep/grepl()                #字符串筛选
sub/gsub()                  #字符串替换
regexpr()/gregexpr()        #返回目标字符串起始位置
substr( )substring()        #字符串截取
str_extract()               #返回匹配值

stringr

#length()

nchar("hello")         #字符长度
length(1:100)          #向量长度
length(ggplot2::mpg)   #数据框长度（列数）
ncol(ggplot2::mpg)     #数据框列数目
nrow(ggplot2::mpg)     #数据框行长度
dim(ggplot2::mpg)

#字符串筛选
grep/grepl()                

myword <- c("fff-888","hh-333","ff-666","ccc-666",'dd-456')

grep("[a-z]{3}",myword,value=FALSE)  #输出符合目标字符串模式的对应记录行位置
grep("[a-z]{3}",myword,value=TRUE)   #输出符合目标字符串模式对应记录的行内容
grepl("[a-z]{3}",myword)             #输出所有行与目标字符串模式是否匹配的布尔值


#字符串替换——sub/gsub() 

myword<-c("fff-888","hh-333","ff-666","ccc-666")
sub("-","",myword)
sub("-","_",myword)
sub("-","*",myword)


myword <- c("fff-888-ccc","hh-333","ff-666","ccc-666")
sub("-","",myword)
gsub("-","",myword)

#字符串定位——regexpr()/gregexpr() 

myword<-c("fff-8880000rrrr","hh-333ccccc","ff-666ooooo","ccc-666jjjjj")
regexpr("\\d{3,}",myword)


myword<-c("fff-8880000rrrr7777","hh-333ccccc","ff-666ooooo","ccc-666jjjjj")
regexpr("\\d{3,}",myword)
gregexpr("\\d{3,}",myword)


#字符串截取函数
substr( )/substring()

myword <- c("fff-8880000rrrr","hh-333ccccc","ff-666ooooo","ccc-666jjjjj")
add <- regexpr("\\d{3,}",myword)

result<-c()
for(i in 1:length(myword)){
  result[i]<-substr(myword[i],add[i],add[i]+attr(add,"match.length")[i]-1)
};result

substring(myword,as.numeric(add),as.numeric(add)+attr(add,"match.length")-1)

#仔细体会substr( )/substring()在使用时的差别：

#字符串提取函数：【这个是stringr包中对基础系统中R字符串处理功能补充最为成功的一个】

str_extract(myword,"\\d{3,}") 


###所以说str_extract函数相当于基础函数中的regexpr()+substring()组合功能，仅仅依赖正则表达式即可，无需太多参数配置。

#str_extract()函数支持正则中使用分组匹配功能，进而实现批量化字符提取，但这块内容属于高阶正则用法，暂不涉及，感兴趣可以
#参考PPT正则部分的参考资料链接。

####1.6 管道函数与向量化函数####

# 当不使用管道函数时代码是这样的：
summarize(
  group_by(iris,
           Species),
  means = mean(Sepal.Length),
  sums = sum(Sepal.Length)
)

# 使用管道函数优化之后

iris %>% 
  group_by(Species) %>% 
  summarize(
    means=mean(Sepal.Length),
    sums=sum(Sepal.Length)
  )

#管道函数传参的一般规则：

myword <- c("fff-888", "hh-333", "ff-666", "ccc-666")
result <- strsplit(myword, "-")
do.call(rbind, result)  %>%  cbind(myword, .) %>% data.frame %>% dplyr::rename(name = "V2", value = "V3")


#在数据抓取中管道函数显得更加神奇！

Name <- read_html(url, encoding = "GBK") %>% #读取url所在的目标网页
  html_nodes("b") %>%                   #选择b节点内容
  html_text(trim = FALSE) %>%           #获取b节点内的文本（清除空格）
  gsub("(\\n\\t|，|\\d|、)", "", .) %>%   #替换掉文本内的所有制表符、标点符号等
  grep("\\S", ., value = T) %>%             #筛选出非空文本
  str_trim(side = "both") %>%             #清除掉文本两侧的空格
  .[1:54] %>%                            #保留字符串向量的1:54个观测值
  .[setdiff(1:54, c(35, 39))]             #剔除掉其中的第35、39个观测值

#向量化函数


#apply  按照维度进行计算

matrix(runif(30,100,1000),nrow = 5) %>% apply(1,mean)
matrix(runif(30,100,1000),nrow = 5) %>% apply(2,mean)


#tapply

tapply(iris1$Sepal.Length,iris$Species,mean)

#plyr::ddply
library("plyr")
plyr::ddply(
  iris,
  .(Species),
  summarize,
  means=mean(Sepal.Length),
  sums=sum(Sepal.Length)
)


#sapply/lapply

sapply (1:3, function(x)x^2)
lapply (1:3,function(x)x^2)   %>% unlist


#l_ply——仅执行任务并放弃输出结果的函数

fun <- function(i) cat(sprintf("你好，%d号！",i),sep = "\n")
l_ply(1:3,fun)

(l_ply(1:3,fun))


####1.7 非结构数据处理之list/json####
library("jsonlite")
library("magrittr")

##jsonlite

#fromJSON()

info_json <- '{"p1":{"name":["Ken"],"age":[24],"interest":["reading","music","movies"],"lang":{"r":[2],"csharp":[4],"python":[3]}},"p2":{"name":["James"],"age":[25],"interest":["sports","music"],"lang":{"r":[3],"java":[2],"cpp":[5]}},"p3":{"name":["Penny"],"age":[24],"interest":["movies","reading"],"lang":{"r":[1],"cpp":[4],"python":[2]}}}'
myjson_info <- info_json %>% fromJSON()
cat(info_json)

#toJSON()
mylist <- list(
  object1 = c("A","B","C","D","E"),
  object2 = matrix(1:20,nrow = 4 ,byrow = FALSE),
  object3 = array(1:27,dim = c(3,3,3)),
  object4 = data.frame(
    name1 = c("A","B","C","D","E"),
    name2 = c(21,34,56,54,32),
    name3 = c(TRUE,FALSE,TRUE,FALSE,FALSE)
  )
)
toJSON(mylist, auto_unbox = FALSE) %>% cat()

##rlist
library("rlist")
setwd("C:/Users/RAINDU/Desktop/R语言数据可视化与商务图表基础/R语言数据可视化与商务图表案例/第一章")

#list.load
mylist <- list.load("mylist.json")

#list.save
list.save(mylist,"mylistnew.json")    #tojson将该列表以json格式字符串文件保存至本地磁盘

#list.select  #批量提取列表结构中的对应字段

homefeed <- fromJSON("homefeed.json",simplifyVector=FALSE)
names(homefeed)

myresult<-homefeed %>% `[[`(2)

str(myresult[[1]])
names(myresult[[1]])

live.seats.taken  <- myresult %>%    #映射
  list.map(live$seats$taken) %>% 
  unlist()    


mydata<-myresult %>% 
  list.select(live$seats$taken,live$fee$original_price) %>%    #批量提取字段（使用list.stack合并,输出数据框）
  list.stack() %>% 
  dplyr::rename(taken=V1,original_price=V2)

mydata<-myresult %>% 
  list.select(live$seats$taken,live$fee$original_price) %>%    #批量提取字段（使用list.rbind合，输出矩阵）
  list.rbind() 

####1.8 R语言与数据库交互####

library("RMySQL")
library("dplyr")

#MySQL数据库连接
conn <- dbConnect(
  MySQL(),
  dbname="db1",       #数据库名称
  username="root",    #登录名称
  password="708965",  #登录密码
  host="127.0.0.1", 
  port=3306
)

dbWriteTable(conn,"mtcars1",mtcars,row.names=F)                   #写表
mydata <- dbReadTable(conn,"mtcars1")                              #读表 
myquery<-  dbSendQuery(conn,
                       "SELECT * FROM mtcars1 where wt between 2.5 and 3.5"
                       ) %>% dbFetch()                           #查询并读取

#使用NoSQL数据集中管理半结构化数据

#安装并加载rmongodb
devtools::install_github("mongosoup/rmongodb")
library("rmongodb")

#创建/断开连接
mongo <- mongo.create(host = "localhost")
mongo.is.connected(mongo)                      #检查是否连接成功
#mongo.destroy(mongo)                          #断开连接

#写入数据

#将list格式数据对象插入mongodb：
mylist <- rlist::list.load("D:/R/File/indy.json")
bson <- mongo.bson.from.list(mylist)
mongo.insert(mongo,ns="rmongodb_test.mydata1",bson)


#将json格式返回值插入mongodb：
json <- toJSON(mylist,auto_unbox = FALSE)
bson <- mongo.bson.from.JSON(json)
mongo.insert(mongo,ns="rmongodb_test.mydata3",bson)


#读取数据：
query = mongo.find.all(mongo, ns = "rmongodb_test.mydata1")

####1.9 高阶数据处理工具之——data.table####

library("data.table")


###I/O性能：

#读取数据
mydata <- fread("https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv")
#写入数据
fwrite(mydata,'mydata.csv')

str(mydata)

###行切片/列索引

carrier <- unique(mydata$carrier)
#[1] "AA" "AS" "B6" "DL" "EV" "F9" "FL" "HA" "MQ" "VX" "WN" "UA" "US" "OO"

tailnum <- sample(unique(mydata$tailnum),5)
#[1] "N332AA" "N813MQ" "N3742C" "N926EV" "N607SW"

origin  <- unique(mydata$origin)
#[1] "JFK" "LGA" "EWR"

dest    <- sample(unique(mydata$dest),5)
#[1] "BWI" "OAK" "DAL" "ATL" "ALB"``

mydata[carrier == "AA"]   #data.table行索引
#等价于
mydata[carrier == "AA",]
#行索引可以直接引用列表，无需加表明前缀，这一点儿数据框做不到,而且i,j,by三个参数对应的条件支持模糊识别，无论加“,”与否都可以返回正确结果。

mydata[carrier %in% c("AA","AS"),]
mydata[carrier %in% c("AA","AS") & dep_delay %between% c(500,1000),.(dep_delay,arr_delay)]  
#支持多条件逻辑筛选

#支持在行索引位置使用%in% 函数。

#data.table列索引 

mydata[,list(carrier,tailnum)]
mydata[,.(carrier,tailnum)]
mydata[carrier %in% c("AA","AS"),.(carrier,tailnum)]
mydata[,.(flight/1000,carrier,tailnum)]
mydata[,delay_all := dep_delay+arr_delay]
mydata[,delay_all := NULL]               #销毁某一列：

#列计算：

mydata[,c("delay_all","delay_dif") := .((dep_delay+arr_delay),(dep_delay-arr_delay))]
#等价于写法2：
mydata[,`:=`(delay_all = dep_delay+arr_delay,delay_dif = dep_delay-arr_delay)]
#销毁新建列：
mydata[,c("delay_all","delay_dif") := NULL]
mydata[carrier %in% c("AA","AS"),.N]      #计数

#支持简单聚合函数
mydata[carrier %in% c("AA","AS"),.(sum(dep_delay),mean(arr_delay))]        
mydata[carrier %in% c("AA","AS"),.(dep_delay,mean(arr_delay))]    #使用简单统计函数（支持自动补齐操作）

#分组聚合运算
mydata[,.(sum(dep_delay),mean(arr_delay)),by = carrier]
mydata[,.(sum(dep_delay),mean(arr_delay)),by = .(carrier,origin)]
mydata[,.N,by = .(carrier,origin)]                                #多分组计数。

#索引的新建列都支持自定义名称
mydata[,.(dep_delay_sum = sum(dep_delay),arr_delay_mean = mean(arr_delay)),by = carrier]
mydata[,.(dep_delay_sum = sum(dep_delay),arr_delay_mean = mean(arr_delay)),by = .(carrier,origin)]
mydata[,.(carrier_n = .N),by = .(carrier,origin)]

#数据排序：  
setorder(mydata,carrier,-arr_delay)  #排序行

#排序列：
sample(names(mydata),length(names(mydata)))
setcolorder(mydata,sample(names(mydata),length(names(mydata))))

#基于分组基础上的聚合运算
mydata[carrier == "AA",
       lapply(.SD, mean),
       by=.(carrier,origin,dest),
       .SDcols=c("arr_delay","dep_delay")
       ]

#数据合并：
#data.table的数据合并方式非常简洁；

DT <- data.table(x=rep(letters[1:5],each=3), y=runif(15))
DX <- data.table(z=letters[1:3], c=runif(3))

#设置各自的主键：
setkey(DT,x)
setkey(DX,z)

DT[DX]

DX LEFT JOIN DT

#长宽转换【见上文】

#######第一章代码部分全部结束######

