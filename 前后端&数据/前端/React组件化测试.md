## bootstrap
+	.container .container-fluid
+	.row  .col-xs-4 col-md-offset-4 右侧偏移
+	列 padding 设置间隔，.row设置负margin抵消 padding
## 栅格布局参数
+	手机，平板，桌面显示器，大桌面显示器
+	超小，小，中等，大
+	.col-xs- sm md lg
## 响应式重置
+	.clearfix visible-xs-block
## 列排序
+	col-md-push 向上
+	col-md-pull 向下
## 标题
+	h1-6 mark del s ins u  strong em abbr br blockquote
+	.small .lead .text-left .text-center .text-right .text-lowercase .text-uppercase .text-capitalize  .initialism  
## 列表
+	ul .list-unstyled

------------------

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
+   app.js中导入，其他文件不需导入
### items 

+	{id：，title：，price：，date：，category：{id：，name：，type：}}
### 实现
+	整体list：bootstrap样式list-group
+	行内元素：bootstrap的栅格系统
+	function组件：PriceList.js
>	const TotalPrice = ({ items, income, outcome }) => {
    return (
        <ul></ul>
    )
}

+ 添加list-group属性：
export default TotalPrice;

> const PriceList = ({ items, onModifyItem,onDeleteItem }) => {
  return (
      <ul className="list-group list-group-flush">
      {
          items.map((item) => (
              <li className="list-group-item d-flex
              justify-content-between align-items-conter"
              key={item.id}
              >
              <span className="col-1 badge badge-primary">{item.category.name}</span>
              <span className="col-5">{item.title}</span>
              <span className="col-2 font-weight-bold"> {(item.category.type === "income")?"+":"-"} {item.price}元</span>
              <span className="col-2">{item.date}</span>
              <button className="col-1 btn btn-primary"
				 onClick ={()=>{onModifyItem(item)}}
				>编辑</button>
              <button className="col-1 btn btn-danger"
				onClick ={()=>{onDeleteItem(item)}}
				>删除</button>
              </li>
          ))
      }
      </ul>
  )
}
export default PriceList;

+	app中导入
+	import PriceList from './components/PriceList';
>           <PriceList items={items}
        onModifyItem ={(item)=>(alert(item.id))}
        onDeleteItem = {(item)=>(alert(item.id))}
        ></PriceList>


## 图标库
+	ionicons
+	npm install --save react-ionicons
+	进展
	+	图片-font-svg
	+	使用svg图表库，而不用font icon
	+	font icon容易出字体错乱
	+	使用Ionicons
### 完成
+	PriceList.js
>    import React, { Component } from 'react'
		import Ionicon from 'react-ionicons'
		const PriceList = ({ items, onModifyItem, onDeleteItem }) => {
  return (
      <ul className="list-group list-group-flush">
      {
          items.map((item) => (
              <li className="list-group-item d-flex
              justify-content-between align-items-conter"
              key={item.id}
              >
              <span className="col-1 badge badge-primary">
              <Ionicon
              className="rounded-circle"
              fontSize='30px'
              style={{backgroundColor:'#007bff', padding:'5px'}}
              color={'#fff'}
              icon={item.category.iconName}
              ></Ionicon>
              {item.category.name}</span>
              <span className="col-5">{item.title}</span>
              <span className="col-2 font-weight-bold"> {(item.category.type === "income")?"+":"-"} {item.price}元</span>
              <span className="col-2">{item.date}</span>
              <a className="col-1 btn btn-primary"
              onClick ={()=>{onModifyItem(item)}}
              >
                            <Ionicon 
                className="rounded-circle"
                fontSize="30px"
                style={{ backgroundColor: '#28a745', padding: '5px'}}
                color={'#fff'}
                icon='ios-create-outline'
              />
              </a>
              <a className="col-1 btn btn-danger"
              onClick ={()=>{onDeleteItem(item)}}
              >
                            <Ionicon 
                className="rounded-circle"
                fontSize="30px"
                style={{ backgroundColor: '#dc35', padding: '5px'}}
                color={'#fff'}
                icon='ios-create-outline'
              />
              </a>
              </li>
          ))
      }
      </ul>
  )
}
export default PriceList;


## 类型检查
+	bug发现
+	react：PropTypes完成类型检查
+	Props的默认数值：defaultProps
+	ItemList添加PropTypes检查
### PriceList类型检查
+	import PropTypes from 'prop-types'
>    PriceList.propTypes = {
  items: PropTypes.array.isRequired,
  onModifyItem: PropTypes.func.isRequired,
  onDeleteItem: PropTypes.func.isRequired,
}
### PriceList默认属性
>    PriceList.defaultProps = {
   onModifyItem:()=>{}}
### 方法重载
+	如果有defaultProps和外来属性传入
+	覆盖默认函数


## 切换tab组件和价格组件
+	ViewTab:切换&切换项目
+	TotalPrice
### 组件属性
+	ViewTab： activeTab='list' onTabChange={onTabChange}
+	TotalPrice： income={10000} outcome = {10000}
### ViewTabs动态计算className
+	函数
+	const generateLinkClass = (current, view) => {
    return (current === view) ? "nav-link active":"nav-link" 
}
+	使用
+	   <a className = {generateLinkClass(activeTab, 'list')} href="#">
    列表模式
    </a>
+	    <a className = {generateLinkClass(activeTab, 'chart')} href="#">
    图表模式
    </a>
+	数据常量化
+	utility.js
>   export const LIST_VIEW = 'list'
>   export const CHART_VIEW = 'chart'

### ViewTabs完成   
+	ViewTabs.js
`
import { LIST_VIEW, CHART_VIEW } from '../utility'
	 import PropTypes from 'prop-types'
	 import IosCreate from 'react-ionicons/lib/IosCreate'
	 const generateLinkClass = (current, view) ={
	    return (current === view) ? "nav-link active":"nav-link" 
	 }
   	const ViewTab =({ activeTab, onTabChange })=>(
	    <ul className = "nav nav-tabs nav-fill my-4">
	    <li className =" nav-item">
	    <a className = {generateLinkClass(activeTab, LIST_VIEW)} 
	    href="#"
	    onClick = {(event) =>{event.preventDefault(); onTabChange(LIST_VIEW)} }
	    >
	    <IosCreate
	     className= "rounded-circle mr-2"
	     fontSize ="25px"
	     color = {"#007bff"}
	    />
	    列表模式
	    </a>
	    </li>
	    <li className =" nav-item">
	    <a className = {generateLinkClass(activeTab, CHART_VIEW)} 
	    href="#"
	    onClick={(event)=>{event.preventDefault(); onTabChange(CHART_VIEW)}}
	    >
	    <IosCreate
	     className= "rounded-circle mr-2"
	     fontSize ="25px"
	     color = {"#007bff"}
	    />
	    图表模式
	    </a>
	    </li>
	    </ul>
	)
	ViewTab.propTypes = {
	    activeTab:PropTypes.string.isRequired,
	    onTabChange:PropTypes.func.isRequired,
	}
	ViewTab.defaultProps = {
	    onTabChange:(view)=>{alert(view)}
	}
	export default ViewTab;
`

## TotalPrice组件
### 完成
+	import React from 'react'
+	import PropTypes from 'prop-types'
`
const TotalPrice = ( { income, outcome } ) => (
  <div className="row">
    <div className="col">
      <h5 className="income">收入：<span>{income}</span></h5>
    </div>
    <div className="col">
      <h5 className="outcome">支出：<span>{outcome}</span></h5>
    </div>
  </div>
)
TotalPrice.propTypes = {
  income: PropTypes.number.isRequired,
  outcome: PropTypes.number.isRequired,
}
export default TotalPrice
`


## 月份组件
+	功能
	+	按钮显示传入的年月，点击按钮可以打开或关闭下拉菜单
	+	显示前后4年；1-12月；显示高亮
	+	传入的年和月，打开菜单以后高亮显示
	+	点击不同的年可以切换，点击月份触发回调
### 静态组件
+	MonthPicker： year={2018} month={8} onChange={onChange}
### 分段开发
+	按钮：显示传入的年和月
+	下拉菜单，点击按钮切换：显示&隐藏
+	下拉菜单，显示2列：年&月份信息
+	两列添加选择高亮
+	点击年月交互

## 月份：下拉按钮
+	dropButton
## 月份：点击切换是否隐藏
+	state
## 月份 ：显示两列数据
+	row&col
+	生成连续数组
## 月份：显示高亮
+	className：active
+	等于特定值，高亮
##	月份：点击后的交互
+	点击年份，切换高亮
+	点击月份：关掉页面；发送OnChange回调
+	点击其他区域:关闭

## 完成
`
import React from 'react'
import PropTypes from 'prop-types'
import { padLeft, range } from '../utility'
class MonthPicker extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: false,
      selectedYear: this.props.year
    }
  }
  componentDidMount() {
    document.addEventListener('click', this.handleClick, false)
  }
  componentWillUnmount() {
    document.removeEventListener('click', this.handleClick, false)
  }
  handleClick = (event) => {
    if (this.node.contains(event.target)) {
      return;
    }
    this.setState({
      isOpen: false,
    })
  }
  toggleDropdown = (event) => {
    event.preventDefault()
    this.setState({
      isOpen: !this.state.isOpen
    })
  }
  selectYear = (event, yearNumber) => {
    event.preventDefault()
    this.setState({
      selectedYear: yearNumber
    })
  }
  selectMonth = (event, monthNumber) => {
    event.preventDefault()
    this.setState({
      isOpen: false
    })
    this.props.onChange(this.state.selectedYear, monthNumber)
  }
  render() {
    const { year, month } = this.props
    const { selectedYear } = this.state
    const { isOpen } = this.state
    const monthRange = range(12, 1)
    const yearRange = range(9, -4).map(number => number + year)
    return (
      <div className="dropdown month-picker-component" ref={(ref) => {this.node = ref}}>
        <p>选择月份</p>
        <button 
          className="btn btn-lg btn-secondary dropdown-toggle"
          onClick={this.toggleDropdown}
        >
          {`${year}年 ${padLeft(month)}月`}
        </button>
        { isOpen && 
          <div className="dropdown-menu" style={{display: 'block'}}>
            <div className="row">
              <div className="col border-right years-range">
                { yearRange.map((yearNumber, index) => 
                  <a key={index}
                    role="button"
                    onClick={(event) => {this.selectYear(event, yearNumber)}} 
                    className={(yearNumber === selectedYear) ? "dropdown-item active text-white" : "dropdown-item"}>
                    {yearNumber} 年
                  </a>  
                )}
              </div>
              <div className="col months-range">
              { monthRange.map((monthNumber, index) => 
                  <a key={index}
                    role="button"
                    onClick={(event) => {this.selectMonth(event, monthNumber)}}
                    className={(monthNumber === month) ? "dropdown-item active text-white": "dropdown-item"}>
                    {padLeft(monthNumber)} 月
                  </a>
                )}
              </div>
            </div>
          </div>
        }
      </div>
    )
  }
}

MonthPicker.propTypes = {
  year: PropTypes.number.isRequired,
  month: PropTypes.number.isRequired,
  onChange: PropTypes.func.isRequired,
}
export default MonthPicker
`

## 组合已有静态组件
+	展示型组件的组合=容器型组件
+	容器组件:数据运作,为展示型组件提供数据和回调函数
### Fragment的使用
+	React.Fragment
### state设计原则	
+	最小化state原则
+	DRY
### state
+	价格列表
+	当前年月
+	支出收入总和
+	价格条目的分类和月份信息
+	视图信息是哪一个
+ {items：[],view:'LIST_VIEW',currentDate:{year:,month:},}
### state结构优化
+	自定义字典
+	通过map添加数据
### 组件方法分析
### 方法实现
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
+	内置代码覆盖率测试
+	为React提供特殊的测试方法
## 重要概念：断言库
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
	+	virtual dom 对象，测试属性，天生隔离，单元测试良方
	+	子组件不会渲染，测试无状态组件（没有state，只有传入的属性）
+	DOM Rendering
	+	速度慢，dom渲染，可做生命周期测试
## 简单实用配置
+	npm install enzyme enzyme-adapter-react-16 --save-dev
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
## TDD 开发
## shotnap测试用例
+	src/components/__test__/PriceList.test.js
+	const props = { onModifyItem：，onDeleteItem：}
+	let wrapper
+  describe('test components',()=>{
beforeEach(()=>{
	wrapper = shallow(<PriceList {...props}/>
})
it('should render match snapshot',()=>{
	expect(wrapper).toMatchSnapshot()
})
})


+	npm test
### 长度测试
+	更改数据dom结构后可以查看是否结构变化
+	item长度
+	it('length',()=>{expect（wrapper).find('.list-group-item').length).toEqual(itemsWithCat.length)})
### 单击组件测试
+	单个item
+	it('item',()=>{
const iconList = wrapper.find('.list-group-item').first().find(IonicList)

expect(IconList.length).toEqual(3)
expect(iconList.first().props.icon)
.toEqual(itemsWithCategory[0].category.iconName)

})
### item点击测试
+	item点击
+	const props = { onModifyItem：jest.fn()，onDeleteItem：jest.fn()}
+	it('click',()=>{
const firstItem = wrapper.find('.list-group-item').first()
firstItem.find('a').first().simulate('click')

expect(props.onModifyItem).toHaveBeenCalled()
expect(props.onModifyItem).toHaveBeenCalledWith(itemsWithCAtegory[0])

})

## 月份选择单元测试
+	默认状态：是否显示正确，下拉框是否显示
+	点击状态：点击以后是否显示
+	返回状态：点击回调
+	传递特殊值：特殊值的处理
+	特殊dom事件：特殊dom的触发和处理
### dom测试
+	虚拟dom
+	模拟测试
+	点击返回
### 完成
`
import React from 'react'
import ReactDOM from 'react-dom'
import { mount } from 'enzyme'
import MonthPicker from '../MonthPicker'

let props = {
  year: 2018,
  month: 8,
  onChange: jest.fn()
}

let wrapper

describe('test MonthPicker component', () => {
  beforeEach(() => {
    wrapper = mount(<MonthPicker {...props} />)
  })
  it('should render the component to match the snapshot', () => {
    expect(wrapper).toMatchSnapshot()
  })
  it('render the correct year and month, show correct dropdown status', () => {
    const text = wrapper.find('.dropdown-toggle').first().text()
    expect(text).toEqual('2018年 08月')
    expect(wrapper.find('.dropdown-menu').length).toEqual(0)
    expect(wrapper.state('isOpen')).toEqual(false)
    expect(wrapper.state('selectedYear')).toEqual(props.year)
  })
  it('after click the button, dropdown should show, year list&month list should have the correct items', () => {
    wrapper.find('.dropdown-toggle').simulate('click')
    expect(wrapper.state('isOpen')).toEqual(true)
    expect(wrapper.find('.dropdown-menu').length).toEqual(1)
    expect(wrapper.find('.years-range .dropdown-item').length).toEqual(9)
    expect(wrapper.find('.months-range .dropdown-item').length).toEqual(12)
    expect(wrapper.find('.years-range .dropdown-item.active').text())
    .toEqual('2018 年')
    expect(wrapper.find('.months-range .dropdown-item.active').text())
    .toEqual('08 月')
    // the first year should be the current year minus 4
    expect(wrapper.find('.years-range .dropdown-item').first().text())
    .toEqual(`${props.year - 4} 年`)
    expect(wrapper.find('.months-range .dropdown-item').first().text())
    .toEqual('01 月')
  })
  it('click the year&month item, should trigger the right status change', () => {
    wrapper.find('.dropdown-toggle').simulate('click')
    wrapper.find('.years-range .dropdown-item').first().simulate('click')
    expect(wrapper.find('.years-range .dropdown-item').first().hasClass('active'))
    .toEqual(true)
    expect(wrapper.state('selectedYear')).toEqual(2014)
    wrapper.find('.months-range .dropdown-item').first().simulate('click')
    expect(wrapper.state('isOpen')).toEqual(false)
    expect(props.onChange).toHaveBeenCalledWith(2014, 1)
  })
  it('after the dropdown is shown, click the document should close the dropdown', () => {
    let eventMap = {}
    document.addEventListener = jest.fn((event, cb) => {
      eventMap[event] = cb
    })
    const wrapper = mount(<MonthPicker {...props} />)
    wrapper.find('.dropdown-toggle').simulate('click')
    expect(wrapper.state('isOpen')).toEqual(true)
    expect(wrapper.find('.dropdown-menu').length).toEqual(1)
    eventMap.click({
      target: ReactDOM.findDOMNode(wrapper.instance())
    })
    expect(wrapper.state('isOpen')).toEqual(true)
    eventMap.click({
      target: document,
    })
    expect(wrapper.state('isOpen')).toEqual(false)
  })
})
`

## 首页容器型测试
+	默认状态：是否正确渲染特定组件和数据
+	测试交互：点击交互组件的state是否有修改
+	测试交互：操作触发后的展示型属性是否修改
### 完成
`
import React from 'react'
import { mount } from 'enzyme'
import { MemoryRouter } from 'react-router-dom'
import { Home }  from '../Home'
import { parseToYearAndMonth, flatternArr, LIST_VIEW, CHART_VIEW } from '../../utility'
import Loader from '../../components/Loader'
import PriceList from '../../components/PriceList'
import { Tabs } from '../../components/Tabs'
import PieChart from '../../components/PieChart'
import { testCategories, testItems } from '../../testData'

const initData = {
  categories: {},
  items: {},
  isLoading: false,
  categoriesIsLoaded: false,
  currentDate: parseToYearAndMonth()
}
const withLoadingData = {
  ...initData, isLoading: true
}
const withLoadedData = {
  categories: flatternArr(testCategories),
  items: flatternArr(testItems),
  isLoading: false,
  currentDate: parseToYearAndMonth()
}
const actions = {
  getInitalData: jest.fn(),
  selectNewMonth: jest.fn(),
  deleteItem: jest.fn()
}
it('test home container first render, without any data, getInitalData should be called', () => {
  const wrapper = mount(
    <MemoryRouter>
      <Home data={initData} actions={actions} />
    </MemoryRouter>
  )
  expect(wrapper.find('.no-record').length).toEqual(1)
  expect(actions.getInitalData).toHaveBeenCalled()
})

it('test home container with loading state, loading icon should show up', () => {
  const wrapper = mount(
    <MemoryRouter>
      <Home data={withLoadingData} actions={actions} />
    </MemoryRouter>    
  )
  expect(wrapper.find(Loader).length).toEqual(1)
})

describe('test home container with loaded data', () => {
  const wrapper = mount(
    <MemoryRouter>
      <Home data={withLoadedData} actions={actions} />
    </MemoryRouter>    
  )
  const wrapperInstance = wrapper.find(Home).instance()
  it('should show price list and view tab', () => {
    expect(wrapper.find(PriceList).length).toEqual(1)
    expect(wrapper.find(Tabs).length).toEqual(1)
    expect(wrapperInstance.state.tabView).toEqual(LIST_VIEW)
    expect(wrapper.find(Loader).length).toEqual(0)
  })
  it('click the year and month should trigger the selectNewMonth callback', () => {
    wrapper.find('.dropdown-toggle').simulate('click')
    wrapper.find('.months-range .dropdown-item').first().simulate('click')
    expect(actions.selectNewMonth).toHaveBeenCalledWith(initData.currentDate.year, 1)
  })
  it('click the item delete button should trigger the deleteItem callback', () => {
    const firstItem = wrapper.find('.list-group .list-group-item').first()
    firstItem.find('a').last().simulate('click')
    expect(actions.deleteItem).toHaveBeenCalledWith(testItems[0])
  })
  it('click the the tab should change the view and state', () => {
    wrapper.find('.nav-tabs .nav-item a').at(1).simulate('click')
    expect(wrapper.find(PriceList).length).toEqual(0)
    expect(wrapper.find(PieChart).length).toEqual(2)
    expect(wrapperInstance.state.tabView).toEqual(CHART_VIEW)
  })
})
`

# 创建页面
## 开发
### 分析需求
### 拆分组件
### 多页面开发
+	React-Router
##	SPA开发
+	web应用或者程序
+	用户交互时候用户不会跳转到其他页面
+	JS实现URL变换和动态变换html内容
+	优点
	+	第一次加载后，下载完静态文件，跳转不需要再次下载
	+	体验好，交互无缝，类原生应用
	+	前后端分离提供实践
+	框架
	+	augule
	+	react（基于view）
### ReactRouter
+	基于组件
+	声明式和可组合
+	支持多种应用：web应用或者RN应用
### 使用
+	npm install react-router-dom

## TDD开发流程
+	分析需求
+	编写测试用例
+	实现组件具体实现
### CategorySelect
+	CategorySelect ：categories:,onSelectCategory：,selectedCategory:
### 实现测试
+	先测试再组件
+	测试步骤
	+	传入数据
	+	数据高亮
	+	条目的属性
### 实现项目
+	添加显示的map和item
+	添加高亮
+	添加点击事件
### test时间
`
import React from 'react'
import { shallow } from 'enzyme'
import CategorySelect from '../CategorySelect'
import Ionicon from 'react-ionicons'

export const categories = [
   {
    "id": "1",
    "name": "旅行",
    "type": "outcome",
    "iconName": "ios-plane",    
  },
   {
    "id": "2",
    "name": "理财",
    "type": "income",
    "iconName": "logo-yen", 
  },
  {
    "id": "3",
    "name": "理财",
    "type": "income",
    "iconName": "logo-yen", 
  }
]

let props = {
  categories,
  onSelectCategory: jest.fn()
}

let props_with_category = {
  categories,
  onSelectCategory: jest.fn(),
  selectedCategory: categories[0],
}

describe('test CategorySelect component', () => {
  it('should render the component to match the snapshot', () => {
    const wrapper = shallow(<CategorySelect {...props_with_category} />)
    expect(wrapper).toMatchSnapshot()
  })
  it('renders with categories should render the correct items', () => {
    const wrapper = shallow(<CategorySelect {...props} />)
    expect(wrapper.find('.category-item').length).toEqual(categories.length)
    expect(wrapper.find('.category-item.active').length).toEqual(0)
    const firstIcon = wrapper.find('.category-item').first().find(Ionicon)
    expect(firstIcon.length).toEqual(1)
    expect(firstIcon.props().icon).toEqual(categories[0].iconName)
  })
  it('render selectedCategory with category item with highlight', () => {
    const wrapper = shallow(<CategorySelect {...props_with_category} />)
    expect(wrapper.find('.category-item').first().hasClass('active')).toEqual(true)
  })
  it('click the item should add active class and trigger the callback', () => {
    const wrapper = shallow(<CategorySelect {...props_with_category} />)
    wrapper.find('.category-item').at(1).simulate('click', { preventDefault: () => {} })
    expect(props_with_category.onSelectCategory).toHaveBeenCalledWith(categories[1])
  })
})


`
### 组件实现
`
import React from 'react'
import Ionicon from 'react-ionicons'
import PropTypes from 'prop-types'
import { Colors } from '../utility'

class CategorySelect extends React.Component {
  selectCategory = (event, category) => {
    this.props.onSelectCategory(category)
    event.preventDefault()
  }
  render() {
    const { categories, selectedCategory } = this.props
    const selectedCategoryId = selectedCategory && selectedCategory.id
    return (
      <div className="category-select-component">
        <div className="row">
        {
          categories.map((category, index) => {
            const iconColor = (category.id === selectedCategoryId) ? Colors.white : Colors.gray
            const backColor = (category.id === selectedCategoryId) ? Colors.blue : Colors.lightGray
            const activeClassName = (selectedCategoryId === category.id)
            ? 'category-item col-3 active' : 'category-item col-3'
            return (
              <div className={activeClassName} key={index} role="button" style={{ textAlign: 'center'}}
              onClick={(event) => {this.selectCategory(event, category)}}>
                <Ionicon
                  className="rounded-circle"
                  style={{ backgroundColor: backColor, padding: '5px' }} 
                  fontSize="50px"
                  color={iconColor}
                  icon={category.iconName}
                />
                <p>{category.name}</p>
              </div>
            )
          })
        }
        </div>
      </div>
    )
  }
}

CategorySelect.propTypes = {
  categories: PropTypes.array.isRequired,
  selectedCategory: PropTypes.object,
  onSelectCategory: PropTypes.func.isRequired,
}
export default CategorySelect
`

## PriceForm
+ 表单验证
	+	h5:input:type-number/number
	+	验证是否为空；验证数字大小范围
	+	
+	样式
	+	bootstrap的form	
+	回调
	+  提交成功的/失败的回调
	+  初始数据是否显示
	+  新建和编辑不同的填写状态
### 测试用例
`
import React from 'react'
import { mount } from 'enzyme'
import PriceForm from '../PriceForm'
import { testItems } from '../../testData'
let props = {
  onFormSubmit: jest.fn(),
  onCancelSubmit: jest.fn(), 
}
let props_with_item = {
  item: testItems[0],
  onFormSubmit: jest.fn(),
  onCancelSubmit: jest.fn(),
}
let wrapper, formInstance, wrapper2
export const getInputValue = (selector, wrapper) => (
  wrapper.find(selector).instance().value
)
export const setInputValue = (selector, newValue, wrapper) => {
  wrapper.find(selector).instance().value = newValue
}
describe('test PriceForm component', () => {
  beforeEach(() => {
    wrapper = mount(<PriceForm {...props} />)
    wrapper2 = mount(<PriceForm {...props_with_item} />)
    formInstance = wrapper.find(PriceForm).instance()
  })
  it('should render the component to match snapshot', () => {
    expect(wrapper).toMatchSnapshot()
    expect(wrapper2).toMatchSnapshot()
  })
  describe('test PriceForm with no item', () => {
    it('render PriceForm should generate three inputs and one form element', () => {
      expect(wrapper.find('input').length).toEqual(3)
      expect(wrapper.find('form').length).toEqual(1)
    })
    it('render PriceForm with no data should render three inputs and no value', () => {
      expect(getInputValue('#title', wrapper)).toEqual('')
      expect(getInputValue('#price', wrapper)).toEqual('')
      expect(getInputValue('#date', wrapper)).toEqual('')
    }),
    it('submit form with empty input should show alert message', () => {
      wrapper.find('form').simulate('submit')
      expect(formInstance.state.validatePass).toEqual(false)
      expect(wrapper.find('.alert').length).toEqual(1)
      expect(props_with_item.onFormSubmit).not.toHaveBeenCalled()
    })
    it('submit form with invalid price should show alert message', () => {
      setInputValue('#title', 'test', wrapper)
      setInputValue('#price', '-20', wrapper)
      wrapper.find('form').simulate('submit')
      expect(formInstance.state.validatePass).toEqual(false)
    })
    it('submit form with invalid date format should show alert message', () => {
      setInputValue('#title', 'test', wrapper)
      setInputValue('#price', '20', wrapper)
      setInputValue('#date', 'wrong date', wrapper)
      wrapper.find('form').simulate('submit')
      expect(formInstance.state.validatePass).toEqual(false)
    })
    it('submit form with valid data should call with the right object', () => {
      setInputValue('#title', 'test', wrapper)
      setInputValue('#price', '20', wrapper)
      setInputValue('#date', '2018-01-01', wrapper)
      const newItem = { title: 'test', price: 20, date: '2018-01-01'}
      wrapper.find('form').simulate('submit')
      expect(props.onFormSubmit).toHaveBeenCalledWith(newItem, false)
    })
    it('click the cancel button should call the right callback', () => {
      wrapper.find('button').last().simulate('click')
      expect(props.onCancelSubmit).toHaveBeenCalled()
    })
  })
  describe('test PriceForm with item data', () => {
    it('render PriceForm with item should render the correct data to inputs', () => {
      expect(getInputValue('#title', wrapper2)).toEqual(testItems[0].title)
      expect(getInputValue('#price', wrapper2)).toEqual(testItems[0].price.toString())
      expect(getInputValue('#date', wrapper2)).toEqual(testItems[0].date)
    }) 
    it('submit with changed value, should trigger callback with right object', () => {
      setInputValue('#title', 'new title', wrapper2)
      setInputValue('#price', '200', wrapper2)
      wrapper2.find('form').simulate('submit')
      const newItem = { ...testItems[0], title: 'new title', price: 200 }
      expect(formInstance.state.validatePass).toEqual(true)
      expect(wrapper2.find('.alert').length).toEqual(0)
      expect(props_with_item.onFormSubmit).toHaveBeenCalledWith(newItem, true)
    })
  })
})
`

### 实际组件
`
import React from 'react'
import PropTypes from 'prop-types'
import { isValidDate } from '../utility'

class PriceForm extends React.Component {
  static propTypes = {
    onFormSubmit: PropTypes.func.isRequired,
    onCancelSubmit: PropTypes.func.isRequired,
    item: PropTypes.object,
  }
  static defaultProps = {
    item: {}
  }
  state = {
    validatePass: true,
    errorMessage: '',
  }
  sumbitForm = (event) => {

    const { item, onFormSubmit } = this.props
    const editMode = !!item.id
    const price = this.priceInput.value.trim() * 1
    const date = this.dateInput.value.trim()
    const title = this.titleInput.value.trim()
    if (price && date && title) {
      if (price < 0) {
        this.setState({
          validatePass: false,
          errorMessage: '价格数字必须大于0'
        })     
      } else if (!isValidDate(date)) {
        this.setState({
          validatePass: false,
          errorMessage: '请填写正确的日期格式'
        })
      } else {
        this.setState({
          validatePass: true,
          errorMessage: ''
        })
        if (editMode) {
          onFormSubmit({ ...item, title, price, date }, editMode)
        } else {
          onFormSubmit({ title, price, date }, editMode)
        }
      }
    } else {
      this.setState({
        validatePass: false,
        errorMessage: '请输入所有必选项'
      })
    }
    event.preventDefault()
  }
  render() {
    const { title, price, date } = this.props.item
    return (
      <form onSubmit={(event) => {this.sumbitForm(event)}} noValidate>
        <div className="form-group">
          <label htmlFor="title">标题 *</label>
          <input 
            type="text" className="form-control" 
            id="title" placeholder="请输入标题"
            defaultValue={title}
            ref={(input) => {this.titleInput = input}}
          />
        </div>
        <div className="form-group">
          <label htmlFor="price">价格 *</label>
          <div className="input-group">
            <div className="input-group-prepend">
              <span className="input-group-text">¥</span>
            </div>
            <input 
              type="number" 
              className="form-control" 
              defaultValue={price}
              id="price" placeholder="请输入价格" 
              ref={(input) => {this.priceInput = input}}  
            />
          </div>
        </div>
        <div className="form-group">
          <label htmlFor="date">日期 *</label>
          <input 
            type="date" className="form-control" 
            id="date" placeholder="请输入日期"
            defaultValue={date}
            ref={(input) => {this.dateInput = input}}  
          />
        </div>
        <button type="submit" className="btn btn-primary mr-3">提交</button>
        <button className="btn btn-secondary" onClick={this.props.onCancelSubmit}> 取消 </button>
        { !this.state.validatePass &&
          <div className="alert alert-danger mt-5" role="alert">
            {this.state.errorMessage}
          </div>
        }
      </form>
    )
  }
}

export default PriceForm
`

## 重构ViewTab组件
### 原因
+	修改不足
	+	可扩展
	+	可定制
+	<Tabs onSelectTab={} activeTabInde={0}>
+	<Tab>
### children属性
+	Children
	+	可以是func，string或者组件
+	React.Children.map()
	+	去掉不可以map的children数据
	+	React.Children.map(this.props.children,(child,index)=>{})
### 完成Tabs和Tab
`
import React from 'react'
import PropTypes from 'prop-types'

export class Tabs extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      activeIndex: props.activeIndex
    }
  }
  tabChange = (event, index) => {
    event.preventDefault()
    this.setState({
      activeIndex: index
    })
    this.props.onTabChange(index)
  }
  render() {
    const { children } = this.props
    const { activeIndex } = this.state
    return ( 
      <ul className="nav nav-tabs nav-fill my-4">
        {React.Children.map(children, (child, index) => {
          const activeClassName = (activeIndex === index) ? 'nav-link active' : 'nav-link'
          return (
            <li className="nav-item">
              <a
                onClick={(event) => { this.tabChange(event, index)}}
                className={activeClassName}
                role="button"
              >
                {child}
              </a>
            </li>
          )
        })}
      </ul>
    )
  }
}
Tabs.propTypes = {
  activeIndex: PropTypes.number.isRequired,
  onTabChange: PropTypes.func.isRequired,
}

export const Tab = ({ children }) => 
<React.Fragment>{children}</React.Fragment>


`

### Tabs和Tab使用
`
            <Tabs activeIndex={tabIndex} onTabChange={this.changeView}>
              <Tab>
                <Ionicon 
                  className="rounded-circle mr-2" 
                  fontSize="25px"
                  color={Colors.blue}
                  icon='ios-paper'
                />
                列表模式
              </Tab>
              <Tab>
                <Ionicon 
                  className="rounded-circle mr-2" 
                  fontSize="25px"
                  color={Colors.blue}
                  icon='ios-pie'
                />
                图表模式
              </Tab>
            </Tabs>
`

+	const tabsText = [LIST_VIEW, CHART_VIEW]
+	  changeView = (index) => {
    this.setState({
      tabView: tabsText[index],
    })
  }

## Create静态页面组合
### 初始页面
`
      <div className="create-page py-3 px-3 rounded mt-3" style={{background: '#fff'}}>
        { data.isLoading &&
          <Loader />
        }
        <Tabs activeIndex={tabIndex} onTabChange={this.tabChange}>
          <Tab>支出</Tab>
          <Tab>收入</Tab>
        </Tabs>
        <CategorySelect categories={filterCategories} 
          onSelectCategory={this.selectCategory}
          selectedCategory={selectedCategory}
        />
        <PriceForm 
          onFormSubmit={this.submitForm}
          onCancelSubmit={this.cancelSubmit}
          item={editItem}
        />
        { !validationPassed &&
          <div className="alert alert-danger mt-5" role="alert">
            请选择分类信息
          </div>
        }
      </div>
`
### 设计和添加test
`
import React from 'react'
import { mount } from 'enzyme'
import { MemoryRouter } from 'react-router-dom'
import { CreatePage }  from '../Create'
import { parseToYearAndMonth, flatternArr, TYPE_OUTCOME } from '../../utility'
import Loader from '../../components/Loader'
import CategorySelect from '../../components/CategorySelect'
import PriceForm from '../../components/PriceForm'
import { testCategories, testItems } from '../../testData'

const testItem = testItems[0]
const match = { params: { id: testItem.id } }
const history = { push: () => {} }
const createMatch = { params: { id: '' } }

const initData = {
  categories: {},
  items: {},
  isLoading: false,
  currentDate: parseToYearAndMonth()
}

const actions = {
  getEditData: jest.fn().mockReturnValue(Promise.resolve({ editItem: testItem, categories: flatternArr(testCategories)})),
  updateItem: jest.fn().mockReturnValueOnce(Promise.resolve('')),
  createItem: jest.fn().mockReturnValueOnce(Promise.resolve(''))
}

const withLoadedData = {
  categories: flatternArr(testCategories),
  items: flatternArr(testItems),
  isLoading: false,
  currentDate: parseToYearAndMonth()
}

const loadingData = {
  ...initData, isLoading: true
}

describe('test component init behavior', () => {
  it('test Create page for the first render, getEditData should be called with the right params', () => {
    const wrapper = mount(
      <MemoryRouter>
        <CreatePage data={initData} actions={actions} match={match} />
      </MemoryRouter>
    )
    expect(actions.getEditData).toHaveBeenCalledWith(testItem.id)
  })
  it('shoud show loading component when isLoaidng is true', () => {
    const wrapper = mount(
      <MemoryRouter>
        <CreatePage data={loadingData} actions={actions} match={match} />
      </MemoryRouter>
    )
    expect(wrapper.find(Loader).length).toEqual(1)
  })
})

describe('test component when in create mode', () => {
  const wrapper = mount(
    <MemoryRouter>
      <CreatePage data={withLoadedData} actions={actions} match={createMatch} history={history} />
    </MemoryRouter>
  )
  const setInputValue = (selector, newValue) => {
    wrapper.find(selector).instance().value = newValue
  }
  it('should pass the null to props selectedCategory for CategorySelect', () => {
    expect(wrapper.find(CategorySelect).props().selectedCategory).toEqual(null)
  })
  it('should pass empty object for PriceForm', () => {
    expect(wrapper.find(PriceForm).props().item).toEqual({})
    expect(wrapper.find(CreatePage).state('selectedTab')).toEqual(TYPE_OUTCOME)
  })
  it('submit the form, the addItem should not be triggered', () => {
    wrapper.find('form').simulate('submit')
    expect(actions.createItem).not.toHaveBeenCalled()
  })
  it('fill all inputs, and select the category, submit the form, addItem should be called', () => {
    setInputValue('#title', 'new title')
    setInputValue('#price', '200')
    setInputValue('#date', '2018-08-30')
    wrapper.find('.category-item').first().simulate('click')
    wrapper.find('form').simulate('submit')
    const testData = {title: 'new title', price: 200 , date: '2018-08-30'}
    expect(actions.createItem).toHaveBeenCalledWith(testData, testCategories[0].id)
  })
})

describe('test component when in edit mode', () => {
  const wrapper = mount(
    <MemoryRouter>
      <CreatePage data={withLoadedData} actions={actions} match={match} history={history} />
    </MemoryRouter>
  )
  const setInputValue = (selector, newValue) => {
    wrapper.find(selector).instance().value = newValue
  }
  const selectedCategory = testCategories.find(category => testItem.cid === category.id)
  it('should pass the right category to props selectedCategory for CategorySelect', () => {
    wrapper.update()
    expect(wrapper.find(CategorySelect).props().selectedCategory).toEqual(selectedCategory)
  })
  it('modify some inputs submit the form, modifyItem should be called', () => {
    setInputValue('#title', 'new title')
    wrapper.find('form').simulate('submit')
    const testData = {...testItem, title: 'new title'}
    expect(actions.updateItem).toHaveBeenCalledWith(testData, selectedCategory.id)
  })
})

`

## 分析和优化整体state
+	状态提升
	+	把所有的共享数据放在app的state中
+	最小可变状态集合
+	选择
	+	filter
+	调整
	+	map filter 更新
### 调整
+	把item改成键值对形式
+	item：数组-object
	+	const items ={"1":{...item},"2":{},}
	+	const selectedItem = items[selectedId]
	+	const modifiedItems = {...items,[modifiedItem.id]:modifiedItem}
	+	delete items[deletedId]
	+	const filteredItems = {...items}	
+	Flatten State
	+	把复杂的嵌套结构变得扁平
	+	使用对象的id打通数据之间的依赖关系
+	优势
	+	数据冗余
	+	数据处理更有效率
![](https://i.imgur.com/8Svj49l.png)

### 全局state传递
+ 一个组件的状态不通过Props传递给子组件
+ Redux
	+	为js提供一个可预测的状态容器
	+	特殊数据结构
	+	使用特殊方法实现数据更改
	+	不是React特有的
+ 解决方案
	+	创建
	+	global.js
`	let data = {
	items:[],
	users:[],
	actions:{
		addItem:async(id) =>{
		const item = await fetch(`/users/$id}`)
		data.items.push(item)
		}	
	}
}
	export default data;
`
	+	some-shitty-file.js
`
	import data from './global'
	data.actions.addItem('2')
`
### Redux解决方法
+ 全局store
+ const store = Redux.createStore(reducer)
+ store.getState()
+ store.dispath({type:,data})
+  store.dispath({type:,username:})
+  缺点
	+	学习成本
	+	增加数据流复杂度
	+	增加太多模板 （Boilerplate） 代码
### Context后的数据流
![](https://i.imgur.com/OexFa7D.png)

## 添加context
### 数据flattern
`
export const flatternArr = (arr) => {
  return arr.reduce((map, item) => {
    map[item.id] = item
    return map
  }, {})
}

`
### Provider
+	数据获取
`
        this.setState({
          items: flatternArr(items.data),
          categories: flatternArr(categories.data),
          isLoading: false,
        })
`
+ 实现
`
   <AppContext.Provider value={{
        state: this.state,
        actions: this.actions,
      }}>
      <Router>
        <div className="App">
          <div className="container pb-5">
            <Route path="/" exact component={Home} />
            <Route path="/create" component={Create} />
            <Route path="/edit/:id" component={Create} />
          </div>
        </div>
      </Router>
      </AppContext.Provider>
`
### Consumer
+ 低级版本
`
<AppContext.Consumer>
{
	({ state }) =>{
	return (
	 <div className="create-page py-3 px-3 rounded mt-3" style={{background: '#fff'}}>
        { data.isLoading &&
          <Loader />
        }
        <Tabs activeIndex={tabIndex} onTabChange={this.tabChange}>
          <Tab>支出</Tab>
          <Tab>收入</Tab>
        </Tabs>
        <CategorySelect categories={filterCategories} 
          onSelectCategory={this.selectCategory}
          selectedCategory={selectedCategory}
        />
        <PriceForm 
          onFormSubmit={this.submitForm}
          onCancelSubmit={this.cancelSubmit}
          item={editItem}
        />
        { !validationPassed &&
          <div className="alert alert-danger mt-5" role="alert">
            请选择分类信息
          </div>
        }
      </div>
		)
	}
}
</AppContext.Consumer>
`
+ 高级版本
`
const withContext = (Component) => {
  return (props) => (
    <AppContext.Consumer>
      {({ state, actions }) => {
        return <Component {...props} data={state} actions={actions} />
      }}
    </AppContext.Consumer>
  )
}

export default withContext
`

### 高阶组件HOC
+	一个函数：接受一个组件为参数，并返回一个新的组件
	+	const HomeWithContext = withContext(Home)
	+	传递Cousumer.state给Home组件作为props使用
	+	<Home {...props} data={state}>
+	比如：React-Router中的WithRouter
+	解决组件逻辑重用的一种技术
+	创建
`
import React from 'react'
import { AppContext } from './AppContext'

const withContext = (Component) => {
  return (props) => (
    <AppContext.Consumer>
      {({ state, actions }) => {
        return <Component {...props} data={state} actions={actions} />
      }}
    </AppContext.Consumer>
  )
}

export default withContext
`
+	使用
`
export default withRouter(withContext(CreatePage))
export default withRouter(withContext(Home))
`

## 整合页面交互
### home
+ withRouter
+ Create.js
	+ 单击跳转：	  createItem = () => {
    this.props.history.push('/create')
  }
	+ 单机修改：  modifyItem = (item) => {
    this.props.history.push(`/edit/${item.id}`)
  }
	+ 单机删除：app.js填写函数；withContext传递actions；子组件调用;  deleteItem = (item) => {
    this.props.actions.deleteItem(item)
  }

`
 app.js
  constructor(props) {
    super(props)
    this.state = {
      items: {},
      categories: {},
      isLoading: false,
      currentDate: parseToYearAndMonth(),
    }
    const withLoading = (cb) => {
      return (...args) => {
        this.setState({
          isLoading: true
        })
        return cb(...args)
      }
    }
    this.actions = {
      getInitalData: withLoading(async () => {
        const { currentDate } = this.state
        const getURLWithData = `/items?monthCategory=${currentDate.year}-${currentDate.month}&_sort=timestamp&_order=desc`
        const results = await Promise.all([axios.get('/categories'), axios.get(getURLWithData)])
        const [ categories, items ] = results
        this.setState({
          items: flatternArr(items.data),
          categories: flatternArr(categories.data),
          isLoading: false,
        })
        return { items, categories }
      }),
      getEditData: withLoading(async (id) => {
        const { items, categories } = this.state
        let promiseArr = []
        if (Object.keys(categories).length === 0) {
          promiseArr.push(axios.get('/categories'))
        }
        const itemAlreadyFetched = !!(Object.keys(items).indexOf(id) > -1)
        if (id && !itemAlreadyFetched) {
          const getURLWithID = `/items/${id}`
          promiseArr.push(axios.get(getURLWithID))
        }
        const [ fetchedCategories , editItem ] = await Promise.all(promiseArr)

        const finalCategories = fetchedCategories ? flatternArr(fetchedCategories.data) : categories
        const finalItem = editItem ? editItem.data : items[id]
        if (id) {
          this.setState({
            categories: finalCategories,
            isLoading: false,
            items: { ...this.state.items, [id]: finalItem },
          })
        } else {
          this.setState({
            categories: finalCategories,
            isLoading: false,
          })         
        }
        return {
          categories: finalCategories,
          editItem: finalItem,
        }
      }),
      selectNewMonth: withLoading(async (year, month) => {
        const getURLWithData = `/items?monthCategory=${year}-${month}&_sort=timestamp&_order=desc`
        const items = await axios.get(getURLWithData)
        this.setState({
          items: flatternArr(items.data),
          currentDate: { year, month },
          isLoading: false,
        })
        return items
      }),
      deleteItem: withLoading(async (item) => {
        const deleteItem = await axios.delete(`/items/${item.id}`)
        delete this.state.items[item.id]
        this.setState({
          items: this.state.items,
          isLoading: false,
        })
        return deleteItem
      }),
      createItem: withLoading(async (data, categoryId) => {
        const newId = ID()
        const parsedDate = parseToYearAndMonth(data.date)
        data.monthCategory = `${parsedDate.year}-${parsedDate.month}`
        data.timestamp = new Date(data.date).getTime()
        const newItem = await axios.post('/items', { ...data, id: newId, cid: categoryId })
        this.setState({
          items: { ...this.state.items, [newId]: newItem.data },
          isLoading: false,
        })
        return newItem.data
      }),
      updateItem: withLoading(async (item, updatedCategoryId) => {
        const modifiedItem = {
          ...item,
          cid: updatedCategoryId,
          timestamp: new Date(item.date).getTime()
        }
        const updatedItem = await axios.put(`/items/${modifiedItem.id}`, modifiedItem)
        this.setState({
          items: { ...this.state.items, [modifiedItem.id]: modifiedItem },
          isLoading: false,
        })
        return updatedItem.data
      })
    }
  }
`

### create
+	提交
+	修改

`
  cancelSubmit = () => {
    this.props.history.push('/')
  }
  submitForm = (data, isEditMode) => {
    if (!this.state.selectedCategory) {
      this.setState({
        validationPassed: false
      })
      return
    }
    if(!isEditMode) {
      // create
      this.props.actions.createItem(data, this.state.selectedCategory.id).then(this.navigateToHome)
    } else {
      // update 
      this.props.actions.updateItem(data, this.state.selectedCategory.id).then(this.navigateToHome)
    }
    this.props.history.push('/')
    
  }
`

### 条目类别的验证
### edit页面
+	得到条目id
+	筛选数据
`
  componentDidMount() {
    const { id } = this.props.match.params
    this.props.actions.getEditData(id).then(data => {
      const { editItem, categories } = data
      this.setState({
        selectedTab: (id && editItem) ? categories[editItem.cid].type : TYPE_OUTCOME,
        selectedCategory: (id && editItem) ? categories[editItem.cid] : null,        
      })
    })
  }
`
+	子组件调用&父组件写函数
### 阶段总结
![](https://i.imgur.com/ESPxRzu.png)

### 开发流程
+	原型图分析
+	页面1，2，3
+	展示型组件开发（单元测试编写）
+	多页面组合
+	整合应用状态和逻辑交互（state设计原则，多层传递props方法）

----------
# 后端Mock环境
+	附属
+	前端工程化
+	h5&js进化
+	RN&小程序&PWA
## 开发模式
+	过往
	1.	提出需求
	2.	前端页面
	3.	翻译模板
	4.	前后端对接
	5.	集成遇到问题
	6.	前端返工
	7.	后端返工
	8.	二次集成
	9.	集成成功
	10.	交付上线
+	分离交互
	1.	定制接口
	2.	前端开发（mock数据），后端开发
	3. 连调
	4. 交互
+	优点
	1.	效率
	2.	静益团对
	3.	专精，面对复杂多变需求
	4.	代码可维护性
## Mock Server
+	开发:express，koa
+	优秀特质：jsonServer
	+	快速搭建
	+	支持标准Restful操作
	+	支持标准Restful路由规则
	+	进阶扩展：自定义路由，中间件支持等
### 使用
+	npm　install json-server --save-dev
+	新建文件 db.json
+	package.json-script-添加命令："mock":"json-server --watch db.json"
+	npm run mock
### 分析应用的接口
+	/items get/post
+	/items/{id} get/put/delete
+	/items?monthCategory=2018-8&_sort=timestamp get
+	/categorier -get/post
+	/categories/{id} get/put/delete
### postman 测试API接口
+	多系统
+	界面简单
+	API测试导出，方便移植
+	请求不同：put全部替换；patch部分替换
# 动静结合
+	下一代的http库axios
+	原生XHR
+	$.ajax
+	fetch
	+	只对网络请求报错，对400，500当作成功的请求
	+	默认不会带cookie
	+	不支持abort，不支持超时控制
	+	没办法原生检测请求的进度
## axios
+	浏览器和node都可以用
+	支持标准的PromiseAPI
+	简单易用API
+	取消请求，json数据自动转换
## 使用
+	npm install axios --save
+	npm run mock --port 3004
+	npm start
+	npm install concurrently --save
	+	多个命令一起用
	+	package.json "start":"concurrently \"react-scripts start\" \"npm run mock"",
### 多个命令
+	concurrently
### 简单实用
+	axios.get("/items").then()
+	cors：协议，端口，域名不一样
+	jsonp，服务器端开启 cors
+	package.json 最外层添加
	+	"proxy":"http://localhost:3004"
### asyn改造
+	Promies. wait
+	async await
### loader
+	Loader.js:Iconion
+	转态指示是否Loader：        { data.isLoading &&
          <Loader />
        }
### loading优化
+	    const withLoading = (cb) => {
      return (...args) => {
        this.setState({
          isLoading: true
        })
        return cb(...args)
      }
    }
### 优化网络请求
+	loaderItemIds：[]
# 图标组件分析  
## 类库选择
+	如何选择
	+	搜索：react charts library
	+	github搜索：star，issure
	+	npm-stat：查看每天下载量
	+	npm-view：查看发布频率
	+	选定Recharts
+	npm install recharts --save
## demo学习
+	Recharts方法:组合式组件
+	先实例在API
## 数据源处理
+	generatePieCharts


# tips 
+ Promise
+ Asynic
+ 网络请求未完成