# model 相关
## model的Meta
+   verbose_name
+   verbose_name_plural 
+   db_table 
+   ordering = "-object_id"
## model 操作
+   objects.all()
+   filter()
+   .save()
## 取出form的参数
### 前端中需要加入 csrf_token
+   {% csrf_token %}   
### 取出参数
+   request.method == "POST"
+   request.POST.get('name','')
## 传递参数到前端
+   message = UserMessage.objects.filter(name='xxx')[0]
+   render(request,'xx.html',{'my_msg':message})
### url取出参数
+ <input value=" {% if my_msg.name == "aaa "%} bobby {% else %}bobby not test {% endif %}" />
+ <input value=" {% ifequal my_msg.name "aaa" %} bobby {% else %}bobby not test {% endif %}" />
+ <input value=" {% ifequal my_msg.name|slice:'5' "aaa" %} bobby {% else %}bobby not test {% endif %}" />
+ <input value=" {{ my_msg.name }}" />
### 其他管道符号
+   https://docs.djangoproject.com/en/2.1/ref/templates/language/
### url配置技巧
+   通过url的别名来使用
+ urlpatterns = [ url(r'^form/$',getform, name='go_form')]
+ 页面中引用
+   <form action = "{% url 'go_form' %}"/>
### url配置技巧
+   url(r'^xx/',function_name,name='xx')
# 环境配置
## setting配置
+   数据库链接设置
+   makemigrations
+   migrate  
# user数据库设计
+   用户,课程,组织,用户操作
+   startapps user
## user
+   django默认user表 auth_user
+   id pwd last_login is_superuser first_name last_name email is_staff is_active date_joined
### 自定义user
+   from django.contrib.auth.models import AbstractUser
+   class UserProfile(AbstractUser):
+   def __unicode__(self): return self.username
### 配置 installed_apps
+   'users'
### 配置覆盖自定义users
+   AUTH_USER_MODEL ="users.UserProfile"
# model分层设计
+   operation:course organization users
# user模块设计
##   自定义user
## 邮箱验证码
+   class EmailVereifyRecode(models.Model):
+   code email send_type(注册,召回密码) send_time
## 轮播图  
+   title image url  index(轮播图的属性) add_time 
# course设计
+   课程--章节--视频
+   课程--资源
## course
+   name desc detail degree learn_times students  fav_nums image click_nums add_time
## Lession
+   course(ForeignKye(Course)) name add_time
## Video
+   lesson(ForeignKye(Lession)) name add_time 
##  CourseResource
+   course(ForeignKye(Course)) name download add_time 
# organization设计
## CourseOrg 
+   课程机构设计
+   **CityDict**
+   name desc add_time
+   **CourseOrg**
+   name desc click_nums fav_nums image address city(ForeignKey(CityDict))
##  Teacher
+   教师基本信息
+   Teacher
+    org(ForeignKey(CourseOrg)) name work_years work_company work_position points add_time
# 用户操作Operation信息 
+   咨询 评论 收藏 消息 我要学习的课程 
## UserAsk
+   name mobile course_name add_time
## CourseComments
+   user(ForeignKey(UserProfile)) course comments add_time
## UserFavorite
+   user(ForeignKey(UserProfile)) course(ForeignKye(Course)) teacher org fav_type
+   user(ForeignKey(UserProfile)) fav_id fav_type add_time
## UserMessage
+   user message has_read add_time
## 用户课程
+   user(ForeignKey(UserProfile)) course(ForeignKye(Course))  add_time
## 表的生成
+   makemigrations
+   migrative
+   配置setting_paths
# model的继承
------------------
# 后台管理
+   权限管理,少样式,快速开发
# 原生admin
+   createsuperuser
## 更改语言
+  settings更改
+   LANGUAGE_CODEdm
+   TIME_ZONE
+   USE_TZ
## admin改写dm
+   from .models import UserProfile
+   class UserProfileAdmin(admin.ModelAdmin):pass
+   admin.site.register(UserProfile,UserProfileAdmin)
# xadmin
## 安装1
+   pip install xadmin
+   setting 添加 installed_apps:xadmin crispy_forms
##安装２
+   github下载xadmin源码
+   复制xadmin到extra_app中
+   extra_app 设置为source_root
## 替换admin
+   import xadmin
+   urlpatterns = [ url(r'^xadmin/',xadmin.site.urls),]
+   makemigrations
+   migrate
## xadmin配置
+   model中新建adminx.py文件
+   from .models import xxmodel
+   class xxmodelAdmin(object):pass
+   xadmin.site.register(xxmodel,xxmodelAdmin)
## 显示设置
+   list_display = ['code', 'email', 'name']
+   search_fields = ['code', 'email', 'name']
+   list_filter = ['date', 'code']
## 后台不显示xxobject
+   重写__unicode(self): 方法
## 搜索外键特定的值
+   外键__xx
+   list_filter = ['course__name',]
## 全局配置
+   class BaseSetting(object):
+   class GlobalSettings(object):
##　主题
+   from xadmin import views
+   class BaseSetting(object):
+   enable_themes = True
+   use_booswatch = True
+   xadmin.site.register(views.BaseAdminView,BaseSetting)
## 页头&页角
+   class GlobalSettings(object):
+   site_title = "后台管理系统＂
+   site_footer = "xx网站＂
+   xadmin.site.register(views.CommAdminView,GlobalSettings)
## 收缩
+   GlobalSettings
+   menu_style = "accordion"
## 显示页面为中文
### apps.py
+   apps.py添加verbose_name
+   from django.apps import AppConfig
+   class BdmoduleConfig(AppConfig):
+   name = 'apps.bdmodule'
+   verbose_name = u'模块列表'
### __init__.py
+   __init__中添加default_app_config
+   default_app_config = "operation.apps.OperationConfig"
---------------------
# url拼接对应的html
##　html 
+   index放在对应的templete中
+   urls.py中
+   from django.views.generic import TemplateView
+   urlpatterns = [
    url('^$',TemplateView.as_view(template_name="index.html"),name="index")
]
## 静态资源
+   STATIC_URL = "/static"
+   STATICFILES_DIRS = [ os.path.join(BASE_DIR, "static")]
+   html中更改资源引用方式
+   css:href="/static/css/style.css"
+   js:href="/static/js/jquery.css"
+   html:href="/login/"
## 使用自定义view
+   views:return render(request,"login.html",{})
+   +   urls:urlpatterns=[    url('^login/$', user_login, name="login"),]
+   urls:urlpatterns=[    url('^login/$', LoginView.as_view(), name="login"),]
## 跨域访问
+   <form> {% csrf_token %} </form>
## 得到post参数
+   request.POST.get("username","")
# 用户登录
## 用户登录验证:基于函数
+   from django.contrib.auth import authenticate.login
+   成功返回user,否则返回None
+   user = authenticate(username = user_name,password = pass_word) 
+   if user is not None: 
+   login(request,user)
+   return render(request,'index.html')
+   else:
+   return render(request,'login.html',{"msg","用户名或者密码错误"})
### 前端接受
+   {% if requset.user.is_authenticated %} 
+   <div>xxxxxxxx</div>
+   {% else %}
+   <div>xxxxxxxx</div>
+   {% endif %}  
+   {{ msg }} 
### 自定义后台认证
+   使用邮箱验证
+   继承ModelBackend类
+   setting配置
### model配置
+   from django.db.models import Q
+   from django.contrib.auth.backends import ModelBackend
+   class CustomBackend(ModelBackend):
+       def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = UserProfile.objects.get(Q(username=username)|Q(email=username))
            if user.check_password(password):
                return user
        except Exception as e:
            return None

### setting配置
+   AUTHENTICATION_BACKENDS = (
    'users.views.CustomBackend',
)

## 用户登录验证:基于类
+   from django.views.generic.base import View
+   class LoginView(View):
+      def get(self,request):
+      def post(self,request):  
>   class LoginView(View):
    def get(self, request):
        return render(request, "login.html", {})
    def post(self, request):
        login_form = LoginForm(request.POST)
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

## form表单验证
+   users下新建forms.py
+    from django import forms
+   class LoginForm(forms.Form):
+    username = forms.CharField(required=True)
+    password = forms.CharField(required=True, min_length=5)
### form验证
+   login_form = LoginForm(request.POST)
+   if login_form.is_valid(): 验证逻辑
+   else:返回form
+   return render(request, "login.html", {"login_form":login_form}) 
### 前端处理
+   如果后台错误前端focus
+  <div class= "form-group  {% if login_form.errors.username %} errorinput {% endif %} "/>
+   显示错误信息
+   <div>{% for key,error in login_form.errors,items %}{{ key }}:{{ error }} {% endfor %} {{ msg}}</div>

## session和cookie机制
+ 用户登录--生成session_id和session_data--并有失效时间
## 注册
+ setiing配置
+   前端改变 <a href="{% url "register" %}"/>
+ 静态文件 <html> {% load staticfiles %} </html>
+  css: <link rel="stylesheet" href="{% static 'css/reset.css' %}"></link>
+   js: <script  src="{% static 'js/reset.css' %}"></script>
##   验证码
+   django-simple-captcha
+   setting配置:installed_app:'captcha'
+   url配置:url(r'^captcha/', include('captcha.urls'))
+   makemigration
+   验证码form设置
+   验证码view设置
+   前端设置 {{ register_form.captcha }} {% csrf_token %}
### form配置
+   定制错误信息
+   class RegisterForm(forms.Form):
+    email = forms.EmailField(required=True)
+    password = forms.CharField(required=True, min_length=5)
+   captcha = CaptchaField(error_messages={"invalid":u"验证码错误"})
### Register设置
+   class RegisterView(View): def get(): def post():
+   注册流程:验证用户账号密码--是否存在--不存在--加密--存储--发送邮箱--接受code--查询是否存在
+       存在--返回
+   from django.contrib.auth.hashers import make_password
+   from django.http import HttpResponse, HttpResponseRedirect
>   class RegisterView(View):
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
            user_profile.password = make_password(pass_word)
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

### 邮箱验证
+ setting配置:
+   EMAIL_HOST = "smtp.sina.com"
+   EMAIL_PORT = 25
+   EMAIL_HOST_USER = "projectsedu@sina.com"
+   EMAIL_HOST_PASSWORD = "admin123"
+   EMAIL_USE_TLS= False
+   EMAIL_FROM = "projectsedu@sina.com"
### 前端显示错误提示
+   错误的话input显示属性为focus
+   显示错误提示
+   回填用户的提交信息
+   <div class= "form-group  {% if register_form.errors.username %} errorinput {% endif %} "/>
+   <div>{% for key,error in register_form.errors,items %}{{ key }}:{{ error }} {% endfor %} {{ msg}}</div>
+   <input value ={{ register_form.email.value }} />
+    <input value ={{ register_form.password.value }} />
## 用户激活
+   提取url链接变量: ?p<active_code>.*
+    url(r'^active/(?P<active_code>.*)/$', AciveUserView.as_view(), name="user_active")
### view配置
+   找到--激活
+   未找到--激活失败
>   class AciveUserView(View):
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
## 找回密码
+  forms
+   url配置
+   views
+   前端设置
    + 显示错误信息
    +   错误聚焦
### forms
>   class ForgetForm(forms.Form):
    email = forms.EmailField(required=True)
    captcha = CaptchaField(error_messages={"invalid":u"验证码错误"})
### views
>   class ForgetPwdView(View):
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
##　重新设置密码
### form
>   class ModifyPwdForm(forms.Form):
    password1 = forms.CharField(required=True, min_length=5)
    password2 = forms.CharField(required=True, min_length=5)
### 修改密码views
>   class ModifyPwdView(View):
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
            return render(request, "password_reset.html", {"email":email, "modify_form":modify_form}

### 重新设置密码
>   class ResetView(View):
    def get(self, request, active_code):
        all_records = EmailVerifyRecord.objects.filter(code=active_code)
        if all_records:
            for record in all_records:
                email = record.email
                return render(request, "password_reset.html", {"email":email})
        else:
            return render(request, "active_fail.html")
        return render(request, "login.html")
----------------------
# xadmin 进阶

----------------------
# 序列化数据
## 原生
+   view的序列化
    +   json_list:[]
    +   原生json_dict :{}
    +   json_dict['xx'] = models.fields
    +   json_list.append(json_dict)
    +   HttpResponse(json.dumps(json_list, content_type = "application/json")
+   view的序列化优化(image,date不能序列化)
    +   from django.forms.model import model_to_dict
    +   json_dict = model_to_dict(model)
    +   json_list.append(json_dict)
+   django的序列化
    +   from django.core import serializers
    +   json_data = json.loads(serializers.serializer("json",goods))
    +   HttpResponse(json_data, content_type = "application/json")
+   django的序列化(JsonResponse)
    +   from django.core import serializers
    +   json_data = serializers.serializer("json",goods)
    +   JsonResponse(json_data,safe=False)
##  APIView
+   重写序列化类:serializer
+   继承APIView:重写get方法
+   data = xxmodel.objects.all()[:10]
+   serializer = xxmodelSerializer
+   return Responnse(serializer.data)
### Serializer
+   serializers.py
+   继承serializers.Serializer:需要写单独的每个fields
+   继承serializers.ModelSerializer:不需要写单独的fields
### 外键的使用
+ class xxSerializer(serializers.ModelSerializer): 
+   foreignKey = foreign_model_Serializer()
+   class Meta:
        +   model = xxnmodel
        +   fields = "__all__"

## GenericView
### mothod1
+   继承GenericAPIView,mixins.ListModelMixin
+   重写queryset和serializer_class
+   重写get方法
### mothod2(不用重写get方法)
+   继承generics.ListAPIView(继承了某些类,重写了get方法)
+   重写queryset和serializer_class
+    queryset = xxmodel.objects.all()
+     serializer_class = xxmodelSerializer
### 分页配置:setting中写死
+   REST_FRAMEWORK = { 'PAGE_SIZE':10}
### 自定义分页配置
+   继承pagenumberpaginaiton
+   重写 page_size
+   view中使用重写的翻页类:pagination_class = GoodsPagination
+   from rest_framework.pagination import PageNumberPagination
>   class GoodsPagination(PageNumberPagination):
    page_size = 12
    page_size_query_param = 'page_size'
    page_query_param = "page"
    max_page_size = 100

>   
class GoodsListViewSet(CacheResponseMixin, mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    """
    商品列表页, 分页， 搜索， 过滤， 排序
    """
    # throttle_classes = (UserRateThrottle, )
    queryset = Goods.objects.all()
    serializer_class = GoodsSerializer
    pagination_class = GoodsPagination

## GenericViewSet
+  该view继承ViewSetMixin,generics.GenericAPIView
+   ViewSetMixin重写了as_view方法
+   ViewSet和router共同使用
###　dict绑定
+   get绑定到list
+   urls配置：　　goods_list = GoodListViewSet.as_view({'get':'list',})
+   url引用:   urlpatterns=[ url(r'goods/$',goods_list,name="goods-list"),]
### router绑定
+   urls.py中
+   router = DefaultRouter()
+   router.register(r'goods',GoodsListViewSet)
+   urlpatterns=[ url(r'^',include(router.urls)),]
## 源码解析
+   viewset--genericApiview--APIview--view
+   mixin:createmodel listmodel retrieveModel UpdateModel DestrouModel(把get和list连接起来)
### genericApiView
+    queryset = None
+    serializer_class = None
+    lookup_field = 'pk'
+   lookup_url_kwarg = None  
+   是在ApiView的基础上组合封装各种ApiView
### GenericViewSet
+   继承genericApiView和ViewSetMixin
+   通过url配置来绑定
+   动态绑定许多方法
## Request
+   .data(post) .query_params(get) .parsers(解析器的类型）
## Response
+   data status template_name headers  content_type
## 过滤
###　数据源过滤
+  重写 genericViewSet的queryset方法
+   类中不需要写queryset属性
+   def get_queryset(self):
+   return xxmodels.objects.filter(xx__gt=100)
### 自定义过滤,搜索,排序
###  过滤字段
+   drf使用的过滤,搜索和排序
+   设置filter_backends,并添加过滤类 (DjangoFilterBackend,)
+   设置过滤字段 filter_fields = ('xxfields','xxfields')
### 搜索字段
+   设置filter_backends,并添加过滤类 (SearchFilter,)
+   设置过滤字段 search_fields = ('xxfields','xxfields')
### 排序字段
+   设置filter_backends,并添加过滤类 (filters.OrderingFilter,)
+   设置过滤字段 ordering_fields = ('xxfields','xxfields')  
###  demo

>   class GoodsListViewSet(CacheResponseMixin, mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    """
    商品列表页, 分页， 搜索， 过滤， 排序
    """
    # throttle_classes = (UserRateThrottle, )
    queryset = Goods.objects.all()
    serializer_class = GoodsSerializer
    pagination_class = GoodsPagination
    # authentication_classes = (TokenAuthentication, )
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = GoodsFilter
    search_fields = ('name', 'goods_brief', 'goods_desc')
    ordering_fields = ('sold_num', 'shop_price')

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        instance.click_num += 1
        instance.save()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)
###   django自定义的过滤
+   安装django-filters
+   installedapp:配置
+   新建filter.py
+   继承drf的FilterSet类
+   填写Meta中的:model,fields
### 使用
+   view中重写filter_class: filter_class =ItemCategoryFilter
### demo
+   import django_filters
+   from django.db.models import Q
+   from .models import Goods
>   class GoodsFilter(django_filters.rest_framework.FilterSet):
    """
    商品的过滤类
    """
    pricemin = django_filters.NumberFilter(name='shop_price', help_text="最低价格",lookup_expr='gte')
    pricemax = django_filters.NumberFilter(name='shop_price', lookup_expr='lte')
    top_category = django_filters.NumberFilter(method='top_category_filter')


    def top_category_filter(self, queryset, name, value):
        return queryset.filter(Q(category_id=value)|Q(category__parent_category_id=value)|Q(category__parent_category__parent_category_id=value))


    class Meta:
        model = Goods
        fields = ['pricemin', 'pricemax', 'is_hot', 'is_new']