# H5专题页面类型
+	活动运营
+	品牌宣传
+	产品介绍
+	总结报告

# 课程内容
+	开发流程
	+	每个流程做什么
	+	各个环节容易出现的问题
	+	问题定责
+	技术实现
	+	技术规划，选型
	+	设计易扩展的开发方案
	+	开发各种图表组件

# 分工
![](https://i.imgur.com/3n0WLfd.png)

+	产品经理PM：ProductManager
	+ 产出MRD：Market Requirements Ducument
+	美术
	+ UI：UserInterface 界面视觉设计
	+ UE ：UserExpericence 用户体验设计
+	技术经理PM：ProjectManager
+	前端FE:FrontEnd engineer
+	后端RD:Research Developer BE:BackEnd 
+ 	测试QA：Quality Assessment
+	运维OP：Operate

#	开发流程
+	开发前
	+	产品功能设计
		+ 需求文档；描述项目功能需求
	+	视觉/交互设计
		+	交互设计稿
		+ 视觉设计稿：PSD

![](https://i.imgur.com/7m2avxx.png)


+	开发中
	+	需求文档
	+	项目开发文档
		+	可行性确定
		+	 技术选型
		+	开发/线上环境规划
		+	技术开发方案设计
		+	团队协作方式

+	技术选型
	+	jquery
	+	FullPage 插件（Jquery插件）
	+	组件：图文组件+图标组件
	+	技术点
		+	html+css
			+	柱状图，垂直柱图
			+	散点图
		+	Canvas
			+	折线图
			+	雷达图
			+	饼图-环图

+	前端开发
	+	设计稿标注&切图
		+	标注工具MarkMan以及使用
		+	静态页面
			+	验证fullpage.js插件的页面切换功能
			+	验证fullpage.js事件，实现组件入场，出场动画
			+	开发测试：基本图文组件：类H5ComponentBase(出场，入场动画提取）
			+	开发测试：内容组织类H5：内容页面与组件的组织功能，方便任意添加page,compeonent内容
			+	开发图标组件
			+	loading功能开发
			+	功能整合：实现设计稿
+	设计稿标注&切图
	+	切图工具 MarkMan
	+	切片工具
+	静态页验证
	+	页面切换
	+	组件切换：入场，出场动画

+	JS规划
	+ 	内容组织页：Page-Components
	+	内容组织页 + fullpage切换
	+	页面切换：通知页内所有的组件
	+	方法：addPage,addComponent,展示页面加载loader
	+	图文组织页：H5ComponentBase
	+	输出Dom，内容可以是图片或者文字
	+	事件：页面载入时：onLoad,页面移出时:onLeave
	+	图表组件类：H5Component图表
	+	在H5ComponentBase基础上插入DOM或者Canvas图形
	+	事件：OnLoad,onLeave,图表组件本身的伸展动画
+	总结
	+	内容组织类 H5
	+	图文组织类 H5ComponentBase:柱图Bar，散点图Point
	+	图表组件类 H5ComPonent:折线图Polyline,雷达图Radar,饼图pie,环图ring

# 开发
## fullpage使用
+	引入文件
+	增加class名字
+	导入 fullpage
+	切换效果
+	切换效果绑定
![](https://i.imgur.com/q2ldLhB.png)

![](https://i.imgur.com/HkND2Ct.png)

![](https://i.imgur.com/8Yu8owS.png)

![](https://i.imgur.com/ul9bKD6.png)

![](https://i.imgur.com/eKxmbd7.png)

## 图文组件（图文设置）
+	基本图文组件
+	接受onLoad，onLeave事件
+	开发方法，独立模块化
### 开发方式
+	自定义组件
+	参数传递方式传递参数
+	通过JQ调用添加dom方式添加组件
+	css样式规划
+	效果添加
+	动态点击

## 内容组织类
+	添加页面
+	添加组件
+	整合fullpage
+	链式调用

## 图表组件
+	散点图
+	柱图
+	折线图
+	雷达图
+	饼图，环图，仪表盘图
+	数据

### 散点图
+ 