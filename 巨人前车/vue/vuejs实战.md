# base

## 数据绑定

### 实例&数据绑定

实例1： var app = new Vue({

el：docuument.getElementById("app")

})

访问： app.$el

实例2： var app = new Vue({

el："#app",

data: {a:2}

})

#### 生命周期

created

mounted

beforeDestroy

使用：var app = new Vue({

el："#app",

data: {a:2}，

created: function(){

​	console.log(this.a);

},

mounted: function(){

​	console.log(this.$el);

},

})

####插值&表达式

$<div id=”app ”>{ { date }}<div>$

使用：

<script>

var app = new Vue({

el："#app",

data: {a:2}，

created: function(){

​	var _this = this;

​	this.timer= setinterval(function() {
this.date= new Date(); ／／修改数据date
}  1000);

},

beforeDestroy: function(){

​	if(this.timer){

​	clearInterval(this.timer)

}

},

})

</script>

v-html ="link"

v-pre



#### 过滤器

${{data | formatDate}}$

${{data | formatDate('arg1','arg2')}}$

var app = new Vue({

el:,

data:,

filter:{

formatDate:function(value){}

}

})

### 指令&事件

v-if="show"
var app = new Vue({

el:'#app',

data:{

show:true

}

})

v-bind:href="url"

v-bind:src="imgUrl"

...

data：{

url:"http://www.github.com",

imgUrl:"http://xx/img.png"

}

...

v-if="show"

v-on:click="handleClose"

...

data:{

show:true

},

mehtods:{

handleClose:funciton(){

this.show = false;

}

}

v-on:click="show = false"

### 语法糖

v-bind:href	:href

v-bind:src	:src

v-on:click="handleClose"	@click="handleClose"	

## 计算属性

### 用法

{{reversedText}}

...

el:"#app",

data:{

text:"123456"

},

computed:{

​	reversedText:function(){

​		return this.text.split(',').reverse().join(",")

​	}

}

...

计算属性方法：getter,setter

...

get:function(){},

set:function(){}

...

### 缓存

计算属性基于它的依赖缓存的

...

el:,

data:{},

methods:{

reversedText:funciton(){}

}

...



## v-bind&class&style绑定

### 指令

### 绑定方式

#### 对象语法

：class="{'active'：isActive}"

...

data:{

isActive:true

}

...

class="static"：class="{'active'：isActive,'error':isError}"

:class="classes"

...

data:{

​	isActive:true,

​	error:null

}

 computed:{

classes:function(){

​	return {

​	active:this.isActive &&  !this.error,

​	'text-fail': this.error && this . error . type === 'fail'

}

}

}

...

#### 数组语法

:class="[activeCls,errorCls]"

...

data:{

activeCls:'active',

errorCls:'error'

}

...

:class="[isActive ？activeCls:"", errorCls]"

:class="[{'active':isActive},errorCls]"

...

data:{

isActive:true,

activeCls:'active',

errorCls:'error'

}

...

:class="classes"

...

data:{

​	size:"large",

​	disabled:true

},

computed:{

​	return [

​		'btn',

​		{

​		['btn-'+this.size:this.size！==""],

​		['btn-disabled']:this.disabled

​		}

]

}

...

#### 组件使用

Vue.component('my-component',{

template: $<p class="article"></p>$

})

$ <my-component :class="{'active':isActive}"></my-component> $

### 绑定内联样式

$<div :style＝"{'color': color, 'fontSize': fontSize ＋'px '}">文本 </div>$

:style="styles"

...

data:{

​	styles:{

color:'red',

fontsize:15+'px'

}

}

...

:style="[styleA, styleB]"

## 内置指令

### 基本

#### v-clock

#### v-once

$<span v-once></span>$

### 条件渲染
#### if & else-if & else

v-if="status===1"

v-else-if="status===2"

v-else

#### show

v-show="status===1"

#### 区别
### 列表渲染

$<li v-for="book in books">{{book.name}}</li>$

$<li v-for="(book,index) in books">{{book.name}}</li>$

$<li v-for="value  in books">{{value}}</li>$

$<li v-for="(value, key, index) in books">{{value}}</li>$

$<li v-for="n in 10">{{n}}</li>$

#### 用法

#### 数组更新

push()

pop()

shift()

unshift()

splice()

sort()

reverse()

Vue.set(app.books,3,{})

 不改变原始数据

filter()

concat()

slice()

#### 过滤&排序

v-for="books in filterBooks"

...

data:{

books:[]

},

computed：{

filterBooks:funciton(){

​	return this.books.filter(function(book){

​	return book.name.match(/JavaScript/);

}),

sortedBooks:function(){

​	return this.books.sort(function(a,b){

​	return a.name.length < b.name.length;

})

}

}

...

### 方法&事件

@click="counter++"

@click="handleAdd()"

...

methods:{

handleAdd:function(count){

count = count ||1;

this.counter +=count;

}

}

...

@click ="handleClick("xx",$event)"

@click.stop

@click.prevent

@click.once

@keyup.13

#### 基本
#### 修饰符
## 表单
### 用法

v-model="message"

...

data:{

message:''

}

...

@inupt="handleInput"

...

methods:{

handleInput:function(e){

this.message = e.target.value;

}

}

...

### 绑定
### 修饰符

v-model.lazy="message"

v-model.number="message"

v-model.tirm ="message"

## 组件

### 组件注册

Vue.component("my-component",{

template:"$<div>this  is compontent</div>$"

})



var Child = {template:"$<div>this  is compontent</div>$"}

var app = new Vue({

el:'#app',

components:{

"my-component":Child

}

})

$$

Vue.component("my-component",{

template:"$<div>{{ message }}</div>$",

data:function(){

​	return{ message:"xxx"}

}

})

### props传递

### 组件通信

$<div id="app"><my-component message="来自父组件的数据"></my-component></div>$

Vue.component("my-component",{

template:"$<div>{{ message }}</div>$",

props:["message"],

data:function(){

​	return{ message:"xxx"}

}

})

var app = new Vue({

​	el:"#app"

})



$<div id="app"><input type="text" v-model="parentMessage"></input><my-component  :message="来自父组件的数据"></my-component></div>$

Vue.component("my-component",{

template:"$<div>{{ message }}</div>$",

props:["message"],

data:function(){

​	return{ message:"xxx"}

}

})

var app = new Vue({

​	el:"#app"

})



单向绑定:父组件传值；bind绑定props值

Vue.component('my-component',{

props:["initCount"],

template:"$<div>{{ count }}</div>$",

data:function(){

​	return{ count:this.initCount}

}

})

$<div><my-component:init-count="1"></my-component></div>$

单向绑定：prop作为需要转变的原始值

Vue.component('my-component',{

props:["width"],

template:"$<div :style="style">组件内容</div>$",

computed:{

​	style : function(){

​	return{ width:this.width + 'px'}

}

}

})

$<div><my-component:width="100"></my-component></div>$

### 数据验证

Vue.component("my-component",{

props:{

propA:Number,

propB:[String,Number],

propC:{

type:Boolean,

default:true

},

propD:{

type:Number,

required:true

},

propE:{

type:Array,

default:function(){

​	return [];

}

},

propF:{

validator: function (value){

​	return value>10;

}

}

}

})

### 自定义事件

$<p>总数： {{total }}</p><my - component	@increase="handleGetTotal"@reduce="handleGetTotal"></my-component></div>$

...

Vue.component ( ’ my - component ’, {
template :

$<div ><button @click＝ ” handleIncrease” > +1 </button > <button @click= ” handleReduce ” >-1< /button> </div>$
data : function () {
return {
counter : 0
methods : {

handleincrease: function () {
this.counter++;
this.$emit ('increase', this.counter);
} ,

handleReduce: function () {
this.counter--;
this.$emIt ('reduce '， this.counter) ;) }

var app =new Vue({
el :'#app',
data: {
total: 0
methods : {
handleGetTotal: function (total) {
this . total = total ;
})


### slot分发

props 传递数据

events触发事件

slot内容分发

### 高级用法
#### 递归组件
#### 内联模板
#### 动态组件
#### 异步组件
## 自定义指令

# advance
## webpack
## vue-router
## 状态管理&vuex


# action
## iView
## 知乎
## 电商
## 库
### Nuxt
### axios

