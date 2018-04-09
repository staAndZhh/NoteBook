# 平台
+	[http://www.yushu.im/](http://www.yushu.im/)
+	把自己的不要的书免费赠送给别人
+	![](https://i.imgur.com/7qoEqdX.png)
#	环境
+	python
+	virtualenv
+	virtualenvwrapper
+	pipenv
+	flask
## pipenv
+	pip install pipenv
+	进入项目目录
+	pipenv install 创建虚拟环境
+	pip list
+	pipenv shell 进入虚拟环境
+	pipenv install flask
+	exit 推出
+ 	pipenv uninstall flask
+	pipenv graph 查看依赖关系
+	pipenv -venv 查看虚拟环境安装位置
## 开发工具
+ 	pycharm
+	Xampp
+	Navicat

#	base使用
##	自动重启
+	app.run(debuy=True)
##	路由注册
+	装饰器
+	@app.route('xx')
+ 	url参数
+	app.add_url_rule('xx',view_func = xxx)

![](https://i.imgur.com/yiQZVu0.png)

+	基于函数的视图
+	基于类的视图(即插试图，必须用url_rule)
##	设置ip访问
+	app.run(host='0.0.0.0',debug=True,
port=81)
## 配置文件
+	项目目录下新建config.py
> DEBUG = True

+	app中引用方法1
>	from config import DEBUG
>		app.run(host='0.0.0.0',debug=DEBUG,
port=81)

+	app中引用方法2
+	app.config.from_object('模块路径')
+	使用方式类似字典
>	app.config.from_object('config')
>	app.run(host='0.0.0.0',debug=app.config['DEBUG'],
port=81)

+ from_object方法的键值，变量名称必须全部大写，小写的会忽略掉
+	所有配置文件所有名字都大写
## 视图函数
+	默认return 中添加了 status content-type=text/html等
+	返回了封装的Response
+	from flask import make_response

![](https://i.imgur.com/R8pcTBi.png)

![](https://i.imgur.com/hMP3GNa.png)

+ return 'xxx',301,headers
+ 返回json :content-type:application/json
+ web返回的本质都是文本，看content-type决定返回的解析方式

# 功能设计
## 搜索书籍
+	使用外部API
	+	ISBN搜索 http://t.yushu.im/v2/book/isbn/{isbn}
	+	关键字搜索 http://t.yushu.im/v2/book/search?q={}&start={}&count={}

### 接受用户传递的参数
+	视图传递
	+	@app.route('/book/search/<q>/<page>'）
>		from helper import is_isbn_or_key
>		from yushu_book import YuShuBook
	@app.route('/book/search/<q>/<page>'）
	def search(q,page):
		isbn_or_key = is_isbn_or_key(q)
		if isbn_or_key == 'isbn':
			result = YuShuBook.search_by_isbn(q)
		else 
			result = YuShuBook.search_by_keyword(q)
		return json.dumps(result),200,{'content-type':'application/json'}
		return jsonify(result)


+	填写判断函数（静态方法）:
![](https://i.imgur.com/usVJt8w.png)
+ 	使用httper填写调用API请求
![](https://i.imgur.com/o8w2BSp.png)
+ 	调用API函数
![](https://i.imgur.com/wMmGZFZ.png)

+	使用？q=xx&page=xx传递参数
	+	Request Response
	+	from flask import reaquest
	+	q= request.args['p']
	+	a = request.args.to_dict()
	+	使用必须由请求来出发，必须在flask上下文中

### 参数验证
+	pip install wtforms 
	+ 	新建form文件夹在app中
	+	新建form/book.py

![](https://i.imgur.com/8ieUS2x.png)

+	使用在book中
	+ from app.forms.book import SearchForm
	+ form = SearchForm(request.args)
>	if form .validate():
			q = form.q.data
			page = form.page.data
			xxxx
	else:
			xxxx

![](https://i.imgur.com/YGZm3mg.png)


### 错误信息
+ return jsonify(form.errors) 
+	q =StringFiled(validators = [DaraRequired(),Length(min=1,max=30,message='')])

## 模块拆包
### 入口文件（启动）
![](https://i.imgur.com/pKF47GW.png)
### 参数拆分
+	page转 count
![](https://i.imgur.com/rywuDzO.png)

####	配置文件
+	app\secure.py
+	app\setting.py
+	setting配置开发环境，生成环境相同的配置的文件
+	secure保存机密信息和不同的配置信息，单独的配置
+	app\__init__.py
	+   app.config.from_object('app.secure')
	+	app.config.from_object(app.setting')
+	from flask import current_app
+	current_app.config['PER_PAGE']

![](https://i.imgur.com/nKE7cZa.png)

### 蓝图 blueprint
+ 	app的__init__
+	book的__init__
+	模块导入
#### 应用初始化
+	初始化在app和不同app的__init__文件中（或者view中）
![](https://i.imgur.com/RVggpQa.png)

+	入口文件调用
+	蓝图注册的最终还是在app中
![](https://i.imgur.com/6Co4mzZ.png)

#### 蓝图初始化
+	Blueprint('xx',__name__)
+ 	@xx.router('xxx')
![](https://i.imgur.com/3IIAT0g.png)

#### 蓝图注册
+	app.register_blueprint(xx)
+	多蓝图注册同上
![](https://i.imgur.com/U91n0Pq.png)

#### 单蓝图多模块
+ app => api|cms|web|xx
+ 单蓝图管理多模块
+	app\web\__init__.py
> 	from flask import Blueprint
> 	web = Blueprint('web',__name__)
> 	from app.web import book
> 	from app.web import user
+	app\web\book.py
>	from . import web
>	@web.route('xx/xx/{q}/{page}')
>	def xx(q,page):

+	多个同上
## 原理解析
+ @app.route
+ self.add_url_rule(rule,endpoint,f,**options)
+ endpoint 空 
+ 	=>	endpoint_from_view_func(view_func)
+	=>	url_map_add(rule) 
+	=>	view_functions[endpoint]=view_func
>	
![](https://i.imgur.com/hrLtUZn.png)

## 循环引用
![](https://i.imgur.com/7OkBRxm.png)

+	模块导入只执行一次
+	fisher 自己一次，作为被导入的模块一次
+	注册路由在红线app里面，启动的是在蓝线app里面

## 数据库
+	pip install flask-sqlalchemy
+ 	model配置
![](https://i.imgur.com/69Dc1WM.png)
+ 	插入app模块
![](https://i.imgur.com/Ql1NVbX.png)
+	配置mysql
![](https://i.imgur.com/wpXTOyG.png)

+方法2： db = SQLALchemy(app)
+方法3：with app.app_context():db.create_app()

## flask源码
+ 上下文
+	应用上下文AppContext： 对象 Flask
+	请求上下午文RequestContext： 对象 request
+  使用了代理模式Local_stack
![](https://i.imgur.com/MmwW2Bb.png)

+	代码中推入context到上下文
	+	ctx = app.app_context()
	+	ctx.push()
	+	a = currnet_app 
	+	d = current_app.config['DEBUG']
	+ 	ctx.pop()
+ 	with语句(__enter__,__exit__)
	+	with app.app_context():
	+	a = currnet_app 
	+	d = current_app.config['DEBUG']
+ 	实现了上下文协议的对象使用with语句：上下文管理器
+	 __enter__, __exit__
+	上下文表达式必须返回一个上下文管理器
+	with a() as xx；
+	xx是a()对象的__enter__函数返回的对象
+	__exit__(self,exc_type,exc_value,tb)
+	exit 返回True 异常不抛出，返回false，异常跑出；什么都不返回，返回None,等价于False

![](https://i.imgur.com/wB0dK0H.png)

resource.query()

## flask多线程
+	对象是保存状态的地方
+ flask 使用字典实现线程隔离： threadName：request
+	werkzeug local Local 字典

![](https://i.imgur.com/MAGi7rx.png)

+ LocalStack
	+ s = LocalStack()
	+	s.push(1)
	+	s.top()
	+	s.pop()

![](https://i.imgur.com/yAroqwE.png)

+	线程隔离的意义

![](https://i.imgur.com/QiEWMaV.png)

+ current_app 线程隔离是没有意义的
+ flask的curent_app 是在主线程进行的，只有一个
+ request 请求一次就有一个
+	全局只有一个current_app对象

![](https://i.imgur.com/rEbWASC.png)


## ViewModel
+	数据修整
	+	数据裁剪
	+	数据修饰
	+	数据合并
+  app下新建view_model文件夹

## 单页应用与网站
+	普通网站
+	数据渲染，模板填充在服务器
+	计算在服务器

![](https://i.imgur.com/VonZUNB.png)



+	单页面应用
+	数据渲染在客户端
+	计算在JS中

![](https://i.imgur.com/oypZjJy.png)


## 	静态文件访问原理
+	应用程序静态文件
	+	默认在app下的static文件夹
	+	app = Flask(__name__,static_folder = 'xxx'，static_url_path = 'xxx')
+	蓝图静态文件
	+	web = Blueprint('web',__name__,static_folder = 'xxx'，static_url_path = 'xxx')
+	下载控制
	+ send_static_file

## 模板
+	return render_template('xx.html',data= r,data1=r1)
+	应用程序下的模板文件
	+	默认在app下的template文件夹
	+ app = Flask(__name__,template_folder = 'xxx')
+	蓝图模板文件
	+  web =  Blueprint('web',__name__,template_folder = 'xxx')

##  模板引擎 JinJa2
+	{{ data.age}} {{ data['age'] }}
+	注释 
	+	{#jinJa2#}
+	if 
	+	{% if  data.age> 18 %} {{ data.name }} {% elif data.age==18 %} <ul>do something</ul> {% endif %}
+	for
	+	 {% for foo in [1,2,3] %} {{foo}} {% endfor %}
+	字典 
	+	{% for key,valye in data.items() %} {{key}} {{value}} {% endfor %}
+	模板继承
	+	{% block head	%} xx{% endblock %}
	+	{% block content	%} xx{% content %}
	+ 	{% extends 'layout.html' %}{% block content % }  {{ super() }}xx {% endblock %}
+	过滤与管道
+	default 
	+	{{ data.name| default('xx') }} 判断属性是否存在，不是判断是否为空
+	长度
	+ {{	data| length()	}}
+	反向构建url
	+ {{	url_for('static',filename= 'test.css')	}}

## 消息闪现&变量作用域
+	flash('xxx',category = 'warning')
+	配置 SECRET_KEY = 'xxxxxxxxxxxxxxx'
+	{{%	set message = get_flashed_messages(category_filter= 'xx') %} {{ message }}
+ 	set 作用域是block
+	{{% with %}} {{% endwith %}} 作用区域是范围内

## 自定义基表
## 自定义验证器
## cookie
## 登录权限分级
#	Tips
+	json.dumps(xxx,default= lambda o:o.__dict__)
+ 	'/'.join(filter(lambda x: True if x else False,[xx,xx,xx]))