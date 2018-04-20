#	React 基础
## 	目录
##	React组件基础
+	虚拟Dom
+	组件化
+	多组件嵌套
+	JSX内置表达式
+	生命周期
##	属性与事件
+	state
+	props
+	事件和数据双向绑定：父子组件参数传递
+	可复用组件
+	组件的Refs
+	组件之间共享Mixins
##	样式
+	内联样式
+	内联样式表达式
+	css模块化
+	jsx与css互转
+	AntDesign
##	Router
+	Router概念
+	界面跳转

## 开发
+	环境
+	logo
+	样式库
+	数据API
+	页头页脚响应式
+	登录注册
+	首页列表
+	评论收藏
+	个人中心
##	二次开发
+	开发规范
+	API借口

##	环境安装
###	node
+	官网下载
+	npm install xxx
+	npm install react
+	npm -v
+ 	node -v 
### 配置镜像源
+	npm install -g cnpm --registry=https://registry.npm.taobao.org
+	cnpm -v 
+	cnpm install 
+	全局更改默认源
+	nodejs安装目录下 node_modules\npm\.npmrc
+	更改	registry=https://registry.npm.taobao.org 
###	React使用
+	url引用网络资源
+	npm包管理器管理
###	npm项目构建
+	npm init 
+	npm install --save react react-dom babelify babel-preset-react babel-preset-es2015
###	webpack热加载配置
+	 npm install -g webpack
+	 npm install -g webpack-dev-server
+	 npm install webpack --save
+	npm install webpack-dev-server --save
+	webpack.config.js
+	>	
	>		var webpack = require('webpack');
		var path = require('path');
		module.exports = {
		context: __dirname + '/src',
		entry: "./js/index.js",
		module: {
		loaders: [{
		test: /.js?$/,
		exclude: /(node_modules)/,
		loader: 'babel-loader',
		query: {
		presets: ['react', 'es2015']
		}
		}]
		},
		output: {
		path: __dirname + "/src/",
		filename: "bundle.js"
		}
		};
+	打包 
+	webpack
+	监听js的打包	
+	webpack --watch 需要自动刷新浏览器
+	自动刷新
+	webpack-dev-server 
+	网址是localhost:8080/webpack-dev-server 
+	更改网址仅为localhost
+	webpack-dev-server --contentbase src  --inline --hot
### chrom插件
+	react delveloper tools
+	redux
###	Atom插件
+	React相关插件
+	JS ⽀持 atom-ternjs
+ 	格式化 atom-beautify
+	直接打开浏览器 open-in-browser
+	快速 HTML 代码 emmet
+	⽂件图标 file-icons
+	⾼亮当前⾏ highlight-line
+	⾼亮所有选择 highlight-selected
## 组件
###	基础组件
+	编写/导出组件
	+	export default class ComponentHeader extends React.Component{
	render(){
	return(<xx></xx>);
	}}
+	引用组件
	+	import xxx from './components/xx';
+	绑定组件与页面
	+	ReactDOM.render(<xx/>, document.getElementById('example'));
+ 	ReactDom只能返回一个子元素
+	注释/**/ //
### 组件逻辑
+	判断是否登录
	>  render(){
	>  	var component;
	>  	if (登录){
	>  		component = <xx_A/>
	>  	}
	>  	else {
	>  		component = <xx_B/>
	>  	}
	>  	return(
	>  		<div>
	>  		{component}
	>  		<xx_C/>
	>  		<xx_D/>
	>  		</div>
	>  	);
	>  }

###	JSX内置表达式
+	<input type = 'button' value = {username} ><input/>
+	var user.name =''; {window.userName == '' ? '默认⽤户名' : '⽤户名： ' + userName}
### html返回
+	unicode转码
+	<p dangerouslySetInnerHTML = {{__html:xxx}}></p>

### 生命周期
![](https://i.imgur.com/zPnHhVN.png)
###	state属性
+	URL
+	[组件资源](https://github.com/enaqx/awesome-react)
+	组件自身的属性
+	组件自身状态改变时，自动改变
+	初始化
	+ this.state = {username:'parry'};
+	修改
	+	this.setState({username:'mooc'});
+	state作用范围仅在当前类，不污染其他模块
###	props属性
+	外层组件直接书写
	+ <Body userid = {123}>
+	内层组件直接接受
	+ this.props.userid
### 事件和组件的绑定
+	onclick = {this.changeUseInfo.bind(this,50)}
### 子页面向父页面传递参数
+	子页面调用父页面的props
+	父页面绑定方法
+ 	![](https://i.imgur.com/lHygq2A.png)
+	子页面调用方法
+	![](https://i.imgur.com/34q0hLT.png)

### props验证
+	类型限制
	>	const propTypes = { id:PropTypes.number.isRequired, url:PropTypes.string.isRequired, text:PropTypes.string };
+	默认属性
	>	const defaultProps = { text:'Hello World' };
	>	BodyIndex.defaultProps =defaultProps;

+	传递所有属性
	>	<Component {...this.props} more="values" />

### 组件的Refs
+	获取Dom树
+	 原生方法
>	var myDiv=document.getElementById('myDiv');
	ReactDOM.findDOMNode(myDiv).style.color ='green';
+	定义refs属性
>	<input id ='xx' ref = 'xxx'>
>	this.refs.xxx..style.color ='green';

### 组件间共享Mixins
+ 安装 react-mixin

## 组件样式
###	内联样式
+	变量形式
+	定义在render内,return外
+	驼峰原则
>		声明：
>		const styleComponentHeader = {
	header: {
	backgroundColor: '#333333',
	color: '#FFFFFF',
	"padding-top": "15px",
	paddingBottom: "15px"
	}
	};
>		调用：
>		render(){
>		return(
>			<header style = {styleComponentHeader.header}></header>
>		)}
+	内联样式表达式
+	paddingBottom: (this.state.miniHeader) ? "3px" : "15px"

+	![](https://i.imgur.com/HKuAI3p.png)


###	文件引用样式
+	class 需要更改成 className
+	<link ref=xxx>
>		render(){
>		return(
>			<header style = {styleComponentHeader.header} className = 'smallFontSize'></header>
>		)}

###	CSS样式模块化
+ npm install 安装包的依赖
+	npm install css-loader style-loader  babel-plugin-react-html-attrs
+ 配置webpack.config.js
+	样式独立
+	![](https://i.imgur.com/51QzzEN.png)

+	导入： 
>	var footCss = require("../../css/footer.css");
+	使用：
>	<footer class = {footCss.miniFooter}>

### JSX与CSS样式互相转化
+	css to React

## AntDesign样式框架
+ Material-UI
+	Ant Design
+ npm install antd --save
+	配置
>	{test：/\.css$/,loader:'style-loader!css-loader'}

### ReactRouter
+ Router
+	Router嵌套
+	Router参数传递
+	所有东西都是组件，Router,Link,Switch都是普通的组件

### Form表单使用
+	Form => handleSubmit
>	FormItem validateStatus =>{getFieldDecorator('xx',
>	{rules:[{xx}]})}  => help  input
>	M:hasError  handleSubmit
>	Form.create()

###	Tab切换
+ Tabs
+	TabPane => tab

### RadioGroup
+	RadioGroup => Radio|RadioButton
+	RadioGroup  options


