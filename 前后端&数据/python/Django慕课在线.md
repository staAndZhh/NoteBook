#	Django& Xadmin 在线教育平台
##	Char 1
1.	环境搭建
2.	django基础知识
	1.	settings配置
	2.	url配置
	3.	view书写
	4.	model设计
	5.	form和modelform使用
	6.	templates模板
	7.	django常用内置函数
3.	数据库设计设计&Xadmin后台
4.	系统功能模块实现
5.	web系统知识以及网络安全
	1.	sql注入
	2.	xss攻击
	3.	csrf攻击
6.	xadmin扩展
	1.	权限管理
	2.	权限配置
	3.	权限，用户和组的关系
	4.	xadmin常用插件
	5.	自定义xadmin插件
	6.	**xadmin富文本编辑**
	7.	**xadminexcel导入**

###	目录介绍
### 静态页面返回
1. 	数据库连接配置
1.	写好的html放到templates文件夹中
2.	css 放在static/css中
3.	配置 static/css路径
	>  STATIC_URL = '/static/'
	>  
	>  STATICFILES_DIR = [
	>  os.path.join(BASE_DIR,'static')
	>  ]
2.	setting中查看templetes配置的本地路径
	>	TEMPLATES = [
	>	{	
	>	'DIRS':[os.path.join(BASE_DIR,'templates')],
	>	}
	>	]
2.	填写view的返回函数，render为html的名字
	>	from django.shortcuts import render
	>
	>	def getform(request):
	>		return render(request,'html_name.html')
3.	填写urls配置函数
	>	from xx.views import getform
	>	
	>	url(r'^form/$',getform)

### 静态页面返回2
1.	不用写view直接配置
	> 	from django.views.generic import TempalteView
		urlpatterns = [
			url('^$',TempalteView.as_view(template_name = 'index.html',name = 'index')
		]
	
###	model设计
1.	填写models
2.	添加到installedapp中
3.	model的数据类型和外键（ForeignKey)
4.	原始数据没有主键时：Django会自动创建一个字段名字为id的主键
>
    'AutoField', 'BLANK_CHOICE_DASH', 'BigAutoField', 'BigIntegerField',
    'BinaryField', 'BooleanField', 'CharField', 'CommaSeparatedIntegerField',
    'DateField', 'DateTimeField', 'DecimalField', 'DurationField',
    'EmailField', 'Empty', 'Field', 'FieldDoesNotExist', 'FilePathField',
    'FloatField', 'GenericIPAddressField', 'IPAddressField', 'IntegerField',
    'NOT_PROVIDED', 'NullBooleanField', 'PositiveIntegerField',
    'PositiveSmallIntegerField', 'SlugField', 'SmallIntegerField', 'TextField',
    'TimeField', 'URLField', 'UUIDField',

5.	meta信息
	> da_table:创建表时的名字
	> ordering:queryset时候的排序
	> verboser_name:后台显示名字
	> verboser_name_plural:后台显示名字的复数

###	数据库的增删改
1.	models.object().all()
2.	models.filter(xx="xx",xxx="xxx")
3.	增加&删除
	>		xx = models()
		xx.属性1 = "xx"
		xx.属性2 = "xx"
		xx.save()
		xx.delete()

4.	表单提交：form的action为/form/（配置的view中的路径）
5.	表单提交需要在form标签的字标签内添加{% csrf_token %}
6.	数据获取：

	> 	if requset.method =="POST":
 		name = request.POST.get('name',"")

###	数据库显示并显示在html中
1.	通过在views中写函数：在render 传递键值对给前端
	>	message = xx.object.all()[0]
			return render(request，'xxx.html',
		{'my_message':message}
2.	在temlplate的模板中使用 {{ my_message.属性	  }}
3.	django的template内建函数
	>						<div class="right">
						<ul>
                            {% for org in course_orgs %}
                                <li class="{% if forloop.counter|divisibleby:5 %}five{% endif %}">
                                    <a href="{% url 'org:org_home' org.id %}">
                                        <div class="company">
                                            <img width="184" height="100" src="{{ MEDIA_URL }}{{ org.image }}"/>
                                            <div class="score">
                                                <div class="circle">
                                                    <h2>{{ org.tag }}</h2>
                                                </div>
                                            </div>
                                        </div>
                                        <p><span class="key" title="{{ org.name }}">{{ org.name }}</span></p>
                                    </a>
                                </li>
                            {% endfor %}
						</ul>
					</div>

4. url别名的用法：url配置中的name属性=用来链接跳转时候的引用
	> 	url(r'^form$',getform,name = 'go_form')
	> 
		 在template中两者等价
		{%	load	staticfiles	%}
		<form action = "{% url 'go_form' %}" method ="post">
		<form action = "/form/" method ="post">	
			静态文件引用
		<a href = "{% static 'css/reset.css'	%}">
		<a src = "{% static 'js/reset.js'	%}">

5. url正则配置是贪婪匹配的

## char2
###	app设计
1.	用户
2.	公开课
3.	教师&机构
4.	用户操作

### 用户设计
1. django 提供默认的用户表
2. 自定义用户：继承AbstractUser
3. setting中添加installedApp
	>		from django.contrib.auth.models import AbstractUser
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
4. setting文件中重载方法 user.UserProfile
	>	AUTH_USER_MODEL = "users.UserProfile"
5. makemigrations /migtate

###	用户相关模块
1.	邮箱验证码
	- 验证码，邮箱，类型，添加时间
2.	轮播图
	- 标题，img,url,index,添加时间	

###	课程
1.	课程
	-	课程名字，描述，详情，级别，时长，学习，收藏人数，封面，点击数，添加时间
2.	章节
3.	视频
4.	课程资源

### 课程机构
1.	课程机构
2.	教师信息
3.	城市列表

###	用户操作信息
1.	用户咨询
2.	用户评论
3.	用户收藏
4.	用户消息
5.	用户学习

###	admin后台管理系统
1.	创建用户(默认用户密码登录）
	> cratesuperuser

2.	更改Admin的语言设置：settings中的时区和语言
	> 	LANGUAGE_CODE = "zh-hans"
		TIME_ZONE = "Aisa/Shanghai"
		USE_TZ = FALSE

3.	注册admin，自定义的user，DJango不再自动注册
	> 	from django.contrib import admin
		class UserProfileAdmin(admin.ModelAdmin):
			pass
		admin.site.register(UserProfile,UserProfileAdmin）

###	xadmin后台管理系统
1.	pip安装:pip install 或者源码安装：github下载并放在extra_apps中
2.	setting中添加extra_apps的路径
	> sys.path.insert(0,os.path.join(BASE_DIR,'extra_apps'))
2.	setting中installedapp添加：xadmin	crispy-forms
3.	把url中配置中的 admin 更改为xadmin
4.	(由于user配置不同）makemigrations /migrate
5.	修改控制台显示的单个admin标题内容（model的__unicodie__或__str__方法)
	>		def __unicode__(self):
			return '{0}({1})'.formet(self.code,self.email)
6.	新建adminx.py文件

	+	继承object重写管理类，xadmin.site.register(models,admin)注册	
	+	自定义显示列 list_display =[]/()
	+	查找列	search_fields = []
	+	列的字段过滤器	list_filter = []
	+	带外键的字段搜索:主表字段_外键名称	list_filter = ['course_name']
	+	多个admin，顺序与注册顺序一样

	>		class VerifyCodeAdmin(object):
    	list_display = ['code', 'mobile', "add_time"]
		xadmin.site.register(VerifyCode, VerifyCodeAdmin)

7.	全局标题，页面footer，其他相关配置
	1.	全局主题配置
		>		from xadmin import views
			class BaseSetting(object):
    		enable_themes = True
    		use_bootswatch = True
			xadmin.site.register(views.BaseAdminView, BaseSetting)
	
	2.	左页头/页脚
		>		class GlobalSettings(object):
    		site_title = "慕学生鲜后台"
    		site_footer = "mxshop"
			# menu_style = "accordion" 页面收缩
			xadmin.site.register(views.CommAdminView, GlobalSettings)
	
	3.	admin页面显示名称
		+	apps.py文件设置
		+	在apps.py文件中，添加verbose_name
		+	在apps.py同级别的__init__文件添加 default_app_config
		>	default_app_config = "ueser.apps.UserOperationConfig"
			
		>		from django.apps import AppConfig
			class UserOperationConfig(AppConfig):
    			name = 'user_operation'
    			verbose_name = "用户操作管理"

## char3
###	登录设置基于类
1.	post中csrf验证配置
	>		<form>
		{%	csrf_token	%}
		</form>

2.	基于类判断
+ step1:
+	直接返回界面
>	from django.views.generic import  TemplateView

>	urlpatterns = [
    url('^xadmin/', xadmin.site.urls),
    url('^login/$',TemplateView.as_view(template_name='login.html'),name='login')]

+ step2:
+	填写views
+	views
>		def login(request):
>		if request.method =='POST':
>			pass
>		elif request.method =='GET':
>			return render(request,'login.html',{})

+	url填写
>		from users.views import login
>		urlpatterns = [
    url('^xadmin/', xadmin.site.urls),
    url('^login/$',login,name='login')]

+	step3:
+	html中form表单添加 csrftoken
>	  <form>
>	                {% csrf_token %}
                </form>
###	登录用户名判断(基于函数/基于类：略去）
1.	登录界面继承view
2.	setting配置
	>		urlpatterns = [
    	url(r'^xadmin/', xadmin.site.urls),
    	url('^$', IndexView.as_view(), name="index"),
    	url('^login/$', LoginView.as_view(), name="login"),
2.		url配置 url('xx',LoginView.as_view(),name = 'login'）
3.	form表单验证：新建forms文件，继承forms.Form
	>		class LoginForm(forms.Form):
		    username = forms.CharField(required=True)
		    password = forms.CharField(required=True, min_length=5)
1.	使用添加自定义authenticate验证models
2.	添加邮箱密码验证，使用自定义的authenticate方法
3.	填写验证逻辑
	+	setting中添加认证类
		>	AUTHENTICATION_BACKENDS = (  
    	'users.views.CustomBackend',)
	+	view中自定义认证类
		>		from django.contrib.auth.backends import ModelBackend
				from django.db.models import Q
				class CustomBackend(ModelBackend):
			    def authenticate(self, username=None, password=None, **kwargs):
			        try:
			            user = UserProfile.objects.get(Q(username=username)|Q(email=username))
			            if user.check_password(password):
			                return user
			        except Exception as e:
			            return None
	+	添加登录判断逻辑(返回错误信息)
		>
				from django.views.generic.base import View
				class LoginView(View):
				    def get(self, request):
				        return render(request, "login.html", {})
				    def post(self, request):
				        login_form = LoginForm(request.POST) #表单验证
				        if login_form.is_valid():
				            user_name = request.POST.get("username", "")
				            pass_word = request.POST.get("password", "")
				            user = authenticate(username=user_name, password=pass_word)
				            if user is not None:
				                if user.is_active:
				                    login(request, user)
				                    return HttpResponseRedirect(reverse("index"))
				                else:
				                    return render(request, "login.html", {"msg":"用户未激活！"})
				            else:
				                return render(request, "login.html", {"msg":"用户名或密码错误！"})
				        else:
				            return render(request, "login.html", {"login_form":login_form})

3.	cookie和session
	+	http是一种无状态请求协议
	+	1th:服务器给用户一个ID，浏览器存储cookie(键值对)在本地
	+	2nd:再次请求服务器时，根据cookie中的ID返回对应的信息
	+	防止cookie漏洞，有了session(有过期时间)
	+	1th:把随机的ID改成，根据用户名和密码产生的随机的字符串session
	+	根据用户信息生成sessionID保存在数据库中,并返回给浏览器，浏览器存储sessionID在cookie中
	+	2nd:再次请求时，不用输入用户名密码，根据浏览器发送的本地的sessionID，服务器就知道是那个用户了
	+	django.contrib.sessions模块默认配置

###	注册/邮箱验证设置
4.	用户注册验证码
	1.	url注册url('xx',RegisterView.as_view(),name = 'register'）
	3.	django验证码基本设置:
		1.	django-simple-captcha
		1.	pip install  django-simple-captcha
		2.	Add 'captcha' to the INSTALLED_APPS
		3.	python manage.py makemigrations/migrate
		4.	添加图片的url配置
		>		urlpatterns += [
    		url(r'^captcha/', include('captcha.urls')),]
			html中使用{{		register_form.captcha	}}
		

	4.	form中添加验证
		>			from captcha.fields import CaptchaField
				class RegisterForm(forms.Form):
				    email = forms.EmailField(required=True)
				    password = forms.CharField(required=True, min_length=5)
				    captcha = CaptchaField(error_messages={"invalid":u"验证码错误"})
	5.	注册view验证form（中文错误信息，密码加密）
	6.	发送邮箱链接并激活( 新建工具类，发送邮箱）
		>		from django.contrib.auth.hashers import make_password
				class RegisterView(View):
		    def get(self, request):
		        register_form = RegisterForm()
		        return render(request, "register.html", {'register_form':register_form})	
		    def post(self, request):
		        register_form = RegisterForm(request.POST)
		        if register_form.is_valid():
		            user_name = request.POST.get("email", "")
		            if UserProfile.objects.filter(email=user_name):
		                return render(request, "register.html", {"register_form":register_form, "msg":"用户已经存在"})
		            pass_word = request.POST.get("password", "")
		            user_profile = UserProfile()
		            user_profile.username = user_name
		            user_profile.email = user_name
		            user_profile.is_active = False
		            user_profile.password = make_password(pass_word) #密码明文变密文
		            user_profile.save()
		            #写入欢迎注册消息
		            user_message = UserMessage()
		            user_message.user = user_profile.id
		            user_message.message = "欢迎注册慕学在线网"
		            user_message.save()
		            send_register_email(user_name, "register")
		            return render(request, "login.html")
		        else:
		            return render(request, "register.html", {"register_form":register_form})

		发送邮箱的工具类
		>			setting中添加配置
		>			EMAIL_HOST = "smtp.sina.com"
					EMAIL_PORT = 25
					EMAIL_HOST_USER = "projectsedu@sina.com"
					EMAIL_HOST_PASSWORD = "admin123"
					EMAIL_USE_TLS= False
					EMAIL_FROM = "projectsedu@sina.com"

			
		>		新建立工具包和类utils
		>		from random import Random
			from django.core.mail import send_mail
			from users.models import EmailVerifyRecord
			from MxOnline.settings import EMAIL_FROM
			def random_str(randomlength=8):
			    str = ''
			    chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
			    length = len(chars) - 1
			    random = Random()
			    for i in range(randomlength):
			        str+=chars[random.randint(0, length)]
			    return str
			def send_register_email(email, send_type="register"):
			    email_record = EmailVerifyRecord()
			    if send_type == "update_email":
			        code = random_str(4)
			    else:
			        code = random_str(16)
			    email_record.code = code
			    email_record.email = email
			    email_record.send_type = send_type
			    email_record.save()
			    email_title = ""
			    email_body = ""
			    if send_type == "register":
			        email_title = "慕学在线网注册激活链接"
			        email_body = "请点击下面的链接激活你的账号: http://127.0.0.1:8000/active/{0}".format(code)
			        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
			        if send_status:
			            pass
			    elif send_type == "forget":
			        email_title = "慕学在线网注册密码重置链接"
			        email_body = "请点击下面的链接重置密码: http://127.0.0.1:8000/reset/{0}".format(code)
			        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
			        if send_status:
			            pass
			    elif send_type == "update_email":
			        email_title = "慕学在线邮箱修改验证码"
			        email_body = "你的邮箱验证码为: {0}".format(code)
			        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
			        if send_status:
			            pass

	7.	用户激活
		1.	激活网址参数获得
		>	url(r'^active/(?P<activive_code>.*)/$',AciveUserView.as_view(),name= 'user_active')
		2.	view设置
		>		class AciveUserView(View): 
		    def get(self, request, active_code):
		        all_records = EmailVerifyRecord.objects.filter(code=active_code)
		        if all_records:
		            for record in all_records:
		                email = record.email
		                user = UserProfile.objects.get(email=email)
		                user.is_active = True
		                user.save()
		        else:
		            return render(request, "active_fail.html")
		        return render(request, "login.html")

###	找回密码设置
1.	url设置
2.	form设置
	>		class ForgetForm(forms.Form):
			    email = forms.EmailField(required=True)
			    captcha = CaptchaField(error_messages={"invalid":u"验证码错误"})

3.	view设置
	>		class ForgetPwdView(View):
	    def get(self, request):
	        forget_form = ForgetForm()
	        return render(request, "forgetpwd.html", {"forget_form":forget_form})
	    def post(self, request):
	        forget_form = ForgetForm(request.POST)
	        if forget_form.is_valid():
	            email = request.POST.get("email", "")
	            send_register_email(email, "forget")
	            return render(request, "send_success.html")
	        else:
	            return render(request, "forgetpwd.html", {"forget_form":forget_form})
4.	密码重置
	>		class ResetView(View):
	    def get(self, request, active_code):
	        all_records = EmailVerifyRecord.objects.filter(code=active_code)
	        if all_records:
	            for record in all_records:
	                email = record.email
	                return render(request, "password_reset.html", {"email":email})
	        else:
	            return render(request, "active_fail.html")
	        return render(request, "login.html")

5.	重置密码表单
	>		class ModifyPwdForm(forms.Form):
		    password1 = forms.CharField(required=True, min_length=5)
		    password2 = forms.CharField(required=True, min_length=5)

6.	修改密码
	>		class ModifyPwdView(View):
		    """
		    修改用户密码
		    """
		    def post(self, request):
		        modify_form = ModifyPwdForm(request.POST)
		        if modify_form.is_valid():
		            pwd1 = request.POST.get("password1", "")
		            pwd2 = request.POST.get("password2", "")
		            email = request.POST.get("email", "")
		            if pwd1 != pwd2:
		                return render(request, "password_reset.html", {"email":email, "msg":"密码不一致"})
		            user = UserProfile.objects.get(email=email)
		            user.password = make_password(pwd2)
		            user.save()
		            return render(request, "login.html")
		        else:
		            email = request.POST.get("email", "")
		            return render(request, "password_reset.html", {"email":email, "modify_form":modify_form})

##	Char 3
1.	Templete模板继承
	2.	{%	block xxx	%}	{%	endblock	%}
	3.	{%	extend	'base.hteml'	%}
	4.	{%block xxx	%}	xxxxxx      {%	endblock	%}
	
2.	机构列表页展示
	1.	图片资源设置(setting文件中配置MEDIA_URL/MEDIA_ROOT,中间件配置，url配置)
		
		+	>		MEDIA_URL = '/media/'
				MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
				使用："/media/{{		course_org.image	}}"
				或者："{{		MEDIA_URL	}}{{		course_org.image	}}"

		+	>		配置settings:
				TEMPLATES = [
		    	{
		        'BACKEND': 'django.template.backends.django.DjangoTemplates',
		        'DIRS': [os.path.join(BASE_DIR, 'templates')]
		        ,
		        'APP_DIRS': True,
		        'OPTIONS': {
		            'context_processors': [
		                'django.core.context_processors.media',
		            ],
	
		+	>		from django.views.static import serve    
				#配置上传文件的访问处理函数
	    		url(r'^media/(?P<path>.*)$',  serve, {"document_root":MEDIA_ROOT}),

	2.	列表分页功能（pure pagination)
		1.	pip install django-pure-pagination
		2.	配置setting
			>	INSTALLED_APPS = (
		    ...
		    'pure_pagination',
				)

		3.	参数设置
			>			PAGINATION_SETTINGS = {
				    'PAGE_RANGE_DISPLAYED': 10,
				    'MARGIN_PAGES_DISPLAYED': 2,
				    'SHOW_FIRST_PAGE_WHEN_INVALID': True,
				}
		4.	html配置
			>		{% load i18n %}
				<div class="pagination">
				    {% if page_obj.has_previous %}
				        <a href="?{{ page_obj.previous_page_number.querystring }}" class="prev">&lsaquo;&lsaquo; {% trans "previous" %}</a>
				    {% else %}
				        <span class="disabled prev">&lsaquo;&lsaquo; {% trans "previous" %}</span>
				    {% endif %}
				    {% for page in page_obj.pages %}
				        {% if page %}
				            {% ifequal page page_obj.number %}
				                <span class="current page">{{ page }}</span>
				            {% else %}
				                <a href="?{{ page.querystring }}" class="page">{{ page }}</a>
				            {% endifequal %}
				        {% else %}
				            ...
				        {% endif %}
				    {% endfor %}
				    {% if page_obj.has_next %}
				        <a href="?{{ page_obj.next_page_number.querystring }}" class="next">{% trans "next" %} &rsaquo;&rsaquo;</a>
				    {% else %}
				        <span class="disabled next">{% trans "next" %} &rsaquo;&rsaquo;</span>
				    {% endif %}
				</div>

3.		列表筛选功能
	1.	前端给出点击的参数
	2.	后端根据点击参数返回列表，并把点击参数也返回
	3.	前端判断是否点击的参数是否为返回的。如果相等，显示对应的结果，否则显示默认的结果

4.		form表单验证(集成modelForm)
	1.	表单建立(新建form文件)
		>		from django import forms
			from operation.models import UserAsk
			class UserAskForm(forms.ModelForm):
			    my_filed = forms.CharField()
			    class Meta:
			        model = UserAsk
			        fields = ['name', 'mobile', 'course_name']
	2.	表单提交
		>		class AddUserAskView(View):
		    """
		    用户添加咨询
		    """
		    def post(self, request):
		        userask_form = UserAskForm(request.POST)
		        if userask_form.is_valid():
		            user_ask = userask_form.save(commit=True)
		            return HttpResponse('{"status":"success"}', content_type='application/json')
		        else:
		            return HttpResponse('{"status":"fail", "msg":"添加出错"}', content_type='application/json')
	3.	html配置csrf_token
	4.	字段自定义验证 clean_field
		>		from django import forms
			from operation.models import UserAsk
			class UserAskForm(forms.ModelForm):
			    my_filed = forms.CharField()
			    class Meta:
			        model = UserAsk
			        fields = ['name', 'mobile', 'course_name']
			    def clean_mobile(self):
			        """
			        验证手机号码是否合法
			        """
			        mobile = self.cleaned_data['mobile']
			        REGEX_MOBILE = "^1[358]\d{9}$|^147\d{8}$|^176\d{8}$"
			        p = re.compile(REGEX_MOBILE)
			        if p.match(mobile):
			            return mobile
			        else:
			            raise forms.ValidationError(u"手机号码非法", code="mobile_invalid")

	
5.		url分发(单独app的url配置)
	1.	在单独的app中新建url文件
		>		urlpatterns = [
		    #课程机构列表页
		    url(r'^list/$', OrgView.as_view(), name="org_list"),
		    url(r'^add_ask/$', AddUserAskView.as_view(), name="add_ask"),
		    url(r'^home/(?P<org_id>\d+)/$', OrgHomeView.as_view(), name="org_home"),]
	2.	在原始目录中引用
		>    #课程机构url配置
    url(r'^org/', include('organization.urls', namespace="org")),
	3.	这样访问的目录为/org/list
	4.	html中引用方法为 {%	url	'org:org_list'	%}
	
6.		ORM取出外键的对应的model
		
	> 	course_org = CourseOrg.objects.get(id = int(org_id))
			all_courses = course_org.course_set.all()
			all_teachers = course_org.teacher_set.all()

7.		用户收藏
	1.	读取收藏的ID，收藏的类型
	2.	读取用户登录状态
	3.	如果未登录，返回首页
	4.	如果登录，查询数据表是否已经收藏（ID&type)
	5.	如果数据表中记录已经存在，删除记录
	6.	如果数据表中记录不存在，保存记录
	7.	其他情况，收藏不成功
	8.	处理页面切换时已经收藏的逻辑
	9.	在页面切换时读取逻辑，返回数据给前端，前端判断是否收藏，并显示
	>		class AddFavView(View):
	    """
	    用户收藏，用户取消收藏
	    """
	    def post(self, request):
	        fav_id = request.POST.get('fav_id', 0)
	        fav_type = request.POST.get('fav_type', 0)
        if not request.user.is_authenticated():
            #判断用户登录状态
            return HttpResponse('{"status":"fail", "msg":"用户未登录"}', content_type='application/json')
        exist_records = UserFavorite.objects.filter(user=request.user, fav_id=int(fav_id), fav_type=int(fav_type))
        if exist_records:
            #如果记录已经存在， 则表示用户取消收藏
            exist_records.delete()
            if int(fav_type) == 1:
                course = Course.objects.get(id=int(fav_id))
                course.fav_nums -= 1
                if course.fav_nums < 0:
                    course.fav_nums = 0
                course.save()
            elif int(fav_type) == 2:
                course_org = CourseOrg.objects.get(id=int(fav_id))
                course_org.fav_nums -= 1
                if course_org.fav_nums < 0:
                    course_org.fav_nums = 0
                course_org.save()
            elif int(fav_type) == 3:
                teacher = Teacher.objects.get(id=int(fav_id))
                teacher.fav_nums -= 1
                if teacher.fav_nums < 0:
                    teacher.fav_nums = 0
                teacher.save()
            return HttpResponse('{"status":"success", "msg":"收藏"}', content_type='application/json')
        else:
            user_fav = UserFavorite()
            if int(fav_id) > 0 and int(fav_type) > 0:
                user_fav.user = request.user
                user_fav.fav_id = int(fav_id)
                user_fav.fav_type = int(fav_type)
                user_fav.save()
                if int(fav_type) == 1:
                    course = Course.objects.get(id=int(fav_id))
                    course.fav_nums += 1
                    course.save()
                elif int(fav_type) == 2:
                    course_org = CourseOrg.objects.get(id=int(fav_id))
                    course_org.fav_nums += 1
                    course_org.save()
                elif int(fav_type) == 3:
                    teacher = Teacher.objects.get(id=int(fav_id))
                    teacher.fav_nums += 1
                    teacher.save()
                return HttpResponse('{"status":"success", "msg":"已收藏"}', content_type='application/json')
            else:
                return HttpResponse('{"status":"fail", "msg":"收藏出错"}', content_type='application/json')