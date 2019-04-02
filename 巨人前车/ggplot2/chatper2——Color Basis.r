##《R语言商务图表与数据可视化》
##课程讲师——杜雨
##课程机构——天善智能


##第二章——可视化基础之设计基础


########2.2 R语言字体环境与代码引入###############

###系统全局环境配置
options(stringsAsFactors = FALSE) #防止数据导入时字符型变量强制转化为因子
setwd("C:/Users/RAINDU/Desktop/R语言数据可视化与商务图表基础/R语言数据可视化与商务图表案例/第二章——可视化基础之设计基础")
# 锁定本地路径

library("showtext")
library("ggplot2")
library("magrittr")

#默认情况下为系统默认字体 （中文宋体）
ggplot(diamonds,aes(color,fill=cut))+
  geom_bar()+
  ggtitle("钻石质量情况")

#情况一——在R语言编辑器的图形设备中打印自定义字体：

windowsFonts( myFont = windowsFont("微软雅黑"))

png("myplot3.jpeg")
ggplot(diamonds,aes(color,fill=cut))+
  geom_bar()+
  ggtitle("钻石质量情况")+
  theme(title=element_text(family="myFont"))
dev.off()

ggplot(diamonds,aes(color,fill=cut))+
  geom_bar()+
  ggtitle("钻石质量情况")+
  theme(title=element_text(family="myFont")) 
ggsave("myplot1.png")



#情况二——在本地磁盘保存图片（同时嵌入字体）
font_add("myfont","msyh.ttc") 
font.families() 


png("myplot.jpeg")
showtext_begin()
ggplot(diamonds,aes(color,fill=cut))+
  geom_bar()+
  ggtitle("钻石质量情况")+
  theme(title=element_text(family="myfont"))
showtext_end()
dev.off()

png("myplot4.jpeg")
ggplot(diamonds,aes(color,fill=cut))+
  geom_bar()+
  ggtitle("钻石质量情况")
dev.off()

####2.4 R语言中的色彩应用####

library("scales")

#1、R语言基础预定义颜色
colors()
show_col(sample(colors(),100),labels = FALSE)

#2、五大预设配色版

show_col(sample(rainbow(1000),replace = FALSE),labels = FALSE)
show_col(sample(heat.colors(1000),replace = FALSE),labels = FALSE)   
show_col(sample(terrain.colors(1000),replace = FALSE),labels = FALSE) 
show_col(sample(topo.colors(1000),replace = FALSE),labels = FALSE) 
show_col(sample(cm.colors(1000),replace = FALSE),labels = FALSE) 
  
#3、colorRampPalette函数自定义色板

patellte <- colorRampPalette(c("red", "green","orange",'blue','yellow'))(1000)
show_col(patellte,labels = FALSE) 

#4、gray(0:n/n)
show_col(gray(0:10000/10000),labels = FALSE) 

#5、hsv函数

x <- seq(0,10)/10
ndx <- expand.grid(x, x, x)
mycolor <- hsv(ndx[,3],ndx[,2],ndx[,1])
show_col(mycolor,labels = FALSE) 



