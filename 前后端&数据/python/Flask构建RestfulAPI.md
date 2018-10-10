# 和Django差别
+	flask很轻Django很重
+	flask没有标准的框架
+	只想完成功能，使用Django

# 环境
+	py3.6
+	pipenv
+	pycharm
+	xampp(mysql)
+	navicat
+	postMan(接口测试）
+	flask 1.0|flask 0.12(代码重构，机制重写，废弃2.6和3.3)

# 项目初始化
+ 	python3.6安装
+	安装pip env
+	新建项目目录
+	进入项目目录
+	使用pipenv　install 直接安装所有项目依赖包（Pipfile)
+	pipenv graph 查看所有的安装包
+	pipenv --venv 查看虚拟环境路径以及名字

# 项目创建
## 入口文件
+	项目根目录下，和项目根文件名字相同FlaskRestFulAPI.py
## 项目总的App
+	新建app文件夹
+	新建app.py文件
## 新建配置文件
+	在app文件夹下新建config包
+	在config包下新建secure.py文件
+	在config包下新建setting.py文件
##	装载配置文件
+	在app.py文件中导入配件文件
>		def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.setting')
    app.config.from_object('app.config,secure')
    return app

##	入口文件调用create_app 
+	获得flask对象创建的app
+	创建运行程序
>		from app.app import create_app
	app = create_app()
	if __name__ == '__main__':
	    app.run(debug = True)
+	运行程序：运行FlakRestFulAPI.py文件

## PostMan测试接口
+	get请求，输入localhost:5000

## 创建新的返回数据
+	app.py文件新建函数
+	使用@app.router装饰器
>		from app.app import create_app
	app = create_app()
	@app.route('/v1/user/get')
	def get_user():
	    return "I'm zhh"
	@app.route('/v1/book/get')
	def get_book():
	    return "get book"
	if __name__ == '__main__':
	    app.run(debug = True)

# 蓝图拆分视图
+	app文件夹下新建api文件夹
+	api文件夹下新建v1文件夹
+	v1文件夹下新建book,user文件
+	对应的文件夹中创建函数
+	使用蓝图对子app进行创建和使用
+	使用子app对象的router对函数进行注册
+	在flask的核心对象中定义：注册蓝图对象
+	在app的函数对象中使用并注册蓝图
>			user.py	(app.api.v1.user.py)
		from flask import Blueprint
		user = Blueprint("user",__name__)
		@user.route('/v1/user/get')
		def get_user():
	    	return "I'm zhh"	
		book.py	(app.api.v1.book.py)
		from  flask import Blueprint
		book = Blueprint("book",__name__)
		@book.route('/v1/book/get')
		def get_book():
		    return "get book"
		app.py	(app.app.py)
		from flask import Flask
		def register_buleprints(app):
		    from app.api.v1.user import user
		    from app.api.v1.book import book
		    app.register_blueprint(user)
		    app.register_blueprint(book)
		def create_app():
		    app = Flask(__name__)
		    app.config.from_object('app.config.setting')
		    app.config.from_object('app.config.secure')
		    register_buleprints(app)
		    return app

+	蓝图拆分视图缺点
+	蓝图应该拆分模块
+	视图api数量较多时，url过长

# 自定义蓝图
+	自定义红图类
+	对象中新建红图类
+	红图对象注册在蓝图上
+	蓝图对象注册在flask对象app上
+ 	蓝图前缀，添加：url_prefix
+	模仿蓝图，添加红图的方法
+	__init__
+	route方法
+	register方法
+	register优化
>		app.v1.__init__.py
>		from flask import Blueprint
	from app.api.v1 import book,user
	def create_blueprint_v1():
    # from app.api.v1.book import api as book
    # from app.api.v1.user import api as user
    bp_v1 = Blueprint('v1',__name__)
    user.api.register(bp_v1,url_prefix ='/user')
    book.api.register(bp_v1,url_prefix ='/book')
    return bp_v1
>		app.v1.book.py
>		from flask import Blueprint
	from app.libs.redprint import Redprint
	# book = Blueprint("book",__name__)
	api = Redprint('book')
	# @book.route('/v1/book/get')
	# def get_book():
	#     return "get book"
	@api.route('/get')
	def get_book():
	    return "get book"
	@api.route('/create')
	def create_book():
	    return "create book"
>		app.v1.user.py
>		from flask import Blueprint
	# user = Blueprint("user",__name__)
	api = Redprint("user")
	# @user.route('/v1/user/get')
	# def get_user():
	#     return "I'm zhh"
	@api.route('/get')
	def get_user():
	    return "I'm zhh"
>		app.libs.redprint.py
>		class Redprint:
    def __init__(self,name):
        self.name = name
        self.monud = []
    def route(self, rule, **options):
        def decorator(f):
            self.monud.append((f,rule,options))
            return f
        return decorator
    def register(self, bp, url_prefix = None):
        for f,rule,options in self.monud:
            endpoint = options.pop('endpoint',f.__name__)
            bp.add_url_rule(url_prefix+ rule,endpoint,f,**options)
>		app.app.py
>		def register_buleprints(app):
	    # from api.v1.user import user
	    # from api.v1.book import book
	    # app.register_blueprint(user)
	    # app.register_blueprint(book)
	    from api.v1 import create_blueprint_v1
	    app.register_blueprint(create_blueprint_v1(),url_prefix ='/v1')
	def create_app():
	    app = Flask(__name__)
	    app.config.from_object('app.config.setting')
	    app.config.from_object('app.config.secure')
	    register_buleprints(app)
	    return app

##	蓝图优化代码
>		app.v1.__init__.py
>		def create_blueprint_v1():
	    # from app.api.v1.book import api as book
	    # from app.api.v1.user import api as user
	    bp_v1 = Blueprint('v1',__name__)
	    user.api.register(bp_v1)
	    book.api.register(bp_v1)
	    return bp_v1
>		app.libs.redprint.py
>		class Redprint:
    def __init__(self,name):
        self.name = name
        self.monud = []
    def route(self, rule, **options):
        def decorator(f):
            self.monud.append((f,rule,options))
            return f
        return decorator
    def register(self, bp, url_prefix = None):
        if url_prefix is None:
            url_prefix = '/'+ self.name
        for f,rule,options in self.monud:
            endpoint = options.pop('endpoint',f.__name__)
            bp.add_url_rule(url_prefix+ rule,endpoint,f,**option

# Rest基本特征
+	uri来定义资源
+	使用http动词来操作资源
+	uri中不能包含动词，使用httpmethod方法来操作
+	@api.route('/'，methods =['GET'])
+	场景：内部开发API，开放API
+	标准API不适合于内部开发API
+	场景复杂
+	借口粒度比较粗，前端开发不方便
+	HTTP请求数量大幅增加
+	开放型API：只提供数据，不考虑业务逻辑
+	优点：JSON & 版本号
+	遵守REST，灵活，业务逻辑，接口

# 用户操作
+	多样性，灵活性
+	常规人：用户注册
+	第三方：产品，app，小程序，用户
+	客户端：client
+	种类非常多
+	注册形式非常多，短信，邮件，QQ，微信
+	注册，登录
+	参数，校验，接受参数