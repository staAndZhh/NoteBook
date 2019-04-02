# base

## demo

### todolist

`<!DOCTYPE html>

<html lang="en">

<head>

​    <meta charset="UTF-8">

​    <title>hello</title>

​    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

</head>

<body>

​    <div id="app">

​    <input type="text" v-model="inputValue"></input>

​    <button v-on:click="handleBtnClick">submit</button>

​    <ul>

​    <todo-item 

​    v-for="(item,index) in list" 

​    v-bind:content="item"

​    v-bind:index="index"

​    @delete="handleItemDelete"

​    \></todo-item>

​    </ul>

​    </div>

​    <script>

 

​    var TodoItem = {

​            props:['content','index'],

​            template: "<li @click='handleItemClick'>{{content}}</li>",

​            methods:{

​                handleItemClick:function(){

​                    // alert("click");

​                    this.$emit("delete",this.index);

​                },

​            }

​    }



​       // Vue.component("TodoItem",{

​       //     props:['content'],

​       //     template: "<li> {{content}}</li>"

​       // })

 

​        var app = new Vue({

​            el:'#app',

​            components:{

​                TodoItem:TodoItem

​            },

​            data:{

​                list:["first","second"],

​                inputValue:""

​            },

​            methods:{

​                handleBtnClick: function(){

​                    this.list.push(this.inputValue)

​                    this.inputValue =""

​                    //alert(this.inputValue)

​                },

​                handleItemDelete: function(index){

​                    // alert('ele')

​                    this.list.splice(index,1)

​                }

​                

​            }

​        })

​    </script>

</body>

</html>`



##  BaseContent

### 根实例

 new Vue

属性：el,

data:{xx:xx},

methods:{

handleClick:function(){}

}

生命周期函数：function(){},

template:<xx></xx>

### 组件实例

Vue.component("xx"{

template:"<xx></xx>"

})

### UI绑定

数据：{{xx}}  v-bind:xx  :xx	  v-model="xx" 

方法绑定: v-on:click="xx"	 @click="xx" 

### 数据获取

vm.$data

vm.#destroy()

### 生命周期钩子

vm的属性

beforeCreate

created

beforeMount

mounted

beforeDestroy

destroyed

beforeUpdate

updated

### 模板语法

v-text="xx"+"aa"   {{xx}}不转义

v-html="xx"  转义

v-bind:xx="xx"

### 计算属性&方法&监听

#### 计算属性

内置缓存：依赖的值发生变化，才开始变化；否则不变化

new Vue({

data:{

firstName:"z",

lastName:"hh",

fullName:"z hh"

},

watch:{

​	firstName: function(){

​	this.fullName = his.firstName + " " + this.lastName  

},

​	lastName: function(){

​	this.fullName = his.firstName + " " + this.lastName  

}

}

computed:{

fullName:function(){

return   this.firstName + " " + this.lastName 

}

},

methods:{  

fullName: function(){

​                  return   this.firstName + " " + this.lastName  

​                }

}

})

使用：

​    {{firstName+""+ lastName}}

​    {{fullName}}

​    {{fullName()}}

方法：

计算属性 computed

watch侦听器

计算方法 methods

#### getter&setter

计算方法:

computed:{

fullName:function(){

return   this.firstName + " " + this.lastName 

}

},

计算方法对象形式：

computed:{

fullName:{

get:function(){

return   this.firstName + " " + this.lastName 

},

set:function(value){

var arr = value.split(" ")

this.firstName= arr[0]

this.lastName = arr[1]

console.log(value)

}

}

}, 

### 样式绑定

#### class的对象绑定

​    <div @click="handleDivClick"

​    :class="{activated:isActivated}"

​    \>

new Vue ({

 data:{

​                isActivated:false,

​            },

methods:{

handleDivClick:function(){

​	this.isActiveated = !this.isActiveated;

}

}

})

#### class与数组绑定

​    <div @click="handleDivClick"

​    :class="[activated,activatedOne]"

​    \>

vue.Componente {

 data:{

​                activated:"",

​		activatedOne:"activated-one"

​            },

methods:{

handleDivClick:function(){

​	this.activated=this.activated=== "activated" ?

​	"":"activated"

}

}

}

#### style样式

##### 对象

<div :style="styleObj"

@click="handleDivClick" ></div>

new Vue({

data:{

​	styleObj:{color:"red"}

},

methods:{

​	handleDivClick:function(){

​	this.styleObj.color = this.styleObj.color === "black"?"red":"black";

}

}

})

##### 数组

<div :style="[styleObj,{fontSize:'20px'}]"

@click="handleDivClick" ></div>

new Vue({

data:{

​	styleObj:{color:"red"}

},

methods:{

​	handleDivClick:function(){

​	this.styleObj.color = this.styleObj.color === "black"?"red":"black";

}

}

})

### 条件渲染

if:display:从页面移除

show: display:none

 <div v-if="show">{{message}}</div>

 <div v-else="show">hello world</div>

 <div v-show="show"></div>



 <div v-if="show==='a'">{{message}}</div>

 <div v-else-if="show==='b'">hello world</div>

 <div v-else="show">This is True</div>

new Vue({

data:{

show:false

}

})

#### key

 <div v-if="show"><input  key="username"/></div>

 <div v-else="show"><input  key="password"/></div>

复用dom，内容不会自动清空

### 列表渲染

<div v-for="(item,index)  of list" :key="index">

{{item.text}}......{{index}}

</div>

new Vue({

data:{

list:[{

id:1,text:'a'

},{

id:2,text:'b'

]

}

})

#### 数组改变

pop

push

shift

unshift

splice

sort

reverse

### 模板占位符

template不渲染为UI

<template v-for="(item,index)  of list" :key="index">

<div></div>

<span></span>

</template>

### set方法

改变对象内容

Vue.set(vm.userInfo,"address","beijing")

app.$set(app.userInfo,"address","beijing")

改变数组内容

m1:改变数组的引用

m2:变异方法

m3:set方法

Vue.set(app.userInfo,1,5)

app.$set(app.userInfo,2,10)

# Details

## 组件引用

### is

is="xx"

<table><tr is="row"></tr></table>

Vue.component('row',{template:'<tr><td>this is a row</td></tr>'})

var vm= new Vue({el:"#root"})

### 子组件 data

data:function(){return content: 'this is data'}

根组件调用一次，子组件可能调用多次

<table><tr is="row"></tr></table>

Vue.component('row',{

data: function(){

return content:"this is content"}

template:'<tr><td>{{content}}</td></tr>'})

var vm= new Vue({el:"#root"}) 

### ref

ref ="xx"

<div  ref="hello" @click="handleClick">hello world</div>

var vm = ne Vue({

el:"#root",

methods:{

handleClick:function(){

alert:this.$refs.hello.innerHTML)

}

}

})

#### ref demo

<div id="root">

<counter  ref="one"  @change="handleChange"></counter>

<counter  ref="two" @change="handleChange"></counter>

<div>{{total}}</div>

</div>



Vue.component('counter',{

template:'<div @click="handleClick">{{number}}</div>',

data:function(){

return {

​	number:0

}

},

methods:{

handleClick:function(){

​	this.number ++

​	this.$emit("change")

}

}

})



var vm = new Vue({

el:"#app",

data:{

total:0

},

methods:{

 handleChange:function(){

alert("change")

console.log(this.$refs.one.number)

this.total =` this.$refs.one.number + this.$refs.two.number`

}

}

})

## 父子组件传值

### 父传子

父传子：属性

子组件克隆副本，并改变使用

<counter :count="0"></counter>

<counter :count="1"></counter>

var counter ={

props:["count"],

//template:'` <div @click="handleClick">{{count}}</div>`'

template:'` <div @click="handleClick">{{number}}</div>`'

},

data:function(){

​	return{

​	number:this.count

}

}

methods:{

​	handleClick:function(){

​	//this.count++  单向数据流，错误

​	this.number++

}

}

var  vm = new Vue({

el:"#root",

components:{

​	counter:counter

}

})

### 子传父

通过emit方式，并在父组件中定义方法

<counter :count="0" @inc = "handleIncrease"></counter>

<counter :count="1"  @inc = "handleIncrease"></counter>

<div>{{total}}</div>

var counter ={

props:["count"],

//template:'` <div @click="handleClick">{{count}}</div>`'

template:'` <div @click="handleClick">{{number}}</div>`'

},

data:function(){

​	return{

​	number:this.count

}

}

methods:{

​	handleClick:function(){

​	//this.count++  单向数据流，错误

​	this.number = this.number +2;

​	this.$emit("inc",2);

}

}

var  vm = new Vue({

el:"#root",

data:{

​	total:5

},

components:{

​	counter:counter

},

methods:{

​	handleIncrease:function(step){

​		this.total += step;

}

}

})

## 参数检验

`<child content="hello world"></child> `

`<child :content="{a:1}"></child> `

​    var Child = {

​            //  props:['content'],

​            //  props:{

​            //  content:String,

​	   //	content:Number,

​	   //	content:[Number,String]

​            },

​		props:{

​		content:{

​			type:String,

​			required:false,

​			default:"default value",

​			validator: function(value){

​                       return (value.length>5)

​                   }

​		}

​		}

​            template: "<div>{{content}}</div>",

​    }

 

​    var app = new Vue({

​            el:'#app',

​            components:{

​                Child:Child

​            }

​        })

#### props特性

父组件传递的属性，子组件的props中有接收，可以直接使用

不在dom标签中显示

#### 非props特性

父传，子不接收，子组件使用：报错

在dom中显示

## 原生事件

m1:子组件emit 传递给父组件，父组件调用   

 <div id="app">

​    <child @click="handleClick"></child>

​    </div>



​    var Child = {

​            template: "<div @click='handleChildClick'>content</div>",

​            methods:{

​                handleChildClick:function(){

​                    this.$emit("click")

​                }

​            }

​    }

 

​    var app = new Vue({

​            el:'#app',

​            components:{

​                Child:Child

​            },

​            methods:{

​                handleClick:function(){

​                    alert("click")

​                }

​            }

​        })

m2:native修饰符

 <div id="app">

​    <child @click.native="handleClick"></child>

​    </div>



​    var Child = {

​            template: "<div @click='handleChildClick'>content</div>",

​            }

​    }



​    var app = new Vue({

​            el:'#app',

​            components:{

​                Child:Child

​            },

​            methods:{

​                handleClick:function(){

​                    alert("click")

​                }

​            }

​        })

## 兄弟组件传值

m1:vuex官方框架

m2:总线机制

   <div id="app">

​    <child content="Dell"></child>

​    <child content="lee"></child>

​    </div>



​    Vue.prototype.bus = new Vue();

​    Vue.component('child', {

​            template: "<div @click='handleClick'>{{selfContent}}</div>",

​            props:{

​                content:String,

​            },

​            data:function(){

​                return {

​                    selfContent:this.content

​                }

​            },

​            methods:{

​                handleClick:function(){

​                    this.bus.$emit('change',this.selfContent)

​                }

​            },

​            mounted:function(){

​                var this_ = this

​                this.bus.$on('change',function(msg){

​                    this_.selfContent = msg;

​                })

​            }

​    });

   

​    var app = new Vue({

​            el:'#app',

​        })

## 插槽

m1:v-html

​    <div id="app">

​    <child content="<p>Dell</p>"></child>

​    </div>

​    Vue.component('child', {

​            props:['content'],

​            template: "<div v-html='this.content'></div>",

​    });

 

​    var app = new Vue({

​            el:'#app',

​        })

### 原始插槽

m2:slot

​    <div id="app">

​    <child>

​    <p>Dell</p>

​    </child>

​    <child>

​    </child>

 

​    </div>

​    <script>

​    Vue.component('child', {

​            template: "<div><slot>默认内容</slot></div>",

​    });

   



​    var app = new Vue({

​            el:'#app',

​        })

​    </script>

    ### 命名插槽

<xx slot="xx">

  <div id="app">

​    <child-content>

​    <div slot="header">header</div>

​    <div slot="footer">footer</div>

​    </child-content>

​    </div>

​    <script>

​    Vue.component('child-content', {

​            template: "<slot name='header'></slot><div>默认内容</div><slot name='footer'></slot>"});

  

​    var app = new Vue({

​            el:'#app',

​        })

​    </script>

### 作用域插槽

子组件某一部分由父组件定义

template slot-scope

   <div id="app">

​    <child>

​    <template slot-scope="props">

​    <h1>{{props.item}}</h1> 

​    </template>

​    </child>

​    </div>

​    <script>

​    Vue.component('child', {

​            template: `<div>

​            <ul>

​            <slot v-for="item of list" :item=item></slot>

​            </ul></div>`,

​            data:function(){

​                return {list:[1,2,3,4]}

​            }

​            

​            });

   

 

​    var app = new Vue({

​            el:'#app',

​        })

​    </script>

## 动态组件

### 动态组件

component:is="xx" 

<div id="app">

​    <component :is="type"></component> 

 

​     <child-one v-if="type=== 'child-one'"></child-one>

​     <child-two v-if="type=== 'child-two'"></child-two>

​     <button @click="handleBtnClick">button</button>

​    </div>

​    <script>

​    Vue.component('child-one', {

​            template: '<div>child-one</div>',

​            });

​       Vue.component('child-two', {

​            template: '<div>child-two</div>',

​            });

 

​    var app = new Vue({

​            el:'#app',

​            data:{

​                type:"child-one"

​            },

​            methods:{

​                handleBtnClick:function(){

​                    this.type= this.type === "child-one"?

​                    "child-two":"child-one";

​                    

​                }

​            }

​        })

​    </script>

### v-once

静态内容只刷新一次

  <div id="app">

​    <component :is="type"></component> 

 

​     <child-one v-if="type=== 'child-one'"></child-one>

​     <child-two v-if="type=== 'child-two'"></child-two>

​     <button @click="handleBtnClick">button</button>

​    </div>

​    <script>

​    Vue.component('child-one', {

​            template: '<div v-once>child-one</div>',

​            });

​       Vue.component('child-two', {

​            template: '<div v-once>child-two</div>',

​            });

 

​    var app = new Vue({

​            el:'#app',

​            data:{

​                type:"child-one"

​            },

​            methods:{

​                handleBtnClick:function(){

​                    this.type= this.type === "child-one"?

​                    "child-two":"child-one";

​                    

​                }

​            }

​        })

​    </script>



# 动画

### 过渡动画

transition 包括标签

.fade-enter

.fade-enter-active

.fade-enter-to

.fade-leave

.fade-lave-active

.fade-leave-to



 <style>

​    .v-enter,

​    .v-leave-to {

​        opacity:0

​    }

​    .v-enter-active,

​    .v-leave-active {

​        transition:opacity 3s;

​    }

​    </style>



​    <transition>

​     <child v-if="show"></child>

​    </transition>

### keyframe

​    <style>

​    @keyframes bounce-in {

​        0% {

​            transform: scale(0);

​        }

​        50% {

​            transform: scale(1.5);

​        }

​        100% {

​            transform: scale(1);

​        }

​    }

 

​    .fade-enter-active {

​        transform-origin: left center;

​        animation: bounce-in 1s;

​    }

​    .fade-leave-active{

​        transform-origin: left center;

​        animation: bounce-in 1s reverse;

​    }

​    </style>

</head>

<body>

​    <div id="app">

 

​    <transition name="fade">

​     <child v-if="show"></child>

​    </transition>

#### 自定义keyframe动画

​    <style>

​    @keyframes bounce-in {

​        0% {

​            transform: scale(0);

​        }

​        50% {

​            transform: scale(1.5);

​        }

​        100% {

​            transform: scale(1);

​        }

​    }

 

​    .active {

​        transform-origin: left center;

​        animation: bounce-in 1s;

​    }

​    .leave{

​        transform-origin: left center;

​        animation: bounce-in 1s reverse;

​    }

​    </style>

</head>

<body>

​    <div id="app">

 

​    <transition name="fade"

​    enter-active-class="active"

​    leave-active-class="leave"

​    \>

​     <child v-if="show"></child>

​    </transition>

### Animate.css

自定义进入，出去类

添加animated 和其他的动作类

<head>

​    <meta charset="UTF-8">

​    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

​    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css">

</head>

<body>

​    <div id="app">



​    <transition name="fade"

​    enter-active-class="animated swing"

​    leave-active-class="animated shake"

​    \>

​     <child v-if="show"></child>

​    </transition>

### 同时使用过度和动画

​    <transition name="fade"

​    appear

​    enter-active-class="animated swing"

​    leave-active-class="animated shake"

​    appear-active-class="animated swing"

​    \>

​     <child v-if="show"></child>

​    </transition>



​    <style>

​    .fade-enter,

​    .fade-leave-to {

​        opacity:0;

​    }

​    .fade-enter-active,

​    .fade-leave-active

​    {

​        transition:opacity 3s;

​    }

​    </style>

</head>

<body>

​    <div id="app">

 

​    <transition name="fade"

​    //:duration="10000"

​    :duration="{enter:5000,leave:10000}" 

​    //type="transition"

​    appear

​    enter-active-class="animated swing fade-enter-active"

​    leave-active-class="animated shake fade-leave-active"

​    appear-active-class="animated swing"

​    \>

​     <child v-if="show"></child>

​    </transition>

### JS动画

  <div id="app">

 

​    <transition name="fade"

​    @before-enter="handleBeforeEnter"

​    @enter="handleEnter"

​    @after-enter="handleAfterEnter"

​    @before-leave="handleBeforeEnter"

​    @leave="handleEnter"

​    @leave-enter="handleAfterEnter"

​    \>

​     <child v-if="show"></child>

​    </transition>

 

​     <button @click="handleBtnClick">button</button>

​    </div>

​    <script>

​    Vue.component('child', {

​            template: '<div v-once>child-one</div>',

​            });

​    var app = new Vue({

​            el:'#app',

​            data:{

​                show:true

​            },

​            methods:{

​                handleBtnClick:function(){

​                    this.show = !this.show

​                },

​                handleBeforeEnter: function(el){

​                    el.style.color='red'

​                },

​                handleEnter:function(el,done){

​                    setTimeout(()=>{

​                        el.style.color='green'

​                    },2000)

​                    setTimeout(()=>{

​                        el.style.color='green'

​                        done()

​                    },2000)

​                },

​                handleAfterEnter:function(el){

​                    el.style.color="#000"

​                }

​            }

​        })

​    </script>

### Velocity JS动画库

   <transition name="fade"

​    @before-enter="handleBeforeEnter"

​    @enter="handleEnter"

​    @after-enter="handleAfterEnter"

​    @before-leave="handleBeforeEnter"

​    @leave="handleEnter"

​    @leave-enter="handleAfterEnter"

​    \>

​     <child v-if="show"></child>

​    </transition>

 

​     <button @click="handleBtnClick">button</button>

​    </div>

​    <script>

​    Vue.component('child', {

​            template: '<div v-once>child-one</div>',

​            });

​    var app = new Vue({

​            el:'#app',

​            data:{

​                show:true

​            },

​            methods:{

​                handleBtnClick:function(){

​                    this.show = !this.show

​                },

​                handleBeforeEnter: function(el){

​                    el.style.opacity= 0

​                },

​                handleEnter:function(el,done){

​                    Velocity(el,{opacity:1},

​                    {duration:1000},

​                    complete,done)

​                },

​                handleAfterEnter:function(el){

​                    alert("done anmiate")

​                }

​            }

​        })

​    </script>

### 多个元素动画

​    <style>

​    .v-enter, .v-leave-to {

​        opacity:0;

​    }

​    .v-enter-active,.v-leave-ative {

​        transition:opacity 1s;

​    }

​    </style>

 

<body>

​    <div id="app">

 

​    <transition mode="in-out">

​     <div v-if="show" key="a" >hello </div>

​     <div v-else key="b"> world</div>

​    </transition>

 

​     <button @click="handleBtnClick">button</button>

​    </div>

### 多个组件动画

m1:

​    <style>

​    .v-enter, .v-leave-to {

​        opacity:0;

​    }

​    .v-enter-active,.v-leave-ative {

​        transition:opacity 1s;

​    }

​    </style>

 

<body>

​    <div id="app">

​    <transition mode="in-out">

​     <child v-if="show"></child>

​     <child-one v-else></child-one>

​    </transition>

 

​     <button @click="handleBtnClick">button</button>

​    </div>



m2:

​    <div id="app">

​    <transition mode="in-out">

​     <component :is="type"></component >



​    </transition>

### 列表过度动画

<transition-group>

<div v-for="item of lsit " :key="item.id"></div>

</transition-group>

### 动画封装

<fade :show="show">

<div>hello </div>

</fade>

Vue.component('fade',{

props:['show'],

template:

'

<transiton  

@before-enter="handleBeforeEnter"

@enter="handleEnter">

<slot v-if="show"></slot> 

</transiton>

'

},

methods:{

handleBeforeEnter:function(el){},

handleEnter:function(el,done){}

}

)

# 开发准备

码云创建项目

本地克隆

npm install --global vue-cli

vue init webpack Travel

npm run dev

git add .

git commit -m 'init '

git push

## 单文件与组件

单文件组件：xx.vue

UI :template

style: 

script

## 路由

根据功能不同；返回不同的页面

## 单页与多页应用

多页：首屏快，SEO优化，跨页面不太好

单页：页面切换快，首屏时间慢，SEO差

## 开发起步

meta元素

reset.css引入

border.css引入







