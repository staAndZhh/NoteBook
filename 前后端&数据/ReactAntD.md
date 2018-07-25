# 导学
## 知识点
+ React&AntD开发后台系统
+	React全家桶
	+	base
	+	Router 4.0
	+	Redux
+	AntDUI组件
	+	基础组件
	+	AntD栅格系统
	+	ETable组件封装
	+	BaseForm封装
	+	表格内嵌，单选，复选封装
+	公共机制封装
	+	Axios请求插件封装
	+	API封装
	+	错误拦截
	+	权限，菜单封装
	+	日期，金额，手机号封装
	+	Loading，分页，Mock
## 特色
+	技术栈
+	架构
+	UI组件
+	共享单车项目
##	架构
+	核心框架库：React16，Router4.0,Redux
+	中间件：Axios,Map,Echarts,Antd
+	公共机制：菜单，权限，header,footer,Etable,EForm,Loading,API,Axios
+	json:Mock-Server
## 内容
+	1 ReactBase
+	2 主页架构
+	3 Router
+	4-6 UI组件
+	7-8 单车基本功能
+	9 项目工程化
+	10-13	核心模块
+	14 Redux
## 前置知识
+	html/js/css
+	React
+	ES6
## 收获
+	React
+	地图和React集成
+	前端图表开发
+	Antd
+	前端后台架构设计，公共机制封装，后台管理系统开发

#	ReactBase
## base
+	React:JS库
+	结合生态库构成一个MV*框架
+	React特点
	+	声明式编码
	+	组件化编码
	+	高效DOM Diff算法，最小化页面重绘
	+	单向数据流
+	MV*框架：只关注视图View层+ 数据层Model

## 生态
+	Vue:Vue+Vue-Router+Vuex+Axios+Babel+Webpack
+	React:React+React-Router+Redux+Axios+Babel+Webpack
+	编程式实现
	+	以具体的代码表在哪里，做什么，如何实现；where,what,how
+	声明式实现
	+	只需要声明在哪里做什么，不需要关心如何实现：where,what
##	脚手架
+	如何安装
+	如何初始化
+	什么是yarn
	+	新一代包管理工具
	+	速度快
	+	安装版本统一，更安全
	+	更简洁的输出
	+	更好的语义化
+	怎么使用yarn
	+	yarn init
	+	yarn add
	+	yarn remove
	+	yarn/yarn install
+	npm isntall -g create-react-app
+	create-react-app my-app 
+	create-react-app my-app --version
+	cd my-app
+	npm start
## 生命周期
+	getDefaultProps
+	getIniticalState
+	componentWillMout
+	render
+	componentDidMout
+	componentWillReceiveProps
+	shouldComponentUpdate
+	componentWillUpdate
+	compoentDidUpdate
+	compontentWillUnmount
# 主页架构设计
## 主页工程搭建
+	基础插件安装，Less文件加载配置
+	项目主页结构开发
+	菜单组件开发
+	头部组件开发
+	底部组件开发
## 基础插件安装
+	React-Router,Axios
+	AntD
+	暴露Webpack配置
+	安装并修改less-loader
+	yarn add react-router-dom axios less-loader
+	yarn eject
+	复制 test的css,更改为less文件
+	yarn add babel-plugin-import

## Antd使用
+	import {Button} from 'antd';
+	import 'antd/dist/antd.css';
## 主页结构开发
+	主页结构定义
	+	页面结构定义
	+	目录结构定义
	+	栅格系统使用
	+	calc计算方法使用
+	新建components文件夹
+	在components文件夹中新建Footer,Header，NavLeft文件夹：index.jsx,index.css
	+	import React from 'react';
	+	export default class Admin extends React.Component{
		render(){	return (<div></div>);
				}
	}
+	新建style文件夹：新建common.less
	+	@colorA:'red'
	+	div{color:@colorA}
+	栅格系统
	+	<Row><Col span=xx></Col></Row>
##	菜单组件开发
+	Nav菜单资源文件
+	src/config/menuConfig.js
	+	export default [];
+	使用：import MenuConfig from './../../config/menuConfig'
+	
