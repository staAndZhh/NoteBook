## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## 方块气泡图

library("ggplot2")
windowsFonts(myFont = windowsFont("arial"))

mydata <- data.frame(
  X=c(3,7,11,15,19),
  A=c(2471,1893,1248,1078,556),
  B=c(1385,951,869,784,366),
  C=c(56,7,19,13,40)
  )


mydata$Axmin<- mydata$X-sqrt(mydata$A)/30
mydata$Axmax<- mydata$X+sqrt(mydata$A)/30
mydata$Aymin<-0
mydata$Aymax<- sqrt(mydata$A)/15


mydata$Bxmin<-mydata$X+sqrt(mydata$A)/30 - sqrt(mydata$B)/15
mydata$Bxmax<-mydata$X+sqrt(mydata$A)/30
mydata$Bymin<-0
mydata$Bymax<-sqrt(mydata$B)/15


mydata$Cxmin<-mydata$X+sqrt(mydata$A)/30-sqrt(mydata$C)/10
mydata$Cxmax<-mydata$X+sqrt(mydata$A)/30
mydata$Cymin<-0
mydata$Cymax<-sqrt(mydata$C)/10

mydata$text<-c(
  "University of\n Pennsylvania",
  "University of\n Notre Dame",
  "Princeton\n University",
  "Stanford\n University",
  "California Institute\n of Technology"
  )
mydata$full<-c("31663","16548","27189","34348","5225")



ggplot(mydata)+
  geom_rect(aes(xmin=Axmin,xmax=Axmax,ymin=Aymin,ymax=Aymax),fill="#59AF8A")+
  geom_rect(aes(xmin=Bxmin,xmax=Bxmax,ymin=Bymin,ymax=Bymax),fill="#0074A3")+
  geom_rect(aes(xmin=Cxmin,xmax=Cxmax,ymin=Cymin,ymax=Cymax),fill="#C72733")+
  geom_linerange(aes(x=X+2,ymin=0,ymax=4.8),col="grey",linetype=2)+
  ylim(-.5,6)+
  labs(x="",y="")+
  geom_text(aes(x=X,y=4.5,label=text),size=4,fontface="bold",family="myFont")+
  geom_label(aes(x=X,y=3.7,label=full),fill="#EFE5CA",colour="black",fontface="bold",size=3.5,label.r=unit(0.15,"lines"),family="myFont")+
  geom_text(aes(x=Axmin,y=Aymax,label=A),hjust=-.2,vjust=1,size=3.5,col="white",family="myFont")+
  geom_text(aes(x=Bxmin,y=Bymax,label=B),hjust=-.2,vjust=1,size=3.5,col="white",family="myFont")+
  geom_text(aes(x=Cxmin,y=Cymax,label=C),hjust=-.2,vjust=1,size=3,col="white",family="myFont")+
  annotate("text",x=2.5,y=5.7,label="Class Struggle",col="black", size=6,family="myFont")+  
  annotate("text",x=8.85,y=5.2,label="A spot on a university or college's waitlist rarely translates into admission. A look at the numbers for several institutions", size=4,family="myFont")+  
  annotate("text",x=3.9,y=-.32,label="Source:The universities and 2011-2012 Common Data Set",col="black",size=3,family="myFont")+  
  annotate("text",x=19.8,y=-.32,label="The wall Street Jaunual",col="black",size=3,family="myFont")+  
  theme_void()+
  theme(panel.background=element_rect(fill="#F5F2E1"))


#建议保存尺寸（1035*330）
#--------------------------------------------------------------------------------------------------------------------------
mydata1<-mydata[,c(1,5:8)]
names(mydata1) <- c("X","xmin","xmax","ymin","ymax")

mydata2<-mydata[,c(1,9:12)]
names(mydata2) <- c("X","xmin","xmax","ymin","ymax")

mydata3<-mydata[,c(1,13:16)]
names(mydata3) <- c("X","xmin","xmax","ymin","ymax")

mynewdata<-rbind(mydata1,mydata2,mydata3)
mynewdata$Group <- factor(rep(c("A","B","C"),each = 5),order=T)


ggplot(mynewdata,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,fill=Group))+
  geom_rect()+
  scale_fill_manual(values=c("#59AF8A","#0074A3","#C72733")) +
  geom_linerange(aes(x=X+2,ymin=0,ymax=4.8),col="grey",linetype=2)+
  geom_text(data =mydata,aes(x=X,y=4.5,label=text),size=4,fontface="bold",family="myFont")+
  geom_label(data =mydata,aes(x=X,y=3.7,label=full),fill="#EFE5CA",colour="black",fontface="bold",size=3.5,label.r=unit(0.15,"lines"),family="myFont") +  geom_text(data =mydata,aes(x=Axmin,y=Aymax,label=A),hjust=-.2,vjust=1,size=3.5,col="white",family="myFont")+
  geom_text(data =mydata,aes(x=Bxmin,y=Bymax,label=B),hjust=-.2,vjust=1,size=3.5,col="white",family="myFont")+
  geom_text(data =mydata,aes(x=Cxmin,y=Cymax,label=C),hjust=-.2,vjust=1,size=3,col="white",family="myFont")+
  ylim(-.5,6)+
  labs(x="",y="") + 
  annotate("text",x=2.5,y=5.7,label="Class Struggle",col="black", size=6,family="myFont")+  
  annotate("text",x=8.85,y=5.2,label="A spot on a university or college's waitlist rarely translates into admission. A look at the numbers for several institutions", size=4,family="myFont")+  
  annotate("text",x=3.9,y=-.32,label="Source:The universities and 2011-2012 Common Data Set",col="black",size=3,family="myFont")+  
  annotate("text",x=19.8,y=-.32,label="The wall Street Jaunual",col="black",size=3,family="myFont")+  
  theme_void()+
  theme(
    panel.background=element_rect(fill="#F5F2E1")
    )
  
  
  