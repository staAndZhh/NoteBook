# base
## express
### base used
+   npm install express --save
+
### used
+   使用
>   var express = require('express');
var app = express();
 
app.get('/', function (req, res) {
   res.send('Hello World');
})
 
var server = app.listen(8081, function () {
 
  var host = server.address().address
  var port = server.address().port
 
  console.log("应用实例，访问地址为 http://%s:%s", host, port)
 
})
+ 自动监听
+   npm install -g nodemon
+   node server.js
+   nodemon server.js
## mongodb
+   brew install mongodb
+   mongo
+   安装node下的mongoose依赖
+   npm install mogoose --save
### 操作
+   mongoose操作mongodb，存储的是json，相对mysql容易很多
+   connect链接数据库
+   定义文档模型，Schema和model新建模型
+   通过find,findOne,create,update,Remove操作数据
## 登录设置     
### 检查登录状态并跳转
+    const redictToLogin = <Redirect to='/login'></Redirect>
+    const app= xxxx
+    return this.props.isAuth?app:redictToLogin
### 如果登录显示主页面，如果不登录，显示提示
+   {this.props.isAuth? <Redirect to='/dashboard'/> :null}
+   <h1> 需要登录</h1>
+   <button onClick={this.props.login}></button>
### 主页根据登录状态，显示是否注销
+   {this.props.isAuth? 注销:登录}
+   const match = this.props.match
+   <Link to= {`${match.url}/params`}>someText</Link>
# Content
## 需求分析
### 页面结构&交互  
+   用户中心,登录，注册，信息完善
+   牛人，求职信息，职位列表
+   boss，管理职位，查看牛人
+   聊天
### 项目骨架
+   src前端源码目录
+   server后端express目录
+   功能文件夹：component,container,reducers
### 页面骨架
+ Router划分
+   进入应用获取用户信息，未登录跳转login页面
+   Login和register不需要权限认证
+   用户信息，聊天信息，职位列表共享底部tabbar
### 其他注意事项
+   Mongodb字段设计
+   axios异步请求
+   redux管理所有数据，组件使用antd-mobile,弱化css
## 前后端问题联调
+  axios发送异步请求
    +   端口不一致，使用proxy配置转发
    +   axios拦截器，统一loading处理
    +   redux使用异步数据，渲染页面
+   npm install axios --save
## 登录注册
+   页面文件结构
+   web开发模式
+   前后端实现
### 页面文件结构
#### 页面骨架结构实现
+   组件放在component文件夹下
+   页面放在container文件夹下
+   页面入口处获取用户信息，决定跳转哪个页面
### web开发模式
#### 基于cookie的用户验证
+   express依赖于cookie-parser，npm install cookie-parser --save
### 开发流程
+   用户加载页面---带cookie向后端获取用户信息---用户加载页面
+   用户已经登录---app内部页面
+   用户未登录页面---登录页面---登录成功，前端存储cookie---app内部页面
###  前后端实现
+   按需记载配置
+   proxy配置
+   @concert装饰器配置
### 登录跳转
+   是否登录
+   现在的url地址 login 不需要跳转
+   用户的type 身份是boss还是牛人
+   用户是否完善信息