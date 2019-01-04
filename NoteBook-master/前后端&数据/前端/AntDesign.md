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
+	disabled：disabled={!hasSelected}
+	loading： loading={loading}
+	ghost
+	button 嵌套Icon
+	ButtonGroup
### Table
+ columns:title,dataIndex,(key),render(text,record,idnex)
+ data:key,column_a,column_b,......	 
+	可选择:rowSelection
>		<Table rowSelection={rowSelection} columns={columns} dataSource={data} />
			const rowSelection = {
			  onChange: (selectedRowKeys, selectedRows) => {
			    console.log(`selectedRowKeys: ${selectedRowKeys}`, 'selectedRows: ', selectedRows);
			  },
			  getCheckboxProps: record => ({
			    disabled: record.name === 'Disabled User', // Column configuration not to be checked
			    name: record.name,
			  }),
			};

+	选择后操作
+	rowSelection.selectedRowKeys,onChange
	+	state:selectedRowKeys:[],loading:false
	+	loading后的操作方法：start=()=>{state,动作	}
	+	更改selectedRowKeys方法： onSelectChange = (selectedRowKeys) => {}
	+   render:接收state:const { loading, selectedRowKeys } = this.state;
	+	传递state: const rowSelection = {
      selectedRowKeys,
      onChange: this.onSelectChange,
    };
	+	使用state: Table rowSelection={rowSelection} 	columns={columns} dataSource={data}


>		class App extends React.Component {
		  state = {
		    selectedRowKeys: [], // Check here to configure the default column
		    loading: false,
		  };
		  start = () => {
		    this.setState({ loading: true });
		    // ajax request after empty completing
		    setTimeout(() => {
		      this.setState({
		        selectedRowKeys: [],
		        loading: false,
		      });
		    }, 1000);
		  }
		  onSelectChange = (selectedRowKeys) => {
		    console.log('selectedRowKeys changed: ', selectedRowKeys);
		    this.setState({ selectedRowKeys });
		  }
		  render() {
		    const { loading, selectedRowKeys } = this.state;
		    const rowSelection = {
		      selectedRowKeys,
		      onChange: this.onSelectChange,
		    };
		    const hasSelected = selectedRowKeys.length > 0;
		    return (
		      <div>
		        <div style={{ marginBottom: 16 }}>
		          <Button
		            type="primary"
		            onClick={this.start}
		            disabled={!hasSelected}
		            loading={loading}
		          >
		            Reload
		          </Button>
		          <span style={{ marginLeft: 8 }}>
		            {hasSelected ? `Selected ${selectedRowKeys.length} items` : ''}
		          </span>
		        </div>
		        <Table rowSelection={rowSelection} columns={columns} dataSource={data} />
		      </div>
		    );
		  }
		}
		ReactDOM.render(<App />, mountNode);

+	自定义选择项
+	rowSelection.selections,selectedRowKeys，onChange,hideDefaultSelections,onSelection
+	selections: [{
		key: 'all-data',
        text: 'Select All Data',
        onSelect: () => {}]
> 	class App extends React.Component {
	  state = {
	    selectedRowKeys: [], // Check here to configure the default column
	  };
	  onSelectChange = (selectedRowKeys) => {
	    console.log('selectedRowKeys changed: ', selectedRowKeys);
	    this.setState({ selectedRowKeys });
	  }
	  render() {
	    const { selectedRowKeys } = this.state;
	    const rowSelection = {
	      selectedRowKeys,
	      onChange: this.onSelectChange,
	      hideDefaultSelections: true,
	      selections: [{
	        key: 'all-data',
	        text: 'Select All Data',
	        onSelect: () => {
	          this.setState({
	            selectedRowKeys: [...Array(46).keys()], // 0...45
	          });
	        },
	      }, {
	        key: 'odd',
	        text: 'Select Odd Row',
	        onSelect: (changableRowKeys) => {
	          let newSelectedRowKeys = [];
	          newSelectedRowKeys = changableRowKeys.filter((key, index) => {
	            if (index % 2 !== 0) {
	              return false;
	            }
	            return true;
	          });
	          this.setState({ selectedRowKeys: newSelectedRowKeys });
	        },
	      }, {
	        key: 'even',
	        text: 'Select Even Row',
	        onSelect: (changableRowKeys) => {
	          let newSelectedRowKeys = [];
	          newSelectedRowKeys = changableRowKeys.filter((key, index) => {
	            if (index % 2 !== 0) {
	              return true;
	            }
	            return false;
	          });
	          this.setState({ selectedRowKeys: newSelectedRowKeys });
	        },
	      }],
	      onSelection: this.onSelection,
	    };
	    return (
	      <Table rowSelection={rowSelection} columns={columns} dataSource={data} />
	    );
	  }
	}
	ReactDOM.render(<App />, mountNode);
+	筛选和排序
+	filterDropdownVisible ,filterDropdownVisibleChange,filterDropdown
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