# base 
## 基础使用
+ css引入，js引入
+ 模板html引入
	+	更改源文件的地址
### 初始栅格
+	电脑4个，平板2个，手机1个
+	container
+	row
	+	col-lg-3 
	+	col-md-3
	+	col-sm-6
	+	col-xs-12
### 响应式布局
+	多设备兼容（手机，平板，电脑)
	+	m1：不同设备，不同的页面
	+	m2：响应式变动
### 响应式内容
+	大区块的响应式
	+	栅格系统
+	内部元素：图片，文字
	+	响应式图片,表格，视频
	+	响应式内容
### 响应式导航
+	响应式导航：头部响应
## 栅格系统
+	container
+	container-fluid:流动占满全屏
+	lg >1200 md >970 sm  >750 xs <750
	+	col-lg-3 
	+	col-md-3
	+	col-sm-6
	+	col-xs-12
## 响应式导航	
+	需要导入jquery和bootstrap
### data-target
+	m1
+	data-target="#bs-example-navbar-collapse-1"
+	对照：<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
+	m2
+	data-target=".bs-example-navbar-collapse-1"
+	对照：<div class="bs-example-navbar-collapse-1">
### 表单
+	导航中的按钮：navbar-btn
+	导航中的表单：navbar-form
## 响应式图片表格内容
+	栅格系统不应该手动给宽高
+	图片
	+	<img src="img/789.jpg" class="img-responsive img-circle"/>
+	表格
	+	<table class="table table-bordered">
+	视频
	+	<div class="embed-responsive embed-responsive-16by9">
# 实战
+	框架为我所用
+	框架迁就项目
## 导航条
+	navbar-text
+	navbar-right
### nav
+	左侧图标
+	右侧非链接导航条
### 字体图标
+	引入fonts文件夹
### 轮播图
+	指示器
+	图片&说明文字
+	左右切换按钮
	+	指示器和图片需要一一对应
+	修改点颜色
### 文字说明
+	居中对齐 text-center
+	左右-前横杠：伪类选择器
	+	.ad:before,.ad:after{
	background: #cdcdcd no-repeat;
	content: " ";
	height: 1px;
	display: inline-block;
	width: 10%;
	vertical-align:middle ;
}
+	字体变换
	+	媒体查询：更改尺寸
## 服务
+	栅格4列：图标，文字
+	br换行或者margin-top
## 案例
+	标题&4缩略图
## 页脚
+ 先分行&在分列
+ 图片居中：center-block
### 阿里图标库
+	导入css
	+	<link href='stylesheet' type="text/css" href="http://at.alicdn.com/t/font_363658_991rk9gzpaj.js"/>
### 关于我们
+	pull-right
+	center-block

## 小屏幕优化
+	媒体查询
### 头部兼容
+	头部图片变小
+	下拉标题居中
	+	@media only screen and (max-width:768px){
	.navbar{
		margin-top: 0px;
		margin-bottom: 0px;
		text-align: center;
	}
	.logo{
		height:35px;
	}
	.navbar-brand{
		padding-top: 5px;
		padding-left: 15px;
	}
}
### 底部兼容
+	隐藏不必要的组件
	+	.visible-xs-*
	+	.hidden-xs
	+	            <p class="visible-lg visible-md">码上有惊喜<br>扫一扫关注微信领大奖</p>
						<p class="hidden-lg hidden-md">码上有惊喜<br>长按识别二维码领大奖</p>
+	图标大小
### 固定在顶部的导航
+	navbar-fixed-top
+	防止遮盖：margin-top: 60px

----------
# 列表页
+	标题
+	图片
+	列表
+	分页
+	列表组合list-group
+	图文混合:Media媒体对象
+	胶囊式标签页
	+	<ul class="nav nav-pills">
  <li role="presentation" class="active"><a href="#">Home</a></li>
  <li role="presentation"><a href="#">Profile</a></li>
  <li role="presentation"><a href="#">Messages</a></li>
</ul>
# 内容页
+	breadbrumd：路径导航
+	jquery 动态添加属性
# modal框弹窗
+	插件导入
	+	先jquery
	+	在bootstrap
+	模态框
+	表单
# bootstrap定制
+	col改为15列
+	@grid-columns：15

----------
# bootstarp
+	开发维护成本低
+	分享网址好用
+	需要载入速度问题
+	功能取舍
### 框架介绍
+	bootstrap
	+	流行
+	pure
	+	pure.css
	+	简单，干净
+	semantic
	+	最新，功能最全
+	foundation
	+	公司维护
+	ulkit
	+	定制化机制，线上编辑
### 容器
+	div:class=container
	+	固定宽度
+	container-fluid
	+	填充满
+ 图片响应：img: img-fluid
+  bs4写col会自动相除：分列
+	分行 div class=w-100
+	col-md-auto
+	对齐：row align-items-center
+	对齐：col aligin-self-center
+	对齐：.ml-auto
### 文字排版
### 表格介绍
+	图片居中：d-block mx-auto
### 导航条