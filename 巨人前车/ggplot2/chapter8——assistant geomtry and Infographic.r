## !/user/bin/env RStudio 1.1.423
## -*- coding: utf-8 -*-
## assistant geomtry and Infographic

## 《R语言商务图表与数据可视化》
## 课程讲师——杜雨
## 课程机构——天善智能

rm(list = ls())
gc()

########第八章：ggplot辅助几何对象与信息图基础########


####8.1 辅助图形操作辅助图形1——geom_rect矩形图####

library("showtext")
library("ggplot2")
library("magrittr")
library("reshape2")
library("ggthemes")
library('dplyr')

mydata <- data.frame(
  Lebal  = c("Point1","Point2","Point3","Point4","Point5"),
  xstart = c(5.5,15.7,19.5,37.2,36.9),
  xend   = c(9.7,28.1,24.6,44.6,47.1), 
  ystart = c(9.6,23.1,2.3,33.2,9.2),
  yend   = c(16.1,36.2,11.7,38.5,15.3),
  size   = c(12,48,30,11.5,28),
  class  = c("A","A","A","C","C")
)

ggplot(mydata)+
  geom_rect(aes(xmin = xstart,xmax = xend , ymin = ystart , ymax = yend , fill = class)) +
  scale_fill_wsj()


#按照x轴进行圆周化：
ggplot(mydata)+
  geom_rect(aes(xmin = xstart,xmax = xend , ymin = ystart , ymax = yend , fill = class)) +
  scale_fill_wsj() +
  ylim(-10,40) +
  scale_x_continuous(expand = c(0,0)) +
  coord_polar(theta = 'x')


#按照y轴进行圆周化
ggplot(mydata)+
  geom_rect(aes(xmin = xstart,xmax = xend , ymin = ystart , ymax = yend , fill = class)) +
  scale_fill_wsj() +
  scale_y_continuous(expand = c(0,0)) +
  coord_polar(theta = 'y')


#分面操作：
ggplot(mydata)+
  geom_rect(aes(xmin = xstart,xmax = xend , ymin = ystart , ymax = yend , fill = class)) +
  scale_fill_wsj() +
  facet_grid(.~class) +
  scale_y_continuous(expand = c(0,0)) 

  
####8.2 辅助图形操作辅助图形2——geom_segment矩形图####


mydata <- data.frame(
  Lebal  = c("Segment1","Segment2","Segment3","Segment4","Segment5"),
  xstart = c(3.5,4.4,8.3,13.2,20),
  ystart = c(5,2.7,4.6,2.2,4.7),
  xend   = c(7.5,8.7,21,25,23), 
  yend   = c(7.9,4.2,7.2,3.8,4.4),
  class  = c("A","A","A","C","C")
)

ggplot(mydata) +
  geom_segment(
    aes(
      x = xstart, 
      y = ystart, 
      xend = xend,
      yend = yend, 
      colour = class
      ),
    arrow = arrow(length = unit(0.5,"cm")),
    size = 1.5
  ) +
  scale_colour_wsj() 
  

#按照X轴圆周化
ggplot(mydata) +
  geom_segment(
    aes(
      x = xstart , 
      y = ystart , 
      xend = xend ,
      yend = yend  , 
      colour = class
    ),
    arrow = arrow(length = unit(0.5,"cm")),
    size = 1.5
  ) +
  scale_colour_wsj() +
  scale_y_continuous(expand = c(0,0)) +
  coord_polar(theta = 'x')

#按照y轴圆周化
ggplot(mydata) +
  geom_segment(
    aes(
      x = xstart , 
      y = ystart , 
      xend = xend ,
      yend = yend  , 
      colour = class
    ),
    arrow = arrow(length = unit(0.5,"cm")),
    size = 1.5
  ) +
  scale_colour_wsj() +
  scale_y_continuous(expand = c(0,0)) +
  coord_polar(theta = 'y')


#分面操作：
ggplot(mydata) +
  geom_segment(
    aes(
      x = xstart , 
      y = ystart , 
      xend = xend ,
      yend = yend  , 
      colour = class
    ),
    arrow = arrow(length = unit(0.5,"cm")),
    size = 1.5
  ) +
  facet_grid(.~class) +
  scale_colour_wsj() +
  scale_y_continuous(expand = c(0,0))


####8.3 辅助图形操作辅助图形3——geom_linerange线范围图####

mydata <- data.frame(
  Lebal  = c("linerange1","linerange2","linerange3","linerange4","linerange5"),
  xstart = c(3.5,7,12,16,20),
  ymin   = c(2.5,6.5,3,4.5,3.8),
  ymax   = c(7.5,9.5,9,13.5,4.2),
  class  = c("A","A","A","C","C")
)


ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  scale_colour_wsj() 
 
# 横纵轴互换：
ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  coord_flip() +
  scale_colour_wsj() 


#按x轴圆周化：
ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  scale_colour_wsj() +
  scale_x_continuous(limits = c(0,25),expand = c(0,0)) +
  coord_polar(theta = 'x')

#按y轴圆周化：
ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  scale_colour_wsj() +
  scale_y_continuous(expand = c(0,0)) +
  coord_polar(theta = 'y')


#分面：
ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  scale_colour_wsj() +
  facet_grid(.~class) +
  scale_x_continuous(limits = c(0,25),expand = c(0,0)) 

ggplot(mydata) +
  geom_linerange(aes(x = xstart, ymin = ymin , ymax = ymax , colour = class) , size = 1.5) +
  coord_flip() +
  scale_colour_wsj() +
  facet_grid(.~class) +
  scale_x_continuous(limits = c(0,25),expand = c(0,0)) 

####8.4 辅助图形操作辅助图形4——geom_ploygon多边形图####

mydata <- data.frame(
  long = c(15.4,17.2,19.7,15.9,7.4,8.9,8.5,10.4,11.3,9.7,4.8,3.7,22.4,25.6,27.8,25.1,16.7,15.9,29.9,38.7,43.2,40.2,35.6,29.4),
  lat  = c(38.1,36.2,33.1,24.6,29.0,33.6,12.1,11.7,8.9,6.1,5.7,9.1,8.4,7.6,5.7,3.9,4.3,5.9,32.6,31.8,27.6,22.3,24.5,29.6),
  group= c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4),
  order =c(1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6),
  class = rep(c("A","c"),each = 12)
)

#
ggplot(mydata) +
  geom_polygon(aes(x = long , y = lat , group  = group , fill = class),colour = "white") +
  scale_fill_wsj()

#按照X轴圆周化：
ggplot(mydata) +
  geom_polygon(aes(x = long , y = lat , group  = group , fill = class),colour = "white") +
  coord_polar(theta = 'x') +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_wsj()

#按照y轴圆周化：
ggplot(mydata) +
  geom_polygon(aes(x = long , y = lat , group  = group , fill = class),colour = "white") +
  coord_polar(theta = 'y') +
  scale_y_continuous(expand = c(0,0)) +
  scale_fill_wsj()

#分面：

ggplot(mydata) +
  geom_polygon(aes(x = long , y = lat , group  = group , fill = class),colour = "white") +
facet_grid(.~class) +
  scale_fill_wsj()



####8.5 折线图与路径图的区别——geom_line/geom_path####

mydata <- data.frame(
  long =  c(15.4,17.2,19.7,15.9,7.4,8.9),
  lat  =  c(38.1,36.2,33.1,24.6,29.0,33.6)
)

#geom_line:
ggplot(mydata) +
  geom_line(aes(x = long, y = lat),colour = "#C72E29")  +
  ylim(0,50)
  
#geom_path:
ggplot(mydata) +
  geom_path(aes(x = long, y = lat),colour = "#C72E29")  +
  ylim(0,50)


#geom_path可以用于勾勒闭合多边形轮廓、洋流扩散、候鸟迁徙等场景：
mydata <- data.frame(
  long = c(15.4,17.2,19.7,15.9,7.4,8.9,8.5,10.4,11.3,9.7,4.8,3.7,22.4,25.6,27.8,25.1,16.7,15.9,29.9,38.7,43.2,40.2,35.6,29.4),
  lat  = c(38.1,36.2,33.1,24.6,29.0,33.6,12.1,11.7,8.9,6.1,5.7,9.1,8.4,7.6,5.7,3.9,4.3,5.9,32.6,31.8,27.6,22.3,24.5,29.6),
  group= c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4),
  order =c(1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6,1,2,3,4,5,6),
  class = rep(c("A","c"),each = 12)
)

ggplot(mydata) +
  geom_path(aes(x = long, y = lat, group = group),colour = "#C72E29")  +
  ylim(0,50)


####8.6 辅助线\误差线象（geom_abline\hline\vline\errorbar\herrorbar）####

#vline
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_vline(xintercept = 5)

#vline——多条线条
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_vline(xintercept = 1:5)


#hline
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_hline(yintercept = 20)

#hline
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_hline(yintercept = c(20,22,24,26,28,30))

#abline:
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_abline(intercept = 15, slope = 5)

ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_abline(intercept = 20, slope = 2)


#smooth:
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  geom_smooth(method = "lm", se = TRUE)


###两类误差线：

#errorbar
df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  upper = c(1.1, 5.3, 3.3, 4.2),
  lower = c(0.8, 4.6, 2.4, 3.6)
)

ggplot(df, aes(trt, resp, colour = group)) + 
  geom_point() +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0)  

#herrorbar
df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  se = c(0.1, 0.3, 0.3, 0.2)
)

ggplot(df, aes(resp, trt, colour = group)) +
  geom_point() +
  geom_errorbarh(aes(xmax = resp + se, xmin = resp - se),height = 0)


####8.7 ggplot2辅助高阶图形扩展包——ggtreemap（树状图）####

#CRAN:
#install.package("treemapify")
#Github:
#devtools::install_github("wilkox/treemapify")
#
#GitHub主页：
#https://github.com/wilkox/treemapify

library("ggplot2")
library("treemapify")
library("tweenr")
library("gganimate")
library("RColorBrewer")


str(G20)
head(G20)

#单序列
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi, label = country)) +
  geom_treemap() +
  geom_treemap_text(fontface = "italic", colour = "red", place = "centre",grow = TRUE,alpha=.6) +
  scale_fill_distiller(palette="Greens",direction = 1)

#次级分组：
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi, label = country,subgroup = region)) +
  geom_treemap() +
  geom_treemap_text(colour = "red", place = "topleft", reflow = FALSE,alpha=.5)+
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", alpha = 0.5, colour ="black", fontface = "italic", min.size = 0) +
  scale_fill_distiller(palette="Greens",direction = 1)
  

#分面：
ggplot(G20, aes(area = gdp_mil_usd, fill = region, label = country)) +
  geom_treemap() +
  geom_treemap_text(grow = T, reflow = T, colour = "black") +
  facet_wrap(~ econ_classification) +
  scale_fill_brewer(palette="Blues")+
  labs(
    title = "The G-20 major economies",
    caption = "The area of each country is proportional to its relative GDP within the economic group (advanced or developing)",
    fill = "Region" 
    )+
  theme(
    legend.position = "bottom",
    plot.caption=element_text(hjust=0)
    ) 


####8.7 ggplot2辅助高阶图形扩展包——ggtreemap（树状图）####

#1. 矩阵方块图：
#2. 不等宽柱形图/不等宽百分比柱形图：

