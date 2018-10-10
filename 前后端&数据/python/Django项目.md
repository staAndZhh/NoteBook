# 页面返回
### TemplateView
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

# 用户验证模块