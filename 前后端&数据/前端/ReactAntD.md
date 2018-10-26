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
+	html/js/css3
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
+   create-react-app my-app
+   cd my-app/
+   npm start
+   yarn/npm eject 
+	yarn add react-router-dom axios less-loader less
+	yarn eject
+	更改wenpack.config.dev.js:复制 test的css,更改为less文件;在最后添加loader：添加less-loader；
+	重新启动项目
+   复制配置的文件搭配config.prod
+	yarn add babel-plugin-import antd babel-loader
+ babel-plugin-import 按需加载
+ 在配置文件里添加antd的全局导入
+  ![](https://i.imgur.com/E8XYEnc.png)
+ 在test的babel loader下面添加：（js，jsx，mjs）下的options下的plugins中添加import：libraryName：xx，style：xx
+ 修改主题颜色
+ ![](https://i.imgur.com/evYuefl.png)
+  修改配置中的变量
### Antd使用
+	import {Button} from 'antd';
+	import 'antd/dist/antd.css';
## 主页结构开发
+	主页结构定义
	+	页面结构定义
	+	目录结构定义
	+	栅格系统使用
	+	calc计算方法使用
### 页面结构
+ 左右两边，右边分为上中下
+   新建管理类js：src/admin.js
+	新建components文件夹:src/components
+	在components文件夹中新建Footer,Header，NavLeft文件夹,文件夹下新建index.jsx,index.css
	+ src/components/Footer,Header，
	+ src/components/Footer,Header，NavigatorLeft/index.js，index.css
+ 文件内容
+	导入react组件
+	导出对象类：组件继承并render
	+	import React from 'react';
	+	export default class Admin extends React.Component{
		render(){	return (<div></div>);
				}
	}
### 栅格系统
+	栅格系统
	+	import { Row } from 'antd';  
	+	<Row><Col span=xx></Col></Row>
+  ![](https://i.imgur.com/mmeSXZH.png)

+ 新建全局样式表：src/style/common.less
+ import './style/common.less';
+	新建style文件夹：新建common.less
	+	@colorA:'red'
	+	div{color:@colorA}
+  ![](https://i.imgur.com/m0wTWal.png)
##	菜单组件开发
+	Nav菜单资源文件
+	src/config/menuConfig.js
	+	export default [];
+	使用：import MenuConfig from './../../config/menuConfig'

#---------------------------
##	2 主页架构
### base 插件,less文件配置
####    content
+   必须插件
    +   react-router ,axios
    +   antd
    +   暴露webpack配置
    +   安装less-loader
    +   修改lessloader
#### install 1
+   yarn add react-router-dom axios less-loader less
+   yarn eject
+   修改配置:webpack-config-dev
+   复制css,改为less,并添加loader
>             {
            test: /\.less$/,
            use: [
              require.resolve('style-loader'),
              require.resolve('css-loader'),
              {
                loader: require.resolve('postcss-loader'),
                options: {
                  ident: 'postcss', // https://webpack.js.org/guides/migrating/#complex-options              
                  plugins: () => [
                    require('postcss-flexbugs-fixes'),
                  ],
                },
              },
              {
                loader: require.resolve('less-loader'),
                options: {
                  modifyVars: {
                    "@primary-color": "#616161"
                  },
                  javascriptEnabled: true
                },
              },
            ],
          },
          
+ **如果出现错误Remove untracked files, stash or commit any changes, and try again.**
    + git commit一下
+   ** 找不到less文件**
    +   降级less 到2.0版本
    +   yarn add less@^2.7.3   
#### install 2
+   yarn add antd
+   yarn add babel-plugin-import 按需加载css文件
+   配置文件中导入antd的style的样式
+   babel-loader 的 plugins 下面添加
>                   ['import', {
                  libraryName: 'antd',
                  style: 'css'
                }],
### 主页结构开发
+   页面结构
+   目录结构
+   栅格系统
+   calc计算方法
### 菜单组件
### 头部组件
### 底部组件
#-------------------------
#	3 Router
#-------------------------
##	4-6 UI组件
+   button
+   modal
+   loading
+   notice
+   message
+   tab
+   gallery
+   carousel
+   登录表单
+   注册表单
+   基础表格
## easy mock官网
+   
#-------------------------
##	7-8 单车基本功能
#-------------------------
##	9 项目工程化
#-------------------------
##	10-13	核心模块
#-------------------------
##	14 Redux
