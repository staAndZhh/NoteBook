## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## visualization of geospatial and data map

## 《R语言商务图表与数据可视化》
## 课程讲师——杜雨
## 课程机构——天善智能

rm(list = ls())
gc()

########第九章——空间可视化与数据地图基础########


####9.1 sp空间数据映射原理####

library("ggplot2")
library("magrittr")
library("reshape2")
library("ggthemes")
library('dplyr')


options(stringsAsFactors=FALSE,warn=FALSE,encoding="UTF-8")

mydata <- data.frame(
  long = c(15.4,17.2,19.7,15.9,7.4,8.9,8.5,10.4,11.3,9.7,4.8,3.7,22.4,25.6,27.8,25.1,16.7,15.9,29.9,38.7,43.2,40.2,35.6,29.4),
  lat  = c(38.1,36.2,33.1,24.6,29.0,33.6,12.1,11.7,8.9,6.1,5.7,9.1,8.4,7.6,5.7,3.9,4.3,5.9,32.6,31.8,27.6,22.3,24.5,29.6),
  group= c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4),
  order =c(1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6),
  class = rep(c("A","c"),each = 12)
 )

#多边形映射
ggplot(mydata) +
  geom_polygon(aes(x = long , y = lat , group  = group , fill = class),colour = "white") +
  scale_fill_wsj()

####9.2 shp、json格式地理信息数据结构####

#------


####9.3 地理信息应用包简介：（sp、maptools、rgdal、sf）####
library("rgdal")
library("sf")
library("maptools")

rm(list = ls())
gc()


###shapefile文件导入

#maptools包导入：
china_map1 <- readShapePoly("D:/R/rstudy/CHN_adm/bou2_4p.shp")
division_data <- china_map1@data %>% mutate(id = row.names(.)) %>% .[,c("id","NAME")]    #行政区划层
polygons_data <- fortify(china_map1)  %>% .[,c(1,2,7,3,6)]                              #地理信息边界点数据
unique(polygons_data$id)

ggplot(polygons_data,aes(long,lat,group = group)) +
  geom_polygon(colour = 'white')

#rgdal包导入:
china_map2 <- readOGR("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors=FALSE)

division_data <- china_map2@data %>% mutate(id = row.names(.)) %>% .[,c("id","NAME")]    #行政区划层
polygons_data <- fortify(china_map2)  %>% .[,c(1,2,7,3,6)]                               #地理信息边界点数据
unique(polygons_data$id)
ggplot(polygons_data,aes(long,lat,group = group)) +geom_polygon(colour = 'white')

#sf包导入:
china_map3 <- st_read("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors=FALSE) %>% as("Spatial")
#china_map3 <- read_sf("D:/R/rstudy/CHN_adm/bou2_4p.shp",stringsAsFactors=FALSE)

division_data <- china_map3@data %>% mutate(id = row.names(.)) %>% .[,c("id","NAME")]    #行政区划层
polygons_data <- fortify(china_map3)  %>% .[,c(1,2,7,3,6)]                               #地理信息边界点数据
unique(polygons_data$id)
ggplot(polygons_data,aes(long,lat,group = group)) +geom_polygon(colour = 'white')

#json格式导入：

#rgdal包读入：
china_map2 <- readOGR("D:/R/mapdata/State/china.geojson",stringsAsFactors=FALSE)
Encoding(china_map2@data$name) <- 'UTF-8'

division_data <- china_map2@data                                   #行政区划层
polygons_data <- fortify(china_map2)  %>% .[,c(1,2,7,3,6)]         #地理信息边界点数据
unique(polygons_data$id)
ggplot(polygons_data,aes(long,lat,group = group)) +geom_polygon(colour = 'white')

#sf包读入：
china_map3 <- st_read("D:/R/mapdata/State/china.geojson",stringsAsFactors=FALSE) %>% as("Spatial")
#china_map3 <- read_sf("D:/R/mapdata/State/china.geojson",stringsAsFactors=FALSE)

division_data <- china_map3@data                                    #行政区划层
polygons_data <- fortify(china_map3)  %>% .[,c(1,2,7,3,6)]          #地理信息边界点数据
unique(polygons_data$id)
ggplot(polygons_data,aes(long,lat,group = group)) +geom_polygon(colour = 'white')


###从sp结构中提取地理信息子集
china_map1 <- readShapePoly("D:/R/rstudy/CHN_adm/CHN_adm2.shp")

china_map_division <- china_map1@data %>% 
  select(ID_2,NAME_1,NAME_2) %>% mutate(id = row.names(.))

china_map_division$NAME_1 <- as.character(china_map_division$NAME_1)
china_map_division$NAME_2 <- as.character(china_map_division$NAME_2)

china_map_polygons <- fortify(china_map1) %>% .[,c(1,2,7,3,6)] 
china_map_polygons$id <- as.numeric(china_map_polygons$id)
china_map_division$id <- as.numeric(china_map_division$id)

dongsansheng <- left_join(china_map_polygons,china_map_division) %>% 
  subset(NAME_1== c("Heilongjiang","Jilin","Liaoning")) %>% arrange(group,order)

ggplot(dongsansheng,aes(long,lat,group = group)) +
  geom_polygon(colour = 'white') +
  coord_map("polyconic")



####9.4 sp空间数据结构操纵与业务数据合并####
rm(list = ls())
gc()

#divsion_data
#polygons_data

china_map2 <- readOGR("D:/R/mapdata/State/china.geojson",stringsAsFactors=FALSE)
Encoding(china_map2@data$name) <- 'UTF-8'

division_data <- china_map2@data                                    #行政区划层
polygons_data <- fortify(china_map2)  %>% .[,c(1,2,7,3,6)]          #地理信息边界点数据

#step 1:

ggplot(polygons_data,aes(long,lat,group = group))+
  geom_polygon(colour = 'white') +
  coord_map("polyconic")

#step 2:
head(polygons_data)

ggplot(polygons_data,aes(long,lat,group = group,fill = factor(id)))+
  geom_polygon(colour = 'white')+
  coord_map("polyconic")


head(division_data)

division_data$sale  <- runif(34,100,200) %>% round()
division_data$Scope <- rep(LETTERS[1:5],length = 34)


polygons_data$id <- as.numeric(polygons_data$id)
final_mapdata <- left_join(polygons_data,division_data,by= 'id')

###连续渐变（适用于指标为连续性度量的情况）

ggplot(final_mapdata,aes(long,lat,group = group,fill = sale))+
  geom_polygon(colour = 'grey60')+
  coord_map("polyconic") +
  scale_fill_distiller(palette ='BrBG' ) +
  theme_void()


#Palettes
#
#The following palettes are available for use with these scales:
#  
#Diverging
#BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral
#
#Qualitative
#Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
#
#Sequential
#Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, 
#PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd


###离散渐变（适用于指标为离散型维度的情况）

ggplot(final_mapdata,aes(long,lat,group = group,fill = Scope))+
  geom_polygon(colour = 'grey60')+
  coord_map("polyconic") +
  scale_fill_brewer(palette ='BrBG' ) +
  theme_void()

###在地图上创建散点图：

province_city <- data.table::fread("D:/R/rstudy/Province/chinaprovincecity.csv") 
cities <- c("北京","上海","天津","重庆","沈阳","呼和浩特","太原","西安","兰州","合肥","南京","杭州","长沙","武汉")
map_point <- province_city %>% filter(city %in% cities) %>% .[,c(2,3,4)]

ggplot()+
  geom_polygon(data = final_mapdata,aes(long,lat,group = group,fill = Scope),colour = 'grey60',alpha = .4)+
  geom_point(data =province_city[province_city$city %in% cities,],aes(x = jd,y = wd,size = zhibiao ),colour="red",alpha = .5) +
  coord_map("polyconic") +
  scale_fill_brewer(palette ='BrBG' ) +
  theme_void()


start_city <- data.frame(
  s_jd = rep(province_city[city=='郑州',]$jd,14),
  s_wd = rep(province_city[city=='郑州',]$wd,14),
  start_city = '郑州'
)

map_point <- cbind(start_city,map_point)

ggplot()+
  geom_polygon(data = final_mapdata,aes(long,lat,group = group,fill = Scope),colour = 'grey60')+
  geom_segment(data = map_point,aes(x = s_jd,y = s_wd, xend = jd,yend = wd),colour = 'orange',size = 1.1) +
  geom_point(data =province_city[province_city$city %in% cities,],aes(x = jd,y = wd,size = zhibiao ),colour="red",alpha = .5) +
  coord_map("polyconic") +
  scale_fill_brewer(palette ='BrBG' ) +
  theme_void()


####9.5 sf格式空间数据结构####

china_map3 <- st_read("D:/R/mapdata/State/china.geojson",stringsAsFactors=FALSE) 

str(china_map3)
class(china_map3)

class(china_map3$geometry)

#业务数据：
mydata <- data.frame(
  id = 1:34,
  name = china_map3$name,
  scale = runif(34,100,200) %>% round(),
  Scope = rep(LETTERS[1:5],length = 34)
)

#将业务数据与地图数据合并
final_namdata2 <- left_join(china_map3,mydata[,c(1,3,4)],by = 'id')
final_namdata2 <- st_transform(final_namdata2, 3857) #4326

#连续指标

# Or the the development version from GitHub:
devtools::install_github("tidyverse/ggplot2")
ggplot() +
  geom_sf(data=final_namdata2) +
  coord_sf() +
  theme_void()  

ggplot() +
  geom_sf(data=final_namdata2,aes(fill = scale)) +
  coord_sf() +
  scale_fill_distiller(palette ='BrBG' ) +
  theme_void()  

#离散指标
ggplot() +
  geom_sf(data=final_namdata2,aes(fill=Scope)) +
  coord_sf() +
  scale_fill_brewer(palette ='BrBG' ) +
  theme_void()  

####9.6 sf格式空间数据映射原理####

###点图(point)：
province_city <- data.table::fread("D:/R/rstudy/Province/chinaprovincecity.csv") 

cities <- c("北京","上海","天津","重庆","沈阳","呼和浩特","太原","郑州","西安","兰州","合肥","南京","杭州","长沙","武汉")
map_point <- st_as_sf(province_city,coords = c("jd", "wd")) %>% filter(city %in% cities)

str(map_point)
class(map_point)
class(map_point$geometry)

st_crs(map_point) = 4326

ggplot() +
  geom_sf(data=final_namdata2, aes(fill = Scope),alpha = .3) +
  geom_sf(data=map_point,aes(colour = class,size=zhibiao)) +
  coord_sf() +
  scale_fill_brewer(palette ='BrBG' ) +
  scale_colour_wsj() +
  theme_void()  


###线图(line)：
mutiline_data <- data.frame(city = rep(NA,28),group = rep(NA,28))

mutiline_data$group <- rep(1:14,each = 2)

for (i in 1:28){
  if (i%%2) {
    mutiline_data$city[i] = '郑州'
  } else {
    mutiline_data$city[i] = cities[cities!='郑州'][i/2]
  }
}

#转换为sf特有的LINESTRING格式
mutiline_data <- left_join(mutiline_data,province_city[,c("city","jd","wd")],by = "city") %>% 
  st_as_sf(coords = c("jd", "wd")) %>%
  group_by(group) %>% 
  summarize() %>% 
  st_cast("LINESTRING")

str(mutiline_data)
class(mutiline_data)
class(mutiline_data$geometry)
      
st_crs(mutiline_data) <- 4326 #设置地理信息投影

ggplot() +
  geom_sf(data = final_namdata2, aes(fill = Scope),alpha = .3) + 
  geom_sf(data = mutiline_data,aes(group = group),colour = "black",size = .8) +
  geom_sf(data = map_point,aes(colour = class,size=zhibiao)) +
  coord_sf() +
  scale_fill_brewer(palette ='BrBG' ) +
  scale_colour_wsj() +
  theme_void()  

###Conversion, including to and from sp
as_Spatial()
st_as_sf(nc.sp) 
nc <- st_read(system.file("shape/nc.shp", package="sf"))

nc.sp <- as(nc, "Spatial")  #sf to sp  #等价于as_Spatial()
nc2 <- st_as_sf(nc.sp)      #sp to sf  #等价于as(x, "sf").





