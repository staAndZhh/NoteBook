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

## nodejs和jis区别

### es

语法和此法；js和nodejs都必须遵守

定义变量，循环，判断，函数

原型和原型链，作用于和闭包，异步

### js

实现了es和WebAPI

dom操作，bom操作，事件绑定，ajax等

### nodejs

es语法和nodejsAPI

### commonjs

### debugger

## server和前端开发的区别

服务稳定性（恶意攻击和误操作/PM2做进程守候）

考虑内存和CPU（优化，扩展）（server端CPU和内存都是稀缺资源/stream写日志，redis存session）

日志记录（前段是日志的发起方，server记录存储分析日志）

安全（越权操作，数据库攻击/登陆验证预防xss攻击和sql注入）

集群和服务拆分（扩展服务器和服务拆分） 

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

数据如何存储：博客，用户

如何与前端对接：接口设计

### 接口设计

list?auther&keyword

id

AURD

login

## 原生接口

nodejs处理http

开发环境

开发接口（不连接数据库，不考虑登陆）

### http

dns解析，tcp链接（3次握手） ，发送http请求

server接受http请求，并返回

客户端接收到返回数据，处理数据

## 处理http

const http = require('http');

const server = http.createServer((req,res)=>{res.end("hello,world")});

server.listen(8000);

### get请求和参数

const http = require('http');

const querystring = require("querystring");

const server = http.createServer((req,res)=>{

console.log(req,method)

const url = req.url

req.query = querystring.parse(url.split("?")[1])

res.end(JSON.stringify(req.query))});

server.listen(8000);

console.log("ok")

### post和postdata

const http = require('http');

const querystring = require("querystring");

const server = http.createServer((req,res)=>{

if(req.method === 'POST'){

console.log('content-type',req.header['content-type'])

let postData=""

req.on('data',chunk=>{

​	postData += chunk.toString()

})

req.on('end',()=>{

​	console.log(postData)

​	req.end("hello world")

})

}

});

server.listen(8000);

console.log("ok")

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

nodemon检测文件变化

cross-env设计环境变量，兼容3大系统

npm init  -y

package.json: "dev": "cross-env NODE_ENV=dev nodemon ./bin/www.js",

### nodejs路由处理