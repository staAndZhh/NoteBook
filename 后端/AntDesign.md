# dva
##	功能说明
+	基于React和Redux(热替换，动态加载，RN，SSR)
+	定义路由
+	编辑UI组件
+	定义model(同步reducer,异步effects,connect)
	+	namespace
	+	state
	+	reducers
+	构建 npm run build
##	组件
### 按钮
+	type:主按钮、次按钮、虚线按钮、危险按钮
+	Icon:circle,search
+	size:large,small
+	disabled
+	loading
+	ghost
+	button 嵌套Icon
+	ButtonGroup

###	Icon
+	type

###	Grid栅格
+	row col 1-24
+	span
+	gutter 
+	offset
+	push pull
+	flex(Row flex)
+	响应式布局（xs sm	 md lg xl)

###	Layout布局
+	Layout
+	Header
+	Slider
+	Content
+	Footer

###	下拉菜单
+	Menu
+	Menu.Item
+	Submenu
+	MenuItemGroup 

###	Pagination分页


##	项目
###	集成pro项目框架
1.	npm install ant-design-pro-cli -g
2.	mkdir my-project && cd my-project
3.	pro new  # 安装脚手架
4.	npm install
5.	npm start

###	集成dva框架
2.	npm install dva-cli -g
3.	dva -v
4.	dva new dva-quickstart
5.	cd dva-quickstart
6.	npm start
####	使用antd在dva中
1.	npm install antd babel-plugin-import --save
2.	编辑.webpackrc文件，让babel-plugin-import 插件生效
>	+  "extraBabelPlugins": [
+    ["import", { "libraryName": "antd", "libraryDirectory": "es", "style": "css" }]
+  ],
3.	路由
4.	UI组件
5.	Model
6.	connect
7.	构建