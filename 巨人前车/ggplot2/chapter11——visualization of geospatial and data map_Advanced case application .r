## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## visualization of geospatial and data map_case and model 

## 《R语言商务图表与数据可视化》
## 课程讲师——杜雨
## 课程机构——天善智能

########第十一章：空间可视化与数据地图高阶案例扩展应用######

####11.1 地图上的mini条形图（柱形图）####
rm(list = ls())
gc()

library("ggplot2")
library("plyr")
library("rgdal")
library("magrittr")
library("dplyr")

china_shp <-readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)    

#地图数据（多边形经纬度边界点数据）
china_map <- fortify(china_shp)  

#城市经纬度数据
province_city <- read.csv("D:/R/rstudy/Province/chinaprovincecity.csv",stringsAsFactors = FALSE) 
province_city1 <- mutate(
  province_city,
  N15=runif(34,min=500,max=1000),
  N16=runif(34,600,1100),
  Ratio=round((N16-N15)/N15,3)
  )
province_data <- province_city1[sample(nrow(province_city1),10),]

#案例一：mini柱形图
windowsFonts(myFont = windowsFont("微软雅黑")) 
ggplot()+
  geom_polygon(data=china_map,aes(x=long,y=lat,group = group), fill="white", colour="grey60") +
  geom_linerange(data=province_data,aes(x=jd - 0.5,ymin = wd,ymax = wd + 0.7*N15/max(N15,N16)*5),size=3,color="#5B88A0",alpha=0.8)+
  geom_linerange(data=province_data,aes(x=jd + 0.5,ymin = wd,ymax = wd + 0.7*N16/max(N15,N16)*5),size=3,color="#FB882C",alpha=0.8)+
  geom_text(data=province_data,aes(x=jd,y=wd - 0.6,label=paste0(province_data$province,ifelse(Ratio > 0,"▲","▼"),Ratio*100,"%")), family="myFont",size=2.5)+
  #coord_map("polyconic") +
  annotate("text", x=105, y=52, label="● 2015", color= "#5B88A0", size=8)+ 
  annotate("text", x=105, y=49, label="● 2016", color= "#FB882C", size=8)+
  theme_void()

#案例二：mini条形图
ggplot()+
  geom_polygon(aes(x=long, y=lat,group=group),data=china_map, fill="white", colour="grey60")+
  geom_errorbarh(data=province_data,aes(y=wd,xmin=jd-3,xmax=jd + 2.5*N15/max(N15,N16)),size=3,color="#5B88A0",height=0,alpha=0.8)+
  geom_errorbarh(data=province_data,aes(y=wd-0.8,xmin=jd-3,xmax=jd + 2.5*N16/max(N15,N16)),size=3,color="#FB882C",height=0,alpha=0.8)+
  geom_text(data=province_data,aes(x=jd+0.2,y=wd + 1,label=paste0(province_data$province,ifelse(Ratio>0,"▲","▼"),Ratio*100,"%")), family="myFont",size=2.5)+
  annotate("text", x=105, y=52, label="● 2015", color= "#5B88A0", size=7)+ 
  annotate("text", x=105, y=50, label="● 2016", color= "#FB882C", size=7)+
  coord_equal()+
  theme_void()


####11.2 地图上的mini气泡饼图####
rm(list = ls())
gc()

library("ggplot2")
library("plyr")
library("rgdal")
library("xlsx")
library("ggthemes")
library("magrittr")
library("scatterpie")

#案例一：
world_map <-readOGR("D:/R/rstudy/wold_map/World_region.shp",stringsAsFactors = FALSE)
x <- world_map@data  %>% mutate(id = row.names(.)) 
world_map1 <- fortify(world_map)  
world_map_data <- merge(world_map1,x, by = "id",all.x = TRUE) 

mydata<-read.xlsx(
  "D:/R/File/WorldGDP.xlsx",
  sheetName="Sheet1",
  header=T,
  encoding='UTF-8',
  stringsAsFactors = FALSE
  ) 

#计算全球各国行政区划中心点：
midpos <- function(x) mean(range(x,na.rm=TRUE))
centres <- ddply(world_map_data,.(COUNTRY),colwise(midpos,.(long,lat)))

#匹配目标国家行政区划中心点：
mapdata<-merge(centres,mydata,by.x="COUNTRY",by.y="FULLName",all.y=TRUE)


#计算映射饼图大小的指标
mapdata$point <- 5*mapdata$GDP/max(mapdata$GDP)+5


mapdata[1,c("long","lat")] <- c(-77.013222,38.913611)   #华盛顿
mapdata[2,c("long","lat")] <- c(2.329671,48.871029)     #巴黎
mapdata[3,c("long","lat")]<-c(-0.124969,51.516434)    #伦敦
mapdata[4,c("long","lat")]<-c(12.496336,41.91076)     #意大利  
mapdata[5,c("long","lat")]<-c(4.882042,52.372936)     #阿姆斯特丹
mapdata[6,c("long","lat")]<-c(-3.704783,40.421502)    #马德里
mapdata[7,c("long","lat")]<-c(139.650947,35.833005)   #东京
mapdata[8,c("long","lat")]<-c(13.407002,52.527935)    #柏林
mapdata[9,c("long","lat")]<-c(8.45468,47.440827)      #苏黎世
mapdata[11,c("long","lat")]<-c(149.116199,-35.315167) #墨尔本
mapdata[12,c("long","lat")]<-c(-43.264882,-22.895071) #里约热内卢
mapdata[15,c("long","lat")]<-c(-99.129758,19.449516)  #墨西哥城


ggplot(world_map_data,aes(x=long, y=lat,group=group)) +
  geom_polygon(fill="white", color="grey")+
  geom_scatterpie(data=mapdata,aes(x=long, y=lat,r = point),cols = names(mapdata)[8:10] ,color=NA, alpha=.8) +
  coord_equal()+
  geom_scatterpie_legend(mapdata$point, x=-160, y=-55)+
  scale_fill_wsj()+
  theme_void()

#案例二：
rm(list = ls())
gc()

china_map <- readOGR(
  "D:/R/mapdata/State/china.geojson",
  stringsAsFactors=FALSE,
  encoding = "utf-8",
  use_iconv = TRUE
  )
china_map <- fortify(china_map) 

province_city <- read.csv(
  "D:/R/rstudy/Province/chinaprovincecity.csv",
  stringsAsFactors = FALSE,
  check.names=FALSE
  )

#构造气泡饼图的指标数据
city_data<-data.frame(Name=rep(c("北京","上海","重庆","武汉","广州","西安")))
for (i in 2:7) city_data[,i]<-round(runif(6,0,250))
names(city_data)[2:7]<-paste0("Year",2011:2016)

city_data$Full<-apply(city_data[,-1],1,sum)
city_data$Full_scale <- scale(city_data$Full,center=F,scale= T )*2

#提取中心城市数据：

city_data <- city_data %>% merge(province_city[,c("city","wd","jd")],by.x="Name",by.y="city",all.x=TRUE)


ggplot() +    
  geom_polygon(data=china_map,aes(x=long,y=lat,group=group),fill="white",color="grey") +
  geom_scatterpie(data=city_data,aes(x=jd,y=wd,r = Full_scale),cols = names(city_data)[2:7],color="grey", alpha=.8) +
  coord_equal() +
  scale_fill_brewer(guide=FALSE)+   
  theme_void()

#案例二扩展——空间地图分面

city_data2 <- data.frame(Name=rep(city_data$Name,6))
for (i in 2:4) city_data2[,i]<-runif(nrow(city_data2),10,100)
names(city_data2)[2:4]<-paste0("Value",1:3)
city_data2$Year<-rep(paste0("Year",2011:2016),each=6)

city_data2 <- city_data2 %>% merge(city_data[,c("Name","jd","wd")],by="Name",all.x=T)
city_data2$Full <- apply(city_data2[,2:4],1,sum) %>% scale(center=F,scale=T)
city_data2$Full <- as.numeric(city_data2$Full)*2
city_data2 <- city_data2%>%arrange(Year,Name)

ggplot()+
  geom_polygon(data=china_map,aes(x=long,y=lat,group=group),fill="white",color="grey")+
  geom_scatterpie(data=city_data2,aes(x=jd,y=wd,r=Full),cols = names(city_data2)[2:4],color="grey", alpha=.8) +
  coord_equal()+
  scale_fill_brewer(guide=FALSE)+   
  facet_wrap(~Year) +
  theme_void()

####11.3 地图+网络流向图案例用应（含多种流向类型）####
rm(list = ls())
gc()


library("plyr")
library("dplyr")
library("ggplot2")
library("ggmap")
library("rgdal")
library("maps")
library("REmap")
library("Cairo")
library("baidumap")
library("showtext")

#案例1.1 放射状路径图
china_map <-readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)
x <- china_map@data  %>% mutate(id = row.names(.)) 
china_map1 <- fortify(china_map)  
china_map_data <- merge(china_map1,x, by = "id",all.x = TRUE) 
mydata1 <- read.csv("D:/R/rstudy/Province/geshengzhibiao.csv",stringsAsFactors = FALSE,check.names=FALSE)
china_data <- join(china_map_data, mydata1, type="full") 

city_list <- c("西安","西宁","郑州","重庆","成都","石家庄","兰州","济南","大同","咸阳","包头","长沙")
source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)

address$lonx <- address[address$address =="长沙","lng"]
address$laty <- address[address$address =="长沙","lat"]
address <- address[address$address!= "长沙",]
names(address)[2:3]<-c("lon","lat")
address$Num <- round(runif(11,50,100),2)

ggplot()+
  geom_polygon(data=china_data,aes(x=long,y=lat,group=group),fill="white",size=0.2,colour="#D9D9D9")+
  geom_segment(data=address,aes(x=lon,y=lat,xend=lonx,yend=laty),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lon,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  geom_point(data=NULL,aes(x=112.97935,y=28.21347),shape=21,size=8,fill=NA,col="steelblue")+
  guides(fill=FALSE)+
  coord_map("polyconic") +
  scale_size_area(max_size = 8)+ 
  theme_void() %+replace%
  theme(
    plot.background=element_rect(fill="#D0DEDE", color=NA),
    panel.spacing = unit(0,"lines"), 
    plot.margin=unit(rep(0.2,4),"cm"),
    legend.position="none"
  )

#案例2：迁徙路径气泡图

city_list <- c("海口","广州","长沙","武汉","郑州","石家庄","北京","沈阳","长春","哈尔滨")
source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)
address$Num<-round(runif(10,50,100),2)

ggplot()+
  geom_polygon(data=china_data,aes(x=long,y=lat,group=group),fill="white",size=0.2,colour="#D9D9D9")+
  geom_path(data=address,aes(x=lng,y=lat),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lng,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  guides(fill=FALSE)+
  coord_map("polyconic")+
  scale_size_area(max_size=8)+ 
  theme_void() %+replace%
  theme(
    plot.background=element_rect(fill="#D0DEDE", color=NA),
    panel.spacing = unit(0,"lines"), 
    plot.margin=unit(rep(0.2,4),"cm"),
    legend.position="none"
  )

#案例1.3：闭环路径气泡图

city_list <- c("兰州","成都","重庆","贵阳","昆明","南宁","海口","广州","福州","上海","青岛","石家庄","呼和浩特","银川")
city_list <- c(city_list,city_list[1])

source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)
address$Num<-round(runif(nrow(address),50,100),2)

ggplot()+
  geom_polygon(data=china_data,aes(x=long,y=lat,group=group),fill="white",size=0.2,colour="#D9D9D9")+
  geom_path(data=address,aes(x=lng,y=lat),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lng,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  guides(fill=FALSE)+
  coord_map("polyconic")+
  scale_size_area(max_size=8)+ 
  theme_void() %+replace%
  theme(
    plot.background=element_rect(fill="#D0DEDE", color=NA),
    panel.spacing = unit(0,"lines"), 
    plot.margin=unit(rep(0.2,4),"cm"),
    legend.position="none"
  )
#案例2：多维度放射状

library("ggplot2")
library("dplyr")
library("rgdal")
library("shiny")
library("shinythemes")
library("magrittr")
rm(list = ls())
gc()

##转换为数据框并合并城市数据：
china_map <- readOGR(
  "D:/R/mapdata/State/china.geojson",
  stringsAsFactors=FALSE,
  encoding = "utf-8",
  use_iconv = TRUE
)  %>% fortify() 

province_city <- read.csv(
  "D:/R/rstudy/Province/chinaprovincecity.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
  ) 

###构造线条起始点数据：
city<-c("北京","上海","重庆","天津","武汉","南京","广州","沈阳","西安","郑州")

city_data <- merge(city,city) %>% rename(Start=x,End=y) %>% arrange(Start)
city_data <- city_data %>% filter(Start != End)

city_data <- city_data %>% merge(province_city[,c("city","jd","wd")],by.x="Start",by.y="city",all.x=TRUE) %>% rename(Start_long=jd,Start_lat=wd)
city_data <- city_data %>% merge(province_city[,c("city","jd","wd")],by.x="End",by.y="city",all.x=TRUE) %>% rename(End_long=jd,End_lat=wd)
city_data <- transform(
  city_data,
  zhibiao1=runif(nrow(city_data),0,100),
  zhibiao2=runif(nrow(city_data),0,100),
  zhibiao3=runif(nrow(city_data),0,100)
  )


ggplot()+
  geom_polygon(data=china_map,aes(x=long,y=lat,group=group),fill="white",colour="grey60") +
  geom_segment(data=city_data,aes(x=Start_long,y=Start_lat,xend=End_long,yend=End_lat,size=zhibiao1),colour="black")+
  coord_map("polyconic") + 
  scale_size_area(max_size=2) +
  theme_void()

###最合适的做法1：图形分面：

ggplot()+
  geom_polygon(data=china_map,aes(x=long,y=lat,group=group),fill="white",colour="grey60")+
  geom_segment(data=city_data,aes(x=Start_long,y=Start_lat,xend=End_long,yend=End_lat),colour="black")+
  geom_point(data =city_data,aes(x=End_long,y=End_lat,size=zhibiao1),shape=21,fill="#8E0F2E",colour="black",alpha=0.4)+
  scale_size_area(max_size=6)+
  coord_map("polyconic") + 
  facet_wrap(~Start,nrow = 2)+
  theme_void()


###最合适的做法2——Shiny动态交互图：

city_list <- list("北京"="北京","上海"="上海","重庆"="重庆","天津"="天津","武汉"="武汉","南京"="南京","广州"="广州","沈阳"="沈阳","西安"="西安","郑州"="郑州")

ui <-shinyUI(fluidPage(
  theme=shinytheme("cerulean"),
  titlePanel("Population Structure Data"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("var1","City",city_list,inline=FALSE),
      selectInput("var2","Value",c("zhibiao1"="zhibiao1","zhibiao2"="zhibiao2","zhibiao3"="zhibiao3"),selected="zhibiao1")
    ),
    mainPanel(h2("Trade Stream"),plotOutput("distPlot"))
  )
))

server <- shinyServer(function(input,output){
  output$distPlot <- renderPlot({
    mydata=filter(city_data%>%filter(Start==input$var1))
    argu<-switch(input$var2,zhibiao1=mydata$zhibiao1,zhibiao2=mydata$zhibiao2,zhibiao3=mydata$zhibiao3)
    ggplot(mydata)+
      geom_polygon(data=china_map,aes(x=long,y=lat,group=group),fill="white",colour="grey60")+
      geom_segment(aes(x=Start_long,y=Start_lat,xend=End_long,yend=End_lat),colour="black")+
      geom_point(aes(x=End_long,y=End_lat,size=argu),shape=21,fill="#8E0F2E",colour="black",alpha=0.4)+
      scale_size_area(max_size=6)+
      coord_map("polyconic") + 
      theme_void()
  })
})
shinyApp(ui=ui,server=server)


####11.4 ggmap背景+ggplot2图层混合应用####

library("dplyr")
library("dplyr")
library("ggplot2")
library("ggmap")
library("rgdal")
library("maps")
library("Cairo")
library("showtext")
library("baidumap")
library("grid")
rm(list = ls())
gc()

#devtools::install_github("dkahle/ggmap")
#devtools::install_github("hadley/ggplot2")
#如下代码若出错，请尝试请更新ggplot2、ggmap至最新开发板！
#问题详情请参见Stack Overflow 主页：
#https://stackoverflow.com/questions/40642850

bbox_everest <- c(left =60, bottom =10, right =150, top =60)
mapdata <- get_stamenmap(bbox_everest, zoom =5)
ggmap(mapdata)

#案例1：基于google地图的放射状路径图

city_list <- c("西安","西宁","郑州","重庆","成都","石家庄","兰州","济南","大同","咸阳","包头","长沙")
source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)

address$lonx <- address[address$address =="长沙","lng"]
address$laty <- address[address$address =="长沙","lat"]
address <- address[address$address!= "长沙",]
names(address)[2:3]<-c("lon","lat")
address$Num<-round(runif(11,50,100),2)

ggmap(mapdata)+
  geom_segment(data=address,aes(x=lon,y=lat,xend=lonx,yend=laty),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lon,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  geom_point(data=NULL,aes(x=112.97935,y=28.21347),shape=21,size=8,fill=NA,col="steelblue")+
  scale_size_area(max_size=8)+ 
  theme_nothing()

#案例2：基于google地图的路径流向图
city_list <- c("海口","广州","长沙","武汉","郑州","石家庄","北京","沈阳","长春","哈尔滨")
source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)
address$Num<-round(runif(10,50,100),2)

ggmap(mapdata)+
  geom_path(data=address,aes(x=lng,y=lat),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lng,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  guides(fill=FALSE)+
  scale_size_area(max_size=8)+ 
  theme_nothing()

#案例3：基于google地图的闭环路径图

city_list <- c("兰州","成都","重庆","贵阳","昆明","南宁","海口","广州","福州","上海","青岛","石家庄","呼和浩特","银川")
city_list <- c(city_list,city_list[1])

source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(city_list)
address$Num<-round(runif(nrow(address),50,100),2)

ggmap(mapdata)+
  geom_path(data=address,aes(x=lng,y=lat),size=0.3,colour="#FF6833")+
  geom_point(data=address,aes(x=lng,y=lat,size=Num),shape=21,fill="#ED7D31",col="#E02939",alpha=.6)+
  guides(fill=FALSE)+
  scale_size_area(max_size=8)+ 
  theme_nothing()

####11.5 地图+mini字体地图应用####

#导入数据：
#生成一个虚拟指标，并分割为有序分段因子变量。
mymapdata <- read.csv("D:/R/File/EyesAsia.csv",stringsAsFactors=FALSE,check.names=FALSE)
mymapdata<-transform(
  mymapdata,
  scale=5,
  peform=runif(43,20,50)
  )

mymapdata$group <- cut(
  mymapdata$peform,
  breaks=c(20,26,32,38,44,50),
  labels=c("20~26","26~32","32~38","38~44","44~50"),
  order=TRUE
  )

word<-c("日本","蒙古","朝鲜","韩国","青海湖","鄱阳湖","洞庭湖","太湖","洪泽湖")
mymapdata <- mymapdata %>% filter(!Cname %in% word) 

mymapdata<-arrange(mymapdata,-peform) 
mymapdata$order=1:nrow(mymapdata)

font_add("myfont","EyesAsia-Regular.otf")
font_add("myyh","msyhl.ttc")


p1<- ggplot(mymapdata,aes(order,scale,label = case))+
  ylim(-6,6)+
  coord_polar(theta="x",start=0)+
  geom_text(aes(colour = group),family="myfont",size=20)+
  scale_colour_brewer(palette="Greens",guide=FALSE)+
  theme_void()


china_map <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)

mydata1   <- china_map@data %>% mutate(id = row.names(.)) %>% select(id,NAME)   
china_map1 <- fortify(china_map)  %>% select(id,long,lat,group,order)         
china_map_data <- left_join(china_map1,mydata1,by = "id")                     

mydata2   <- read.csv("D:/R/rstudy/Province/geshengzhibiao.csv",stringsAsFactors = FALSE)   
mydata2$zhibiao <- as.numeric(mydata2$zhibiao)
final_data <- left_join(china_map_data,mydata2,by = "NAME") %>% select(-province)         

#1、常见的热力填色地图：
p2<- ggplot() +
  geom_polygon(data = final_data,aes(x = long,y = lat, group = group,fill = zhibiao),colour="grey40") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  guides(fill=FALSE)+
  coord_map("polyconic") + 
  theme_void()
  


CairoPNG("C:/Users/RAINDU/Desktop/chineserador.png",900,900)
showtext_begin()

vs <- viewport(width=0.95,height=0.95,x=0.5,y=0.5)    
print(p1,vp = vs)  
vs <- viewport(width=0.75,height=0.8,x=0.5,y=0.5)   
print(p2,vp=vs)

showtext_end()
dev.off()


CairoPNG("C:/Users/RAINDU/Desktop/chineserador2.png",900,900)
showtext_begin()
ggplot(mymapdata,aes(order,scale,label = case))+
  ylim(-6,6)+
  coord_polar(theta="x",start=0)+
  geom_text(aes(colour = group),family="myfont",size=20)+
  scale_colour_brewer(palette="Greens",guide=FALSE)+
  theme_void()
showtext_end()
dev.off()


CairoPNG("C:/Users/RAINDU/Desktop/chineserador3.png",900,900)
showtext_begin()
ggplot() +
  geom_polygon(data = final_data,aes(x = long,y = lat, group = group,fill = zhibiao),colour="grey40") +
  scale_fill_distiller(palette = "BrBG",na.value = "white") +  
  guides(fill=FALSE)+
  coord_map("polyconic") + 
  theme_void()
showtext_end()
dev.off()



####11.6 基于ggplot2的等值线密度图####
rm(list=ls())
gc()
library("dplyr")
library("dplyr")
library("ggplot2")
library("ggmap")
library("rgdal")
library("maps")
library("Cairo")
library("showtext")
library("baidumap")
library("grid")

china_map <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors = FALSE)

mydata1   <- china_map@data %>% mutate(id = row.names(.)) %>% select(id,NAME)   
china_map1 <- fortify(china_map)  %>% select(id,long,lat,group,order)         
china_map_data <- left_join(china_map1,mydata1,by = "id")                     

cityname <- c("北京", "天津", "哈尔滨", "乌鲁木齐", "西宁", "兰州", "银川", "呼和浩特", "石家庄", "太原", 
            "沈阳", "长春", "济南", "拉萨", "成都", "昆明", "西安", "郑州", "重庆", "武汉", "长沙", "贵阳", "南京", 
            "合肥", "上海", "杭州", "南昌", "福州", "广州", "南宁", "海口", "台北", "香港", "澳门", "厦门", "青岛", 
            "大连",  "无锡", "桂林")
source("D:/R/web_city_adress.r",encoding = "utf-8")
address <- GetJD(cityname)

###纯ggplot2静态图

ggplot() +
  geom_polygon(data = china_map_data,aes(x = long,y = lat, group = group),colour="grey40",fill = "white") +
  geom_point(data = address,aes(x = lng,y = lat),colour = "red") +
  geom_polygon(data = address,aes(x=lng,y=lat,fill = ..level..), stat = "density_2d", alpha = .3, color = NA)+ 
  scale_fill_distiller(palette = "Reds",na.value = "white",direction = 1) +  
  guides(fill=FALSE)+
  coord_map("polyconic") + 
  theme_void()


###基于googlemap的密度热度图
bbox_everest <- c(left =60, bottom =10, right =150, top =60)
mapdata <- get_stamenmap(bbox_everest, zoom =5)


ggmap(mapdata) +
  geom_polygon(data = address,aes(x=lng,y=lat,fill = ..level..), stat="density_2d", alpha = .3, color = NA)+ 
  geom_point(data = address,aes(x = lng,y = lat),colour = "red") +
  scale_fill_distiller(palette = "Reds",na.value = "white",direction = 1) +  
  guides(fill=FALSE)+
  theme_nothing()


####END####
