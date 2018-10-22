#------------------------first 配置和项目搭建----------------
## 配置
+	npm install -g create-react-app
+	create-react-app jianshu
+	tips: cnpm install
+	cd jianshu
+	yarn start/npm start
+	显示原生页面

##  项目改写
+	只留下：App.js,index.css,index.js
+	其他的都删除
+	**css一旦在一个文件中引入，在JSX文件中全局通用**
+   高度耦合
+	一般使用：styled-components进行样式管理

## 	项目改写
+	yarn add styled-components
+	style.css 改写为 style.js
+	import style.js
+	![](https://i.imgur.com/yVzpo6h.png)
+	搜索reset.css，复制内容在global中

##  样式统一
+   reset.css 
+   https://meyerweb.com/eric/tools/css/reset/
+   复制在globaltable中

## 项目结构
+   src
    +   common
        +   header
            +   index.js
            +   style.js  
## 头部区块
+	src/common/heaheaderder/index.js ->class Header 
+	src/common/header/style.js
+	style.js
+	![](https://i.imgur.com/jCl8lUT.png)
+	import {HeaderWrapper,Logo} from './style';
>	<HeaderWrapper><Logo href = '/'/></HeaderWrapper>

### 搜索框
### 搜索框动画
## Nav

#---------------styled- components------------------------
## styled-components
+   css in js
+   理念：移除样式与组件之间的对应关系来强制执行最佳实践
### demo
+   style.js
+   const Title = styled.h1`
  color: palevioletred;
  font-size: 1.5em;
  text-align: center;
`;

+ react
+   <Wrapper>
  <Title>Hello World, this is my first styled component!</Title>
</Wrapper>

## reset.js
## normallized.js
#------------------iconfont------------------------------
## iconfont
+   http://www.iconfont.cn/
+   http://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8d11a391&helptype=code
+ 下载对应图标
+   把iconfont导入到static中
+   把iconfont.css改为inconfont.js并修改全局样式
+   使用
+   <i class="iconfont icon-xxx"></i>
#-------------------react-transaction-group----------------
+   CSSTransition
#-------------------react-redux----------------------------


#-------------------react-redux----------------------------
#-------------------redux-devtools-extension----------------------------
+   https://github.com/zalmoxisus/redux-devtools-extension
+   配置开发工具
+   import { createStore, applyMiddleware, compose  } from 'redux';
import  reducer from './reducer';

// const store = createStore(reducer,
//     window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
// );
// export  default  store;

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const store = createStore(reducer,  composeEnhancers());
export default store;
## ------------------- 配置不同文件的reducer---------------------
+   全部的store中
+   import { combineReducers } from 'redux';
import {reducer as headerReducer } from '../common/header/store';

const reducer =  combineReducers({
    header:headerReducer
})

export default reducer;
+   header的store中 f:index.js
+   import  reducer from './reducer';
export {reducer};
## ------------------- actionCreator和constants的拆分---------------------
## ------------------- immutable.js完善state-------------------------------------
+   facebook开发
+   不可变更的对象：state，不会出问题
+   yarn add immutable
+   https://github.com/facebook/immutable-js
import * as constants from './actionTypes';
import { fromJS } from 'immutable';
const defaultState = fromJS(
    {
        focused: false
    }
);
export default (state = defaultState,action)=>{
    if(action.type === constants.SEARCH_FOCUS){
        // return {
        //     focused:true
        // };
        return state.set('focused',true);
    }
    if(action.type === constants.SEARCH_BLUR){
        return state.set('focused',false);
    }
    return state;
}
##----------------------- redux-immutable--------------
+   让最外层的state变成immutable
+   header：f：index
+   const MapStateToProps = (state)=>{

        return {
            focused: state.get('header').get('focused'),
        }
}
+   或者这样写
+   const MapStateToProps = (state)=>{

        return {
            // focused: state.get('header').get('focused'),
            focused: state.getIn(['header','focused']),
        }
}
#----------------------- 搜索框------------------------
#----------------------- ajax获取数据---------------------
+   public下创建headerList.json假数据
+   http://localhost:3000/api/headerList.json
#----------------------- 热门搜索实现换页------------------
#----------------------- 数据list初始化-------------------
#----------------------- iconfonts----------------------
#----------------------- 避免不必要的ajax内容--------------
+   没有数据的时候才请求数据
#---------------------- react-router--------------------
+   绝对路径
#---------------------- 组件拆分--------------------------
+   专题
+   列表
+   推荐
+   作者
#---------------------- Topic组件------------------------
#----------------------list组件--------------------------
#-----------------------Recommend组件--------------------
#-----------------------首页获取数据----------------------
#-----------------------获取数据优化----------------------
#-----------------------点击加载更多功能-------------------
#-----------------------返回顶部组件----------------------
#----------------------- 返回顶部组件是否隐藏--------------
#------------------------首页性能调优---------------------
+   PureComponent
+   PureComponent底层实现了shouldComponentsUpdate不用重新更改
+   PureComponent需要和immutableJs一起使用
+   否则可能出现一系列的坑
#------------------------首页跳转详情页--------------------
+   单页应用：整个网络只加载一次html
#------------------------详情页和总的store配置--------------
#------------------------获取详情页数据--------------------
#------------------------获取不同详情页数据-----------------
+ m1:动态路由
+   <Link key={index} to={'/detail/' + item.get('id')}>
+  总的页面获取
+    <Route path ="/detail/:id" exact component={Detail} />
+  详情页面获取页码
+   this.props.match.params.id
+   m2:参数传递
+   <Link key={index} to={'/detail?id=' + item.get('id')}>
+  总的页面获取
+    <Route path ="/detail" exact component={Detail} />
+  详情页面获取页码
+   this.props.location.search 结果是： ?id=2
#--------------------------登录页面-----------------------
#--------------------------登录状态切换--------------------
#--------------------------登录功能实现--------------------
+   ref获取组件的真实dom
+   styled-components的inner-ref
+   账号密码等录
+   登录成功，组件切换并跳转到主页
+   登录失败，重定向到首页
+   Redict
#--------------------------退出功能实现--------------------
#--------------------------权限认证------------------------
+  如果用户登录显示界面
+   否则重定向到首页
#--------------------------异步组件------------------------
+   不一次加载所有的组件，按需加载
+   react-loadable
+   withRouter(Detail)
