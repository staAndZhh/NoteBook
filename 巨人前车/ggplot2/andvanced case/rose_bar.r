## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## circle and bar chart


rm(list = ls())
gc()


library("ggplot2")
library("tidyr")
library("dplyr")
library("grid")
library("showtext")
library("Cairo")
library("scales")


font_add("myfont","msyhl.ttc")
setwd("D:/R/File")

mydata<-read.csv("shudu_data.csv",stringsAsFactors=FALSE,check.names=FALSE) 

mydata <- transform(
  mydata,
  index  = 1:nrow(mydata),
  angle1 = 1.5*seq(-1,-59),
  angle2 = 1.5*seq(59,1)
)


#处理标签
label<-strsplit(mydata$Country,"")
for (i in 1:length(label)){
  label[[i]]<-paste0(label[[i]],collapse="\n")
}
mydata$label<-unlist(label)
mydata$label[37:59]<-gsub("\n","",mydata$label[37:59])

#数据塑性——宽数据转长数据

mynewdata <- mydata  %>%  
  gather(Class,Value,2:4)
mynewdata$Class <- factor(mynewdata$Class,levels=c("环保优先","其他/未回答","经济优先"),order=T)

p1<- ggplot(data=mynewdata,aes(x=index,y=Value,fill=Class))+
  geom_bar(stat="identity",width=0.95)+
  geom_text(aes(y=105,label=ifelse(index<=36,label,""),angle=angle1),hjust=.5,vjust=0,family="myfont")+
  geom_text(aes(y=105,label=ifelse(index>36,label,""),angle=angle2),hjust=0,vjust=0.5,family="myfont")+
  geom_text(aes(y=Value,label=Value,angle=angle2),position=position_stack(vjust=.9),family="myfont")+
  xlim(0.5,236.5)+ylim(-120,105)+
  coord_polar(theta="x")+
  guides(fill=guide_legend(title=NULL))+
  scale_fill_manual(values=c("#2EA7E0","#B5B5B6","#CBE510"))+
  theme_void(base_size=20)  %+replace%
  theme(
    legend.position=c(.95,.75),
    legend.key.size  =unit(.8,'cm')
  )


mydata2<-data.frame(
  year=c("1998年","2004年","2009年","2014年"),
  `经济优先` = c(.24,.27,.23,.28),
  `未回答`   = c(.25,.21,.23,.15),
  `环保优先` =c(.51,.52,.54,.57),
  smallyear=rep(.15,4),
  check.names = FALSE
  )

names(mydata2)[3] <- "其他/未回答"
mydata2$index<-1:nrow(mydata2)


mynewdata2<-mydata2 %>% 
  gather(Class,Value,2:5)

mynewdata2$Class<-factor(
  mynewdata2$Class,
  levels=c("smallyear","环保优先","其他/未回答","经济优先"),
  order=T
  )


p2<-ggplot(data=mynewdata2,aes(x=index,y=Value,fill=Class))+
  geom_bar(stat="identity",width=0.99)+
  geom_text(aes(y=Value,label=ifelse(mynewdata2$Class=="smallyear",levels(mynewdata2$year),""),angle=c(rep(0,12),11.25*seq(-1,-7,-2))),position=position_stack(vjust=.5),family="myfont",size=7.5)+
  geom_text(aes(y=Value,label=ifelse(mynewdata2$Class!="smallyear",percent(mynewdata2$Value),"")),position=position_stack(vjust=.5),family="myfont",size=6)+
  xlim(0.5,16.5)+ylim(-.5,1.25)+
  coord_polar(theta="x")+
  guides(fill=FALSE)+
  scale_fill_manual(values=c("#EFEFEF","#2EA7E0","#B5B5B6","#CBE510"))+
  theme_void()


CairoPNG(file="circletile1.png",width=2000,height=2000)
showtext_begin()

vie <- viewport(width=0.5,height=0.5,x=0.5,y=0.5)
p1;print(p2,vp=vie)
grid.text(
  label="六成中国人认为\n环境比经济更重要",
  x=.99,y=.90,
  gp=gpar(col="black",fontsize=60,draw=TRUE,just="right")
 )

showtext_end()
dev.off()
          