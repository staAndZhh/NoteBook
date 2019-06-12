#	模块
## base
+	html元素分类和特性
+	html原色默认样式和定制化
+	css选择器全解析
+	css常用属性逐一解析
##	css布局
+	布局属性和组合解析
+	常见布局方案
+	三栏布局案例
+	国内大站布局拆解
## 动画和效果
+	多背景多投影
+	3D特效
+	过渡动画和关键帧动画实践
+	动画细节原理
##	框架和CSS工程化
+	预处理器作用和原理
+	Less/Sass
+	Bootstrap原理
+	css工程化
+	Js框架中集成css
##	问题
+	html嵌套关系
+	css权重
+	浮动布局
+	css帧动画
+	Bootstrap响应式布局
+	css选择器相互干扰

# HTML
##	 html常见元素
+	标签
![常见元素](https://i.imgur.com/mxsT34I.png)

+ 元素
![](https://i.imgur.com/yl0gEqe.png)
+ 	属性
![](https://i.imgur.com/oCuvHxy.png)
+	表单
![](https://i.imgur.com/XBvwc4S.png)
+	含义
	+	文档
	+	描述文档的结构
	+	区块和大纲
	+	大纲视图
	+	[http://h5o.github.io/](http://h5o.github.io/)
+	历史版本
	+	html4 SGML
	+	XHTML XML
	+	html5
	+	h5新增元素：
		+	section article nav aside
		+	表单增强 日期，时间，搜索；表单验证；PlaceHolder自动聚焦
	+	h5新增语意
		+	header/footer 头尾
		+	section/artilce 区域
		+	nav 导航
		+	aside 不重要的内容
		+	em/strong 强调
		+	i icon
+	![](https://i.imgur.com/fTSVuu1.png)

## 元素分类
+	默认样式分
	+ 块状	block（默认占据整行，方形） div section article aside
	+	行内 inlinde （没有特定的规则形状） span em strong 
	+	inline-block (对内方块形状，对外不占据整行，有宽高） 下拉，输入框
+	内容分
![](https://i.imgur.com/E784qtb.png)

## 元素嵌套
+	块级元素可包含行内元素
+	块级元素不一定包含块级
+	行内一般不包含块级
+	a > div 是例外

##	默认样式
+	更改css默认样式
+	css reset
+	雅虎ui yui
+  <stye> * padding marginL:0</style>
+	Normalize.css

#	CSS基础
##	base
+	Cascading Style Sheet 
+	层叠样式表
+	>	选择器{属性：值；
	属性：值}
+	选择器
	+	用于匹配HTML元素
	+	不同的选择规则
	+	可以叠加
	+	分类和权重
	+	解析方式和性能
	+	值得关注的选择器
+	解析规则
	+	.body div .hello{xx:xx}
	+	浏览器解析是从右往左的，加快解析速度
## 选择器分类
+	![](https://i.imgur.com/gSQflkE.png)
+	伪元素是真实存在的元素::
+	伪类是元素的某种状态：
##	选择器权重
+ ![](https://i.imgur.com/oOHWvOn.png)
+	案例
+	![](https://i.imgur.com/97CGMH8.png)
+ 	计算一个不进位的数字
+	权重：11个Id选择器<1个ID选择器；
+	官大一级压死人
+	特殊情况

![](https://i.imgur.com/kOFRWV9.png)
## 非布局样式
+	字体，字重，颜色，大小，行高
+	背景，边框
+	滚动，换行
+	粗体，斜体，下划线
+	其他
+	概念：	
	+	字体族
		+	serif sans-serif monospace 	cursive fantasy
		+ 衬线字体（宋体）非衬线字体（黑体） 等宽字体 手写体 花体
	+	多字体 fallback(前面的字体找不到，使用后面的字体）
	+	网络字体 自定义字体
	+  iconfont
+	字体名称加引号，字体族不加引号
>	.chinese{
>	font-family:'PingFang SC',"Microsoft Yahei",monospace;
>	}
+	自定义字体
![](https://i.imgur.com/KYSBQYJ.png)

+	远程字体，需要远程文件允许跨域访问
+	图标转字体
+	[http://www.iconfont.cn/](http://www.iconfont.cn/)
## 行高
+	行高构成
+	inline基于baseline
+	设置对其方式为bottom可以清楚底部间隔
##	背景
+	背景色
	+	backgrounp:xx;
	+	white
	+	#F00
	+	hsl(色相，饱和度，亮度）;
	+	rgb(255,0,0);
	+	url(./xx/xx.png);
+	渐变背景
	+	-webkit-linear-gradient(left,red,green);
	+	linear-gradient(180deg,red,green);
+	多背景叠加
	+	backgrounp:linear-gradient()
		linear-gradient()
+	背景图片和属性
	+ backgrounp：red  url();
	+ background-repeat: no-reapeat;
	+ background-size:center top;
	+ background-position:20px 100px;
+	base64和性能优化
	+	把图片变成base64来引用，变为原来的4/3
	+	小图标引用
+	多分辨率适配

##	边框
+	属性：线型 大小 颜色
	+ border:30px solid red;
+	背景图
	+ border-image:url() 30 repeat round;
+	边框衔接：（三角形）
##	滚动
+	滚动行为和滚动条
+	overflow
+	![](https://i.imgur.com/iPMChIs.png)

## 文字换行
+	overflow-wrap(word-wrap)通用换行控制
+	是否保留单词
+	word-break 针对多字节文字
+	中文句子也是单词 
+	white-space 空白处是否断行

##	装饰用属性
+	自重（粗体） font-weight
	+	normal bold bolder lighter 100 (100~900)
+	斜体	font-style:itatic
+	下划线 text-decorations
+	指针	cursor

## cssHack
+	针对特别浏览器
+	不合法但是有效
+	难理解难维护容易失效
+	方法：特性检测针对性加class

# CSS布局
+	table
+	技巧性为主
+	flexbox/grid
+	响应式布局

##	布局方式
+	table
	+	table默认剧中
+	float+margin
	+	盒子模型
		+ content padding border margin
	+	位置信息
		+ ![](https://i.imgur.com/FMZ5osj.png)

		+	flex在可视区域的绝对定位
	+	元素浮动
	+	脱离文档流
	+	不脱离文本流
	+	做图文混排
	+	对自身影响
		+	形成块
		+	位置尽量靠上
		+	位置尽量靠左（右）
	+	对兄弟影响
		+	上面贴非float元素
		+   旁边贴非float元素
		+	不影响其他块状元素位置
		+	影响其他块级元素内部文本
	+	对父级影响
		+	从布局上消失
		+	高度塌陷
+	inline-block
	+	像文本一样排block元素
	+	没有清除浮动等问题
	+	需要处理间隙
	+	想象为文字
+	flexbox
	+	弹性盒子
	+	盒子本来是并列的
	+	指定宽度就可以

+	响应式设计和布局
	+	不同设备上使用
	+	一般处理屏幕大小问题
	+	主要方法
		+	隐藏+折行+自适应空间
		+	rem/viewport/midia query

# 效果属性
+	box-shadow
	+	层次感
	+	没有宽度的边框
	+	特殊效果
+	text-shadow
	+	立体感
	+	印刷品质感
+	border-radius
	+	圆角矩形
	+	圆形
	+	半圆/扇形
+	background
	+	纹理，图案
	+	渐变
	+	雪碧图
	+	 背景图适应
+	clip-path
	+	容器裁剪
	+	几何图形
	+	自定义路径
## 3D变换

## CSS动画
+	transition
	+ 补间动画
	+	![](https://i.imgur.com/lCyNSoO.png)
+	keyframe
	+	![](https://i.imgur.com/RzUC5sK.png)
+	逐帧动画
	+	![](https://i.imgur.com/hx1jtzK.png)

# CSS预处理器
+	基于css的另一种语言
+	通过工具编译为css
+	+很多css不同的特性
+	提升css文件的组织
+	Less:node,js写的，快速
+	Sass/Scss:Ruby，编译慢有node-sass版本
+	功能
	+	嵌套：反映层级和约束
	+	变量和计算：减少重复代码
	+	Extend和Mixin:代码片段
	+	循环：复杂有规律的样式
	+	import:css文件模块化

## less
+	node npm
+	npm install  kless -g
+	新建xx.less
	+	嵌套  
	>	.a {
				.b{}
				&:c{}
					}
	+	变量
	>	@fontSize:12px;
		.a { font-size:@fontSize+2px;}
		
	+	minix
	>		.block(@fontSize){
		>	font-size:@fontSize;
		>	border:1px solid #ccc;
		>	}
		>	使用：
		>	.content{
		>	.block(@fontSize+2px);
		>	}
		>	.nav{
		>	.block(@fontSize);
		>	}
	+	extend
	>		.block(@fontSize){
		>	font-size:@fontSize;
		>	border:1px solid #ccc;
		>	}
		>	使用
		>	.wrapper{
		>	background:lighten(@bgColor:40%);
		>	.nav:extend(.block){}
		>	.content{
		>		&:extend(.block);
		>		&:hover{
		>			background:red;
		>		}
		>	}
		>	}
	+	循环loop
		+	minix可以调用自己，使用递归
		+  ![](https://i.imgur.com/3zUzdI0.png)
	+	import导入
		+	预处理器的变量可以跨文件使用
		+	多个@import编译为一个文件
+	编译less文件 less xx.less > xx.css
	
## sass
+	npm install node-less -g
+	新建xx.sass
	+	嵌套  
	>		.a {
				.b{}
				&:c{}
					}
	+	变量
	>	$fontSize:12px;
		.a { font-size:$fontSize+2px;}
	+	minix
		+ $
		+	@mixin显示声明
		+	@include显示调用
		+	不需要用类名 .
	>		@mixin block($fontSize){
		font-size:$fontSize;
		border:1px solid #ccc;
		}
		使用：
			.content{
			@include block($fontSize+2px);
			}
			.nav{
			@include block($fontSize);
			}
	+	extend
	>		.block(@fontSize){
		>	font-size:@fontSize;
		>	border:1px solid #ccc;
		>	}
		>	使用
		>	.wrapper{
		>	background:lighten(@bgColor:40%);
		>	.nav:{
		>		@extend.block}
		>	.content{
		>		@extend .block;
		>		&:hover{
		>			background:red;
		>		}
		>	}
		>	}
	+	循环loop
		+	minix可以调用自己，使用递归
		+  ![](https://i.imgur.com/bzsYM2W.png)
	+	sass支持for循环
		+	![](https://i.imgur.com/bHkscHu.png)
	+	import导入
		+	预处理器的变量可以跨文件使用
		+	多个@import编译为一个文件
+	编译less文件 node-sass xx.scss > xx.css

## 预处理器框架
+	可以使用别人的代码
+	SASS-Compass
	+ [http://compass-style.org/](http://compass-style.org/)
+	Less-Lesshat/EST
	+	[http://ecomfe.github.io/est/#top](http://ecomfe.github.io/est/#top)
+	提供现成的mixin
+	类似JS类库 封装常用功能
## BootStrap
+	css框架
+	twitter出品
+	提供基础样式
+	BootStrap4
	+	兼容IE10
	+	使用flexbox
	+	抛弃Nomalize.css
	+	提供布局和reboot版本
	+	基础样式，常用组件，JS插件
	+	3.0使用less,4.0使用sass
	+	[https://getbootstrap.com](https://getbootstrap.com)

+	网格系统
+	BootStrap Js组件
	+ 使用方式
	+	基于 data-*属性
	+	基于JS API
+	BootStrap 响应式布局
	+	网格系统在不同的分辨率下有不同的分配
		> 		<div class = 'content col-12 col-lg-3 col-md-4 col-sm-6'></div>
		> 		自动在不同的屏幕环境下适配格式表达
		
+	BootStrap定制化
	+	使用css同名文件覆盖
	+	修改源码重新覆盖
	+	应用scss源文件 修改变量

##	CSS工程化
+	组织  优化	构建 维护
+	PostCSS
	+	![](https://i.imgur.com/17UBXYS.png)
	+	PostCSS本身只有解析能力
	+	各种神奇特性全靠插件
	+	200+插件
	+	常用插件
		+	import 模块合并
		+	autoprefixier 自动加前缀
		+	cssnano	压缩代码
		+	cssnext	使用css新特性
		+	precss	变量 minxin 循环
	+  npm install postcss-cli
	+	postcss xx.css -o xx.css

## Webpack
+	js是整个文件的核心入口
+	webpack是js实现模块化的方法
+ 	通过css-loader把css转化为js
+	通过 style-loader把css-loader转化的js转化为样式