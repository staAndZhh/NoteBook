## 亮点
+	思想
+	状态数据流分析
+	测试
+	mock环境
+	部署上线
+	不讲重复逻辑
## 流程
+	单页开发
	+	原型图分析
	+	组件拆分和实现
	+	数据流交出&最终实现
+	单页测试
	+	测试工具简介
	+	展示型组件&单元测试
	+	容器型组件&集成测试
+	多页面组合	
	+	ReactRouter和SPA简介
	+	整个应用状态分析和提取
	+	context整合多页面数据和行为
+	对接后端以及上线
	+	json-server打造mock环境
	+	axios异步逻辑
	+	leancloud应用部署
## 知识点
+	基础
	+	react16
	+	理念
	+	contenxt
	+	高阶组件
+	工具
	+	ionicon
	+	reactrouter
	+	recharts
	+	bootstrap
+	测试以及后端
	+	jest
	+	Enzyme
	+	JsonServer
	+	Axios
#----------
# 设计稿
## 原型图
+	首页/列表页
+	图文详情
## 代码结构
+	create-react-app
### 结构
+	components文件夹放所有的展示型组件
+	containers文件夹放所有的容器型组件
+	这2个文件夹下的__test__文件夹存放所有的组件测试文件
+	文件使用Pascal Case命名法
+	src根目录下防止统一使用的一些文件
+	app.css
+	app.js
+	src
	+	components
		+	ComponentName.js
		+	__test__
			+  ComponentName.test.js
	+	containers
		+	ComponentName.js
		+	__test__
			+	ComponentName.test.js

## content
### 创建
+	src
	+	theme-context.js

>	import React from 'react';
>	const ThemeContext = React.createContenxt()
>	export default ThemeContext；
### 使用
+	出现2个变量：Provider，Consumer
+   传入数据	<ThemeContext.Provider value = {themes.light}>
+	使用数据 	<ThemeContext.Consumer>{
theme =>{ console.log(theme）；
}}
## 高阶函数
+	函数可以作为参数被传递
+	函数可以作为返回值输出
## 高阶组件
+	接受一个组件为参数并返回一个新组件的函数
+	高阶组件是一个函数，不是组件
## 高阶组件事例
+	react-redux中的connect
## 代理高阶组件
+	操纵prop
+	抽取状态
+	访问ref
+	包装组件
## 继承高阶组件
#----------
# 拆分静态组件
## think in react
+	ui划分出组件层级
+	创建应用的静态版本
## 拆分展示型组件
+	header
+	MonthSelect
+	TotalNumber
+	ViewTab
+	CreateBtn
+	PriceList
	+	PriceItem
##	PriceItem
+ 属性：数据，方法：删除，修改
+	PriceList
+	items = {items}
+	onDeleteItem = {onDeleteItem}
+	onEditItem = {onEditItem}
## bootstrap
+	npm install bootstrap --save
+	import 'bootstrap/dist/css/bootstrap.min.css'
+	
### items 
+	{id：，title：，price：，date：，category：{id：，name：，type：}}
-------
# 步骤
+	设计稿分析
+	功能点拆分
+	代码结构和标准的制定
-------
# 测试
## 现状
+	重视程度
+	没有时间
+	不会写
## 测试意义
+	高质量
+	更早发现bug，减少成本
+	重构和升级：容易和可靠
+	开发更加敏捷
## 测试金字塔
+	顶级：小（UI界面）：UI
+	中部：中（单元测试的组合）：Server
+	底部：大（比重最大）：Unit
## React单元测试
+	组件化
+	functional Component
+	单向数据流
## Jest框架
+	通用测试框架Jest
+	特点：通用，跨平台，（浏览器，node）
## 断言库
+	判断一个值是否对应相应的结果
+	https://jestjs.io/docs/zh-Hans/using-matchers
+	expect()
+	其他断言库：chai等等
## 断言使用
+	src
	+	example.test.js
	+	example.test.js文件中输入demo代码：
	>	test('test equal ', () => {
		  expect(2+2).toBe(4);
		})
+	使用： npm test src/example.test.js
## 断言demo
>		test('test equal ', () => {
		  expect(2+2).toBe(4);
		})
		test('test not equal', () => {
		  expect(2+2).not.toBe(5)
		})
		test('test to be true or false', () => {
		  expect(1).toBeTruthy()
		  expect(0).toBeFalsy()
		})
		test('test number ', () => {
		  expect(4).toBeGreaterThan(3)
		  expect(4).toBeLessThan(5)
		})
		test('test === object  ', () => {
		  expect({name: 'viking'}).toBe({name: 'viking' })
		})
		test('test object == object value  ', () => {
		  expect({name: 'viking'}).toEqual({name: 'viking' })
		})
		test('test object == eval ', () => {
		  expect({name: 'viking',age:30}).toEqual({name: 'viking',age:30 })
		})

## React测试工具
+	把react组件渲染或者挂载到测试用例中
+	React官方测试工具ReactTestUtils（api复杂）
+	Airbnb基于官方的封装Enzyme（官方推荐）
## enzyme特点
+	简单易懂
+	类似于jquery
>		const wrapper = mount(<Foo bar = 'baz'/>)
	wrapper.find('#test .sample').text()

##	enzyme两种测试方法
+	Shallow Rendering
	+	virtual dom 对象，测试属性，天生隔离
	+	子组件不会渲染，测试无状态组件（没有state，只有传入的属性）
+	DOM Rendering
	+	速度慢，dom渲染
## 简单实用配置
+	npm install enzyme enzyme-adapter-react-16 --save
+	src/setupTests.js
+	impprt Adapter from 'enzyme-adapter-react-16'
+	configure（{adapter：new Adapter()}）
## 测试用例
+	src/components/__test__/TotalPrice.test.js
+	import react from 'react'；
+	import { shallow } from 'enzyme ；
+	import TotalPrice from '../TotalPrice';
+	const props = { income：1000，outcome：2000}
+	describe（'test TotalPrice components',()=>{
	it（'com render incom&outcom number',
()=>{
	const wrapper shallow（<TotalPrice {...props}/>

	expect(wrapper.find('.income span').text()*1.toEqual(1000))
	expect(wrapper.find('.outcome span').text()*1.toEqual(2000))
})
})

+ 命令行输入：	npm test
## 价格列变单元测试
+	数组是否渲染对应长度
+	单个条目是否渲染特定组件和内容
+	单机按钮是否出发特定回调
## 测试用例
+	src/components/PriceList.test.js
+  describe('test components',()=>{
beforeEach(()=>{
	wrapper = shallow(<PriceList {...props}/>
})
it('should render match snapshot',()=>{
	expect(wrapper).toMatchSnapshot()
})
})


+	npm test
+	更改数据dom结构后可以查看是否结构变化
+	item长度
+	it('length',()=>{expect（wrapper).find('.list-group-item').length).toEqual(itemsWithCat.length)})

+	单个item
+	it('item',()=>{
const iconList = wrapper.find('.list-group-item').first().find(IonicList)

expect(IconList.length).toEqual(3)
expect(iconList.first().props.icon)
.toEqual(itemsWithCategory[0].category.iconName)

})
+	item点击
+	+	it('click',()=>{
const firstItem = wrapper.find('.list-group-item').first()
firstItem.find('a').first().simulate('click')

expect(props.onModifyItem).toHaveBeenCalled()
expect(props.onModifyItem).toHaveBeenCalledWith(itemsWithCAtegory[0])

})

## 月份选择单元测试
+	是否显示正确，下拉框是否显示
+	点击以后是否显示
+	点击回调
+	特殊值的处理
+	特殊dom的触发和处理
## 首页容器型测试