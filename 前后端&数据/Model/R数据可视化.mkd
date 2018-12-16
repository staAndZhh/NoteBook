### 设计基础
+   字体，色彩，版式，设计元素
### 色彩
+   色相，饱和度，亮度
### 排版
+   对齐，对比，亲密性，重复
## ggplot2
### 框架
+   数据
    +   几何图层（统计变换）：geom_xxx()， stat_xxx()
    +   数据映射
        +   美学映射：mapping_aes(): x,y,col,color,colour,group,size,alpha,linetype
        +   位置调整：positon adjustment :identity,stack,dodge,fill
    +   坐标系转换 coordinate
        +   coord_cartesian,coord_fixed,coord_flip,coord_polar,coord_map
    +   标度调整 scales
        +   scale_x|y_xxx, scale_fill/color_xxx,scale_size_xxx
        +   scale_alpha_xxx
        +   scale_line_type_xxx
        +   scale_line_shape_xxx
    +   分面 facetting
        +   facet_grid
        +   facet_wrap
+   美化
    +   图例调整    guides
        +   guide_colourbar
        +   guide_legend
    +   主题   themes
        +   element_line
        +   element_text
        +   element_rect
        +   element_blank
    +   数据标签 geom_text()
    +   自定义注释 annotation()
    +   标题，副标题，备注 labs()
### 图层
#### mapping
+   mapping（x,y,size,alpha,linetype,colour,fill)
+   geom_bar(mapping = NULL, data = NULL, stat = "count",position = "stack)
+   stat_count(mapping = NULL, data = NULL, geom = "bar",position = "stack")
#### position
+   bar,area,histigram
+   identity ：序列相互遮盖
+   stack:垂直堆叠
+   fill:百分比堆叠
###   标度
+   物理元素
    +   点线面;形状大小;（shape,linetype,size)
+   色彩元素
    +   色相，颜色，透明度；
    +   分面，分组（facet，group）
    +   坐标轴设定(x,y)
+   标度调整
    +   x,y,colour,fill,alpha,scale,shape,linetype
###   坐标轴
+   coord_cartesian 笛卡尔，默认
+   coord_fixed 固定宽高比
+   coord_flip 翻转
+   coord_map 地图
+   coord_polar 极坐标
###   图例
+   guides
    +   title,title.vjust,title.hjust
    +   label,label.vjust,label.hjust,direction
    +   size:barwidth/barheight,nbin,ticks
###   标签
+   geom_text
+   labs
+   annotations
###   分面
+   facet_grid 网格分面
+   facet_wrap 一维分面
###  主题
+   text
+   rect
+   line