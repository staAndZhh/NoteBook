## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## Graphical output&quality control

## 《R语言商务图表与数据可视化》
## 课程讲师——杜雨
## 课程机构——天善智能

########结尾篇：图形输出、精度设置及图层权限操纵######

######一、 图表输出格式######

#清空系统内存
rm(list = ls())
gc()

#### 演示案例  ####
#2.1 导入加载包：
rm(list = ls())
gc()
library("ggplot2")
library("Cairo")
library("xlsx")
library("lubridate")
library("reshape2")
library("showtext")
library("grid")
library("plyr")
library("dplyr")
library("magrittr")

ECOdata <- read.xlsx(
  "D:/R/File/ECOCircle.xlsx",
  sheetName="Sheet1",
  header=T,
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

#2.2 使用循环构造作图数据：
transfun <- function(data){
  f <- c(99,91,84,77)
  for (i in 1:nrow(data)){
    m <- sum(data[i,3:6] == 1)
    h <- grep(1,data[i,3:6])
    data[i,h+2]<- f[1:m]
  }
  return(data)
}

ECOdata <- transfun(ECOdata)

#2.3 
dateseries <- data.frame(
  newdate = seq(from=as.Date("2014-01-01"),to=as.Date("2014-12-31"),by="1 day")
)

mydata <-dateseries %>% mutate(
  newmonth = newdate %>% month(),
  ID       = 1:nrow(dateseries),
  Type     = ifelse(newmonth%%2 == 0,"A","B"),
  Scale    = 100,
  Circle   = c(seq(from=90,to=-90,length=181),seq(from=90,to=-90,length=184))
)


mynewdata <- merge(
  mydata,
  ECOdata,
  by.x="newdate",
  by.y="date",
  all.x= T
)

mynewdataone <- melt(
  na.omit(mynewdata), 
  id.vars =names(mynewdata)[1:7],
  variable.name = "Class", 
  value.name = "Fact"
 )


#月份标签旋转角度：

circlemonth <- seq(15,345,length=12)
circlebj    <- rep(c(-circlemonth[1:3],rev(circlemonth[1:3])),2)

#将事件圆环图的主体部分分为两个图层单独映射（把fill美学标度映射的机会留给后面的散点图，这样散点图可以提供填充色和轮廓色，提升审美水平！）
mynewdataoneA <- mynewdataone %>% filter(Fact!=0 & ID < 180) 
mynewdataoneA <- mynewdataoneA[!duplicated(mynewdataoneA[,1]),]

mynewdataoneB <- mynewdataone %>% filter(Fact!=0 & ID > 180)
mynewdataoneB <- mynewdataoneB[!duplicated(mynewdataoneB[,1]),]

#图形输出：

p <-ggplot()+
  geom_bar(data=mydata[mydata$Type=="A",],aes(x=ID,y=Scale),stat="identity",width=1,fill="#ECEDD1",col="#ECEDD1")+
  geom_bar(data=mydata[mydata$Type=="B",],aes(x=ID,y=Scale),stat="identity",width=1,fill="#DFE0B1",col="#DFE0B1")+
  geom_point(data=mynewdataone[mynewdataone$Fact!=0,],aes(x=ID,y=Fact,fill=Class),size=5,shape=21,col="white")+
  geom_text(data=mynewdataoneA,aes(x=ID,y=max(mynewdataoneA$Fact)+20,label=State,angle=Circle),family="sans",size=5,hjust=0)+
  geom_text(data=mynewdataoneB,aes(x=ID,y=max(mynewdataoneB$Fact)+20,label=State,angle=Circle),family="sans",size=5,hjust=1)+
  geom_text(data=NULL,aes(x=circlemonth,y=30,label=paste0(1:12,"月"),angle=circlebj),family="myfont",size=7,hjust=.5,vjust=.5)+
  ylim(-90,130)+
  scale_x_continuous(expand = c(0,0))+
  scale_fill_manual(limits=c("Legislative","Referendum","President","Primary"),values=c("#93A299","#CF543F","#B5AE53","#86825B"),labels=c("立法","公投","总统","初选"))+
  guides(colour=guide_legend(title=NULL))+
  coord_polar(theta="x")+
  labs(
    title="2014年全球选举事件图",
    subtitle="这是一幅用心良苦的好图",
    caption="Source：Economics\nMake:DataMofang"
  ) +
  theme_void() %+replace%
  theme(
    legend.position=c(0.95,0.92),
    legend.text=element_text(size=20,hjust=0,face="bold",family="myfont"),
    plot.title=element_text(size=50,family="myfont"),
    plot.subtitle=element_text(size=35,family="myfont"),
    plot.caption=element_text(size=25,hjust=0,family="myfont"),
    plot.margin=unit(c(.5,.5,.5,.5),"lines")
  )

#####图形输出——Ciaro、showtext应用####
setwd("C:/Users/RAINDU/Desktop/")

#输出PNG版：
font_add("myfont","msyhl.ttc")
font_families()

CairoPNG(file="C:/Users/RAINDU/Desktop/ECOCircle1.png",width=1000,height=1050)
showtext_begin()
print(p)
showtext_end()
dev.off()


#输出SVG版：
CairoSVG(file="C:/Users/RAINDU/Desktop/ECOCircle3.svg",width=12,height=10)
showtext_begin()
print(p)
showtext_end()
dev.off()


#输出PDF版：
CairoPDF(file="C:/Users/RAINDU/Desktop/ECOCircle4.pdf",width=12,height=10)
showtext_begin()
print(p)
showtext_end()
dev.off()

#显示Cairo当前支持的图形设备：
Cairo.capabilities()

ggsave(
  filename="C:/Users/RAINDU/Desktop/ECOCircle1.png",
  plot = p,
  width  = 10,
  height = 10,
  units = "in"
  )

ggsave(
  filename="C:/Users/RAINDU/Desktop/ECOCircle2.jpeg",
  plot = p,
  width = 10,
  height = 10,
  units = "in"
)

ggsave(
  filename="C:/Users/RAINDU/Desktop/ECOCircle3.pdf",
  plot = p,
  width = 10,
  height = 10,
  units = "in"
)

ggsave(
  filename="C:/Users/RAINDU/Desktop/ECOCircle3.svg",
  plot = p,
  width = 10,
  height = 10,
  units = "in"
)


####精度控制——字体渲染与控制####

#字体解决方案一——使用R为windows提供的字体嵌入函数：

windowsFonts(
  myFont1 = windowsFont("微软雅黑"),
  myFont2 = windowsFont("汉仪行楷简")
  )

data<-data.frame(
  Name = c("苹果","谷歌","脸书","亚马逊","腾讯"),
  Conpany = c("Apple","Google","Facebook","Amozon","Tencent"),
  Sale2013 = c(5000,3500,2300,2100,3100),
  Sale2014 = c(5050,3800,2900,2500,3300),
  Sale2015 = c(5050,3800,2900,2500,3300),
  Sale2016 = c(5050,3800,2900,2500,3300)
)
mydata<-melt(
  data,
  id.vars=c("Name","Conpany"),
  variable.name="Year",
  value.name="Sale"
)

p1 <- ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="stack") +
  geom_text(aes(label = Sale),position=position_stack(vjust = 0.5),family = "myFont1") +
  labs(
    title ="猜猜这是什么字体",
    subtitle = "再猜一猜这是什么字体
    ") +
  theme(
    plot.title = element_text(family = "myFont1",size  = 24),
    plot.subtitle = element_text(family = "myFont2",size= 24)
    )
print(p1)


ggsave(
  filename="C:/Users/RAINDU/Desktop/ggg.png",
  plot = p1,
  width = 13,
  height = 10,
  units = "in"
)

font_add("myfont1","msyhl.ttc")
font_add("myfont2","STXIHEI.TTF")
font_families()

CairoPNG(file="C:/Users/RAINDU/Desktop/eee.png",width=600,height=400)
#字体载入
showtext_begin()
ggplot(mydata,aes(reorder(Conpany,-Sale),Sale,fill=Year))+
  geom_bar(stat="identity",position="stack") +
  geom_text(aes(label = Sale),position=position_stack(vjust = 0.5),family = "myFont1") +
  labs(
    title ="猜猜这是什么字体",
    subtitle = "再猜一猜这是什么字体
    ") +
  theme(
    plot.title = element_text(family = "myfont1",size  = 24),
    plot.subtitle = element_text(family = "myfont2",size= 24)
  )
showtext_end()
dev.off()


####多图排版——多图排版与图形版面整合####

library("ggplot2")
library("grid")

#方案一：使用grid版面函数
chart1 <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) + geom_point()
chart2 <- ggplot(diamonds, aes(carat, depth, colour = color)) + geom_point()
chart3 <- ggplot(diamonds, aes(carat, depth, colour = color)) + geom_point() + facet_grid(.~color) 

grid.newpage()                ###新建页面
pushViewport(viewport(layout = grid.layout(2,2))) ###将版面分成2*2矩阵

vplayout <- function(x,y){
  viewport(layout.pos.row = x, layout.pos.col = y)
}  

print(chart3, vp = vplayout(1,1:2))   ###将（1,1)和(1,2)的位置画图chart3
print(chart2, vp = vplayout(2,1))     ###将(2,1)的位置画图chart2          
print(chart1 ,vp = vplayout(2,2))    ###将（2,2)的位置画图chart1
dev.off()


#方案2——Rmisc::multiplot
library("Rmisc")
library("plyr")


multiplot(chart1,chart2,chart3, cols = 2)
multiplot(chart1,chart2,chart3, layout = matrix(c(1,2,3,3),byrow = TRUE,ncol =2))
multiplot(chart1,chart2,chart3, layout = matrix(c(3,3,1,2),byrow = TRUE,ncol =2))

dev.off()


#方案3——贴图：


chart1 <- ggplot(diamonds,aes(carat,price,colour=cut))+
  geom_point()+
  theme(
    legend.position=c(0.9,0.72),
    legend.background=element_rect(I(0))
    )

chart2 <- ggplot(diamonds,aes(depth,fill=cut,alpha=.2))+
  geom_density()+
  xlim(54,70) +
  theme_void()


print(chart1)
vie <- viewport(width=0.669,height = 0.4,x = 0.7,y = 0.306)
print(chart2,vp = vie)


####图层权限——使用grid越过ggplot2对象权限，添加图形辅助信息####

library("ggplot2")
library("tidyr")
library("dplyr")
library("grid")
library("showtext")
library("Cairo")
library("scales")


font_add("myfont","msyhl.ttc")

mydata <- read.csv("D:/R/File/shudu_data.csv",stringsAsFactors=FALSE,check.names=FALSE) 

mydata$index  <- 1:nrow(mydata)
mydata$angle1 <- 1.5*seq(-1,-59)
mydata$angle2 <- 1.5*seq(59,1)


label<-strsplit(mydata$Country,"")

for (i in 1:length(label)){
  label[[i]]<-paste0(label[[i]],collapse="\n")
}


mydata$label<-unlist(label)
mydata$label[37:59]<-gsub("\n","",mydata$label[37:59])

mynewdata<-mydata %>% gather(Class,Value,2:4)
mynewdata$Class <- factor(mynewdata$Class,levels=c("环保优先","其他/未回答","经济优先"),order=T)

p1<- ggplot(data=mynewdata,aes(x=index,y=Value,fill=Class))+
  geom_bar(stat="identity",width=0.95)+
  geom_text(aes(y=105,label=ifelse(index<=36,label,""),angle=angle1),hjust=.5,vjust=0,family="myfont")+
  geom_text(aes(y=105,label=ifelse(index>36,label,""),angle=angle2),hjust=0,vjust=0.5,family="myfont")+
  geom_text(aes(y=Value,label=Value,angle=angle2),position=position_stack(vjust=.9),family="myfont")+
  xlim(0.5,236.5)+
  ylim(-120,105)+
  coord_polar(theta="x")+
  guides(fill=guide_legend(title=NULL))+
  scale_fill_manual(values=c("#2EA7E0","#B5B5B6","#CBE510"))+
  theme_void(base_size = 20) %+replace%
  theme(
    legend.position=c(.95,.75),
    legend.key.size  =unit(.8,'cm'),
  )


mydata2 <- data.frame(
  year=c("1998年","2004年","2009年","2014年"),
  经济优先=c(.24,.27,.23,.28),
  未回答=c(.25,.21,.23,.15),
  环保优先=c(.51,.52,.54,.57),
  smallyear=rep(.15,4),
  check.names = FALSE
  )

names(mydata2)[3]<-"其他/未回答"
mydata2$index<-1:nrow(mydata2)


mynewdata2<-mydata2%>%gather(Class,Value,2:5)
mynewdata2$Class<-factor(
  mynewdata2$Class,
  levels=c("smallyear","环保优先","其他/未回答","经济优先"),
  order=T
  )

p2<- ggplot(data=mynewdata2,aes(x=index,y=Value,fill=Class))+
  geom_bar(stat="identity",width=0.99)+
  geom_text(aes(y=Value,label=ifelse(mynewdata2$Class=="smallyear",levels(mynewdata2$year),""),angle=c(rep(0,12),11.25*seq(-1,-7,-2))),position=position_stack(vjust=.5),family="myfont",size=7.5)+
  geom_text(aes(y=Value,label=ifelse(mynewdata2$Class!="smallyear",percent(mynewdata2$Value),"")),position=position_stack(vjust=.5),family="myfont",size=6)+
  xlim(0.5,16.5)+ylim(-.5,1.25)+
  coord_polar(theta="x")+
  guides(fill=FALSE)+
  scale_fill_manual(values=c("#EFEFEF","#2EA7E0","#B5B5B6","#CBE510"))+
  theme_void() %+replace%
  theme(
    legend.position="none"
  )


CairoPNG(file="C:/Users/RAINDU/Desktop/circletile1.png",width=2400, height = 2000)
showtext_begin()
vie <- viewport(width=0.5,height=0.5,x=0.5,y=0.5)
p1;print(p2,vp=vie)
grid.text(label="六成中国人认为\n环境比经济更重要",x=.8,y=.90,gp=gpar(col="black",fontsize=60,draw=TRUE,just="right",fontfamily = "myfont"))
showtext_end()
dev.off()
          
          



