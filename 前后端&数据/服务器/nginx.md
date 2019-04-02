#	1.1	主要内容
1.	代理服务
2.	动态缓存
3.	动静分离
4.	负载均衡
5.	nginx与Lua


1.	中间件架构（sql注入，请求访问控制/频率控制，防爬虫）
2.	中间件性能优化（http性能压测	，系统性能优化，性能瓶颈分析，nginx性能配置优化）
# 技术原理
1.	http协议原理
2.	linux协议原理

#	基础
1.	快速安装
2.	配置语法
3.	默认模块
4.	nginx的log
5.	访问限制
	1.	http请求连接
	2.	请求限制&连接限制
	3.	access模块配置语法
	4.	请求限制巨行星
	5.	**基本安全认证**
	6.	auth模块配置语法
	7.	**安全认证局限性**
#	实践
1.	静态资源web服务
	1.	什么是静态资源
	2.	静态资源服务场景
	3.	**静态资源服务配置**
	4.	**客户端缓存**
	5.	**静态资源压缩**
	6.	**防盗链**
	7.	**跨域访问**
2.	**代理服务**
3.	负载均衡
4.	缓存服务
#	深度学习
1.	动静分离
2.	rewrite规则
3.	进阶模块配置
4.	https服务
	1.	https协议
	2.	配置语法
	3.	nginx的https服务
	4.	苹果要求的https服务
5.	nginx与Lua开发
# 架构
1.	常见问题
2.	中间件优化
	1.	调试优化
	2.	性能影响因素
	3.	**操作系统性能优化**
	4.	**nginx性能优化**
3.	nginx与安全
4.	新版本
5.	架构设计

-------------
# 	环境
## 环境调试确认
1.	系统网络
ping www.baidu.com
2.	yum可用
yum list|grep gcc
3.	关闭iptables规则
iptables -L
iptables -F
iptabales -t nat -L
iptables -t nat -F
4.	停用selinux
getenforce
setenforce 0
## 辅助安装
1.	![](https://i.imgur.com/iKkCbnA.png)
2.	yum -y install wget httpd-tools vim
3.	![](https://i.imgur.com/TYE6UcG.png)
#	2.1 配置&介绍
1.	初始化
2.	cd /opt
3. 	sudo mkdir app download work backup logs
4. 	ping www.baidu.com
5. 	ctrl l 清理屏幕
5. 	开源高性能http中间件
6. 	其他中间件httpd iis gws 
7. 	优点
	1. IO多路复用epoll
	2. 轻量级（功能模块少，代码模块化）
	3. cpu亲和（affinity)
	4. sendfile
8.	版本：开发版 稳定版 历史版本
9.	sudo apt-get install nginx
10.	nginx -v
11.	nginx -V 查看参数版本
#	2.8 安装目录&编译参数
+	/etc/logrotate.d/nginx 	配置文件	nginx日志轮转：用于日志切割
+	目录，配置文件	nginx主配置配件		
	1.	/etc/nginx	
	1.	/etc/nginx/nginx.conf 
	1.	/etc/nginx/conf.d
	1.	/etc/nginx/conf.d/default.conf	
+	配置文件 	编码转换映射转换文件
	1.	/etc/nginx/koi-utf
	2.	/etc/nginx/koi-win
	3.	/etc/nginx/win-utf
+	/etc/nginx/mime.types	配置文件 http协议与content-type扩展名对应关系
+	目录		nginx模块目录
	1.	/usr/lib64/nginx/modules
	2.	/etc/nginx/modules
+	命令	 nginx服务的启动管理终端命令
	1.	/usr/sbin/nginx
	2.	/usr/sbin/nginx-debug
+ 	/var/cache/nginx 目录	缓存目录
##	编译参数&默认配置
1.	nginx.conf
2.	include /etc/nginx/conf.d/*.conf	读取所有配置文件
###	编译参数
![](https://i.imgur.com/svYYwm5.png)

![](https://i.imgur.com/o3rcccP.png)

![](https://i.imgur.com/7vln7QD.png)

![](https://i.imgur.com/dA9gljE.png)

![](https://i.imgur.com/syKu0uw.png)
###	默认配置
![](https://i.imgur.com/CxN4G1k.png)

![](https://i.imgur.com/kAwJmyo.png)
	
+	一个http多个server,一个server对应多个location
#	2.13	基于nginx的访问日志
1.	error.log 与access_log
2.	log_format机制
3.	cd /var/log/nginx
4.	sudo cat error.log
4.	format的机制
![](https://i.imgur.com/6Ir6fJy.png)
#	nginx模块讲解
1.	官方模块&第三方模块
2.	nginx -V 查看显示的内容
3.	--with-http_ssl_module 以--with开头显示的内容就是这些模块

##	特定模块
###	客户端状态
1.	--with-http_stub_module	nginx
>		Syntax:	stub_status；
	Default:--
	Context:server,location
![](https://i.imgur.com/RoabxDW.png)

1.	访问 xx.xx.xx.xx/mystatus
### 随机访问主页
1.	--with-http_random_index_module 目录中选择一个随机主页
>		Syntax:	random_index on|off；
	Default:random_index off;
	Context:location
>	    location / {
        root   /opt/app/code;
        #index  index.html index.htm;
        random_index on;
    }
###	http内容替换
1.	--with-http_sub_module	http内容替换
>		Syntax:	sub_filter string replacement；
	Default:--;
	Context:http,server,location

>		Syntax:	sub_filter_last_modified on|off;
	Default:sub_filter_last_modified off;	是否有更新
	Context:http,server,location

>		Syntax:	sub_filter_once_on on|off;
	Default:sub_filter_once on;	是否只匹配第一个
	Context:http,server,location

>		location / {
       root   /opt/app/code;
       index  index.html index.htm;
       sub_filter '<a>imooc' '<a>IMOOC';
       sub_filter_once off;
   	 }

# Nginx的请求限制
+	连接频率限制 -limit_conn_module
+	请求频率限制 -limit_req_module

![](https://i.imgur.com/wKLavWk.png)

+	http请求建立在一次TCP连接的基础上
+	一次TCP请求至少产生一次Http请求
+	连接限制配置
>		Syntax:	limit_conn_zone key zone=name:size;
	Default:--
	Context:http

>		Syntax:	limit_conn_zone number;
	Default:--
	Context:http,server,location

+	请求限制配置
>		Syntax:	limit_req_zone key zone=name:size rate=rate;
	Default:--
	Context:http

>		Syntax:	limit_req_zone zone=name [burst=number][nodelay];
	Default:--
	Context:http,server,location

> 	limit_conn_zone $binary_remote_addr zone=conn_zone:1m;
    limit_req_zone $binary_remote_addr zone=req_zone:1m rate=1r/s;
	server {
    listen       80;
    server_name  localhost;
    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;
    location / {
        root /opt/app/code;
        limit_conn conn_zone 1;
        #limit_req zone=req_zone burst=3 nodelay;
        #limit_req zone=req_zone burst=3;
        #limit_req zone=req_zone; 
        index  index.html index.htm;
    }

# Nginx的访问控制
+	基于IP的访问控制 http_access_module
+	基于用户的信任登录 http_auth_basic_module
+	基于$remote_addr来限制信任，客户端使用代理时存在一定问题
+	解决方法
	1.	http_x_forwarded_for记录了中转过程，http协议有求
	2.	结合geo模块
	3.	通过http自定义变量传递

+	IP访问控制

>		Syntax:	allow  address|CIDR|unix:|all;
	Default:--
	Context:http,server,location,limit_except

>		Syntax:	deny  address|CIDR|unix:|all;
	Default:--
	Context:http,server,location,limit_except

>		location ~ ^/admin.html {
	root   /opt/app/code;
    deny 222.128.189.17;
    allow all;
    index  index.html index.htm;
	 }

>		location ~ ^/admin.html {
        root   /opt/app/code;
        allow 222.128.189.0/24;
        deny all;
        index  index.html index.htm;
    }

+	认证访问控制
+	用户信息依赖文件
+	操作管理机械，效率低下
+	解决犯法
	1.	结合LUA实现高效认证
	2.	和LDAP打通，利用nginx-auth-ldap模块

>		Syntax:	auth_basic string|off;
	Default:auth_basic off;
	Context:http,server,location,limit_except

>		Syntax:	auth_basic_user_file file;
	Default:--;
	Context:http,server,location,limit_except

>		location /^admin.html{
	root	....
	auth_basic "auth access test,pls input your pwd";
	auth_basic_user_file /etc/nginx/auth_conf;
	indx ......
}

1.	htpasswd
1.	
1.	cd /etc/nginx/
2.	htpasswd -c ./auth_conf jeson
3.	输入密码
4.	ls ./auth_conf
5.	nginx -t -c /etc/nginx/nginx.conf
6.	nginx -s reload -c /etc/nginx/nginx.conf

----------------------
#	3.1	应用场景
+	静态资源&动态资源
+	CDN配置
![](https://i.imgur.com/goNIxGO.png)

+	配置文件文件读取
>		Syntax:	sendfile string|off;
	Default:sendfile off;
	Context:http,server,location,if in location

>		Syntax:	tcp_nopush on|off;
	Default:tcp_nopush off;
	Context:http,server,location
	send_file开启的情况下，提高网络包的传输效率

>		Syntax:	tcp_nodelay on|off;
	Default:tcp_nodelay off;
	Context:http,server,location
	keepalive连接下，提高网络包的传输实时性

>		Syntax:	gzip on|off;
	Default:gzip off;
	Context:http,server,location,if in location
	压缩传输


>		Syntax:	gzip_comp_level level;
	Default:gzip_comp_level 1;
	Context:http,server,location



>		Syntax:	gzip_http_version 1.0|1.1;
	Default:gzip_http_version 1.1;
	Context:http,server,location

+	预读gzip模块	http_gzip_static_module
+	应用支持gunzip压缩方式	http_gunzip_module

![](https://i.imgur.com/u97Tpf1.png)

# 	服务器缓存
+	缓存机制
+	添加Cache-Control，Expires头
>		Syntax:	expires [modified] time;
	expires	epoch|max|off;
	Default:expires off;
	Context:http,server,location,if in location 

>		location {
	expires 24h;
	root ...........
	}
![](https://i.imgur.com/7tjhnL6.png)
+请求机制
![](https://i.imgur.com/kI3kVI0.png)

#	跨域访问
>		Syntax:	add_header name value [always];
	Default:--;
	Context:http,server,location,if in location 
	如果允许跨域访问，需要设置：Access-Control-Allow-Origin *

>		location{
	add_header Access-Control-Allow-Origin http://www.jesonc.com;
	add_header Access-Control-Allow-Methods	GET,POST,DELETE,OPTIONS;
	root ........	
}

>		location{
	add_header Access-Control-Allow-Origin *;
	add_header Access-Control-Allow-Methods	GET,POST,DELETE,OPTIONS;
	root ........	}

#	防盗链
+	区别正常用户和非正常用户
>		Syntax:	valid_feferers none|blocked|server_names|string...;
	Default:--;
	Context:server,location


-------------
#	3.2 代理服务
![](https://i.imgur.com/fblSaqT.png)

+	正向代理&反向代理
	
	1.	正向代理的对象是客户端
	1.	反向的对象是是服务器

>		Syntax:	proxy_pass URL;
	Default:--;
	Context:location,if in location,limit_except
	url一般是这种形式 http://localhost:8000/uri/


+	其他配置项：缓冲区/跳转重定向/头信息/超时
+	常用配置信息

>		proxy_redirect default;
	proxy_set_header Host $http_host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_connect_timeout 30;
	proxy_send_timeout 60;
	proxy_read_timeout 60;		
	proxy_buffer_size 32k;
	proxy_buffering on;
	proxy_buffers 4 128k;
	proxy_busy_buffers_size 256k;
	proxy_max_temp_file_size 256k;

>	    location / {
        proxy_pass http://127.0.0.1:8080;
        include proxy_params;
    }


#	3.3	负载均衡
+	全局负载均衡化
![](https://i.imgur.com/sgAkOin.png)

+	SLB
![](https://i.imgur.com/5I6UMIP.png)

+	四层负载均衡和七层负载均衡（nginx)
![](https://i.imgur.com/h1PNMVa.png)


>		Syntax:	upstream name {..}
	Default:--
	Context:http

>	    upstream imooc {
 	 server 116.62.103.228:8001; down;
     server 116.62.103.228:8002; backup;
     server 116.62.103.228:8003; max_fails=1 fail_timeout =10s;b 
    }
	server {
    listen       80;
    server_name  localhost jeson.t.imooc.io;
    #charset koi8-r;
    access_log  /var/log/nginx/test_proxy.access.log  main;
    resolver  8.8.8.8;   
    location / {
        proxy_pass http://imooc;
        include proxy_params;
    }
	参数：down backup max_fails fail_timeout max_conns负载均衡的状态

+ 轮询策略
![](https://i.imgur.com/P9lzv6G.png)

#	3.4	缓存服务器
+	服务端缓存/代理端缓存/客户端缓存
![](https://i.imgur.com/H4oxspT.png)

----------
#	4.1	动静分离
+	未完成待续

#	nginx常用命令
+	/usr/local/nginx/sbin/nginx              # 启动Nginx
+	/usr/local/nginx/sbin/nginx -t           # 测试配置文件是否有错误
+	/usr/local/nginx/sbin/nginx -v           # 查看Nginx版本
+	/usr/local/nginx/sbin/nginx -V           # 查看Nginx版本和编译安装时的编译参数
+	/usr/local/nginx/sbin/nginx -s stop      # 强制停止Nginx服务
+	/usr/local/nginx/sbin/nginx -s quit      # 优雅地停止Nginx服务（即处理完所有请求后再停止服务）
+	/usr/local/nginx/sbin/nginx -s reload    # 重新加载Nginx配置文件，然后以优雅的方式重启Nginx
+	    sudo apt-get remove nginx nginx-common 		# 卸载删除除了配置文件以外的所有文件。
+		sudo apt-get purge nginx nginx-common 		# 卸载所有东东，包括删除配置文件。
+		sudo apt-get autoremove 		# 在上面命令结束后执行，主要是卸载删除Nginx的不再被使用的依赖包。
+		sudo apt-get remove nginx-full nginx-common 	#卸载删除两个主要的包。
+		sudo apt-get install nginx		#	nginx安装
+	sudo apt-get install libpcre3 libpcre3-dev  	#安装关联的包
