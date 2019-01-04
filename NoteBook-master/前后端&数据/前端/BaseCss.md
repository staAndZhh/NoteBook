#--------------- base------------------------------------
# book
+   css权威指南
+   精通CSS(高级web标准解决方案)
+   CSS Secrets
# 样式使用
+   行内,内嵌,外部
# 基本选择器
##   标签,类,id,通用
+   p
+   .
+   #适用与js选择的,有动态效果的
+   
#属性选择器
+   [title~=hello] { color:blue; }
+   
# 扩展选择器
##   后代(空格),交集(后面.),并集(,),伪类(静态,动态伪类)
+   空格  div .red 后代选择器
+   . 交集选择机器没有空格 div.red 交集选择器一般标签名开头 div.haha
+   , p1,h1,#mytitle,.one{}
+   静态 只能用于超链接 a:link{} a:visited{}
+   动态  focus hover active 
# 选择器优先级(low-high)
+   通用
+   元素(类型)  1
+   类 10
+   属性
+   伪类
+   id 100
+   内联 1000
# 要点
+   盒子,浮动,定位

# 常见属性
+   color
+   font-size
+   background-color
+   font-weight 加粗
+   font-style
+   text-decoration 下划线
## background
+   -color
+   -image:url('paper.gif');
+   -repeat:
    +   repeat-x;水平平铺;                                                                                              
    +   no-repeat;背景不影响文本排版
+   -attachment:
    +   fixed scroll local
+   -position:
    +   top right;
    +   50% 50%;
## Text
+   -color
+   -align:center;right;justify;
+   -decoration:none;overline;line-through;underline; 下划线
+   -transform:uppercase;lowercase;capitalize; 
+   -indent:50px; 缩进
## font
+   -family:字体簇
+   -style:normal;italic;oblique;
+   -size:1em;16px;px/font-size(默认)=em;
+   -weight:bolder;bold;normal;lighter
## a
+   :link
+   :visited
+   :hover
+   :active
## ul
+   list-style-type:none;disc;circle;square;demical;lower-alpha;upper-alpha;lower-roman;upper-roman;
+   list-style-image
+   list-style-position
+   list-style-type
## table
+   border-collapse:collapse; 
+   border:1px solid black;
+   text-align:right;left;center;
+   vertical-align:bottom; 
## 盒子模型
+   content
+   padding
+   border
+   margin
## border
+   -style:dotted;dashed;solid;double;
+   -width:
+   -color:
## 尺寸
+   height:
+   width
+   max-height
+   min-height
## 隐藏
+   display:none; 隐藏,位置也消失
+   visibility:hidden; 隐藏,但是占位置
## display
+   display:inline;block
+   块元素:全部宽度;前后都是换行符 h p div
+   内联:有宽度,不强制换行 span a
##  position
+   positon:static;fixed;relative
+   top:
+   bottom:
+   left:
+   right:
### static
+   默认数据流
### fixed
+   固定位置
### relative
+   相对其正常位置
### absolute
+   相对与最近的已经定位的父元素,没有的已经定位的父元素,相对于html
### 重叠元素
+   position:absolute;
+   z-index:-1 ;    数字大的在签名
### float
+   定义元素哪个方向浮动;生成一个块级框;直到块框碰到包含框或者其他的浮动框;
####　CSS浮动
+   使元素向左或向右移动，其周围的元素也会重新排列
#### 元素浮动
+   只能左右不能上下;
+   尽量向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止
+   浮动元素之后的元素将围绕它。
+   浮动元素之前的元素将不会受到影响。
#### 相邻的浮动
+   有空间的话,会彼此相邻
#### 清除浮动 
+   使用 clear
+   clear:both;
+   元素浮动之后，周围的元素会重新排列，为了避免这种情况，使用 clear 属性。
+   clear 属性指定元素两侧不能出现浮动元素
## 水平对齐
### 块对齐
+   margin左右 auto; 
+   宽度100%,对齐没效果
## 组合选择器
+   后代 空格
+   子元素 大于号
+   相邻  加号
+   普通兄弟 波浪号
## 图片透明
+   img {opacity:0.5;filter:alpha(opacity=60);}

#------------------ other--------------
## 伪类
+   元素达到一个特定状态时，它可能得到一个伪类的样式
## 伪元素
+   基于元素的抽象，并不存在于文档中，所以称为伪元素。
# 选择器
+   元素：html {color:black;}
+   id：#red {color:red;}
+   类：.center {text-align: center}
+   属性：a[href][title] {color:red;}
+   后代：h1 em {color:red;}
+   子元素：    h1 > strong {color:red;}
+   选择器分组：h2, p {color:gray;}
+   相邻兄弟：h1 + p {margin-top:50px;}
+   伪类：a:hover {color: #FF00FF}	
+   伪元素：p:first-line
  {
  color:#ff0000;
  font-variant:small-caps;
  }
+   派生：
+   li strong {
    font-style: italic;
    font-weight: normal;
  }
+   # sidebar p {
	font-style: italic;
	text-align: right;
	margin-top: 0.5em;
	}
+   div#sidebar {
	border: 1px dotted #000;
	padding: 10px;
	}
+  .fancy td {
	color: #f60;
	background: #666;
	}

# margin 方式
+   margin:25px 50px 75px 100px; 上右下左
+   margin:25px 50px 75px; 上,左右,下
+   margin:25px 50px; 上下，左右
+   margin:25px; 所有的
# 定位
+   普通流、浮动和绝对定位
+   块级框从上到下一个接一个地排列，框之间的垂直距离是由框的垂直外边距计算出来
+   static,relative,absolute,fixed
# flex
+   older:display+position+float
+   new:flex

# vh
+    vw  相对于视口的宽度。视口被均分为100单位的vw
+   vh  相对于视口的高度。视口被均分为100单位的vh
+   vmax 相对于视口的宽度或高度中较大的那个。其中最大的那个被均分为100单位的vmax
+   vmin 相对于视口的宽度或高度中较小的那个。其中最小的那个被均分为100单位的vmin

# calc
+   动态计算长度
+   width: calc(100% - 10px)

# div水平居中
+  m1
    +   body设置css内容居中样式（css text-align:center）
    +   然后布局最外层DIV盒子时候使用 margin:0 auto(对象上下间隔为0，左右间隔自动)
#--------------------------demo--------------
# 导航
# 下拉菜单
# 图片走廊
# 雪碧图
# viewport
# 媒体查询
# 