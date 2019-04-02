## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## visualization of geospatial and data map_case and model 

## 《R语言商务图表与数据可视化》
## 课程讲师——杜雨
## 课程机构——天善智能

########第十章：空间可视化与数据地图基础案例应用########


####10.1 连续填充热力地图案例应用####
rm(list = ls())
gc()

library("ggplot2")
library("plyr")
library("rgdal")
library("magrittr")
library("dplyr")

china_map <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)

mydata1   <- china_map@data %>% mutate(id = row.names(.)) %>% select(id,NAME) #sp地图对象中的行政区划信息    
china_map1 <- fortify(china_map)  %>% select(id,long,lat,group,order)         #sp地图对象中的多边形边界点信息
china_map_data <- left_join(china_map1,mydata1,by = "id")                     #合并两个数据框


mydata2   <- read.csv("D:/R/rstudy/Province/geshengzhibiao.csv",stringsAsFactors = FALSE)   #读取业务指标数据(csv格式)
mydata2$zhibiao <- as.numeric(mydata2$zhibiao)
final_data <- left_join(china_map_data,mydata2,by = "NAME") %>% select(-province)           #合并地理信息数据和业务数据
head(final_data)

#1、常见的热力填色地图：
ggplot() +
  geom_polygon(data = final_data,aes(x = long,y = lat, group = group,fill = zhibiao),colour="grey40") +
  scale_fill_gradient(low="white",high="Blue") +  
  coord_map("polyconic") +       #指定投影方式为polyconic(多圆锥投影)，获得常见视角中国地图
  theme_void()

ggplot() +
  geom_polygon(data = final_data,aes(x = long,y = lat, group = group,fill = zhibiao),colour="grey40") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  coord_map("polyconic") + 
  theme_void()

#2、关于数据地图的数据标签：

#2.1 直接使用带有经纬度点坐标的数据
windowsFonts(myFont=windowsFont("微软雅黑"))
province_city <- read.csv("D:/R/rstudy/Province/chinaprovincecity.csv",stringsAsFactors = FALSE)  #读取省会城市坐标

ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill = zhibiao),colour="grey60")+
  geom_point(data = province_city,aes(jd,wd,colour = class,size = zhibiao))+  
  #geom_text(data = province_city,aes(x = jd,y = wd,label = province),family= "myFont") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  scale_colour_brewer(palette = "RdBu",na.value = "white") +    
  scale_size_area(max_size = 10) +
  coord_map("polyconic") +
  theme_void()


#问题1
#1、全部添加标签导致空间挤压
#2、有些省份省会坐标过于靠近导致标签重合


#2.2 使用聚合函数聚合出各个省份（地区)的多边形区域中心坐标作为标签、散点图位置

midpos <- function(mydata1) mean(range(mydata1,na.rm=TRUE))
centres <- ddply(china_map_data,.(NAME),colwise(midpos,.(long,lat)))

ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill = zhibiao),colour="grey60")+
  geom_point(data = province_city,aes(jd,wd,colour = class,size = zhibiao))+  
  geom_text(data = centres,aes(x = long,y = lat,label = NAME),family= "myFont") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  scale_colour_brewer(palette = "RdBu",na.value = "white") +    
  scale_size_area(max_size = 10) +
  coord_map("polyconic") +
  theme_void()

#问题：
#1、少数省份标签偏离本土位置太远（如海南岛）

top_10 <- top_n(province_city, 10, zhibiao) %>% .[,"province"]
label_data <- centres %>% filter(centres$NAME %in% top_10)
ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill = zhibiao),colour="grey60")+
  geom_point(data = province_city,aes(jd,wd,colour = class,size = zhibiao))+  
  geom_text(data = centres,aes(x = long,y = lat,label = NAME),family= "myFont") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  scale_colour_brewer(palette = "RdBu",na.value = "white") +    
  scale_size_area(max_size = 10) +
  coord_map("polyconic") +
  theme_void()

#问题：
#仍然无法解决标签遮挡问题：

ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill = zhibiao),colour="grey60")+
  geom_point(data = province_city,aes(jd,wd,colour = class,size = zhibiao))+  
  ggrepel::geom_text_repel(data = centres,aes(x = long,y = lat,label = NAME),family= "myFont") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  scale_colour_brewer(palette = "RdBu",na.value = "white") +    
  scale_size_area(max_size = 10) +
  coord_map("polyconic") +
  theme_void()

####10.2 离散填充热力地图案例应用####

library("ggplot2")
library("plyr") 
library("magrittr")
library("dplyr")
library("rgdal")      
library("RColorBrewer") 
library("ggthemes")
rm(list = ls())
gc()

windowsFonts(myFont = windowsFont("微软雅黑"))  
china_map <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)

mydata1   <- china_map@data %>% mutate(id = row.names(.)) %>% select(id,NAME) 
china_map1 <- fortify(china_map)  %>% select(id,long,lat,group,order)
china_map_data <- left_join(china_map1,mydata1,by = "id")

mydata2   <- read.csv("D:/R/rstudy/Province/geshengzhibiao.csv",stringsAsFactors = FALSE)
mydata2$zhibiao <- as.numeric(mydata2$zhibiao)


#连续性变量分箱：等距分箱与自定义分箱

#根据自己的数据量级和具体业务需要设置分割点

mydata2$fau <- cut(
  mydata2$zhibiao, 
  breaks = c(5,7,9,11,13,15),
  labels = c('5~7','7~9','9~11','11~13','13~15'),
  order = TRUE,
  include.lowest = FALSE, 
  right = TRUE
  ) 

#mydata$fau <- cut(mydata2$zhibiao, breaks = 5) 

###合并分箱后的业务指标等级数据和地理信息数据
final_data <- left_join(china_map_data,mydata2,by = "NAME") %>% select(-province)

#带有各省经纬度数据的辅助数据（可制作散点图、数据标签）
province_city <- read.csv("D:/R/rstudy/Province/chinaprovincecity.csv",stringsAsFactors = FALSE)  


ggplot() +
  geom_polygon(data = final_data,aes(x = long, y = lat, group = group,fill =fau),colour="grey60", na.rm = TRUE)+
  ggrepel::geom_text_repel(data =province_city,aes(x = jd,y = wd,label = province), family="myFont")+
  scale_fill_brewer(palette="Greens") +  ###Blues&Greens
  coord_map("polyconic") +
  labs(title = "某公司2015~2016年度营业状况分布图")+ 
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+       
  theme_void()

#连续性变量分箱：分位数分箱

mydata2$zhibiao_q <- cut(
  mydata2$zhibiao,
  breaks = quantile(na.omit(mydata2$zhibiao),probs = seq(0,1,.2)),
  labels = c("0-20%", "20-40%","40-60%","60-80%", "80-100%"),
  include.lowest=TRUE
  )

###合并分箱后的业务指标等级数据和地理信息数据
final_data <- left_join(china_map_data,mydata2[,c("NAME","zhibiao_q")],by = "NAME")

ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill=zhibiao_q),colour="grey65")+
  scale_fill_brewer(palette="Greens")+
  coord_map("polyconic") +
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+ 
  labs(title = "某公司2015~2016年度营业状况分布图")+
  theme_void() +
  theme(
    title=element_text(family="myFont"),
    legend.position = c(0.9,0.4),
    legend.text.align=1
  ) 

#关于配色问题
#The following palettes are available for use with these scales:
#  
#  Diverging
#BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral
#
#Qualitative
#Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
#
#Sequential
#Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, 
#Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd

###不合理搭配情况——1
ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill=zhibiao_q),colour="grey65")+
  scale_fill_brewer(palette="Paired")+
  coord_map("polyconic") +
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+ 
  labs(title = "某公司2015~2016年度营业状况分布图")+
  theme_void() +
  theme(
    title=element_text(family="myFont"),
    legend.position = c(0.9,0.4),
    legend.text.align=1
  ) 


###不合理搭配情况——2
ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill=zhibiao_q),colour="grey65")+
  scale_fill_brewer(palette="BrBG")+
  coord_map("polyconic") +
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+ 
  labs(title = "某公司2015~2016年度营业状况分布图")+
  theme_void() +
  theme(
    title=element_text(family="myFont"),
    legend.position = c(0.9,0.4),
    legend.text.align=1
  ) 

###自定义配色：
ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill=zhibiao_q),colour="grey65")+
  scale_fill_manual(values=c("#c72e29","#016392","#be9c2e","#098154","#fb832d"))+
  coord_map("polyconic") +
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+ 
  labs(title = "某公司2015~2016年度营业状况分布图")+
  theme_void() +
  theme(
    title=element_text(family="myFont"),
    legend.position = c(0.9,0.4),
    legend.text.align=1
  ) 

scales::show_col(c("#c72e29","#016392","#be9c2e","#098154","#fb832d"),labels = FALSE)

color = c("#edf8fb","#b2e2e2","#66c2a4","#2ca25f","#006d2c")
scales::show_col(color,labels = FALSE)

ggplot()+
  geom_polygon(data = final_data,aes(long,lat,group=group,fill=zhibiao_q),colour="grey65")+
  scale_fill_manual(values=color) +
  coord_map("polyconic") +
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+ 
  labs(title = "某公司2015~2016年度营业状况分布图")+
  theme_void() +
  theme(
    title=element_text(family="myFont"),
    legend.position = c(0.9,0.4),
    legend.text.align=1
  ) 

####10.3 地图+散点图（气泡图）案例应用####

#1 大小 + 颜色分类
ggplot() +
  geom_polygon(data = final_data,aes(x = long, y = lat, group = group,fill = zhibiao_q),colour="grey60", na.rm = TRUE)+
  geom_point(data = province_city,aes(x = jd,y = wd,size = zhibiao , colour = class)) +
  ggrepel::geom_text_repel(data =province_city,aes(x = jd,y = wd,label = province), family="myFont") +
  scale_fill_brewer(palette="Greens") +  ###Blues&Greens
  scale_colour_wsj() + 
  coord_map("polyconic") +
  labs(title = "某公司2015~2016年度营业状况分布图")+ 
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+       
  theme_void()


#2 颜色 + 形状分类：
ggplot() +
  geom_polygon(data = final_data,aes(x = long, y = lat, group = group,fill = zhibiao_q),colour="grey60", na.rm = TRUE)+
  geom_point(data = province_city,aes(x = jd,y = wd,shape = class,colour = class),size = 5) +
  ggrepel::geom_text_repel(data =province_city,aes(x = jd,y = wd,label = province), family="myFont") +
  scale_fill_brewer(palette="Greens") +  ###Blues&Greens
  scale_shape_manual(values = c(6,15,16,17,18)) +
  scale_colour_wsj() + 
  coord_map("polyconic") +
  labs(title = "某公司2015~2016年度营业状况分布图")+ 
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+       
  theme_void()

#3 颜色标度重合问题解决方案：

ggplot() +
  geom_polygon(data = final_data, aes(x=long,y=lat,group=group,fill= zhibiao_q),colour="grey65")+
  geom_point(data=province_city,aes(x=jd,y=wd,size= zhibiao,fill= class),shape=21,colour="#8E0F2E",alpha=0.6)+     
  scale_fill_brewer(palette = "Greens") + 
  scale_fill_brewer(palette="Reds") +  ###Blues&Greens 
  scale_size_area(max_size=6) +
  coord_map("polyconic") +
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(
    fill=guide_legend(reverse=TRUE,title=NULL),
    size=guide_legend(reverse=TRUE,title=NULL)
    )+   
  theme_map() %+replace% 
  theme(
    legend.position = c(0.08,0.4),
    legend.text.align=1
    )  

#问题：
#使用了点形状中的21号点（还记得21~25号点是既有colour属性又有fill属性等）
#使用21号点制作的散点图比较优美、圆润，容易调整效果，
#但是使用fill属性来映射点颜色导致与geom_polygon图层内的fill属性标度重合
#（一个ggplot()系统内不允许出现两个同名标度【即便一个是离散颜色、一个是连续颜色也不行】）
#迂回的方法，放弃点的填充色，使用0~20号点，只用colour属性来控制颜色，结果就是点只有填充色，没有轮廓色看起来不是很协调

ggplot() +
  geom_polygon(data = final_data, aes(x=long,y=lat,group=group,fill=zhibiao_q),colour="grey65")+
  geom_point(data=province_city,aes(x=jd,y=wd,size = zhibiao, colour = class),shape=20,alpha=0.6)+     
  scale_fill_brewer(palette = "Greens") +  
  scale_colour_brewer(palette="Reds") +  ###Blues&Greens & Reds                                                      整
  scale_size_area(max_size=10) +
  coord_map("polyconic") +
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(
    fill=guide_legend(reverse=TRUE,title=NULL),
    size=guide_legend(reverse=TRUE,title=NULL)
  )+   
  theme_map() %+replace% 
  theme(
    legend.position = c(0.95,0.4),
    legend.text.align=1
  )  

####10.4 美国两个海外州位置平移问题####
rm(list = ls())
gc()


library("ggplot2")
library("RColorBrewer")
library("ggthemes")
library("ggmapr")
library("plyr")
library("dplyr")

mymapdata <- states %>% filter(NAME!="Puerto Rico")
ggplot()+
  geom_polygon(data = mymapdata,aes(x = long,y = lat,group = group),fill="grey95",col="grey")+
  coord_map("polyconic")+
  theme_map()


#调整方案1——综合效果（欠佳）

fun <- function(data){
  data1<-subset(data,NAME!='Alaska'& NAME!='Hawaii')
  data2<-subset(data,NAME=="Hawaii")%>% transform(long=long+65,lat=lat+5)
  data3<-subset(data,NAME=="Alaska")%>% transform(long=(long+40)*.3-78,lat=(lat-42)*.3+20)
  mydata<-rbind(data1,data2,data3)
}
American_data <- fun(mymapdata)

###合并地理信息数据与选举数据：
newdata <- read.csv("D:/R/File/President.csv",stringsAsFactors=FALSE,check.names=FALSE)
American_data <- merge(American_data,newdata,by.x="NAME",by.y="STATE_NAME")

###提取各州中心经纬度指标：
midpos <- function(AD1) mean(range(AD1,na.rm=TRUE))
centres <- ddply(American_data,.(NAME),colwise(midpos,.(long,lat)))
centres$NAME <- as.character(centres$NAME)
mynewdata <- left_join(centres,newdata,by = c("NAME" = "STATE_NAME"))

ggplot()+
  geom_polygon(data=American_data,aes(x=long,y=lat,group=group),colour="grey",fill="white")+
  geom_point(data=mynewdata,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=15)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic") +
  theme_map() %+replace% 
  theme(legend.position ="none")

#2 调整方案2——使用grid包把海外两州拼到主图上：

library("grid") 
midpos <- function(AD1) mean(range(AD1,na.rm=TRUE))
centres <- ddply(mymapdata,.(NAME),colwise(midpos,.(long,lat)))
#计算中心经纬度：
mynewdata  <- merge(centres,newdata,by.x="NAME",by.y="STATE_NAME")
mynewdata1 <- subset(mynewdata,NAME!='Alaska'& NAME!='Hawaii')    
mynewdata2 <- subset(mynewdata,NAME=="Hawaii")    
mynewdata3 <- subset(mynewdata,NAME=="Alaska") 

#将美国各州的经纬度中心也三成三分

#定制一个主题：
mytheme <- theme_map() %+replace% 
  theme(
    legend.position ="none",
    plot.background=element_rect(I(0),linetype=0)
    )

#做了三个ggplot图表对象：

p1<- subset(mymapdata,NAME!='Alaska'& NAME!='Hawaii') %>%   #图一，只含美国大陆本土
  ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group),colour="grey",fill="white",size=.2)+
  geom_point(data=mynewdata1,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=10)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic") +
  mytheme

p2<-subset(mymapdata,NAME=="Hawaii")%>%     #图二，只包含夏威夷州
  ggplot()+  
  geom_polygon(aes(x=long,y=lat,group=group),colour="grey",fill="white",size=.2)+    
  geom_point(data=mynewdata2,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=10)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic") +
  mytheme

p3 <- subset(mymapdata,NAME=="Alaska")%>%    #图三，只包含阿拉斯加：
  ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group),colour="grey",fill="white",size=.2)+  
  geom_point(data=mynewdata3,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=10)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic") +
  mytheme

#将三个图表独享拼贴在一起（具体的位置要一点儿一点儿调试）
p1
vs <- viewport(width=0.1,height=0.1,x=0.35,y=0.16)    
print(p2,vp=vs) 
vs <- viewport(width=0.2,height=0.2,x=0.2,y=0.2)   
print(p3,vp=vs)  


#问题：不是在同一个ggplot系统内生成的散点大小标度，导致标度失真（不统一），夏威夷和阿拉斯加的散点应该很小才对

#3、使用ggmapr包调整
rm(list=ls())
gc()

newdata <- read.csv("D:/R/File/President.csv",stringsAsFactors=FALSE,check.names=FALSE)  #从新读入美国大选的选票数据集：
 
states <-states %>%     #该函数可以很方便的将海外两州进行调整
  filter(NAME!="Puerto Rico") %>% 
  shift(NAME=="Hawaii",shift_by=c(52.5,5.5)) %>%
  scale(NAME=="Alaska",scale=0.25,set_to=c(-117,27)) %>% filter(lat>20)

#获取各州多边形中心经纬度中心坐标：
midpos <- function(AD1) mean(range(AD1,na.rm=TRUE))
centres <- ddply(states,.(NAME),colwise(midpos,.(long,lat)))
centres$NAME <- as.character(centres$NAME)

#合并投票结果数据
mynewdata <-left_join(centres,newdata,by = c("NAME" = "STATE_NAME"))


#美国总统大选各州选举人票数分布：
ggplot()+
  geom_polygon(data=states,aes(x=long,y=lat,group=group),colour="grey",fill="white")+
  geom_point(data=mynewdata,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=15)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic") +
  theme_map() %+replace% 
  theme(legend.position ="none")


#综合结果来看，成功做到位置平移，成功显示大小，但是投影仍然存在问题

#4 使用albersusa包（最佳）

library("albersusa")
mapdata <-usa_composite() %>% fortify(us,region="name")     #这是该包中处理过位置偏移的地理位置信息
midpos <- function(AD1){mean(range(AD1,na.rm=TRUE))} 
centres<- ddply(mapdata,.(id),colwise(midpos,.(long,lat)))  #获取各州中心点经纬度坐标：
mynewdata<-merge(centres,newdata,by.x="id",by.y="STATE_NAME")

ggplot()+
  geom_polygon(data=mapdata,aes(x=long,y=lat,group=group),colour="grey",fill="white")+
  geom_point(data=mynewdata,aes(x=long,y=lat,size=Count,fill=Count),shape=21,colour="black")+
  scale_size_area(max_size=15)+ 
  scale_fill_gradient(low="white",high="#D73434")+
  coord_map("polyconic")+
  theme_map() %+replace% 
  theme(legend.position ="none")

#BingGo！,这才是我想要的效果！！！

####10.5 世界地图空间投影参数设置####

library("ggplot2")
library("plyr")
library("rgdal")
library("magrittr")
library("dplyr")
library("maptools")
library("magrittr")
rm(list = ls())
gc()

world_map <-readOGR("D:/R/rstudy/wold_map/World_region.shp",stringsAsFactors=FALSE)
division <- world_map@data %>% mutate(id = row.names(.)) %>% select(id,COUNTRY,POP_1994)  #含岛屿共251个形状
division$POP_1994 <- as.numeric(division$POP_1994)

division$fau <- cut(
  division$POP_1994, 
  breaks = quantile(na.omit(division$POP_1994),probs = seq(0,1,.2)),
  labels = c("0-20%", "20-40%","40-60%","60-80%", "80-100%"),
  order = TRUE,
  include.lowest = FALSE, 
  right = TRUE
) 

world_map1 <- fortify(world_map)  %>% select(id,long,lat,group,order)                     #转化为数据框
world_map_data <- merge(world_map1, division, by = "id")                                  #合并两个数据框


windowsFonts(myFont = windowsFont("微软雅黑"))
ggplot() +
  geom_polygon(data = world_map_data, aes(x = long, y = lat, group = group,fill = fau),colour="grey65",size = .25) +
  scale_fill_brewer(palette="Blues") +  ###Blues&Greens  
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+    
  theme_void() %+replace%
  theme(
    title=element_text(family="myFont"),               
    legend.position = c(0.08,0.4)
  ) 

###球型投影：

ggplot() +
  geom_polygon(data = world_map_data, aes(x = long, y = lat, group = group,fill = fau),colour="grey65",size = .25) +
  scale_fill_brewer(palette="Blues") +  ###Blues&Greens 
  scale_x_continuous(breaks = seq(-180,180,30)) +
  scale_y_continuous(breaks = seq(-90,90,15)) +  
  coord_map("ortho", orientation = c(30,120,0))+
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+    
  theme_void() %+replace%
  theme(
    panel.grid.major.x = element_line(colour = "grey65",size = .25),
    panel.grid.major.y = element_line(colour = "grey65",size = .25),
    title=element_text(family="myFont"),               
    legend.position = c(0.98,0.3)
  ) 

# 将世界地图显示范围聚焦到一定的经纬度范围内：

#方案一——使用xlim、ylim函数限制：
ggplot() +
  geom_polygon(data = world_map_data, aes(x = long, y = lat, group = group,fill = fau),colour="grey65",size = .25) +
  scale_fill_brewer(palette="Blues") +  ###Blues&Greens 
  xlim(75,150) +
  ylim(15,60) +
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+    
  theme_void() %+replace%
  theme(
    title=element_text(family="myFont"),               
    legend.position = c(0.08,0.4)
  ) 

#方案二——使用坐标系函数内的经纬限制：

ggplot() +
  geom_polygon(data = world_map_data, aes(x = long, y = lat, group = group,fill = fau),colour="grey65",size = .25) +
  scale_fill_brewer(palette="Blues") +  ###Blues&Greens 
  coord_cartesian(xlim = c(75,155),ylim = c(15,60)) +
  labs(title = "某公司2015~2016年度营业状况分布图")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+    
  theme_void() %+replace%
  theme(
    title=element_text(family="myFont"),               
    legend.position = c(0.98,0.4)
  ) 


####10.6 地理信息可视化与分面综合应用####
library("ggplot2")
library("plyr")
library("rgdal")
library("magrittr")
library("dplyr")
library("maptools")
library("magrittr")
rm(list = ls())
gc()

###案例一

CHN_adm2 <- readOGR("D:/R/rstudy/CHN_adm/CHN_adm2.shp",stringsAsFactors=FALSE) 
CHN_adm2_1 <- fortify(CHN_adm2) %>% select(id,long,lat,group,order)  
data1 <- CHN_adm2@data %>% mutate(id = row.names(.)) %>%  select(id,NAME_1,NAME_2)        
china_map_data <- merge(CHN_adm2_1,data1, by= "id") 
dongsansheng <-subset(china_map_data,NAME_1==c("Heilongjiang","Jilin","Liaoning")) 
dongsansheng$NAME_1 <- as.character(dongsansheng$NAME_1)

mydata <- read.csv("D:/R/rstudy/State/dongsansheng.csv",header=T,stringsAsFactors=FALSE)
dongsansheng<-within(dongsansheng,{
  NAME_1[NAME_1=="Heilongjiang"]="黑龙江"
  NAME_1[NAME_1=="Jilin"]="吉林"
  NAME_1[NAME_1=="Liaoning"]="辽宁"
})

dongsansheng <- merge(dongsansheng,mydata[,c("NAME_2","city","zhibiao")],by ="NAME_2")

midpos  <- function(x) mean(range(x,na.rm=TRUE))
centres <- ddply(dongsansheng,.(NAME_2),colwise(midpos,.(long,lat)))
mydata  <- merge(centres,mydata) %>% rename(NAME_1 = Province)

windowsFonts(myFont = windowsFont("微软雅黑"))
ggplot() +
  geom_polygon(data = dongsansheng,aes(x=long,y=lat,group=group,fill = zhibiao),colour="grey40") +
  geom_point(data = mydata,aes(x=long,y=lat,size=zhibiao),colour="red",alpha=.5)+
  scale_fill_distiller(palette = "BrBG") +
  facet_wrap(~NAME_1,scales = "free")+
  scale_size_area(max_size=8)+
  theme_void(base_size=18) %+replace%
  theme(
    strip.text = element_text(family = "myFont")
  )

###方案二：

#清洗地图数据源

china_map <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors=FALSE)
mydata <- china_map@data %>% mutate(id = row.names(.)) %>% select(id,NAME)
mydata[mydata$id==898,"NAME"]<-"澳门特别行政区"

mymapdata<-fortify(china_map) %>% select(id,long,lat,group,order)
mymapdata$id<-as.numeric(mymapdata$id)
mymapdata<-merge(mymapdata,mydata,all.x=TRUE) %>% rename(region = NAME)


#首先构造12个年份变量：
mydata_new <- data.frame(NAME=unique(mydata$NAME))
for (i in 2:13){
  mydata_new[,i]<-round(runif(34,0,250))
}
names(mydata_new)[2:length(mydata_new)] <- as.character(2001:2012)

#定义并切割连续型数据为因子变量
mydata_new <- mydata_new %>% tidyr::gather(year,zhibiao,-1)
mydata_new$fact <- cut(
  mydata_new$zhibiao,
  breaks=c(0,50,100,150,200,250),
  labels=c('0~50','50~100','100~150','150~200','200~250'),
  order=TRUE,
  include.lowest = TRUE
  )

#1 热力填色分面地图：

ggplot(data = mydata_new)+
  geom_map(aes(map_id = NAME,fill = fact),map = mymapdata,colour="grey65")+
  scale_fill_brewer(palette="Blues") +  ###Blues&Greens
  facet_wrap(~year)+
  expand_limits(x=mymapdata$long,y=mymapdata$lat)+
  coord_map("polyconic")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL))+       
  theme_void() %+replace% 
  theme(
    legend.position = c(0,0.7),legend.text.align=1
    )   

#2 散点图分面

#导入并合并省份行政中心经纬度数据
province_city <- read.csv("D:/R/rstudy/Province/chinaprovincecity.csv",stringsAsFactors=FALSE) 
province_city <- province_city %>% select(province,jd,wd)
mydata_new <- merge(mydata_new,province_city[,c("province","jd","wd")],by.x="NAME",by.y="province",all.x=TRUE)

ggplot(data = mydata_new)+
  geom_map(aes(map_id=NAME),map = mymapdata,colour="grey65",fill= "#EEF3FA")+
  geom_point(aes(x=jd,y=wd,size = zhibiao,colour = zhibiao),shape=16)+
  scale_size_area(max_size=6) +  
  scale_colour_gradient(low="white",high="#D73434")+ 
  facet_wrap(~year)+
  expand_limits(x=mymapdata$long,y=mymapdata$lat)+
  coord_map("polyconic")+
  guides(fill=guide_legend(reverse=TRUE,title=NULL),size=guide_legend(reverse=TRUE,title=NULL))+       
  theme_void()%+replace% 
  theme(
    legend.position = c(0,0.7),
    legend.text.align=1
    )   


#3 热力填充+散点图+分面：
ggplot(mydata_new)+
  geom_map(aes(map_id= NAME ,fill = fact) , map = mymapdata, colour="grey65")+
  geom_point(aes(x=jd,y=wd,size = zhibiao,colour = zhibiao),shape=16)+
  scale_size_area(max_size=4) +  
  scale_fill_brewer(palette="Greens") +  ###Blues&Greens
  scale_colour_gradient(low="white",high="#D73434")+ 
  facet_wrap(~year)+
  expand_limits(x=mymapdata$long,y=mymapdata$lat)+
  coord_map("polyconic")+
  guides(
    fill=guide_legend(reverse=TRUE,title=NULL),
    size=guide_legend(reverse=TRUE,title=NULL)
    )+       
  theme_void()%+replace% 
  theme(
    legend.position = c(0,0.7),
    legend.text.align=1
    ) 

####END####





