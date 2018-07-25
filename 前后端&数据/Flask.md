# Flask个性网址
## 知识
![](https://i.imgur.com/r5dIulM.png)
![](https://i.imgur.com/zozzkVR.png)
![](https://i.imgur.com/yW5yymb.png)
## 扩展
![](https://i.imgur.com/XzMzNc6.png)
![](https://i.imgur.com/IutPCH0.png)
![](https://i.imgur.com/7k1NA26.png)
## 功能
![](https://i.imgur.com/o3F5Yiy.png)
![](https://i.imgur.com/61ufiFm.png)
##	区别
![](https://i.imgur.com/G1kQZhz.png)
## 特点
+ 轻量级
+	WSGI工具箱采用WerkZeug
+	模板引擎Jinja2
+	使用BSD授权
## 微内核
+ 无默认数据库，窗体验证工具
+	保留扩增弹性，用扩展加入功能：ORM，窗体验证，文件上传，开放式身份验证

#	环境
## win
![](https://i.imgur.com/sbLlGG6.png)
## 基础
### helloworld
![](https://i.imgur.com/d6rF1OP.png)

### 带参数的helloworld
>		from flask import  Flask
	app = Flask(__name__)
	@app.route('/')
	def index():
	    return 'hello'
	@app.route('/user/<name>')
	def user(name):
	    return 'hello %s'%name	
	if __name__ =='__main__':
	    app.run(debug=True)
### 带响应码的
>		@app.route('/')
	def index():
	return '<h1>Bad Request</h1>', 400
### 多个参数
>		from flask import make_response
	@app.route('/')
	def index():
	response = make_response('<h1>This document carries a cookie!</h1>')
	response.set_cookie('answer', '42')
	return response
### 重定向
>		from flask import redirect
	@app.route('/')
	def index():
	return redirect('http://www.example.com')
### 错误函数
>	from flask import abort
### flask全局变量
+ current_app
+	g
+ 	request
+	session
### 请求钩子
+	before_first_request
+	before_request
+	after_request
+	teardown_request
## 开发
### 目录
### 配置文件
+	app | config.py
>		class Config(object):
	    pass
	class ProdConfig(Config):
	    pass
	class DevConfig(Config):
	    DEBUG = True

+	使用配置 app | main.py
>		from config import DevConfig
		app = Flask(__name__)
		app.config.from_object(DevConfig)
		@app.route('/')
		def index():
		    return make_response('hello config')
		if __name__ =='__main__':
    	app.run()
### 脚本扩展
+	pip install flask-script
+	app | main .py
>		app = Flask(__name__)
	app.config.from_object(DevConfig)

+	app | manage.py

>		from flask_script import Manager,Server
	from flask import Flask
	app = Flask(__name__)
	manager = Manager(app)
	manager.add_command('server',Server())
	@manager.shell
	def make_shell_context():
		return dict(app = app)
	if __name__ =='__main__':
		manager.run()

+ 使用
+	命令行：python manage.py server
+	命令行：python manage.py shell
+	测试命令行：app
### 数据库集成与新建
+	pip install flask-sqlalchemy
+	pip install flask-migrate
+	pip install PyMySQL
+	配置mysql路径
+	app | config.py 添加语句
>		class DevConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:@127.0.0.1:3306/smnews'

+	使用sqlalchemy声明模型
+	app | main.py

>			from flask.ext.sqlalchemy import SQLAlchemy
		app = Flask(__name__)
		app.config.from_object(DevConfig)
		db = SQLAlchemy(app)
		class User(db.Model):
		    __tablename__ ='user_table_name'
		    id =  db.Column('user_name',db.Integer(),primary_key=True)
		    username = db.Column(db.String(255))
		    password = db.Column(db.String(255))
		    def __init__(self,username):
		        self.username = username   
		    def __repr__(self):
		        return '<User `{}`>'.format(self.username)

+	导入模型
+	app | manage.py
>		from main import app,db,User
	@manager.shell
	def make_shell_context():
	    return dict(app = app,db= db,User = User)
	if __name__ == "__main__":
	    manager.run()

+	命令行：python manage.py shell
+	命令行：db.create_all()
### 数据库操作
####	新建
+	user = User(username='fake_name')
+	db.session.add(user)
+	db.session.commit()
#### 	读取
+	users = User.query.all()
+	users = User.query.limit(10).all()
+	User.query.order_by(User.username).all()
+	User.query.order_by(User.username.desc()).all()
+	User.query.first()
+	User.query.get(1).username
+	User.query.order_by(User.username.desc()).limit(10).first()
+	分页
+	page = User.query.paginate(1,10)
+	page.items/page/pages/has_prev/has_next/prev()/next()
+	条件查询
+	User.query.fillter_by(username='xxx').all()
+	User.query.order_by(User.username.desc()).fillter_by(username='xxx').limit(2).all()
#### 修改数据
+	User.query.filter_by(username ='fake_name').update({'password':'test'})
+	db.session.commit()
#### 删除数据
+	db.session.delete(user)
+	db.session.commit()
#### 表关系
+	一对多
+	多对多
### 数据库迁移
+	pip install Flask-Migrate
+	配置Migrate
+	配置Manage添加db命令
+	命令行：python manage.py db
+	python manage.py db init
+	python manage.py db migrate -m'xxxx'
+	python manage.py db upgrade
+	python manage.py db history
+	python manage.py db downgrade 7ded34bc4fb
+	app | manage.py
>		from flask import Flask
	from flask_script import Manager,Server
	from flask.ext.migrate import Migrate,MigrateCommand
	from main import app,db,User
	app = Flask(__name__)
	migrate = Migrate(app,db)
	manager = Manager(app)
	manager.add_command('server',Server())
	manager.add_command('db',MigrateCommand)
	@manager.shell
	def make_shell_context():
	    return dict(app = app,db= db,User = User)
	if __name__ == "__main__":
	    manager.run()

### 集成已有数据库
+   pip install sqlacodegen
+	sqlacodegen --help
+	sqlacodegen  mysql+pymysql://root:@127.0.0.1:3306/flask_test > models.py
+	修改model

### 后台admin	

###	蓝图
+	每个单独的app的__init__中:创建
>		from flask import Blueprint
	admin = Blueprint("admin", __name__)
	import app.admin.views

>		from flask import Blueprint
	home = Blueprint("home", __name__)
	import app.home.views

+	每个单独app的views中：引用
>	 	from . import admin
	@admin.route('/')
	def index():
	    return 'admin hello'

>		from . import home
	@home.route('/')
	def index():
	    return 'home hello'

+	项目app的__init__中:注册
>		from flask import Flask
>		from flask_sqlalchemy import SQLAlchemy
	app = Flask(__name__)
	app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@127.0.0.1:3306/flask_test'
	app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
	app.debug = True
	db = SQLAlchemy(app)
	from app.admin import admin as admin_blueprint
	from app.home import home as home_blueprint
	app.register_blueprint(admin_blueprint,url_prefix="/admin")
	app.register_blueprint(home_blueprint)

+	manage.py控制
>		from  app import app
	from flask_script import Manager
	manager = Manager(app)
	if __name__ == "__main__":
	    manager.run()

+	命令行使用：python manage.py runserver

### restful API
+ 	python返回json
>		import json
>		@home.route('/js/')
	def js():
	    return  json.dumps({'name': 'tyrael',
	                       'email': 'liqianglau@outlook.com'})

+	flask返回json
>		from  flask import jsonify
>		@home.route('/js1/')
>		def js1():
	    	return  jsonify({'name': 'tyrael',
	                       'email': 'liqianglau@outlook.com'})

+	增删改查
+	@app.route('/', methods=['GET']) |PUT|POST|DELETE
+	request.args.get('xx')
+	request.data

>		#!/usr/bin/env python
	# encoding: utf-8
	import json
	from flask import Flask, request, jsonify
	app = Flask(__name__)
	@app.route('/', methods=['GET'])
	def query_records():
	    name = request.args.get('name')
	    print name
	    with open('/tmp/data.txt', 'r') as f:
	        data = f.read()
	        records = json.loads(data)
	        for record in records:
	            if record['name'] == name:
	                return jsonify(record)
	        return jsonify({'error': 'data not found'})
	@app.route('/', methods=['PUT'])
	def create_record():
	    record = json.loads(request.data)
	    with open('/tmp/data.txt', 'r') as f:
	        data = f.read()
	    if not data:
	        records = [record]
	    else:
	        records = json.loads(data)
	        records.append(record)
	    with open('/tmp/data.txt', 'w') as f:
	        f.write(json.dumps(records, indent=2))
	    return jsonify(record)
	@app.route('/', methods=['POST'])
	def update_record():
	    record = json.loads(request.data)
	    new_records = []
	    with open('/tmp/data.txt', 'r') as f:
	        data = f.read()
	        records = json.loads(data)
	    for r in records:
	        if r['name'] == record['name']:
	            r['email'] = record['email']
	        new_records.append(r)
	    with open('/tmp/data.txt', 'w') as f:
	        f.write(json.dumps(new_records, indent=2))
	    return jsonify(record)
	@app.route('/', methods=['DELETE'])
	def delte_record():
	    record = json.loads(request.data)
	    new_records = []
	    with open('/tmp/data.txt', 'r') as f:
	        data = f.read()
	        records = json.loads(data)
	        for r in records:
	            if r['name'] == record['name']:
	                continue
	            new_records.append(r)
	    with open('/tmp/data.txt', 'w') as f:
	        f.write(json.dumps(new_records, indent=2))
	    return jsonify(record)
	app.run(debug=True)


### Jinjia2

### 表单

### admin
+ 	pip install Flask-Admin
### 创建包列表
+	pip freeze > requirements.txt
+	pip install -r requirements.txt
## 项目分析
### 前台
![](https://i.imgur.com/jjTprXx.png)

### 后台
![](https://i.imgur.com/6013vl7.png)

### 项目目录
![](https://i.imgur.com/tAkb1d1.png)

### 蓝图构建项目目录
![](https://i.imgur.com/jLG6Lmr.png)

### 蓝图创建
+	定义蓝图 __init__
+	调用蓝图 views
+	注册蓝图
+	启动脚本
>		manage.py
	from app import app
	if __name__=='__main__':
		app.run()

![](https://i.imgur.com/KLMeWFD.png)

## 模型分析
### 前台
![](https://i.imgur.com/TInTevm.png)

![](https://i.imgur.com/9WdgVlk.png)

![](https://i.imgur.com/k89c27s.png)

![](https://i.imgur.com/EC9jF8K.png)

![](https://i.imgur.com/TlWde4e.png)

![](https://i.imgur.com/cmcw0Ik.png)
![](https://i.imgur.com/uqOXr2e.png)

![](https://i.imgur.com/3DsFQdw.png)

![](https://i.imgur.com/PQ2jl7j.png)

### 后台
![](https://i.imgur.com/hMDVgQk.png)

![](https://i.imgur.com/7XLk8a5.png)

![](https://i.imgur.com/CzBBN0p.png)

![](https://i.imgur.com/WeDGYTz.png)

![](https://i.imgur.com/w4Tqukc.png)

![](https://i.imgur.com/w5Ly1sA.png)

## 登录设计
![](https://i.imgur.com/6vs38Ys.png)
![](https://i.imgur.com/erQ7OeU.png)

