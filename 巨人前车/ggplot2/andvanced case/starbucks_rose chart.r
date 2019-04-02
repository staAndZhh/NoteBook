## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## rose chart of starbucks

rm(list = ls())
gc()

library("rvest")
library("dplyr")
library("ggplot2")
library("grid")
library("showtext")
library("Cairo")
font_add("myfont","msyh.ttc")

#数据获取：
url<-"http://bbs.thmz.com/thread-2715502-1-1.html"
table<-read_html(url,encoding="gbk")%>%
  html_nodes("td.t_f>table")%>%
  html_table(header =TRUE,trim =TRUE,fill=TRUE) %>% 
  as.data.frame()

mydata<-data.frame(
  label=c("上海","北京","杭州","广州","深圳","苏州","成都","天津",
          "南京","武汉","宁波","重庆","西安","无锡","厦门","青岛","长沙","南通","常州","福州")
)

###数据整理
mydata<-merge(mydata,table[,c("城市","门店数量")],by.x="label",by.y="城市",all.x=TRUE)
mydata[mydata$label=="常州","门店数量"]=27
names(mydata)[2]<-"value"
mydata<-arrange(mydata,-value)%>%transform(id=1:20,class=c(1,6,rep(1:6,3)))
mydata$label<-as.character(mydata$label)

#标签拆成单字换行，竖排布局：
label<-strsplit(mydata$label,"")
for (i in 1:length(label)){
  mydata$label_ff[[i]]<-paste0(label[[i]],collapse="\n")
}

mydata[1:2,"label_ff"]<-c("上海","北京")
mydata[16:20,"label_ff"]<-c("青岛","厦门","常州","福州","南通")

#计算标签的旋转角度：
mydata$angle=c(rev(9*(1:10-1)+4.5),-(9*(1:10-1)+4.5))
mydata$angle[16:20]<-rev(9*(1:5-1)+4.5)

#图形可视化过程：

p<-ggplot(mydata)+
  geom_col(aes(x=id,y=value,fill=factor(class)))+
  geom_hline(yintercept =c(25,50,100,200,500),linetype=2,size=.25)+
  geom_text(aes(x=id,y=value+12,label=label_ff,angle=angle),family="myfont",size=3.5,lineheight=1)+
  #坐标轴放大一倍占位：
  scale_x_continuous(limits=c(0,40),expand=c(0,0))+
  #Y延伸到负值突出圆心的空白
  scale_y_continuous(limits=c(-100,600))+
  scale_fill_manual(values=c("#00643E","#207A57","#3D8C6D","#59A284","#76B69B","#95CBB3"),guide=FALSE)+
  coord_polar(start=-14.245)+
  theme_void();p

#图形输出
CairoPNG(file="polar_rose.png",width=2400,height=1800)
showtext_begin()
grid.newpage()
pushViewport(viewport(layout=grid.layout(6,8)))
vplayout<-function(x,y){viewport(layout.pos.row =x,layout.pos.col=y)}
print(p,vp=vplayout(1:6,1:8))
showtext_end()
dev.off()

