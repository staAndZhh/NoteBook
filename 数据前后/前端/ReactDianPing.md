# mock数据
## m1: 代理到mock服务器
+	npm install -g serve
+	在某个路径下的命令行执行serve命令
	+	serve
+	请求转发
### demo
+	test/api/data.json
	+	{"data":"test data"}
+	test/
	+	cmd:server
+	http://localhost:5000/api/data.json	
+	数据访问
	+	package.json与scripts同级别，添加
	+	"proxy":{"/api":{"target":"http://localhost:5000"}}
+	重启项目
+	http://localhost:3000/api/data.json	
### 更新版本
+	npm install http-proxy-middleware --save
+	src/setupProxy.js
	+	const proxy = require('http-proxy-middleware')
module.exports = function (app) {
    app.use(proxy('/api', { target: 'http://localhost:5000/' }))
    app.use(proxy('/*.svg', { target: 'http://localhost:5000/' }))
}
## m2:直接把mock数据放在public文件夹下面
+	public/mock/data.json
	+	public文件夹中的数据不会被打包，直接作为静态资源保存
	+	路径为：/mock/data.json
+	http://localhost:3000/mock/data.json
# 组件划分
+	 解耦：降低单一模块，组件的复杂度
+	 复用：保证组件的一致性，提升开发效率
+	 组件颗粒度需要避免过大或者过小
## TodoList
+	App
	+	AddTodo
	+	TodoList
		+	Todo
	+	Footer
## 开发
+	过程解耦：静态页面-动态交互
+	开发顺序：自上而下-自下而上
+	app-todolist-todo-addtodo-footer
## state
+	代表UI的完整且最小状态集合
	+	代表UI
	+	状态
### 判断
+	是否通过父组件props：不是
+	是否随着时间，交互操作变化：是
+	是否可以通过其他state或者props计算得到：否
### Todo State
+	输入文本框中文本
+	待办事项列表
+	筛选条件
### State双层含义
+	代表应用UI的所有状态的集合
+	状态集合中的每一部分（待办列表，新增输入框文本，筛选条件）
### State保存位置
+	确定依赖state的每一个组件
+	如果某个state被多个组件依赖，寻找共同的父组件（状态上移）
	+	addtodo:仅自己使用
	+	结果列表:addtodo & todolist都有使用 => 父组件：App中
	+	筛选条件：需要对结果列表进行筛选 =>状态上移 => 父组件：App中
### 添加交互行为
+	借助props，添加反向数据流
	+	props传递父组件函数，子组件调用
+	新增todo，修改todo转态，过滤显示
# Redux
+	复杂的数据：API数据，本地数据，UI状态
+	视图和状态管理耦合，状态管理失控
+	视图层：React；状态管理层Redux
+	概念
+	store：state-action-reducer-state
## state
+	集中管理，全局唯一
+	不可变性
+	定义方式同ReactState
### 定义	
+	ReduxState :{ text:"", todos:[{id:1,text:"xx",completed:true}],filter:"all" }
## action
+	描述如何修改状态
+	JSON对象，type属性必需
+	发送：store.dispatch
### 定义
+	actions/index.js
+	addTodo
	+	var addTodoAction = { type:"ADD_TODO", id:1, text:"xxx"}
	+	let nextTodoId = 0,
	+	export const addTodo = (text)=>({type:"ADD_TODO", id:nextTodoId++, text:"xxx"})
+	toggleTodo
	+	export const toggleTodo = (id)=>({type:"TOGGLE_TODO", id})
+	setFilter
	+	export const setFilter = (filter)=>({type:"SET_FILTER", filter})
+	setTodoText
	+	export const setTodoText = (text)=>({type:"SET_TODO_TEXT", text})
### actionTypes
+	actions/actionTypes.js
	+	export const ADD_TODO = ADD_TODO;
+	actions/index.js
+	export const addTodo = (text)=>({type:ADD_TODO, id:nextTodoId++, text:"xxx"})
## Reducer
+	Previous+Action = Reducer() => New State
+	action（描述如何修改）的解析器：真正修改
### 事件
+	src/reducers/index.js
+	initialState
	+	const initialState = {}
+	todoApp
	+		const todoApp = (state=initialState,action) => {
		switch(action.type){
			case ADD_TODO:
				return { ... state, todos:[...state.todos,{text:action.text, completed:false}]}
			case TOGGLE_TODO:	
			case SET_TODO_TEXT:
			case SET_FILTER:
            default:
				return state;
			}
		}
### Reducer拆分
+	便于扩展和维护
+	合并API：combineReducers
+	src/reducers/filter.js src/reducers/index.js src/reducers/text.js src/reducers/todo.js