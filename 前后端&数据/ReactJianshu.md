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
### 组件
> import  React, {Component} from 'react';
> import React from 'react';
> const Component  = React.Component;
+ 只要包含有jsx语法，就需要import react； 
### JSX语法
+ js中的html组件
+ jsx语法中自定义的组件要用大写字母开头
## react基础
### todolist
+ react 16中提供了类似于div的fragment组件
+  输入内容确定
+  输入内容更改
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
+   const {deleteItem,index} = this.props;
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
