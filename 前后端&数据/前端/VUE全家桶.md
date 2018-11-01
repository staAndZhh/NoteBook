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
#-------cha2 基础-------
## 环境搭建
+   当前环境：vue-cli@3，vue@2.5
+   npm install -g @vue/cli
+   yarn global add @vue/cli
+   vue -V
+   vue -version
+   vue create vue-learn
+   默认配置 bable eilient
+   cd vue-learn
+   npm run serve
##  模板语法
+   模板，样式，文本
+   变量在props或者在data(){return()}中
###  文本
+   <span>Message: {{ msg }}</span>
### 原始Html
+   <p>{{rawHtml}}</p>
+   <p><span v-html="rawHtml"></span></p>
### 特性
+   <div v-bind:id="dynamicId"></div>
### 表达式
+   {{number+1}}
+   {{ok？'yes':'no'}}
+   {{message.split(").reverse().join(")}}
##  计算属性
##  类与样式
##  条件&列表渲染
##  事件处理
## 深入了解组件
## 路由基础
## vuex基础
#------cha3 基础-----------