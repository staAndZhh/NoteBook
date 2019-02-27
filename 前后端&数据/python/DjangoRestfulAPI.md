# Django 
1.  框架结构
1. ORM设计
2. 自定义User
3. xadmin安装和使用
4. 原生Json使用和返回
5. Drf生成和使用Json
6. Drf过滤|搜索|排序
7. 跨域访问
8. 服务器配置部署

## 环境安装
>		pip install virtualenv
	pip install virtualenv
	virtualenv testvir
	cd testvir
	dir 
	cd Script
	activate.bat
	pip list
	deactivate.bat
	或者	pip install virtualenvwrapper -win


##	项目目录创建
1.	安装django
2.	使用pycharm开发	
+	新建apps	extra_apps static/css media log文件夹

![](https://i.imgur.com/gjR3Ngl.png)

3.	配置setting目录结构
>		# Build paths inside the project like this: os.path.join	(BASE_DIR, ...)
	BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
	sys.path.insert(0,sys.path.join(BASE_DIR,'apps'))
	sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps/xadmin'))	#如果安装xadmin的话
	sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps'))

## 相关配置
+	新建app
	1.	manager.py	startapp dashboard
	2.	移动dashboard到apps目录中区
	3.	在settings文件中的install添加dashboard
>		INSTALLED_APPS = [
	'django.contrib.admin',
	'django.contrib.auth',
	'django.contrib.contenttypes',
	'django.contrib.sessions',
	'django.contrib.messages',
	'django.contrib.staticfiles',
	'apps.dashboard'
	]

+	static配置
>		STATIC_URL = '/static/'
	STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static')]

+	国际化配置
>		LANGUAGE_CODE = 'zh-hans'
	TIME_ZONE = 'Asia/Shanghai'
	USE_I18N = True
	USE_L10N = True
	USE_TZ = False


+	数据库配置

>		DATABASES = {
    	'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME':'semir_trip',
        'USER':'root',
        'PASSWORD':'',
        'HOST':'127.0.0.1'
			}
		}

+	服务器运行
	1.	manager.py runserver 8001
	2.	弹出网页，数据加载成功
	3.	如果需要在公网访问：需要 runserver 0.0.0.0:8000
##	ORM
1.	创建数据库以及数据表
2.	集成已有的数据库
3.	manager.py inspectdb
4.	mysite/manage.py inspectdb > mysite/myapp/models.py
5.	syncdb（Django 1.9移除,直接makegiragtion) migrate
6.	makemigration
7.	migrate
8.	ModeL配置
	>		在model中添加方法__str__或者__unicode__:更改数据库的每一条记录的行标题
		# coding:utf-8
		from django.db import models
		class Article(models.Model):
		  title = models.CharField(u'标题', max_length=256)
		  content = models.TextField(u'内容')
		  pub_date = models.DateTimeField(u'发表时间', auto_now_add=True, editable = True)
		  update_time = models.DateTimeField(u'更新时间',auto_now=True, null=True)
		  def __unicode__(self):# 在Python3中用 __str__ 代替 __unicode__
		 	 return self.title


## 原生admin
1. 创建管理员
2. manager.py createsuperuser
3. url匹配设置
	>		urlpatterns = [
    	url(r'^admin/', admin.site.urls),
    	url(r'^shops/',include('shops.urls'))]
4.	settings的installed_app中添加admin
	>		INSTALLED_APPS = [
    	'django.contrib.auth',
    	'django.contrib.contenttypes',
   	 	'django.contrib.sessions',
    	'django.contrib.messages',
    	'django.contrib.staticfiles',
  	  	'apps.users.apps.UsersConfig',
    	'apps.shops.apps.ShopsConfig',
    	'django.contrib.admin']

5.	在（不同的app的）admin文件中进行注册和管理model
	>		from django.contrib import admin
		from .models import Allinfo
		# Register your models here.
		admin.site.register(Allinfo)

7.	自定义原生admin文件配置选项：搜索|筛选|显示字段
	>		from django.contrib import admin
				from .models import Article, Person
			class ArticleAdmin(admin.ModelAdmin):
			 	list_display = ('title', 'pub_date', 'update_time',)			
			class PersonAdmin(admin.ModelAdmin):
			 	list_display = ('full_name',)	
			admin.site.register(Article, ArticleAdmin)
			admin.site.register(Person, PersonAdmin)

	>		搜索功能：search_fields = ('title', 'content',)
		筛选功能：list_filter = ('status',)

##	原生Admin 自定义User
1.	原生自带的user字段不满足要求，要添加某些字段
2.	继承AbstractUser
	>		# _*_ encoding:utf-8 _*_
		from __future__ import unicode_literals
		from datetime import datetime
		from django.db import models
		from django.contrib.auth.models import AbstractUser
		class UserProfile(AbstractUser):
		    nick_name = models.CharField(max_length=50, verbose_name=u"昵称", default="")
		    birday = models.DateField(verbose_name=u"生日", null=True, blank=True)
		    gender = models.CharField(max_length=6, choices=(("male",u"男"),("female","女")), default="female")
		    address = models.CharField(max_length=100, default=u"")
		    mobile = models.CharField(max_length=11, null=True, blank=True)
		    image = models.ImageField(upload_to="image/%Y/%m",default=u"image/default.png", max_length=100)
		    class Meta:
		        verbose_name = "用户信息"
		        verbose_name_plural = verbose_name		
		    def __unicode__(self):
		        return self.username
3.	Setting中配置InstalledApp
4.	配置用户认证模型
5.	
	>		AUTH_USER_MODEL = 'users.UserProfile'
		INSTALLED_APPS = [......]


##	xadmin使用
1.	pip安装	pip install xadmin
2.	源码安装	
	
	![](https://i.imgur.com/xAqIvYc.png)

3.	setting配置文件配置路径
	>		sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps/xadmin'))
		sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps'))
4.	把xadmin作为资源文件	mark as source root
5.	更改表配置 makemigrations	|migrate
6.	url匹配，把所有的admin改为xadmin
7.	在settings中的installedapp中添加crispy_forms
6.	使用
7.	在待使用的model中新建adminx文件
8.	继承object对象
	>		class EmailVerifyRecordAdmin(object):
    	list_display = ['code', 'email', 'send_type', 'send_time']
    	search_fields = ['code', 'email', 'send_type']
    	list_filter = ['code', 'email', 'send_type', 'send_time']
		xadmin.site.register(Email,EmailVerifyRecordAdmin)

9.	xadmin 全局配置
10.	在用户配置的adminx中添加全局配置
11.	后台主题设置
	>		class BaseSetting(object):
   	 	enable_themes = True
    	use_bootswatch = True
		xadmin.site.register(views.BaseAdminView, BaseSetting)  #修改主题

12.	页头页脚设置
	>		class GlobalSettings(object):
	    	site_title = "慕学后台管理系统"
	    	site_footer = "慕学在线网"
	    	# menu_style = "accordion"
		xadmin.site.register(views.CommAdminView, GlobalSettings)  #修改内容


13.	折叠设置
	>		class GlobalSettings(object):
	    	#site_title = "慕学后台管理系统"
	    	#site_footer = "慕学在线网"
	    	 menu_style = "accordion"
		xadmin.site.register(views.CommAdminView, GlobalSettings)  #修改内容
14.	组别名声设置（组别名称设置为中文）
	1.	修改每个app下的apps.py文件,添加配置名字
	2.	修改每个app下的__init__.py文件，使用默认配置
	3.	apps.py文件
	>		from django.apps import AppConfig
		class GoodsConfig(AppConfig):
		    name = 'users'
		    verbose_name = "用户管理"
	
	4.__init__文件

	> default_app_config = "users.apps.UserConfig"
	

## 原生返回json文件
1. 拼装json
	> 在view中创建[]和字典，通过json.dumps([])来返回json
2.	通过django的model_to_dict模块(image_field和datatime_field不能序列化）
	> 	from django.forms.models import model_to_dict
		for good in goods:
			json_list.append(model_to_dict(good))
		json.dumps([])
	
3. 通过django.core的serializers模块
	>		from django.core import serializers
			from django.http import HttpResponse,JsonResponse
		serializers.serialize('json',goods)	
		json.loads(json_data)
		JsonResponse(json.loads(json_data),safe = False)

	
## Drf使用
###配置
1.	安装
	>		pip install djangorestframework
		pip install markdown       # Markdown support for the browsable API.
		pip install django-filter  # Filtering support

2.	installedApp
	>		INSTALLED_APPS = (
		...
		rest_framework',)

3.	api
	>		urlpatterns = [
    	...
    	url(r'^api-auth/', include('rest_framework.urls'))]

###	序列化与Apiview
1.	通过在对应的app中新建serializers.py文件实现对象的序列化
2.	字段类型为SnippetSerializer类的子类型
3.	继承序列化借口
	>		from rest_framework import serializers
		class GoodsSerializer(serializers.Serializer):
   		 id = serializers.IntegerField(read_only=True)
    	title = serializers.CharField(required=False, allow_blank=True, max_length=100)
   		 linenos = serializers.BooleanField(required=False)
3.	ModelSerializer
	>		from rest_framework import serializers
		from goods.models import Goods
		class GoodsSerializer(serializers.ModelSerializer):
			class Meta:
				model = Goods
				fields = ('name','click_num')
				fields = "__all__"
3.	使用ApiView
	>		from .serializers import GoodsSerializer
			from rest_framework.views import APIView
			from rest_framework.response import Response
		class GoodsListView(ApiView):
			def	get(self,request,format=None):
				goods = Goods.object.all()[:10]
				goods_serializer = GoodsSerializer(goods,many = TRUE)
				return Response(goods_serializer.data)
4.	显示View
	>		url(r'goods/$',GoodsListView.as_view(),name = "goods-list")	
4.	GenericView
5.	Viewset和router
6.	过滤|搜索|排序

![](https://i.imgur.com/AASyPGE.png)

------------------
# 接口
+   view实现 rest api接口
+   genericview 实现api接口
+   viewset 和router 实现api接口和url配置
+   django_filter,searchFilter,OrderFilter,分页
+   通用mixins			
# 权限和认证
+   authentication用户认证设置
+   动态设置permisssion，authenticaiton
+   validators 实现字段验证
# 序列化和表单验证
+   serializer
+   ModelSerializer
+   动态设置serializer   
# 支付，登录和注册
+   json web token 实现登录
+   手机注册
+   支付宝支付
+   第三方登录
# 进阶开发
+   drf源码
+   文档自动化管理
+   drf缓存
+   Throttling对用户和ip限速

----------
# drf 登录
## base
+	配置setting
>    REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
    )
}

+	原理：取出cookie和session中的登录的user
+	类型：basic，token，session
+	session浏览器常见，系统自动附带，所以比较少见
+	常用的是token
## token
+	INSTALLED_APPS = (
    ...
    'rest_framework.authtoken'
)
+	makemigrations
+	migrate
+	使用token：一个user对应一个token
+	新建用户-新建token
>	from rest_framework.authtoken.models import Token
token = Token.objects.create(user=...)
print(token.key)

+	使用：代码中创建用户时-新建token
+	前端访问-header中加入-Authorization: Token 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b
+	获取前端的token-post用户名密码到网页-返回token
	
>   from rest_framework.authtoken import views
urlpatterns += [
    url(r'^api-token-auth/', views.obtain_auth_token)
]

+	如果请求中附带token-后端响应：-setting中添加token
+	setting中添加-rest-frame-work的token
		
>   REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
		'rest_framework.authentication.TokenAuthentication'
    )
}

+	缺点：drf的token放在服务器中，分布式无法处理；没有过期时间；每个数据页面都验证
### Viewset中添加token
+	setting中不加token验证
+	>   REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
    )
}

+	ViewSet中添加
+	from rest_framework.authentication import TokenAuthentication
>	class UserViewset(viewsets.xxxx):
	authentication_classes = (TokenAuthentication, )
## 原理
+ session-process_request/process_response-注册之后会在传递到view之前自动处理
+ request-RequestMiddleWare-ReponseMiddleWare-response
+ 可以布置拦截器
+	django默认的-重在登录
+	drf的-重在验证
+	自动调用-TokenAuthentication中的-authenticate方法-如果任意一个注册了-认证通过-放在request中
+	登录信息在request.auth中
+	前后端认证-一般使用token来认证
## jwt认证
+	原始：drf生成token-前端获取
+	缺点：cookie泄露；csrf漏洞；根据token请求id，存储压力
+	对称加密
+	适合传递web非敏感信息；用户认证和授权系统；web单点登录
### 认证方式
+	jwt认证：简洁，自包含
+	header头：token类型，加密的算法
+	Payload：存放信息：签发者，过期时间，面对用户，接收方，签发时间
+	Signature：header+Payload+后端提供的秘钥+header中提供的签名算法=签名
+	header&Payload：base64加密，前端可以解密，获取相关信息
+	通过算法加密解密-服务器不需要存储cookie-session
### 前端
+	登录-账户&密码-后端验证-生成jwt-前端接受jwt-前端保存jwt-跳转登录页或请求api
+	jwt-过滤器拦截请求，验证jwt-通过-业务操作&返回数据-展示数据-不通过-返回错误信息-提示错误-跳转
### drf的jwt实现
+	pip install djangorestframework-jwt
+	setting配置：
>   REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
    )
}

+	url配置：url(r'^api-token-auth/', obtain_jwt_token),
>	from rest_framework_jwt.views import obtain_jwt_token

+	post 用户名，密码到接口-判断token生成
### view和jwt借口调试
+	前端保存
+	cookie.setCookie('name',xxx,7)
+	cookie.setCookie('token',resposne.data.token,7)
+	放置到state中
### 自定义用户认证
+	setting中配置
>	AUTHENTICATION_BACKENDS = (
    'users.views.CustomBackend',
)


+	user.py中添加
>   from django.contrib.auth.backends import ModelBackend
>   from django.contrib.auth import get_user_model
>   from django.db.models import Q
		User = get_user_model()
		class CustomBackend(ModelBackend):
			    """
			    自定义用户验证
			    """
			    def authenticate(self, username=None, password=None, **kwargs):
			        try:
			            user = User.objects.get(Q(username=username)|Q(mobile=username))
			            if user.check_password(password):
			                return user
			        except Exception as e:
			            return None


### JWT过期时间认证
+	setting中配置
>    import datetime
	JWT_AUTH = {
    'JWT_EXPIRATION_DELTA': datetime.timedelta(days=7),
    'JWT_AUTH_HEADER_PREFIX': 'JWT',
}

----------
# 手机注册
### 第三方服务	
### 短信发送借口
+ SmsCodeViewset(CreateModelMixin，Viewsets.GenericViewSet):
+ serializer.py验证类 mobile = 
+ 重写 validate_mobile(self,data):
### 注册
+	用户验证
+	验证码长度验证，时间验证