
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
+	css一旦在一个文件中引入，在JSX文件中全局通用
+	一般使用：styled-components进行管理
## 	项目改写
+	yarn add styled-components
+	style.css 改写为 style.js
+	import style.js
+	![](https://i.imgur.com/yVzpo6h.png)
+	搜索reset.css，复制内容在global中

## 头部区块
+	src/common/header/index.js ->class Header
+	src/common/header/style.js
+	style.js
+	![](https://i.imgur.com/jCl8lUT.png)
+	import {HeaderWrapper,Logo} from './style';
>	<HeaderWrapper><Logo href = '/'/></HeaderWrapper>

## Nav
