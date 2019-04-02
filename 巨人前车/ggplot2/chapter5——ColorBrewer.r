##《R语言商务图表与数据可视化》
##课程讲师——杜雨
##课程机构——天善智能


########第五章——R语言与数据可视化用色规范与标准########

##5.1  R语言基础预设配色系统

#1、R语言基础预定义颜色
library("scales")
library("ggplot2")

colors()
show_col(colors(),labels = FALSE)
show_col(sample(colors(),100),labels = FALSE)

colors()[1:10]
sample(colors(),100)

ggplot(mpg,aes(class,displ))+
  geom_bar(stat="identity",fill="steelblue")

ggplot(mpg,aes(class,displ))+
  geom_bar(aes(fill = class),stat="identity")

palette <- sample(colors(),7)
ggplot(mpg,aes(class,displ))+
  geom_bar(aes(fill = class),stat="identity") +
  scale_fill_manual(values = palette)

length(unique(mpg$class))
length(palette)


#2、五大预设配色版

show_col(sample(rainbow(1000),replace = FALSE),labels = FALSE)
show_col(sample(heat.colors(1000),replace = FALSE),labels = FALSE)   
show_col(sample(terrain.colors(1000),replace = FALSE),labels = FALSE) 
show_col(sample(topo.colors(1000),replace = FALSE),labels = FALSE) 
show_col(sample(cm.colors(1000),replace = FALSE),labels = FALSE) 


par(mfrow=c(1,5),mar=c(0.5,0.5,2,0.5),xaxs="i",yaxs="i")
n<-1000
barplot(rep(1,times=n),col=rainbow(n),border=rainbow(n),horiz=T,axes=F,main="Rainbow Color")
barplot(rep(1,times=n),col=heat.colors(n),border=heat.colors(n),horiz=T,axes=F,main="Heat.Colors")
barplot(rep(1,times=n),col=terrain.colors(n),border=terrain.colors(n),horiz=T,axes=F,main="Terrain.Colors")
barplot(rep(1,times=n),col=topo.colors(n),border=topo.colors(n),horiz=T,axes=F,main="Topo.Colors")
barplot(rep(1,times=n),col=cm.colors(n),border=cm.colors(n),horiz=T,axes=F,main="Cm.Colors")
dev.off()


ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = rainbow(7))
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = heat.colors(7))
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = terrain.colors(7))
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = topo.colors(7))
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = cm.colors(7))


#3、colorRampPalette函数自定义色板

patellte <- colorRampPalette(c("red", "green","orange",'blue','yellow'))
show_col(patellte(100000),labels = FALSE,border = NA) 
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill=class),stat="identity") + scale_fill_manual(values = patellte(n = 7))


#4、gray(0:n/n)
show_col(gray(0:10000/10000),labels = FALSE,border = NA) 
ggplot(mpg,aes(class,displ)) + geom_bar(aes(fill = class),stat="identity") + scale_fill_manual(values = gray(0:6/6))

#5、hsv函数

x <- seq(1,4)/4
ndx <- expand.grid(x, x, x)

mycolor <- hsv(ndx[,3],ndx[,2],ndx[,1],alph = .5)

show_col(mycolor,labels = FALSE) 
ggplot(mpg,aes(class,displ)) + 
  geom_bar(aes(fill=class),stat="identity") + 
  scale_fill_manual(values = sample(mycolor,7))

####颜色标度的主要参数解释：

limits   #可用类型（离散）/度量区间范围（连续）
breaks   #指定显示刻度位置
labels   #对应刻度位置图例文本标签
values   #对应类别呈现的颜色（透明度、大小、形状、线条、线条等），仅用于自定义标度场景（scale_xxx_manual()）


#关于默认情况下显示的颜色与分类变量子类别顺序如何匹配，是否可以自定义？

#1、如果分类变量不是有序因子变量：

#1.1 默认情况下values顺序与类别变量的名称首字母顺序一一对应
 mydata1 <- data.frame(
   name = LETTERS[1:5],
   value = runif(5,1,100)
 )
 
 color = colors()[sample(1:100,5)]
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill= name),stat="identity") + 
   scale_fill_manual(values = color )
 
 unique(mydata1$name)
 show_col(color,labels=F)

 #1.2 如果values对应的色值向量是一个命名向量，且名称为类别变量的类别名称，则最终颜色会与类别一一对应
 
 color <- c("red","grey","orange","yellow","green")
 names(color) <- LETTERS[sample(1:5,5)]
 
     color <- c('B' = 'red' , 'A' = 'grey' , 'D' = 'orange' , 'E' = 'yellow' , 'C' = 'green')
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_manual(values = color )
 
 names(color)
 show_col(color,labels=T)
 
#2、 有序因子变量情况下，图例顺序与因子顺序一致，颜色顺序仍然符合上述规则：
 color <- c("red","grey","orange","yellow","green")
 show_col(color,labels=T)
 
 mydata1$class <- ordered(mydata1$name,levels = LETTERS[c(3,2,1,5,4)])
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=class),stat="identity") + 
   scale_fill_manual(values = color)
 show_col(color,labels=T)

 
#####5.2 配色系统及扩展包接口调用#####
 
#Diverging(div)        
#BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral

#Qualitative(qual)       
#Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
 
#Sequential(seq)
#Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, 
#PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
 
 mydata1 <- data.frame(
   name = LETTERS[1:6],
   value = runif(6,1,100)
 )
 
 #使用type+index进行指定色盘
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(type = 'div',palette = 1 , direction = 1)
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(type = 'qual',palette = 1 , direction = 1)
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(type = 'seq',palette = 1 , direction = 1)
 
 
 #使用name指定色板
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(palette = 'Blues' , direction = 1)
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(palette = 'BuGn' , direction = 1)
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(palette = 'Greens' , direction = 1)
 
 #色盘顺序指定——direction=1，默认顺序，-1则相反
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_brewer(palette = 'Greens' , direction = -1)
 
 
 #离散色盘连续化封装函数——scale_fill_distiller
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill = value),stat="identity") + 
   scale_fill_distiller(palette = 'Greens' , direction = 1) 
 

 ###5.2 scales::brewer_pal()
 
 brewer_pal(type = "seq", palette = 1, direction = 1)
 
 #
 show_col(brewer_pal()(9))
 show_col(brewer_pal("div")(5))
 show_col(brewer_pal(palette = "Greens")(5))
 
 # Can use with gradient_n to create a continous gradient
 cols <- brewer_pal("div")(5)
 show_col(gradient_n_pal(cols)(seq(0, 1, length.out = 1000)), labels = FALSE, borders =NA)
 
 
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_manual(values = brewer_pal()(6))
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_manual(values = brewer_pal(direction = -1)(6))
 
 

 
 ######5.3 R语言RcolorBrewer在线配色网站及其使用详解######
 library('RColorBrewer')

 
 #查看色板类型
 display.brewer.all(type = "all")    #查看所有色板
 display.brewer.all(type = "seq")    #查看单色渐变色板
 display.brewer.all(type = "div")    #查看双色渐变色板
 display.brewer.all(type = "qual")   #查看离散（分类）色板
 
 #查看指定主题色板
 display.brewer.pal(9, "BuGn")   ###以可视化面板的形式树池色板
 
 brewer.pal(9,"BuGn")            ###以色值向量的形式输出文本向量
 display.brewer.pal(9,"Blues")     
 
 
 
 #查看色板在图形中的效果：
 par(mfrow=c(1,5),mar=c(1,1,2,1),xaxs="i", yaxs="i")
 mycolors<-brewer.pal(9, "BuGn")
 barplot(rep(1,times=9),col=mycolors,border=mycolors,axes=FALSE, horiz=T,main="MyColors of BuGn ")
 mycolors<-brewer.pal(9, "OrRd")
 barplot(rep(1,times=9),col=mycolors,border=mycolors,axes=FALSE, horiz=T,main="MyColors of OrRd")
 mycolors<-brewer.pal(9, "YlGn")
 barplot(rep(1,times=9),col=mycolors,border=mycolors,axes=FALSE, horiz=T,main="MyColors of YlGn")
 mycolors<-brewer.pal(9, "Oranges")
 barplot(rep(1,times=9),col=mycolors,border=mycolors,axes=FALSE, horiz=T,main="MyColors of Oranges")
 mycolors<-brewer.pal(9, "Blues")
 barplot(rep(1,times=9),col=mycolors,border=mycolors,axes=FALSE, horiz=T,main="MyColors of Blues")
 dev.off()
 
 
 #组合色板
 b1<-brewer.pal(9, "BuGn");b2<-brewer.pal(9,"Blues")
 c<-c(b1[c(1,3,5,7,9)],b2[c(2,4,6,8)])
 show_col(c,labels=F)

 c<-c(50,30,50,70,90,40)
 names(c)<-LETTERS[1:6]
 
 library(plyr)
 mydata<-data.frame(c)
 ggplot(data=mydata,aes(x=factor(1),y=c,fill=row.names(mydata)))+
   geom_bar(stat="identity",width=1,col="white")+
   coord_polar(theta = "y",start=0)+
   scale_fill_brewer(palette="Greens")+
   guides(fill=guide_legend(title=NULL)) +
   theme_void()
 
 
 #####5.4 ggthemes主题包简介#####

 library("ggthemes")
 
 m1<-economist_pal()(6)
 show_col(m1)
 mydata$class <- row.names(mydata)
 
 
 ggplot(data=mydata,aes(x=factor(1),y=c,fill=class))+
   geom_bar(stat="identity",width=1,col="white")+
   coord_polar(theta = "y",start=0)+
   theme(panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.text = element_blank(),
         axis.ticks = element_blank(),
         axis.title = element_blank())+
   scale_fill_economist()+
   guides(fill=guide_legend(reverse=TRUE,title=NULL))
 
 
 m2<-wsj_pal()(6)
 show_col(m2)
 
 ggplot(data=mydata,aes(x=factor(1),y=c,fill=class))+
   geom_bar(stat="identity",width=1,col="white")+
   coord_polar(theta = "y",start=0)+
   theme(panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.text = element_blank(),
         axis.ticks = element_blank(),
         axis.title = element_blank())+
   scale_fill_wsj()+
   guides(fill=guide_legend(reverse=TRUE,title=NULL))
 

 #WSJ背景色
 ggthemes_data$wsj$bg         
 gray     green      blue     brown 
 "#efefef" "#e9f3ea" "#d4dee7" "#f8f2e4"
 show_col(ggthemes_data$wsj$bg)
 
 
 #WSJ主题色
 ggthemes_data$wsj$palettes   #主题色
 $rgby
 yellow       red      blue     green 
 "#d3ba68" "#d5695d" "#5d8ca8" "#65a479" 
 
 $red_green
 green       red 
 "#088158" "#ba2f2a" 
 
 $black_green
 black      gray   ltgreen     green 
 "#000000" "#595959" "#59a77f" "#008856" 
 
 $dem_rep
 blue       red      gray 
 "#006a8e" "#b1283a" "#a8a6a7" 
 
 $colors6
 red      blue      gold     green    orange     black 
 "#c72e29" "#016392" "#be9c2e" "#098154" "#fb832d" "#000000"
 
 show_col(ggthemes_data$wsj$palettes$rgby)
 show_col(ggthemes_data$wsj$palettes$red_green)
 show_col(ggthemes_data$wsj$palettes$black_green) 
 show_col(ggthemes_data$wsj$palettes$dem_rep)  
 show_col(ggthemes_data$wsj$palettes$colors6)   
 
 
 mytheme <- ggthemes_data
 
 #economist背景色：
 ggthemes_data$economist$bg
 #economist主题色：
 ggthemes_data$economist$fg
 
 ###
 
 scale_colour/fill_economist(stata = FALSE, ...)
 scale_colour/fill_wsj(stata = FALSE, ...)
 
 mydata1 <- data.frame(
   name = LETTERS[1:6],
   value = runif(6,1,100)
 )
 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_economist() +
   theme_economist()


 
 ggplot(mydata1,aes(name,value)) + 
   geom_bar(aes(fill=name),stat="identity") + 
   scale_fill_wsj() +
   theme_wsj()
 
 
 #####5.5 其他配色类扩展包简介——ggtech、ggthemer#####
 
 
 ###5.5.1 ggthch
 
 
 #devtools::install_github('hadley/ggplot2')
 
 library(ggplot2)
 library(ggtech)
 
 data<-diamonds[diamonds$color %in%LETTERS[4:7], ]
 
 
 #airbnb style
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)+
   theme_airbnb_fancy() + 
   scale_fill_tech(theme="airbnb")  + 
   labs(title="Airbnb theme", 
        subtitle="now with subtitles for ggplot2 >= 2.1.0")
 
 #etsy style
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)+
   theme_tech(theme="facebook") +
   scale_fill_tech(theme="facebook") + 
   labs(title="Facebook theme", 
        subtitle="now with subtitles for ggplot2 >= 2.1.0")

 
 #google style
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)+
   theme_tech(theme="google") + 
   scale_fill_tech(theme="google") + 
   labs(title="Google theme", 
        subtitle="now with subtitles for ggplot2 >= 2.1.0")
 
 #tiwtter style
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)+
   theme_tech(theme="twitter") + 
   scale_fill_tech(theme="twitter") + 
   labs(title="Twitter theme", 
        subtitle="now with subtitles for ggplot2 >= 2.1.0")
 
 #5.5.2 ggthemr
 
 devtools::install_github('cttobin/ggthemr')
 library('ggthemr')
 
 ###启动主题
 #ggthemr('dust')
 ggthemr('flat')
 #ggthemr('flat dark')
 #ggthemr('camoflauge')
 #ggthemr('chalk')
 #ggthemr('copper')
 #ggthemr('earth') 
 #ggthemr('fresh')
 #ggthemr('grape')
 #ggthemr('grass')
 #ggthemr('greyscale')
 #ggthemr('light')
 #ggthemr('lilac')
 #ggthemr('pale')
 #ggthemr('sea')
 #ggthemr('sky')
 #ggthemr('solarized')
 
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)
 
 ###回复系统默认主题
 ggthemr_reset()
 ggplot(data,aes(carat,fill=color))+geom_histogram(bins=30)
 
 
 #5.5.3  ggsci
  
 #install.packages("devtools")                   #官方镜像
 #devtools::install_github("road2stat/ggsci")    #github仓库
 library('ggsci')
 library("scales")
 
 show_col(pal_d3("category10")(10))
 show_col(pal_d3("category20")(20))
 show_col(pal_d3("category20b")(20))
 show_col(pal_d3("category20c")(20))
 
 library("ggsci")
 library("ggplot2")
 library("gridExtra")
 
 data("diamonds")
 
 p1 = ggplot(subset(diamonds, carat >= 2.2),
             aes(x = table, y = price, colour = cut)) +
   geom_point(alpha = 0.7) +
   geom_smooth(method = "loess", alpha = 0.05, size = 1, span = 1) +
   theme_bw()
 
 p2 = ggplot(subset(diamonds, carat > 2.2 & depth > 55 & depth < 70),
             aes(x = depth, fill = cut)) +
   geom_histogram(colour = "black", binwidth = 1, position = "dodge") +
   theme_bw()
 
 ###NPG
 p1_npg = p1 + scale_color_npg()
 p2_npg = p2 + scale_fill_npg()
 grid.arrange(p1_npg, p2_npg, ncol = 2)
 
 
 ###AAAS
 p1_aaas = p1 + scale_color_aaas()
 p2_aaas = p2 + scale_fill_aaas()
 grid.arrange(p1_aaas, p2_aaas, ncol = 2)
 
 ###NEJM
 p1_nejm = p1 + scale_color_nejm()
 p2_nejm = p2 + scale_fill_nejm()
 grid.arrange(p1_nejm, p2_nejm, ncol = 2)
 
 
 
 ###Lancet
 p1_lancet = p1 + scale_color_lancet()
 p2_lancet = p2 + scale_fill_lancet()
 grid.arrange(p1_lancet, p2_lancet, ncol = 2)
 
 
 ###JAMA
 p1_jama = p1 + scale_color_jama()
 p2_jama = p2 + scale_fill_jama()
 grid.arrange(p1_jama, p2_jama, ncol = 2)
 
 
 ###JCO
 p1_jco = p1 + scale_color_jco()
 p2_jco = p2 + scale_fill_jco()
 grid.arrange(p1_jco, p2_jco, ncol = 2)
 
 
 ###UCSCGB
 p1_ucscgb = p1 + scale_color_ucscgb()
 p2_ucscgb = p2 + scale_fill_ucscgb()
 grid.arrange(p1_ucscgb, p2_ucscgb, ncol = 2)
 
 ###D3
 p1_d3 = p1 + scale_color_d3()
 p2_d3 = p2 + scale_fill_d3()
 
 
 ###LocusZoom
 p1_locuszoom = p1 + scale_color_locuszoom()
 p2_locuszoom = p2 + scale_fill_locuszoom()
 grid.arrange(p1_locuszoom, p2_locuszoom, ncol = 2)
 grid.arrange(p1_d3, p2_d3, ncol = 2)
 
 
 ###IGV
 p1_igv_default = p1 + scale_color_igv()
 p2_igv_default = p2 + scale_fill_igv()
 grid.arrange(p1_igv_default, p2_igv_default, ncol = 2)
 
 
 ###UChicago
 p1_uchicago = p1 + scale_color_uchicago()
 p2_uchicago = p2 + scale_fill_uchicago()
 grid.arrange(p1_uchicago, p2_uchicago, ncol = 2)
 
 
 ###Star Trek
 p1_startrek = p1 + scale_color_startrek()
 p2_startrek = p2 + scale_fill_startrek()
 grid.arrange(p1_startrek, p2_startrek, ncol = 2)
 
 
 ###Tron Legacy
 p1_tron = p1 + scale_color_tron() + 
  theme_dark() + 
  theme(panel.background = element_rect(fill = "#2D2D2D"),
     legend.key = element_rect(fill = "#2D2D2D"))
 
 p2_tron = p2 + theme_dark() + theme(
   panel.background = element_rect(fill = "#2D2D2D")) +
   scale_fill_tron()
 grid.arrange(p1_tron, p2_tron, ncol = 2)
 
 ###Futurama
 p1_futurama = p1 + scale_color_futurama()
 p2_futurama = p2 + scale_fill_futurama()
 grid.arrange(p1_futurama, p2_futurama, ncol = 2)
 
 
 ###Rick and Morty
 p1_rickandmorty = p1 + scale_color_rickandmorty()
 p2_rickandmorty = p2 + scale_fill_rickandmorty()
 grid.arrange(p1_rickandmorty, p2_rickandmorty, ncol = 2)
 
 ###The Simpsons
 p1_simpsons = p1 + scale_color_simpsons()
 p2_simpsons = p2 + scale_fill_simpsons()
 grid.arrange(p1_simpsons, p2_simpsons, ncol = 2)
 
 
 
 ###Continuous Color Palettes
 
 
 library("reshape2")
 data("mtcars")
 cor = cor(unname(cbind(mtcars, mtcars, mtcars, mtcars)))
 cor_melt = melt(cor)
 
 p3 = ggplot(cor_melt,
             aes(x = Var1, y = Var2, fill = value)) +
   geom_tile(colour = "black", size = 0.3) +
   theme_bw() +
   theme(axis.title.x = element_blank(),
         axis.title.y = element_blank())
 
 ###GSEA
 p3_gsea     = p3 + scale_fill_gsea()
 p3_gsea_inv = p3 + scale_fill_gsea(reverse = TRUE)
 grid.arrange(p3_gsea, p3_gsea_inv, ncol = 2)
 
 
 
 
 
 