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
	+	ssh-keygen -t rsa -b 4096 -C "tjzhanghuanhuan@gmail.com"
2.	在码云创建项目
3.	添加个人公钥
	+	管理-公钥管理-添加个人公钥
4.	项目clone到本地
	+	git clone git@gitee.com:staAndZhh/adminReat.git
5.	配置.gitgnore文件
	+	node_modules 
	+	dist 
	+	*.log
6.	本地开发
	1.	从master切换到开发分支
	2.	git merge origin master 拉取远程仓库最新的代码
	3.	git add .
	4.	git commit -am
	5.	git push
	6.	提交pull request 管理员审核
## yarn安装
1.	npm install yarn -g
## node.js安装
1.	node 6.12.3
2.	npm install yarn -g
3.	yarn与npm差别
![](https://i.imgur.com/71lABBS.png)
4.	yarn init
	+	git add.
	+	git commit -m 'yarn init'
	+	git push -u origin master
	+	git merge origin/master
## Ruby安装
1.	官网下载RubyInstall
2.	配置环境变量添加bin到path路径
3.	程序窗口打开startCommandwithRuby
4.	gem install sass
## Sass安装
1.	gem install sass
2.	sass -v  ruby -v
## webpack安装
1.	yarn add webpack@3.10.0 --dev
2.	多版本webpack并存
2.	处理的文件类型
	1.	html html-webpack-plugin
	2.	js	babel+babel-preset-react
	3.	样式(css sass)		css-loader + sass-loader
	4.	图片/字体	url-loader+file-loader
3.	常用插件
	1.	html-webpack-plugin  html单独打包成文件
	2.	extract-text-webpack-plugin 样式打包为单独文件
	3.	CommonsChunkPlugin  提出通用模块

## webpack配置
###	新建webpack.config.js
>		const path = require('path');
	var HtmlWebpackPlugin = require('html-webpack-plugin');
	module.exports = {
	  entry: './src/app.js',
	  output: {
	    path: path.resolve(__dirname, 'dist'),
	    filename: 'app.js'
	  }


###	HtmlWebpackPlugin
+	npm install --save-dev html-webpack-plugin
+	初始配置
+	>		var HtmlWebpackPlugin = require('html-webpack->			plugin');
		var path = require('path');
		var webpackConfig = {
			  entry: 'index.js',
			  output: {
			    path: path.resolve(__dirname, './dist'),
			    filename: 'index_bundle.js'
			  },
			  plugins: [new HtmlWebpackPlugin()]
			};

+	自定义模板配置
+	[https://github.com/jantimon/html-webpack-plugin#configuration](https://github.com/jantimon/html-webpack-plugin#configuration)
+	>		var HtmlWebpackPlugin = require('html-webpack->			plugin');
		var path = require('path');
		var webpackConfig = {
			  entry: 'index.js',
			  output: {
			    path: path.resolve(__dirname, './dist'),
			    filename: 'index_bundle.js'
			  },
			  plugins: [new HtmlWebpackPlugin(
				{
				template:'./src/index.html'
				}
			)]
			};
	+	src中新建index模板
+	>		<!DOCTYPE html>
		>	<html>
		<head>
		  <meta charset="UTF-8">
		  <meta name ='viewPort' content="
		  width = device-width,initial-scale = 1">
		  <meta name='author' content='Zhh'>
		  <title>happy mall admin</title>
		</head>
		<body>
		  <div id ='app'></idv>
		</body>
		</html>

###	babel-loader
+	npm install babel-loader babel-core babel-preset-env webpack
+ 	yarn add babel-core babel-preset-env babel-loader

+	>		module: {
			  rules: [
		    {
	      test: /\.js$/,
	      exclude: /(node_modules|bower_components)/,
	      use: {
	        loader: 'babel-loader',
	        options: {
	          presets: ['env'],
	          plugins: [require('@babel/plugin-transform-object-rest-spread')]
		        }
		      }
		    }
		  ]
		}

+	更改src下的app.js
>		let a = 123;
		let test =(value)=>{
		  return value*2
		};
		test(a);
+	webpack
+	查看dist下的app.js是否打包js代码

###	babel的react
+	yarn add babel-preset-react
+	添加对react的支持
+	presets: ['env','react']
+	>	 	 module: {
			  rules: [
		    {
	      test: /\.js$/,
	      exclude: /(node_modules)/,
	      use: {
	        loader: 'babel-loader',
	        options: {
	          presets: ['env','react'],
	          // plugins: [require('@babel/plugin-transform-object-rest-spread')]
		        }
		      }
		    }
		  ]
		}
+	yarn add react react-dom
+	更改src中的app.js为app.jsx
+	更改webpack ：entry: './src/app.jsx'
+	更改webpack ： test: /\.jsx$/
+	>	 	 module: {
			  rules: [
		    {
	      test: /\.jsx$/,
	      exclude: /(node_modules)/,
	      use: {
	        loader: 'babel-loader',
	        options: {
	          presets: ['env','react'],
	          // plugins: [require('@babel/plugin-transform-object-rest-spread')]
		        }
		      }
		    }
		  ]
+	添加内容到app.jsx
+	>	import React from 'react';
		import ReactDom from 'react-dom';
		ReactDom.render(
		  <h1>hello </h1>,
		  document.getElementById('app')
		);

+ webpack
### CSS loader
+ yarn add css-loader style-loader
+	>		module.exports = {
		  module: {
		    rules: [
		      {
		        test: /\.css$/,
		        use: [ 'style-loader', 'css-loader' ]
		      }
		    ]
		  }
		}
+	新建src中的index.css
+	>		#app{
		  color:red;
		}


+	更该app.jsx引入css文件
+	>		import React from 'react';
			import ReactDom from 'react-dom';
			import './index.css';
			ReactDom.render(
			  <h1>hello </h1>,
			  document.getElementById('app')
			);

+	webpack
### css提取为单独的插件
+	[https://doc.webpack-china.org/plugins/extract-text-webpack-plugin/#src/components/Sidebar/Sidebar.jsx](https://doc.webpack-china.org/plugins/extract-text-webpack-plugin/#src/components/Sidebar/Sidebar.jsx)
+ yarn add extract-text-webpack-plugin@3.0.2 --dev
+	>		const ExtractTextPlugin = require("extract-		text-webpack-plugin");
			module.exports = {
			  module: {
			    rules: [
			      {
			        test: /\.css$/,
			        use: ExtractTextPlugin.extract({
			          fallback: "style-loader",
			          use: "css-loader"
			        })
			      }
			    ]
			  },
			  plugins: [
			    new ExtractTextPlugin("index.css"),
			  ]
			}

+	更改rules下的use
+	webpack
+	查看app.js生成了index.css
### sass
+	npm install sass-loader node-sass webpack --save-dev
+	>		const ExtractTextPlugin = require("extract-text-webpack-plugin");
		const extractSass = new ExtractTextPlugin({
		    filename: "[name].[contenthash].css",
		    disable: process.env.NODE_ENV === "development"
		});
		module.exports = {
		    ...
		    module: {
		        rules: [{
		            test: /\.scss$/,
		            use: extractSass.extract({
		                use: [{
		                    loader: "css-loader"
		                }, {
		                    loader: "sass-loader"
		                }],
		                // 在开发环境使用 style-loader
		                fallback: "style-loader"
		            })
		        }]
		    },
		    plugins: [
		        extractSass
		    ]
		};

+	src新建index.scss
+	>		body{
		  background: #ccc;
		  #app{
		    font-size: 100px;
		  }
		}
+ src下的app.jsx配置
+	>		import React from 'react';
		import ReactDom from 'react-dom';
		import './index.css';
		import './index.scss';
		ReactDom.render(
		  <h1>hello </h1>,
		  document.getElementById('app')
		);
+	webpack

### 图片处理file-loader
+	npm install --save-dev file-loader
+	>		module.exports = {
		  module: {
		    rules: [
		      {
		        test: /\.(png|jpg|gif)$/,
		        use: [
		          {
		            loader: 'file-loader',
		            options: {}
		          }
		        ]
		      }
		    ]
		  }
		}

### 图片处理 url-loader
+	npm install --save-dev url-loader
+	>		module.exports = {
		  module: {
		    rules: [
		      {
		        test: /\.(png|jpg|gif)$/,
		        use: [
		          {
		            loader: 'url-loader',
		            options: {
		              limit: 8192
		            }
		          }
		        ]
		      }
		    ]
		  }
		}
+ body添加背景图
+	>		body{
		  background: url(./1.jpg);
		  #app{
		    font-size: 100px;
		  }
		}
###	字体库
+	yarn add font-awesome
+	配置字体加载
+	>	 	const path = require('path');
		  module.exports = {
		    entry: './src/index.js',
		    output: {
		      filename: 'bundle.js',
		      path: path.resolve(__dirname, 'dist')
		    },
		    module: {
		      rules: [
		        {
		          test: /\.css$/,
		          use: [
		            'style-loader',
		            'css-loader'
		          ]
		        },
		        {
		          test: /\.(png|svg|jpg|gif)$/,
		          use: [
		            'file-loader'
		          ]
		        },
		       {
		         test: /\.(woff|woff2|eot|ttf|otf)$/,
		         use: [
		           'file-loader'
		         ]
		       }
		      ]
		    }
		  };

+	>	 	use: [
		            'file-loader'
		          ]
		        },
		       {
		         test: /\.(woff|woff2|eot|ttf|otf)$/,
		         use: [
		           {
					loader:'url-loader',
					options:{
						limit:8192
					}
					}
		         ]
		       }
		      ]
+	src的app.jsx添加数据
+	>		import React from 'react';
		import ReactDom from 'react-dom';
		import './index.css';
		import './index.scss';
		import 'font-awesome/css/font-awesome.min.css';
		ReactDom.render(
		  <div>
		    <i className = "fa fa-address-book"></i>
		      <h1>hello </h1>,
		  </div>
		  document.getElementById('app')
		);	

###	公共组件
+	plugins添加新插件
+	>		 plugins: [
	        new webpack.optimize.CommonsChunkPlugin({
	            name : 'common',
	            filename: 'js/base.js'
	        }),
	        new HtmlWebpackPlugin({
	            template    : './src/index.html',
	            filename    : 'index.html',
	            favicon     : './favicon.ico'
	        }),
	        new ExtractTextPlugin("css/[name].css"),
	    	]
		};

### 其他配置dist路径
+	更改出口文件名称
+	更改路径出口
		
### webpack-dev-server
1.	2.9.7版本
2.	自动刷新路径转发
3.	yarn add webpack-dev-server@2.9.7 --dev
4.	更改代码自动刷新，路径转发
5.	多版本共存
+	node_module/bin/webpack-dev-server
+	npm install --save-dev webpack-dev-server
+	>	+   devServer: {
     contentBase: './dist'
   }

### package.json添加脚本
+	![](https://i.imgur.com/a8QwITO.png)
+	yarn run dist
+	>		{
		  "name": "admin-v2",
		  "version": "1.0.0",
		  "main": "index.js",
		  "repository": "git@gitee.com:happymmall/admin-v2.git",
		  "author": "Rosen <gaorunsheng1@126.com>",
		  "license": "MIT",
		  "private": null,
		  "scripts": {
		    "dev": "WEBPACK_ENV=dev node_modules/.bin/webpack-dev-server",
		    "dev_win": "set WEBPACK_ENV=dev&& node_modules/.bin/webpack-dev-server",
		    "dist": "WEBPACK_ENV=online node_modules/.bin/webpack -p",
		    "dist_win": "set WEBPACK_ENV=online&& node_modules/.bin/webpack -p"
		  },
		  "dependencies": {
		    "bootstrap": "^3.3.7",
		    "font-awesome": "^4.7.0",
		    "prop-types": "^15.6.0",
		    "rc-pagination": "^1.14.0",
		    "react": "^16.2.0",
		    "react-dom": "^16.2.0",
		    "react-router-dom": "^4.2.2",
		    "simditor": "^2.3.6"
		  },
		  "devDependencies": {
		    "babel-core": "^6.26.0",
		    "babel-loader": "^7.1.2",
		    "babel-preset-env": "^1.6.1",
		    "babel-preset-react": "^6.24.1",
		    "css-loader": "^0.28.8",
		    "extract-text-webpack-plugin": "^3.0.2",
		    "file-loader": "^1.1.6",
		    "html-webpack-plugin": "^2.30.1",
		    "node-sass": "^4.7.2",
		    "sass-loader": "^6.0.6",
		    "style-loader": "^0.19.1",
		    "url-loader": "^0.6.2",
		    "webpack": "^3.10.0",
		    "webpack-dev-server": "2.9.7"
		  }
		}


### 代码提交
![](https://i.imgur.com/7eKg2Cj.png)
### 最终版webpak.config.js
![](https://i.imgur.com/DNbYzhv.png)
![](https://i.imgur.com/uiber6s.png)
![](https://i.imgur.com/1PdjthJ.png)
![](https://i.imgur.com/gK0md0Y.png)
![](https://i.imgur.com/ZGFHegP.png)
### 最终版webpak.config.js
>		use strict';
	const HtmlWebpackPlugin = require('html-webpack-plugin'); //installed via npm
	const webpack           = require('webpack'); //to access built-in plugins
	const ExtractTextPlugin = require('extract-text-webpack-plugin');
	const path              = require('path');
	// 环境变量, dev, (test), online
	var WEBPACK_ENV         = process.env.WEBPACK_ENV || 'dev';
	const config = {
	    entry: './src/app.jsx',
	    output: { 
	        path: path.join(__dirname, 'dist'),
	        publicPath: WEBPACK_ENV === 'online' ? '//s.happymmall.com/admin-fe-v2/dist/' : '/dist/',
	        // publicPath  : '/dist/',
	        filename: 'js/app.js'
	    },
	    externals : {
	        'jquery' : 'window.jQuery'
	    },
	    module: {
	        rules: [{
	            test: /\.css$/,
	            loader: ExtractTextPlugin.extract({
	                use: 'css-loader',
	                fallback: 'style-loader'
	            })
	        }, 
	        {
	            test: /\.scss$/,
	            loader: ExtractTextPlugin.extract({
	                use: 'css-loader!sass-loader',
	                fallback: 'style-loader'
	            })
	        }, 
	        {
	            test: /\.(gif|jpg|png|woff|svg|eot|ttf)\??.*$/,
	            use: [{
	                loader: 'url-loader',
	                options: {
	                    name: 'resource/[name].[ext]',
	                    limit: 2000
	                }
	            }]
	        }, 
	        {
	            test: /\.jsx$/,
	            use: {
	                loader: 'babel-loader',
	                options:{
	                    presets : ['env', 'react']
	                }
	            }
	        }]
	    },
	    resolve: {
	        alias: {
	            node_modules    : path.join(__dirname, '/node_modules'),
	            util            : path.join(__dirname, '/src/util'),
	            component       : path.join(__dirname, '/src/component'),
	            service         : path.join(__dirname, '/src/service'),
	            page            : path.join(__dirname, '/src/page')
	        }
	    },
	    devServer: {
	        port : '8086', //设置端口号
	        // 路径的配置
	        historyApiFallback: {
	            index: '/dist/index.html'
	        },
	        proxy: {
	            '/manage': {
	                target: 'http://test.happymmall.com/',
	                changeOrigin: true
	            },
	            '/user/logout.do': {
	                target: 'http://test.happymmall.com/',
	                changeOrigin: true
	            }
	        }
	    },
	    plugins: [
	        new webpack.optimize.CommonsChunkPlugin({
	            name : 'common',
	            filename: 'js/base.js'
	        }),
	        new HtmlWebpackPlugin({
	            template    : './src/index.html',
	            filename    : 'index.html',
	            favicon     : './favicon.ico'
	        }),
	        new ExtractTextPlugin("css/[name].css"),
	    ]
	};
	module.exports = config;

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
	1.	3要素：历史		跳转		事件
	2.	页面Router	页面改变，页面跳转时都重新加载
	3.	HashRouter	页面跳转只是页面的hash值发生改变，页面不重新加载；只是页面的hash值状态发生改变
	4.	H5Router	类似HashRouter 也可hash刷新页面,也可跳转新页面
	5.	V4.2.2
	6.	动态路由，纯react组件
		7.	<BrowserRouter> ：H5类型整个类型：转到后端请求,<HashRouter> ，路由方式
		8.	<Route>路由规则
		9.	<Switch>路由选项：解决多次匹配问题（Route匹配问题）
		10.	<Link> <NavLink> 跳转导航（NavLink多了选中状态处理）
		11.	<Redirect>自动跳转，匹配某些路径时自动跳转
	7.	yarn add react-router-dom@4.2.2
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

--------------
#	通用模块
