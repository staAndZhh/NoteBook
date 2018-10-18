# 框架

## base
+ 环境搭建
+ 基础语法
+ 原理进阶
+ 动画
+ redux
+ redux进阶
## 实战
+ 环境搭建
+ header 
+ 首页
+ 详情页
+ 登陆验证
+ 上线
## 技术点
+ create-react-app
+ 组件化思维
+ jsx
+ 开发调试
+ 虚拟dom
+ 生命周期
+ react-transition-group
+ redux
+ antd
+ ui,容器组件
+ 无状态组件
+ redux-thunk
+ redux-saga
+ styled-components
+ immutable.js
+ redux-immutable
+ axios
## 学习前提
+ js
+ es6
+ webpack
+ npm

# base
+ fackbook 2013 函数式编程
+ 16.3.2 react Fiber
+ 复杂度高 react
+ 复杂度低 vue
### 开发环境
+   m1:引入.js文件使用react
+   m2:脚手架工具编码
+   使用官方的脚手架工具 create-react-app
+   node
+   node install create-react-app
+   create-react-app todolist
+   cd todolist
+   yarn start
### 组件
> import  React, {Component} from 'react';
> import React from 'react';
> const Component  = React.Component;
+ 只要包含有jsx语法，就需要import react； 
### JSX语法
+ js中的html组件
+ jsx语法中自定义的组件要用大写字母开头
## todolist
### 响应式设计思想&事件绑定
+   数据的变化代替原来的dom操作
#### inputvalue值随时变动
#### 新增删除列表项
#### 扩大输入区域
#### 分割子组件
+   把父组件中的参数和函数都以props形式传递给子组件
+   子组件点击调用父组件的函数和参数
#### 属性类型配置
####  字符转义
#### 代码优化
+   子组件写在自定义的render函数中
#### 子组件状态判断
#### axios模拟请求数据
#### charles实现本地数据mock
## Redux的todolist
#### store创建
+   yarn add redux
+   store文件夹
+   store：f ： index.js
+   import { createStore } from 'redux';
import reducer from './reducer';
const store = createStore(
    reducer,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__());

export default store;
####   创建reducer
+   store: f: reducer.js
+   const defaultState = {
    inputvalue : '123',
    list: [1,2,3]
}
export default (state  = defaultState,action) =>{
    return state;
}
####    引用store
+   import store from './store';
+   得到store中的元素
+   store.getState()
+   使用store中的元素
+   this.state = store.getState();
+   import React , { Component } from  'react';
import { Button ,Input, List} from 'antd';
import store from './store';
import  'antd/dist/antd.css';


// const data = [
//     'Racing car sprays burning fuel into crowd.',
//     'Japanese princess to wed commoner.',
//     'Australian walks 100km after outback crash.',
//     'Man charged over missing wedding girl.',
//     'Los Angeles battles huge wildfires.',
// ];

class AntdTodolist extends Component{

    constructor(props){
        super(props);

        console.log(store.getState());
        this.state = store.getState();
    }
    render(){
        return(
            <div style={{marginTop :'10px', marginLeft:'10px'}}>
                <Input placeholder ='todo info' style = {{ width: '400px'}} value={this.state.inputvalue}/>
                <Button type="primary"> commit </Button>
                <List
                    bordered
                    style = {{ marginTop:'10px', width:'300px'}}
                    // dataSource={data}
                    // dataSource={[]}
                    dataSource = {this.state.list}
                    renderItem={item => (<List.Item>{item}</List.Item>)}
                />
            </div>
        )
    }
}
####    使用插件
+   chrom安装redux插件
+   store中导入
+   import { createStore } from 'redux';
import reducer from './reducer';
const store = createStore(
    reducer,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__());

export default store;
#### 创建action
+   变更数据
#### input数据框变更，store也变更  
+   数据变更函数
+        <Input placeholder ='todo info' style = {{ width: '400px'}} value={this.state.inputvalue}
                 onChange = {this.handleInputChange.bind(this} />
#### 创建action  
+    handleInputChange(e){
        const action = {
            type:'change_input_value',
            value:e.target.value
        }
        store.dispatch(action);
       console.log(e.target.value);
    }  
#### 传递给store
+   store.dispatch(action);
#### store自动转发给reducer变更数据
#### reducer对之前的数据和要做的动作，对数据进行改变
+   拷贝之前的数据
+   拷贝的数据的inputvalue等于传话传过来的新动作
+   const defaultState = {
    inputvalue : '123',
    list: [1,2,3]
}
export default (state  = defaultState,action) =>{
    if (action.type === 'change_input_value'){
        const newState = JSON.parse(JSON.stringify(state));
        newState.inputvalue = action.value;
        return newState;
    }

    console.log(state,action)
    return state;
}
#### reducer传递给store，自动替换掉store里面的老数据
####  组件未更新，需要组件来订阅store并处理
+   store.subscribe(this.handleStoreChange);
+   his.handleStoreChange = this.handleStoreChange.bind(this);
+   import React , { Component } from  'react';
import { Button ,Input, List} from 'antd';
import store from './store';
import  'antd/dist/antd.css';


// const data = [
//     'Racing car sprays burning fuel into crowd.',
//     'Japanese princess to wed commoner.',
//     'Australian walks 100km after outback crash.',
//     'Man charged over missing wedding girl.',
//     'Los Angeles battles huge wildfires.',
// ];

class AntdTodolist extends Component{

    constructor(props){
        super(props);

        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleStoreChange = this.handleStoreChange.bind(this);

        console.log(store.getState());
        this.state = store.getState();

        store.subscribe(this.handleStoreChange);
    }
    render(){
        return(
            <div style={{marginTop :'10px', marginLeft:'10px'}}>
                <Input placeholder ='todo info' style = {{ width: '400px'}} value={this.state.inputvalue}
                 onChange = {this.handleInputChange} />
                <Button type="primary"> commit </Button>
                <List
                    bordered
                    style = {{ marginTop:'10px', width:'300px'}}
                    // dataSource={data}
                    // dataSource={[]}
                    dataSource = {this.state.list}
                    renderItem={item => (<List.Item>{item}</List.Item>)}
                />
            </div>
        )
    }

    handleInputChange(e){
        const action = {
            type:'change_input_value',
            value:e.target.value
        }
        store.dispatch(action);
       console.log(e.target.value);
    }

    handleStoreChange(){
        console.log('store change');
    }
}
export default AntdTodolist;
####    更新组件的状态
+       handleStoreChange(){
        console.log('store change');
        this.setState(store.getState());
    }

+   import React , { Component } from  'react';
import { Button ,Input, List} from 'antd';
import store from './store';
import  'antd/dist/antd.css';


// const data = [
//     'Racing car sprays burning fuel into crowd.',
//     'Japanese princess to wed commoner.',
//     'Australian walks 100km after outback crash.',
//     'Man charged over missing wedding girl.',
//     'Los Angeles battles huge wildfires.',
// ];

class AntdTodolist extends Component{

    constructor(props){
        super(props);

        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleStoreChange = this.handleStoreChange.bind(this);

        console.log(store.getState());
        this.state = store.getState();

        store.subscribe(this.handleStoreChange);
    }
    render(){
        return(
            <div style={{marginTop :'10px', marginLeft:'10px'}}>
                <Input placeholder ='todo info' style = {{ width: '400px'}} value={this.state.inputvalue}
                 onChange = {this.handleInputChange} />
                <Button type="primary"> commit </Button>
                <List
                    bordered
                    style = {{ marginTop:'10px', width:'300px'}}
                    // dataSource={data}
                    // dataSource={[]}
                    dataSource = {this.state.list}
                    renderItem={item => (<List.Item>{item}</List.Item>)}
                />
            </div>
        )
    }

    handleInputChange(e){
        const action = {
            type:'change_input_value',
            value:e.target.value
        }
        store.dispatch(action);
       console.log(e.target.value);
    }

    handleStoreChange(){
        console.log('store change');
        this.setState(store.getState());
    }
}
export default AntdTodolist;

#### todolist列表添加功能
+ btn绑定方法
+  发送action
+   重写reducer
+   监听数据变化
+   重写接受方法

#### todolist列表删除功能
+  listitem绑定方法
+  发送action
+   重写reducer
+   监听数据变化
+   重写接受方法
#### actiontypes的拆分
+   store： f ： actionTypes.js
+   export const CHANGE_INPUT_VALUE = "change_input_value";
export const ADD_TODO_ITEM  = "add_todo_item";
export const DELETE_TODO_ITEM  = "delete_todo_item";
+   reducer.js :import { CHANGE_INPUT_VALUE, ADD_TODO_ITEM, DELETE_TODO_ITEM } from './actionTypes';
+   todolist.js:import { CHANGE_INPUT_VALUE, ADD_TODO_ITEM, DELETE_TODO_ITEM } from './store/actionTypes';
#### actionCreator统一创建action
+   store： f：actionCreator.js
+   import { CHANGE_INPUT_VALUE, ADD_TODO_ITEM, DELETE_TODO_ITEM } from './store/actionTypes';

export const getInputChangeAction = (value) => (
    {
        type:CHANGE_INPUT_VALUE,
        value
    }
)

export const getAddItemAction = (value) => (
    {
        type:ADD_TODO_ITEM,
    }
)

export const getDeleteItemAction = (index) => (
    {
        type:DELETE_TODO_ITEM,
        index
    }
)
+   todolist中使用actionCreator创建并分发action
+   import {getInputChangeAction,getAddItemAction,getDeleteItemAction} from './store/actionCreator';
+       handleItemDelete(index){
        console.log(index);
        // const action = {
        //     type: DELETE_TODO_ITEM,
        //     index
        // }
        const action = getDeleteItemAction(index);
        store.dispatch(action);
    }

#### redux复习
+   store是唯一的
+   只有store可以改变state
+   reducer必须是纯函数，不能有任何副作用
+   createStore，store.dispatch,store.getState,store.subscribe

## UI&容器组件和无状态组件
+   UI组件只涉及到样式
+   容器组件涉及到交互逻辑
+   普通组件只有一个render函数时，可以写成无状态组件
+   无状态组件是一个只有render函数的函数
+   无状态组件：接受父组件的props返回一个jsx
+   UI组件可以写成无状态组件，理论上
+   const AntdTodoListUI = (props) =>{

    return(
        <div style={{marginTop :'10px', marginLeft:'10px'}}>
            <Input placeholder ='todo info'
                   style = {{ width: '400px'}}
                // value={this.state.inputvalue}
                   value={props.inputValue}
                // onChange = {this.handleInputChange}
                   onChange = {props.handleInputChange}
            />

            <Button type="primary"
                // onClick={this.handleBtnClick}
                    onClick={props.handleBtnClick}
            > commit </Button>
            <List
                bordered
                style = {{ marginTop:'10px', width:'300px'}}
                // dataSource={data}
                // dataSource={[]}
                // dataSource = {this.state.list}
                dataSource = {props.list}
                renderItem={(item,index) => (
                    <List.Item
                        // onClick = {this.handleItemDelete.bind(this,index)}>
                        onClick ={(index) => {
                            props.handleItemDelete(index)
                        }
                        }>
                        {item}</List.Item>)}
            />
        </div>
    )
}
export default AntdTodoListUI;
## redux异步请求
#### didmount发送action
+     componentDidMount(){
        axios.get('/api/todolist').then(
            (res)=>{
                // alert('succ');
                // this.setState(()=>{
                //     return{
                //         list:[...res.data]
                //     }
                // })
                const data = res.data;
                const action = initListAction(data);
                store.dispatch(action);
            }
        ).catch(
            ()=>{
                alert('error')
                const data = [1,2];
                const action = initListAction(data);
                store.dispatch(action);
            }
        )
    }

#### 创造action
+   export const initListAction = (data) => (
    {
        type:INIT_LIST_AX,
        data
    }
)
#### reducer处理
+       if (action.type === INIT_LIST_AX){
        const newState = JSON.parse(JSON.stringify(state));
        newState.list = action.data;
        return newState;
    }

#### 接收store处理过的数据
+   store.subscribe(this.handleStoreChange);
+       handleStoreChange(){
        console.log('store change');
        this.setState(store.getState());
    }


## redux-thunk
+   把异步的网络请求更改为action统一处理
+   action：函数--dispath：action执行函数--改变store装填--action中dispath
+   import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import rootReducer from './reducers/index';

// Note: this API requires redux@>=3.1.0
const store = createStore(
  rootReducer,
  applyMiddleware(thunk)
); 

+   https://github.com/zalmoxisus/redux-devtools-extension
+   安装并在store中使用thunk
+   import { createStore,applyMiddleware,compose} from 'redux';
import thunk from 'redux-thunk';
import reducer from './reducer';

const composeEnhancers =
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
        window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
            // Specify extension’s options like name, actionsBlacklist, actionsCreators, serialize...
        }) : compose;

const enhancer = composeEnhancers(
    applyMiddleware(thunk),
    // other store enhancers if any
);
const store = createStore(reducer, enhancer);

export default store;
#### 异步操作的代码从组件中移除，并写为action
+ action creator 可以返回函数，进行异步操作；使用thunk之后
+   dispath一个函数，获取json
+   actionCreator.js
+   export const getTodoList = ()=>{
    return (dispatch)=>{
        axios.get('./list.json').then(
            (res)=>{
                const data = res.data;
                console.log(data);
                const action = initListAction(data);
                dispatch(action);
            }
        )
    }
}
+   store接收后进行dispath然后执行函数
##  redux中间件
+   指的是action和store中间
+   实际上对dispath的升级
+   thunk中间件：对象--直接dispatch
+   thunk中间件：函数--先执行，然后dispatch
##　redux-saga
+   不同于thunk把函数在action中
+   redux-soga异步操作放在另外的文件中
+   yarn add redux-saga
+   在自定义saga中拦截action，接收到action后执行特定的函数方法
####  使用流程
+   容器组件正常派发aciton
+   派发之后，reducer，saga都能接收到函数
+   现在action可以通过takeevery来接收到action
+   然后通过put来分发action
#### 前端进行使用
+   前端创建action函数：函数，并dispatch；dispath会自动执行action中的函数
+   import { createStore,applyMiddleware,compose} from 'redux';
import reducer from './reducer';

import createSagaMiddleware from 'redux-saga';
import todoSagas from './sagas';
// thunk
// const composeEnhancers =
//     window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
//         window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
//             // Specify extension’s options like name, actionsBlacklist, actionsCreators, serialize...
//         }) : compose;
//
// const enhancer = composeEnhancers(
//     applyMiddleware(thunk),
//     // other store enhancers if any
// );
// const store = createStore(reducer, enhancer);
//
// export default store;


// sage
const composeEnhancers =
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
        window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
            // Specify extension’s options like name, actionsBlacklist, actionsCreators, serialize...
        }) : compose;

const sagaMiddleware = createSagaMiddleware();
const enhancer = composeEnhancers(
    applyMiddleware(sagaMiddleware),
    // other store enhancers if any
);
const store = createStore(reducer, enhancer);
sagaMiddleware.run(todoSagas);
export default store;
#### 还需要在action中的函数改变store的状态
+    在action中：dispatch(action);
+    componentDidMount(){
        const  action = getInitListSaga();
        store.dispatch(action);
    }

####   在saga中接收并请求网络
+  store:sagas.js
+  import { takeEvery ,put} from 'redux-saga/effects';
import {GET_INIT_LIST_SAGE} from './actionTypes';
import {initListAction} from './actionCreator';

import axios from 'axios';

function* getInitList() {
    try{
        const res = yield axios.get('/list.json');
        const action = initListAction(res.data);
        yield put(action);
    } catch (e) {
        console.log('error');
         const res ={
            data:[1,2,3]};
        const action = initListAction(res.data);
        yield put(action);
    }


}
// generator 函数
function * todoSagas (){
    yield takeEvery(GET_INIT_LIST_SAGE, getInitList);
}

export  default  todoSagas;
#### reducer中进行状态迭代
+       if (action.type === INIT_LIST_AX){
        const newState = JSON.parse(JSON.stringify(state));
        newState.list = action.data;
        return newState;
    }

## react-redux
+   provider store提供给每个连接组件的
+   connect 连接store和组件组件和属性
+   mapStateToProps：映射store的state属性到组件的props：store数据和组件的数据做关联
+   mapDispatchToProps:修改store的属性，把store.dispatch挂载到props：组件props如何修改store和dispath

#### connect
## react基础
### todolist
#### input组件自动变换输入
+ react 16中提供了类似于div的fragment组件
+  输入内容确定
+  输入内容更改使用
+  展示数据列表
+  点击增加列表数据
+  点击item删除item
    + state的immutable
### jsx语法细节
+ 注释 {//  /**/}
+ css样式类： import ‘./style.css';
+ css使用：className
+ html不转义:dangerouslSetInnerHTML = {{__html:item}}
+ label 光标聚焦 ：htmlFor = 'insertArea' <label htmlFor = 'insertArea'>please input</label>
###  组件拆分与传值
+ 父组件通过属性向子组件传递，子组件调用通过 this.props.xx来调用
+  子组件调用父组件中的方法：类似于接口调用，父组件把函数和参数都传递
+    content = {item} 
                            index = {index}
                            key = {index}
                            deleteItem = {this.handleItemDelete}
+    const {deleteItem,index} = this.props;
    //   this.props.deleteItem(this.props.index);
    deleteItem(index);
### 属性优化
+   const {deleteItem,iimport App from './App';ndex} = this.props;
+   this.props.deleteItem(this.props.index);
+   deleteItem(index);
+   bind(this)写在从构造函数中
+   item组件单独写一个函数：{this.getTodoItem()}
+ 在构造方法中统一绑定：    constructor(props){
        this.handleClick = this.handleClick.bind(this);
    } 
    
+  把调用的方法通过属性传递，把调用的参数通过属性传递：传递给子组件
+  类似于子组件调用父组件中的接口
+   setState变为异步的传递参数：
  
>       // this.setState({
>       //     list:[...this.state.list,this.state.inputValue],
>       //     inputValue:''
>       // })
   
> const value = e.target.value ;
>       this.setState(()=>(
>            {
>               inputValue:value
>           }
>       )) 

+ 使用过去中状态：
>        this.setState((preState)=>(
>           {
>               list:[...preState.list,preState.inputValue],
>           inputValue:''
>           }
>       ))

+ 使用函数传递

>        this.setState((preState)=>{
>           const list = [...this.state.list];
>           list.splice(index,1);
>           return {list};
>       }

###  高级思考
+ 可以和其他框架共存
+  声名式开发
+ 组件式开发
+ 单向数据流：父组件可以向子组件传值，子组件只能使用，不能更改父组件传递的数据
+ 视图层框架
+ 函数式编程
## react高级
+  安装插件reactDeveloperTools
### propsType&DefalutProps
+ import  PropTypes from 'prop-types';
+ TodoItem.propTypes = {
    test:PropTypes.string.isRequired,
    content:PropTypes.string,
    deleteItem:PropTypes.func,
    index:PropTypes.number
}
+ TodoItem.defaultProps = {
    test:'hello word'
}
+ https://reactjs.org/docs/typechecking-with-proptypes.html
+ class Comment extends Component {
  static propTypes = {
    comment: PropTypes.object.isRequired
  }
}
### props,state,render关系
+ 当组件的state或者props发生改变时，自己页面会重新渲染，render函数就会重新执行一次
+ 父组件的render函数被运行时，它的子组件的render将被重新运行
+ state组件控制自己的状态，props让外部对组件自己进行配置
+ 少用state，多用props
### 虚拟DOM
+ 同层比对
+ key值比对，key值保持稳定:key:content/item
+ React.createElement('div',{},'item');
+ React.createElement('div',{},React.createElement('span',{},'item'));
+   性能提升
+   跨平台应用得以应用,React Native
### ref使用
+ input组件：ref ={(input) =>{this.input = input}}
+ const value = this.input.value;
+ 同步操作dom
+    <ul ref = {(ul)=>{this.ur = ul}}> 
+ console.log(this.ul.querySelectorAll('div').length);
+ 异步操作dom
+        this.setState((preState)=>(
            {
                list:[...preState.list,preState.inputValue],
            inputValue:''
            }
        ),()=>{
            console.log(this.ul.querySelectorAll('div').length);  
        });
        console.log(this.ul.querySelectorAll('div').length);
  }

### props.children
+  容器组件
> <div className='card-content'>
>         {this.props.content}
>       </div>
### 状态提升
+ 某个状态被多个组件依赖或者影响的时候，就把该状态提升到这些组件的最近公共父组件中去管理，用 props 传递数据或者函数来管理这种依赖或着影响的行为。
+ 下拉菜单的展开或者收起状态，一般保存在组件内部即可
### 样式表
> <h1 style={{fontSize: '12px', color: this.state.color}}>React.js 小书</h1>
### 生命周期函数
+ 在某一时刻，组件会自动调用执行的函数
+ render()
+ constructor()
+ **Mounting** 
+ willmount: 组件第一次即将被挂载在页面之前执行：组件启动：ajax拉曲数据，定时器的启动
+ Didmount：第一次
+ componentWillUnmount：数据清理，定时器的清理
+ 组件挂载： -> constructor()
-> componentWillMount()
-> render()
// 然后构造 DOM 元素插入页面
-> componentDidMount()
+ 组件删除：-> constructor()
-> componentWillMount()
-> render()
// 然后构造 DOM 元素插入页面
-> componentDidMount()
// ...
// 即将从页面中删除
-> componentWillUnmount()
// 从页面中删除
+ **update**
+ 属性或者状态发生变换
+ receiveprops：一个组件要从父组件中接受参数，只要父组件的render函数被执行，子组件的生命周期函数将被执行
+ receiveprops：如果子组件第一次存在于父组件中，不执行
+ receiveprops：如果子组件已经存在于父组件中，不执行
+  shouldcomponentUpdate:被更新之前，返回bool
+  willupdate：shouldcomponentUpdate返回true才执行，否则不执行
+  render()
+  didupdate：更新之后
### 性能优化
+  在子组件中判断属性和数据是否变化，变化了就更新，否则不更新
+     shouldComponentUpdate(nextProps, nextState){
      if (nextProps.content !== this.props.content) {
        return true;
      } else {
        return false;
      }
    }

+ 网络请求写在componentDidMount中
+   import axios from 'axios';
+   componentDidMount(){
      axios.get('/api/todolist').then(
        (res)=>{
          this.setState(()=>{
            list:[...res.data]
          })
        }
      ).catch(
        ()=>{
          alert('error')})
    }
### charles
+ 

###  axios
+   yarn add axios
### 动画
+ 基础设置
>   this.state = {
>       show:true
>   }
>
>          <div className = {this.state.show? 'show':'hide'}>hello</div>
>      <button onClick = {this.handleToggole}>click to toggle</button>
>
>   handleToggole(){
>   this.setState(
>     {
>       show:this.state.show ? false : true
>     }
>  )
>  }  

+   动画组件
+   需要自己添加 in，className 属性
+   并根据需要重写.fade-enter，.fade-enter-active，.fade-enter-done，.fade-exit，.fade-exit-active，.fade-exit-done样式表
+   nmountOnExit 可以根据需要是否显示组件dom
+   可以添加钩子函数 onEntered 添加对应的钩子函数
+   appear = True 设置第一次显示是否显示动画，.fade-appear,.fade-appear-active
+   https://reactcommunity.org/react-transition-group/ 
+   CSSTransition
+   import { CSSTransition } from 'react-transition-group';
+   	<Fragment>
				<CSSTransition
					in={this.state.show}
					timeout={1000}
					classNames='fade'
					unmountOnExit
					onEntered={(el) => {el.style.color='blue'}}
					appear={true}
				>
					<div>hello</div>
				</CSSTransition>
				<button onClick={this.handleToggole}>toggle</button>
			</Fragment>
+   style.css
+   .fade-enter {
    opacity: 0;
}
.fade-enter-active {
    opacity: 1;
    transition: opacity 1s ease-in;
}
.fade-enter-done {
    opacity: 1;
}

.fade-exit{
    opacity: 1;
}
.fade-exit-active {
    opacity: 0;
    transition: opacity 1s ease-in;
}
.fade-exit-done {
    opacity: 0;
}
+   TransitionGroup
+   import { CSSTransition, TransitionGroup } from 'react-transition-group';
+   	render() {
		return (
			<Fragment>
				<TransitionGroup>
				{
					this.state.list.map((item, index) => {
						return (
							<CSSTransition
								timeout={1000}
								classNames='fade'
								unmountOnExit
								onEntered={(el) => {el.style.color='blue'}}
								appear={true}
								key={index}
							>
								<div>{item}</div>
							</CSSTransition>
						)
					})
				}
				</TransitionGroup>
				<button onClick={this.handleAddItem}>toggle</button>
			</Fragment>
		)
	}

	handleAddItem() {
		this.setState((prevState) => {
			return {
				list: [...prevState.list, 'item']
			}
		})
### redux入门
+  base共享状态
>       const appState = {
>    title: {
>     text: 'React.js 小书',
>      color: 'red',
>    },
>    content: {
>      text: 'React.js 小书内容',
>      color: 'blue'
>    }
>  }


>   function renderApp(appState){
>    renderTitle(appState.title)
>    renderContent(appState.content)
>   }

>   function renderTitle(title){
>    const titleDOM = document.getElementById('title')
>    titleDOM.innerHTML = title.text
>    titleDOM.style.color = title.color

>   }
>   function renderContent(content){
>    const contentDOM = document.getElementById('content')
>    contentDOM.innerHTML = content.text
>    contentDOM.style.color = content.color
>    }


>    function dispatch(action){
>    switch (action.type) {
>        case 'UPDATE_TITLE_TEXT':
>          appState.title.text = action.text
>          break
>        case 'UPDATE_TITLE_COLOR':
>          appState.title.color = action.color
>          break
>        default:
>          break
>      }
>   }

>   renderApp(appState)
>   // dispatch({ type: 'UPDATE_TITLE_TEXT', text: '《React.js 小书》' }) // 修改标题文本
>   // dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'blue' }) // 修改标题颜色

+   把所有的dispatch放在同一个地方，抽象出来叫做store
>   function createStore (state, stateChanger) {
>  const getState = () => state
>    const dispatch = (action) => stateChanger(state, action)
>     return { getState, dispatch }
>   }
>
>   let appState = {
>     title: {
>    text: 'React.js 小书',
>    color: 'red',
>  },
>  content: {
>    text: 'React.js 小书内容',
>    color: 'blue'
>  }
> }

>   function stateChanger (state, action) {
>  switch (action.type) {
>    case 'UPDATE_TITLE_TEXT':
>      state.title.text = action.text
>      break
>    case 'UPDATE_TITLE_COLOR':
>      state.title.color = action.color
>      break
>    default:
>      break
>  }
>    }

>   const store = createStore(appState, stateChanger)

>   renderApp(store.getState()) // 首次渲染页面
>   store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '《React.js 小书》' }) // 修改标题文本
>   store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'blue' }) // 修改标题颜色
>   renderApp(store.getState()) // 把新的数据渲染到页面上

+   监控数据变化
>   function createStore (state, stateChanger) {
>  const listeners = []
>   const subscribe = (listener) => listeners.push(listener)
>   const getState = () => state
>   const dispatch = (action) => {
>   stateChanger(state, action)
>   listeners.forEach((listener) => listener())
> }
>    return { getState, dispatch, subscribe }
>   }
>
>   const store = createStore(appState, stateChanger)
>   store.subscribe(() => renderApp(store.getState()))

>   renderApp(store.getState()) // 首次渲染页面
>   store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '《React.js 小书》' }) // 修改标题文本
>   store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'blue' }) // 修改标题颜色
>   // ...后面不管如何 store.dispatch，都不需要重新调用 renderApp
+  共享结构
+   浅复制
+   const obj = { a: 1, b: 2}
+   const obj2 = { ...obj } // => { a: 1, b: 2 }
+   复制和拓展
+   const obj = { a: 1, b: 2}
+   const obj2 = { ...obj, b: 3, c: 4} // => { a: 1, b: 3, c: 4 }，覆盖了 b，新增数据
+   共享结构
>   function createStore (state, stateChanger) {
>   const listeners = []
>   const subscribe = (listener) => listeners.push(listener)
>   const getState = () => state
>   const dispatch = (action) => {
>   state = stateChanger(state, action) // 覆盖原对象
>   listeners.forEach((listener) => listener())
>   }
>   return { getState, dispatch, subscribe }
>    }

>   function renderApp (newAppState, oldAppState = {}) { // 防止 oldAppState 没有传入，所以加了默认参数 >  >   oldAppState = {}
>     if (newAppState === oldAppState) return // 数据没有变化就不渲染了
>    console.log('render app...')
>    renderTitle(newAppState.title, oldAppState.title)
>     renderContent(newAppState.content, oldAppState.content)
>   }

>   function renderTitle (newTitle, oldTitle = {}) {
>  if (newTitle === oldTitle) return // 数据没有变化就不渲染了
>   console.log('render title...')
>   const titleDOM = document.getElementById('title')
>   titleDOM.innerHTML = newTitle.text
>   titleDOM.style.color = newTitle.color
>   }

>   function renderContent (newContent, oldContent = {}) {
>  if (newContent === oldContent) return // 数据没有变化就不渲染了
>  console.log('render content...')
>  const contentDOM = document.getElementById('content')
>  contentDOM.innerHTML = newContent.text
>  contentDOM.style.color = newContent.color
>   }

>   let appState = {
>  title: {
>    text: 'React.js 小书',
>    color: 'red',
>  },
>  content: {
>    text: 'React.js 小书内容',
>    color: 'blue'
>  }
>   }

>   function stateChanger (state, action) {
>  switch (action.type) {
>   case 'UPDATE_TITLE_TEXT':
>      return { // 构建新的对象并且返回
>       ...state,
>       title: {
>              ...state.title,
>              text: action.text
>            }
>          }
>        case 'UPDATE_TITLE_COLOR':
>          return { // 构建新的对象并且返回
>           ...state,
>            title: {
>              ...state.title,
>              color: action.color
>            }
>          }
>        default:
>          return state // 没有修改，返回原来的对象
>      }
>    }
    
>    const store = createStore(appState, stateChanger)
>    let oldState = store.getState() // 缓存旧的 state
>    store.subscribe(() => {
>      const newState = store.getState() // 数据可能变化，获取新的 state
>      renderApp(newState, oldState) // 把新旧的 state 传进去渲染
>      oldState = newState // 渲染完以后，新的 newState 变成了旧的 oldState，等待下一次数据变化重新渲染
>    })
    
>    renderApp(store.getState()) // 首次渲染页面
>    store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '《React.js 小书》' }) // 修改标题文本
>    store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'blue' }) // 修改标题颜色

+ **reduce**
+   **appstat和statechanger合并在一起**

+   function stateChanger (state, action) {
  if (!state) {
    return {
      title: {
        text: 'React.js 小书',
        color: 'red',
      },
      content: {
        text: 'React.js 小书内容',
        color: 'blue'
      }
    }
  }
  switch (action.type) {
    case 'UPDATE_TITLE_TEXT':
      return {
        ...state,
        title: {
          ...state.title,
          text: action.text
        }
      }
    case 'UPDATE_TITLE_COLOR':
      return {
        ...state,
        title: {
          ...state.title,
          color: action.color
        }
      }
    default:
      return state
  }
}

+   **createStore优化**

function createStore (reducer) {
  let state = null
  const listeners = []
  const subscribe = (listener) => listeners.push(listener)
  const getState = () => state
  const dispatch = (action) => {
    state = reducer(state, action)
    listeners.forEach((listener) => listener())
  }
  dispatch({}) // 初始化 state
  return { getState, dispatch, subscribe }
}

+ **reducer**

+   function themeReducer (state, action) {
  if (!state) return {
    themeName: 'Red Theme',
    themeColor: 'red'
  }
  switch (action.type) {
    case 'UPATE_THEME_NAME':
      return { ...state, themeName: action.themeName }
    case 'UPATE_THEME_COLOR':
      return { ...state, themeColor: action.themeColor }
    default:
      return state
  }
}

const store = createStore(themeReducer)

#### 总结
+   dispatch限制权限
+   共用createStore
+   自动渲染store.subscribe
+   共享结构对象 ...state
+   reducer
+   // 定一个 reducer
function reducer (state, action) {
  /* 初始化 state 和 switch case */
}

// 生成 store
const store = createStore(reducer)

// 监听数据变化重新渲染页面
store.subscribe(() => renderApp(store.getState()))

// 首次渲染页面
renderApp(store.getState()) 

// 后面可以随意 dispatch 了，页面自动更新
store.dispatch(...)
## redux进阶
+   高阶组件connect：复用context
+   高阶组件传递props
+   其他状态变化逻辑放在高阶组件中：mapStateToProps
+   高阶组件的mapDispatchToProps:组件特殊的dispatch
+   context放在provider中
+   smart组件和dumb组件
