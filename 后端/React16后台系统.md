# ES6
+	提高JS编写大型复杂应用的能力
+	Babel ES6->ES5的转换器

#	语法
+	let	变量 const 常量
+	箭头函数 参数=>函数/表达式
+	模板字符串 反引号·· ${}
+	Promise对象 
>			new Promise((resolve,reject)=>{
		$ajax({
		url：
		type:'post,
		seccess(res){
			resolve(res);},
		error(res){
			reject(err);}
		});
		}).then(
			(res)=>{
				console.log(res)},
			(err)=>{
				console.log(res)}
		);
+	类
+	模块化
+	localStorage和sessionStorage

# 框架对比
+	Angular 基于html的框架大而全		组织方式MVC	数据双向绑定	模板强大	自由度较小	路由静态路由 背景Goole 文档英文	上手难度较高		App方案Ionic
+	React 	基于js的视图层框架	模块化	单向绑定	模板自由	自由度最大	路由动态路由	Faceback	英文		较高		RN
+		Vue	基于html的视图层框架	模块化	双向绑定	模板简洁	自由度较大	动态路由	阿里		多语言	一般		Weex
##	框架选择
+	Angular	后端开发人员构建CURD类型应用	
+	React	前端开发人员构建复杂Web应用
+	Vue.js	前端开发人员快速构建Web应用
--------------

#	开发环境
1.	git	webpack	nodejs npm/yarn node-sass  node-sass/Sass/Ruby
2.	webpack安装配置	
	1.	系统多个版本webpack工程
	2.	webpack各种类型文件处理
	3.	webpack-dev-server安装配置

## git仓库
1.	本地生生ssh公钥 
2.	在码云创建项目
3.	添加个人公钥
4.	项目clon到本地
5.	配置.gitgnore文件
6.	本地开发
	1.	从master切换到开发分支
	2.	git merge origin master 拉取远程仓库最新的代码
	3.	git add .
	4.	git commit -am
	5.	git push
	6.	提交pull request 管理员审核

## node.js安装
1.	node 6.12.3
2.	npm install yarn -g
3.	yarn与npm差别
![](https://i.imgur.com/71lABBS.png)

## Ruby安装

## Sass安装
1.	gem install sass
2.	sass -v  ruby -v
## webpack安装
1.	yarn add webpack@3.10.0 --dev
2.	处理的文件类型
	1.	html html-webpack-plugin
	2.	js	babel+babel-preset-react
	3.	样式(css sass)		css-loader + sass-loader
	4.	图片/字体	url-loader+file-loader
3.	常用插件
	1.	html-webpack-plugin
	2.	extract-text-webpack-plugin
	3.	CommonsChunkPlugin
# webpack-dev-server
1.	2.9.7版本
2.	自动刷新路径转发
3.	yarn add webpack-dev-server@2.9.7 --dev

------------
#	React
1.	视图层框架
	1.	构建用户界面的框架
	2.	声明式的框架
	3.	数据驱动DOM，用事件反馈给数据
2.	组件化
	1.	组件组合而不是集成
	2.	state & props
	3.	生命周期
3.	JSX表达式
	1.	JSX扩展表达式
	2.	带逻辑的标记语法，不同于html模板
	3.	对样式逻辑表达式和事件的支持
4.	虚拟DOM
	1.	虚拟DOM
	2.	比较操作前后的数据差异
	3.	如果有数据差异，同意操作DOM

5.	优缺点
	1.	简洁	灵活	高效
	2.	思维转换	依赖生态	变动频繁

6.	JSX语法
	1.	基本语法
	2.	ReactDOM
	3.	样式处理
	4.	数据逻辑处理

7.	React组件
	1.	组件基本结构
	2.	state& props
	3.	事件处理
	4.	组件组合方式
	5.	组件间数据通信
8.	声明周期
	1.	Mounting
	2.	Updating
	3.	Unmounting
	4.	Error Hangding
9.	Router
	1.	历史		跳转		事件
	2.	页面Router	页面改变
	3.	HashRouter	状态改变，页面不改变
	4.	H5Router
	5.	V4.2.2
	6.	动态路由，纯react组件
		7.	<BrowserRouter> ：H5类型整个类型：转到后端请求,<HashRouter> ，路由方式
		8.	<Route>路由规则
		9.	<Switch>路由选项：解决多次匹配问题
		10.	<Link> <NavLink> 跳转导航
		11.	<Redirect>自动跳转
10.	React数据管理
	1.	状态提升
		1.	组件扁平，兄弟组件通信很少
	2.	发布订阅模式
		1.	业务规模小，层级较深
	3.	Redux等单向数据流
		1.	业务复杂，组件较深，兄弟组件通信密切
--------------
#	接口文档
+	接口名称
+	接口地址
+	请求信息
+	响应状态(响应状态码，响应数据）
#	系统功能
+	商品管理
+	订单管理
+	品类管理
+	管理员登陆
#	通用模块
1.	项目布局
2.	头部导航
3.	侧边导航
4.	功能区通用标题