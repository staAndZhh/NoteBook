#	概念
## cata
+   基础知识
    + vue 全家桶
    +   koa2核心知识
    +   nuxt.js快速入门
+   实战
    +   登录/注册  SMTP 城市，推荐，搜索，地图服务
    +  购物车，订单，组件服用，接口，数据对象模型，思维技巧
+   流程
    + 注册-登录-首页-推荐/搜索-产品列表-产品详情-登录-购物车-订单
##  content
+   vue2基础
#-------cha1 基础-------
## 环境搭建
+   当前环境：vue-cli@3，vue@2.5
+   npm install -g @vue/cli
+   yarn global add @vue/cli
+   yarn add vuex
+   vue -V
+   vue -version
+   vue create vue-learn
+   默认配置 bable eilient
+   cd vue-learn
+   npm run serve
##  模板语法
+   模板，样式，文本
+   变量在props或者在data(){return()}中定义
###  文本
+   <span>Message: {{ msg }}</span>
### 原始Html
+   <p>{{rawHtml}}</p>
+   <p><span v-html="rawHtml"></span></p> 类似富文本编辑器
### 特性
+   <div v-bind:id="dynamicId"></div>
### 表达式
+   {{number+1}}
+   {{ok？'yes':'no'}}
+   {{message.split(").reverse().join(")}}
### 指令
+   <p v-if='seen'>you see me</p>
+   <p v-else='seen'>you see me</p>
+   <p v-else-if='seen'>you see me</p>
+   <h1 v-show="ok">Hello!</h1>
### for循环
+       <li v-for="(value, key) in object">
    {{ key }} : {{ value }}
    </li>
+       <li v-for="site in sites">
      {{ site.name }}
    </li>
+     <ul>
    <li v-for="(value, key, index) in object">
     {{ index }}. {{ key }} : {{ value }}
    </li>
  </ul>
### 修饰符
+   <form v-on:submit.prevent="onSubmit">...</form>
### 缩写
+   <a  v-bind:href="url">...</a>   <a href="url">...</a>
+   <a  v-on:click="doSomething">...</a>   <a @click="doSomething">...</a>
##  计算属性
+   有依赖关系的数据监听
+   data(){ 
    computed:{
    b:function(){ return this.money-this.a}
}}
##  类与样式
+   对象语法：适合较多的class名字或者动态的class
+   数组语法：适合较少的class名字
+   <div :class="[a1,a2]"></div>
+   <div :class="{test-1:a3}"></div>
##  条件&列表渲染
+   <li v-for="(value, key) in object" :key="item'>
##  事件处理
###  事件定义和缩写
+    <a @click="msg('s')">...</a>
+   data:function(){},methods:{msg:function(){window.console.log(Math,.random());}}
###   内联写法：事件传参数和事件对象
+    <a @click="msg('s',$eventd)">...</a>
###  事件修饰符：结合键盘事件提高效率
+   v-on:prevent @click.stop
## 深入了解组件
### props
#### 父传子
+   组件的参数传递
+   组件
+   <div :age="age"></div>
+   export default {
    props:['age']
}
+   父组件
+   data中return age：18
###　slot
+   插槽在组件抽象设计中的应用
+  子组件中 <slot></slot>　
+   <slot name="a"></slot>
+   使用：<h1 slot="a"></h1> 
### 自定义事件
+   父子组件的通信方式
####　子传父
+   子组件
+   ＠click="$emit('patch')
+   父组件
+   ＠patch="msg"
+   methods:{msg:function(){window.console.log(msg)}}
## 路由基础
+   配置路由
+   路由实例化
+   router.vue.js
+   npm inistall vue-router
+   import VueRouter from 'vue-router';
Vue.use(VueRouter）
+   const routes = [{path:'/pagea',component:pagaA}]
+   const router = new VueRouter({router})
+   export default router;
+   更改index的router的渲染组件
+   更改config的配置
+   index中添加router加载的页面　
#------cha2 基础-----------
## vuex基础
+   安装
+   定义
### store.js
+   所有的组件公用一个数据
+   state actions mutations
+   新建store.js文件
+   import Vuex from 'vuex';
+   Vue.use(Vuex)
+   const state = {count:1}
+   const mutations ={
    increment（state){
    state.count++
},
    decrement(state){
    state.count--
}
}
+   const actions = {
    increment:({commit})=>{
    commit('increment')
},
    decrement:({commit})=>{
    commit('increment')
}
}
+   export default new Vuex.Store({state,mutations,actions})
### main
+   new Vue({store}).$mount('#app')
### 组件使用
+   import { mapActions } from 'vuex';
+   export default {
    methods: mapActions([
    'increment',
    'decrement'
])
}
+    {{ $store.state.count }}
## vuex高级用法
+   不同的页面拥有不同的state管理
### 导出
+   export default {
    namespaced:true,
    state,
    mutations,
    actions
}
### 导入
+   Vue.use(Vuex)
+   export default new Vuex.Store({
    modules:{
    money,
    count 
}
})
### 使用
+   import { mapActions } from 'vuex';
+   export default {
    methods: mapActions(
    'money':[
    'increment',
    'decrement'
])
}
+    {{ $store.state.count.count }}  
### 参数传递
#### actions
+   const actions = {
    increment:({commit}，params)=>{
    commit('increment'，params)
},
}
#### mutations
+   const mutations ={
    increment（state，parms){
    state.count+=params
},
}
#------cha3 Koa2基础-----------
## 概念
+   koa-generator
+   async和await
+   koa2中间件
+   koa2路由
+   cookie和session
+   mongoose基础
+   redis基础
## koa-generator
+   npm install -g koa-generator
+   创建：koa2 project
+   koa2 -e koa2-learn
+   cd koa2-learn
+   npm install
+   node bin/www
+   自启动： npm run dev
## koa异步
+   异步
+   async和await
+   await必须嵌套在async中
+   await后面跟着的是promise对象
+   router.get('/testAsync',async (ctx)=>{  
    global.console.log('start',new Date().getTime())
    const a = await new Promise((resolve,reject)=>{
    setTimeout(function(){
    global.console.log('start',new Date().getTime())
    resolve('this is result')
    }
},1000);
    const b= await Promise.resolve(123)
    const c= await 456
})
ctx.body={a,b,c}
}
}）
## koa中间件
### 自定义中间件
+   function pv(ctx){
    global.console.log(ctx.path)
}
+   module.exports = function(){
    return async function(ctx,next){
    pv(ctx)
    await next()
}
}
### 中间件使用
+ app.use(pv())
## koa路由
### 路由写法
+   模块化写法
+   router.get()
+   router.post()
+   router.prefix('/user')
+   router.get('/',function(ctx,next){
    ctx.body = 'this is a user'
})
+   router.get('/string',function(ctx,next){
    await ctx.render('index',{
    title:'hello koa2'
}
})
+   module.exports = router
## cookie和session
### 读取cookie
+   ctx.cookies.set('pvid',Math.random())
+   ctx.cookies.get('pvid')
### 写入cookie
#------cha4 mongoose&Redis基础-----------
## 概念
+   mongodb 安装
+  mongodb可视化工具RoBo 3T安装以及应用
+   mongoose的作用 
+   mongoose的应用
## 安装
+   which mongod
+   启动 mongod
+   RoBo 3T 安装
## mongoose概念
+   模式
+   模型
+   实体
+   npm i mongoose
+   dbs/config.js
+   export default({
    dbs:'mongodb://127.0.0.127017/dbs'
})
+   dbs/models/person.js
+   import mongoose form 'mongoose'
+   let presonSchema = new mongoose.Schema({
    name:String,
    age:Number
})
+   export default mongoose.model('Person',presonSchema)
+   app.ks
+   const mongoose = require('mongoose')
+   const dbConfig = require('./dbs/config')
+   mongoose.connect(dbConfig.dbs,{
    userNewUrlParser:true
})
### 增删改查
#### add
+   routers/users.js
+   const Person = require('../dbs/models/person;)
+   router.post('add/Person',async function(ctx){
       const person= new Person({
        name:ctx.request.body.name,
        age:ctx.request.body.age
})
    let code
    try{
    await person.save()
    code=0
    }
    catch(e){
    code=-1
    } 
    
    ctx.body={
    code 
    }
})
#### find
+   const result = await Person.findOne({name:ctx.request.body.name})
+   const results = await Person.find({name:ctx.request.body.name})
+   ctx.body = {
    code:0,
    result,
    results
}
#### update
+    const results = await Person.find({name:ctx.request.body.name}).update({
    age:ctx.request.body.age
})
+ ctx.body = {
    code:0
}
#### remove
+    const results = await Person.find({name:ctx.request.body.name}).remove({
    age:ctx.request.body.age
})
+ ctx.body = {
    code:0
}
## redis
+   服务器用session保存客户端的登录状态
+   客户端用cookie保存session
## 安装
+   brew install redis
+   redis-server
+   npm i koa-generic-session koa-redis
+   app.js
+   const session = require("koa-generic-session")
+   const Redis = require("koa-redis")
+   app.keys=['keys','keyskeys']
+   app.use(session({
    key:'mt',
    prefix:'mtpr',
    store:new Redis()}))
##＃　中间件使用
+   ctx.session.count++
### 查看
+   redis-cli
+   keys *
+   get xxxxxxxxxxxxxxx
### 直接操作redis存储
+   const Store = new Redis().client
+   router.get('/fix',async function(ctx){
    cnst st = await Store.hset('fix','name',Math.random())
})
### redis
+   存储session
+   直接存储数据
#------cha5 Nuxt.js基础-----------
+   包含vue2，vue Router，Vuex，Vue Server Renderer，vue-meta
## 安装
+   vue init nuxt-community/koa-template nuxt-learn
## 路由&实例
## 页面模板&实例
## 异步数据&示例&SSR剖析
## vue应用&示例   
