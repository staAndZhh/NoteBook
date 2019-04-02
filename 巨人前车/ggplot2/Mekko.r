## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## bar with a unequal width

library("ggplot2")
library("scales")
windowsFonts(myFont = windowsFont("微软雅黑"))


mydata <- data.frame(
  Name=paste0("项目",1:5),
  Scale=c(35,30,20,10,5),
  ARPU=c(56,37,63,57,59)
  )


#构造矩形X轴的起点（最小点）
mydata$xmin<-0
for (i in 2:5){
  mydata$xmin[i]<-sum(mydata$Scale[1:i-1])
}

#构造矩形X轴的终点（最大点）
for (i in 1:5){
  mydata$xmax[i]<-sum(mydata$Scale[1:i])
}


#构造数据标签的横坐标：
for (i in 1:5){
  mydata$label[i]<-sum(mydata$Scale[1:i])-mydata$Scale[i]/2
}

ggplot(mydata)+
  geom_rect(aes(xmin=xmin,xmax=xmax,ymin=0,ymax=ARPU,fill=Name))+
  scale_fill_manual(values=c("#54576B","#BD1F12","#E8BA11","#62962A","#9B56AF"))+
  geom_text(aes(x=label,y=ARPU-3,label=ARPU),size=6,col="white",family="myFont")+
  geom_text(aes(x=label,y=-2.5,label=Scale),size=4,col="black",family="myFont")+
  geom_text(aes(x=label,y=-5.5,label=Name),size=4,col="black",family="myFont")+
  annotate("text",x=16,y=70,label="不等宽柱形图",size=8,family="myFont")+  
  annotate("text",x=14,y=64,label="这是一幅很用心的图表",size=4,family="myFont") + 
  annotate("text",x=11,y=-9.8,label="Source:DataMofang",size=4,family="myFont") + 
  ylim(-10,80)+
  theme_void(base_family = "myFont")

#不等宽堆积百分比图

Mekko<-read.csv("Mekko.csv",stringsAsFactors = FALSE) 
Mekko$Class<-factor(Mekko$Class,order=T)


#构造矩形(Obama)X轴的起点（最小点）
Mekko$xmin<-0
for (i in 2:nrow(Mekko)){
  Mekko$xmin[i]<-sum(Mekko$percent[1:i-1])
}

#构造矩形(Obama)X轴的终点（最大点）
for (i in 1:nrow(Mekko)){
  Mekko$xmax[i]<-sum(Mekko$percent[1:i])
}


#构造数据标签的横坐标：
for (i in 1:nrow(Mekko)){
  Mekko$label[i]<-sum(Mekko$percent[1:i])-Mekko$percent[i]/2
}

mynewdata1<-Mekko[,c(1,6,7)];
mynewdata1$ymin<-0;
mynewdata1$ymax<-Mekko$Obama;
mynewdata1$Type<-"Obama"
mynewdata2<-Mekko[,c(1,6,7)];
mynewdata2$ymin<-Mekko$Obama+Mekko$m;
mynewdata2$ymax<-Mekko$Obama+Mekko$m+Mekko$McCain;mynewdata2$Type<-"McCain"
mynewdata<-rbind(mynewdata1,mynewdata2)

mynewdata$Type<-factor(mynewdata$Type,levels=c("Obama","McCain"),order=T)

ggplot(mynewdata)+
  geom_rect(aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,fill=Type),col="white")+
  scale_fill_manual(values=c("#004C7F","#B70023"))+
  scale_x_continuous(breaks=Mekko$label,labels=Mekko$Class)+
  geom_text(data=Mekko,aes(x=label,y=.25,label=percent(Obama)),size=3.5,col="white",family="myFont")+
  geom_text(data=Mekko,aes(x=label,y=.8,label=percent(McCain)),size=3.5,col="white",family="myFont")+
  labs(
    title="MEKKO-市场细分矩阵图",
    subtitle="这是一幅用心良苦的图表",
    caption="Source:EasyCharts",
    x="",
    y=""
    )+
  theme_grey()  %+replace%
  theme(
    plot.margin=unit(c(2,0,0.5,0),"lines"),
    panel.spacing=unit(c(0,0,0,0),"lines"),
    axis.text.x=element_text(angle=90,size=10),
    legend.position=c(.78,1),
    legend.direction="horizontal",
    plot.title=element_text(size=18,hjust = 0),
    plot.subtitle=element_text(size=14,hjust = 0),
    plot.caption=element_text(size=10,hjust=0)
  )
