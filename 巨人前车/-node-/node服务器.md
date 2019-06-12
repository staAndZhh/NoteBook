# 导学

## nodejs用途

js运行环境

服务器，webserver

本地，打包，构建工具

## 困惑

nodejs服务器端

服务器端与前端差别

## 概述

what: node个人博客系统

detail:api，数据存储，登录，日志，安全

skill:http,stream session mysql redis nginx pm2...

## 知识点介绍

准备：

nodejs

服务端特点

案例分析和设计

原生代码：

api和数据存储

登录和redis

安全和日志

使用框架：

express和koa2

中间件和插件

中间件原理

线上环境：

PM2介绍和配置

PM2多进程模型

服务器运维

## nodejs介绍

### 普通安装

### nvm安装

nodejs版本管理工具，切换nodejs版本

mac os : brew instdall nvm

win: github 搜索:nvm-windows

nvm list

nvm install v10.13.0

nvm use -delete-prefix 10.13.0  切换

nvm -v

## 课程安排

API和数据存储mysql

登录，使用redis存储登录信息

安全，日志记录和日志分析

express和koa2

中间件机制

常用插件

中间件原理

PM2介绍和配置

PM2多进程模型

服务器运维

## 安装

node 安装

nvm安装

mac:brew install nvm

win:github 搜索nvm-windows

win下需要以管理员身份运行 nvm.install

nvm list

nvm install v10.15.0

nvm use --delete-prefix 8.12.0

## nodejs和js区别

### es

语法和此法；js和nodejs都必须遵守

定义变量，循环，判断，函数

原型和原型链，作用于和闭包，异步

### js

实现了es和WebAPI

dom操作，bom操作，事件绑定，ajax等

两者结合，完成浏览器端的任何操作

### nodejs

实现了es语法和nodejsAPI

处理http,处理文件等

两者结合，完成server端的任何操作

### 总结

ECMAScript是语法规范

nodejs = ECMA + nodejs API

### commonjs

模块化的规范

a.js

function add(x,y){}

module.exports = add

module.exports = {add,mul}

b.js

const add = require('./a')

const {add ,mul}= require('./a')

const sum = add(10,20)

### debugger

visual studio

debugger模式

## server和前端开发的区别

服务稳定性（恶意攻击和误操作/PM2做进程守候）

考虑内存和CPU（优化，扩展）（server端CPU和内存都是稀缺资源/stream写日志，redis存session）

日志记录（前端是日志的发起方，server记录存储分析日志）

日志记录（前端会参与写日志，但是只是日志的发起方，不关心后端）

日志记录（server端要记录，存储，分析日志，前端不关心）

安全（server端要随时准备接受各种恶意攻击，前端很少）

安全（越权操作，数据库攻击/登陆验证预防xss攻击和sql注入）

集群和服务拆分（产品发展速度快，流量迅速增加）

集群和服务拆分（扩展服务器和服务拆分） 

### 总结

稳定，内存和CPU，日志，安全，集群和服务拆分

如何在nodejs中解决

# 项目介绍

目标，需求，UI设计，技术方案，开发，联调，测试，上线，查看统计结果

需求一定要明确，需求指导开发

不纠结页面，不影响server端复杂度（功能才影响）

## 目标

外：博客系统，基本功能

内：只开发server端，不关心前端

原生，express，koa2

##需求

首页，作者首页，博客详情页

登陆页

管理中心，新建页，编辑页

## 技术方案

通过需求怎么一步一步完成方案

数据如何存储：

存储内容：博客，用户

id,title,content,createtime,author

id,username,password,realname

如何与前端对接：接口设计

### 接口设计

list?auther&keyword

id

AURD

login

描述，接口，方法，url参数，备注

获取bolg列表，   /api/blog/list,    get,，auther；keyword，参数为空不查询

获取一篇博客内容，/api/blog/detail,  get， id,

新增博客， /api/blog/new, post, ，post有新增内容

更新博客， /api/blog/update, post，id，postData中有新增内容

删除博客， /api/blog/del, post，id，

登录， /api/user/login, post,，postData中有用户名和密码

### 登陆

业界有统一的解决方案，一般不用重新设计

实现起来复杂，日后讲

## 原生接口

nodejs处理http

开发环境

开发接口（暂时不连接数据库，不考虑登陆）

### http

浏览器：dns解析，tcp链接（3次握手） ，发送http请求

dns解析：443对应https的默认端口，80对应http默认端口；域名对应ip地址

​		有缓存使用缓存，无缓存请求DNS服务器

3次握手：第一次握手：客户端找到ip地址后，客户端询问服务器是否可用

​		第二次握手：服务器告诉客户端，自己可用

​		第三次握手：客户端再次告诉服务器，接下来即将访问

server接受http请求，并返回

客户端接收到返回数据，处理数据（渲染页面，执行js）

## nodeJS处理http

npm init -y

index.js改为app.js

{
  "name": "-node-",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}





const http = require('http');

const server = http.createServer((req,res)=>{res.end("hello,world")});

server.listen(8000);

require-createServer-lister

### get请求和参数querysting

const http = require('http');

const querystring = require("querystring");

const server = http.createServer((req,res)=>{

console.log(req,method) //get

const url = req.url  //完整的url

req.query = querystring.parse(url.split("?")[1])   //解析querystring并赋值给req.query

res.end(JSON.stringify(req.query))});  

server.listen(8000);

console.log("ok");



node app.js

访问 ： http://localhost:8000/api?a=1&b=1

### post请求和postdata

客户端向服务端传递数据，新建博客

浏览器无法直接模拟，需要手写js，或者使用postman

const http = require('http');

const querystring = require("querystring");

const server = http.createServer((req,res)=>{

if(req.method === 'POST'){

console.log('content-type',req.headers['content-type'])

let postData=""

req.on('data',chunk=>{

​	postData += chunk.toString()

})

req.on('end',()=>{

​	console.log(postData)

​	res.end("hello world")  // 异步返回

})

}

});

server.listen(8000);

console.log("ok")

### 路由

http://xx/u

http://xx/username

http://xx/username/xxx

###  综合案例

const http = require('http');

const querystring = require("querystring");

const server = http.createServer((req,res)=>{

​	const method = req.method

​	const url = req.url

​	const path = url.split('?')[0]

​	const query = querystring.parse(url.split('?')[1])

​	res.setHeader('Content-type','application/json')

​	

​	const resData = {

​	method,

​	url,

​	path,

​	query

​	}

if(method === "GET"){

​	res.end(JSON.stringify(resData))

}

if(method === "POST"){

​	let postData=""

​	req.on('data',chunk=>{

​	postData += chunk.toString()

})

​	req.on("end",()=>{

​	resData.postData = postData

​	res.end(JSON.stringify(resData))

}）

}



server.listen(8000)

console.log('OK')

})

##  开发环境

从0开始，不使用任何框架

nodemon检测文件变化

cross-env设置环境变量，兼容3大系统

node -v 

npm init  -y

npm install nodemon cross-env --save-dev

package.json的scripts中添加和test同级别的字段:

 "dev": "cross-env NODE_ENV=dev nodemon ./bin/www.js",



{
  "name": "blog",
  "version": "1.0.0",
  "description": "",
  "main": "bin/www.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev": "cross-env NODE_ENV=dev nodemon ./bin/www.js",
    "prd": "cross-env NODE_ENV=production pm2 ./bin/www.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "cross-env": "^5.2.0",
    "nodemon": "^1.18.10"
  }
}



获取配置:

process.env.NODE_ENV



npm run dev

### 初步试用

blog/bin/www.js



const http = require('http')
const PORT = 8000
const serverHandle = require("../app")

const server = http.createServer(serverHandle)
server.listen(PORT)



blog/app.js



const serverHandle = (req, res) =>{
    // 设置返回格式
    resconst resData = {
    name:'zhh100',
    site:'imooc',
    env:process.env.NODE_ENV
}
res.end(
    JSON.stringify(resData)
).setHeader('Content-type','application/json')



}
module.exports = serverHandle



### nodejs路由处理

### 初始化路由

返回假数据：把路由和数据处理分离，符合设计原则

### 项目结构

demo

​	blog

​		bin

​			www.js

​		node_modules

​		src

​			router

​				blog.js

​				user.js

​		app.js

​		package.json

#### www

const http = require('http')
const PORT = 8000
const serverHandle = require("../app")

const server = http.createServer(serverHandle)
server.listen(PORT)

#### app

const handleBlogRouter = require('./src/router/blog')
const handleUserRouter = require('./src/router/user')
const serverHandle = (req, res) =>{
    // 设置返回格式
    // res.setHeader('Content-type','application/json')

// const resData = {
//     name:'zhh100',
//     site:'imooc',
//     env:process.env.NODE_ENV
// }
// res.end(
//     JSON.stringify(resData)
// )

res.setHeader('Content-type','application/json')
const blogData = handleBlogRouter(req,res)
if(blogData){
    res.end(
        JSON.stringify(blogData)
    )
    return
}

const userData = handleBlogRouter(req,res)
if(blogData){
    res,end(
        JSON.stringify(userData)
    )
    return
}

res.writeHeader(404,{'Content-type':'text/plain'})
res.write('404 not Fond')
res.end()

}
module.exports = serverHandle

####  blog

const handleBlogRouter = (req, res) =>{
    const  method = req.method //GET POST
    const url = req.url
    const path = url.split('?')[0]
//    获取博客列表
    if(method === "GET" && path === "/api/blog/list"){
        return {
            msg:'this is get blog'
        }
    }
//    获取博客详情
    if(method === "GET" && path === "/api/blog/detail"){
        return {
            msg:'this is get blog details'
        }
    }

//    新建博客详情
if(method === "POST" && path === "/api/blog/new"){
    return {
        msg:'this is new blog '
    }
}

//    更新博客详情
if(method === "POST" && path === "/api/blog/update"){
    return {
        msg:'this is update blog '
    }
}

//    删除博客详情
if(method === "POST" && path === "/api/blog/del"){
    return {
        msg:'this is del blog '
    }
}

}
module.exports = handleBlogRouter

#### user

const handleUserRouter = (req, res) =>{
    const  method = req.method //GET POST
    const url = req.url
    const path = url.split('?')[0]

//login
if(method === 'POST' && path === '/api/user/login'){
    return {
        msg:'this is login'
    }
}

}
module.exports = handleUserRouter

#### run

npm run dev

### 路由和API

API：

前端和后端，不同子系统之间对话的术语

路由：

api的一部分

后端系统内部的一个模块

# 连接MySQL

安装 mysql

安装 workbench（mysql工具）

## 建库

## 增删改查

## node操作数据库

示例：demo演示，不考虑使用

封装：封装为系统可用的工具

使用：api直接操作，不使用假数据

### base

npm init -y

npm i mysql

const mysql = require('mysql')

const con = mysql.createConnection({

​	host:'localhost',

​	user:'root',

​	password:'xxx',

​	port:'3306',

​	database:'my'

})

con.connect()

const sql= "select * from users;"

con.query(sql,(err,result)=>{

​	if(err){

​	console.error(err)

​	return

​	}

​	console.log(result)

})

con.end()

### 工具链

#### 配置

db.js

const env = process.env.NODE_ENV

let  MYSQL_CONF 

if(env ==="dev"){

​	MYSQL_CONF = {

​	host:'localhost',

​	user:'root',

​	password:'xxx',

​	port:'3306',

​	database:'my'

}

}

if(env ==="production"){

​	MYSQL_CONF = {

​	host:'localhost',

​	user:'root',

​	password:'xxx',

​	port:'3306',

​	database:'my'

}

}

module.exports = {

MYSQL_CONF 

}

#### 中间层

const mysql = require('mysql')

const { MYSQL_CONF  } = require('../conf/db')

const con = mysql.createConnection(MYSQL_CONF)

con.connect()

function exec(sql){

​	const promise = new Promise((reslove,reject)=>{

​		con.query(sql,(err,result)=>{

​			if(err){

​				reject(err)

​				return

​			}

​			      reslove(result)

​		})

​	})

​	return promise

}

module.exports = {

​	exec

}

#### 使用

const getList  = (author,keyword)=>{

​	let sql = "select *  from blogs where 1=1"

​	if (author){

​		sql+=`and author='${author}'`

​	}if(keyword){

​		sql+=`and title='${keyword}'`

​		}

​		sql+='order by createtime desc;'

}

const result = getList(author,keyword)

result.then(listData =>{

​	return new SuccessModel(listData)

})

if(result){

​	result.then(blogData =>{

​		res.end(JSON.stringify(blogData))

​	})

}

# 登录系统

核心：登录校验&登录信息存储

基本注册，无意义；

现在多为：短信，微信登录

## cookie

### 定义

存储在浏览器的一段字符串，max5kb

隔离，跨域不共享

格式如：k1=v1;k2=v2;k3=v3;可以存储结构化数据

每次发送http请求，会把请求域的cookie一起发送给server

server可以修改cookie并返回给浏览器

浏览器中也可以通过js修改cookie(有限制)

### js操作

查看:

浏览器查看cookie的方式：3种

req发送时,res返回时;

application;

控制台：document.cookie

修改：

document.cookie="k2=100;" //不能删除智能添加

### server验证

#### 查看cookie

req.cookie ={}

const cookieStr = req.headers.cookie ||''

cookieStr.split(';').forEach(item=>{

​	if(!item){
		return

​	}

​	const arr = item.split('=')

​	const key = arr[0].trim()

​	const val = arr[1].trim()

​	req.cookie[key] = val

})

#### 修改cookie

res.setHeader('Set-Cookie',`username=${data.username};path=/`)

#### 登录验证

登录-验证-写入cookie-前端验证cookie

res.setHeader('Set-Cookie',`username=${data.username};path=/;httpOnly`)

过期时间

const getCookieExpires =()=>{

​	const d = new Date()

​	d.setTime(d.getTime()+24*60*60*60*1000)

​	return d.toGMTString()

}

res.setHeader('Set-Cookie',`username=${data.username};path=/;httpOnly;expires=${getCookieExpires}`)

## session

cookie存放username很危险

解决：

cookie中存储userid，server端对应username

解决方案：

session,服务器端存储用户信息

### base

cont SESSION_DATA  = 

##redis

内存数据库

存储session

##nginx联调

# 日志系统

## stream



# 安全系统

## sql注入

## xss攻击

# express重构

# KO2重构

# 上线配置





