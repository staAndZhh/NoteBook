#环节
1.	域名
2.	服务器
3.	域名备案
4.	配置服务器环境
5.	配置数据库
6.	远程部署发布与更新

# 环境变量配置

## 	临时
1.	查看环境变量
2.	echo $PATH

1.	临时环境
2.	export PATH=/usr/local/mongodb/bin:$PATH
3.	立即生效,临时改变，当前的终端窗口中有效，窗口关闭后就会恢复原	有的path配置,仅对当前用户

##	用户
1.	用户变量 修改.bashrc
2.	vim ~/.bashrc & vi ~/.bash_profile
3.	在最后一行添加 
4.	export PATH=$PATH：/usr/local/mongodb/bin
5.	source ~/.bashrc
6.	仅对当前用户，永久有效

##	全局
1.	全局变量 修改profile文件
2.	vim /etc/profile
3.	在最后一行添加export PATH=$PATH：/usr/local/mongodb/bin
4.	source /etc/profile
5.	对所有用户有效

1.	MAVEN_HOME=/data/software/maven
2.	export MAVEN_HOME
3.	export PATH=${PATH}：${MAVEN_HOME}/bin
	
1.	export NODE_HOME=/usr/local/node/node-v6.11.2/bin
2.	export PATH=$NODE_HOME:$PATH

#	ssh连接
1.	Ubuntu14.04&putty
2.	主机IP地址 默认用户名：阿里云默认为root 
3.	ssh root@120.26.235.4 （公网IP：47.94.10.71）
4.	yes 加入指纹，输入法切换为英文
5.	输入登录密码：5201314zhh123.

# 无密码登录本地生成
1.	查看是否以前配置过
2.	查找.ssh隐藏文件下的是否有 id_rsa id_rsa.pub文件
3.	生成密匙文件，代开
4.	bash文件
4.	ssh-keygen -t rsa -b 4096 -C "tjzhanghuanhuan@gmail.com"
5.	不需要密码，回车跳过
6.	eval "$(ssh-agent -s)" 运行代理
7.	ssh-add ~/.ssh/id_rsa	运行添加到代理中
#	服务器生成
1.	ls 查看文件
2.	ls -a
3.	ssh-keygen -t rsa -b 4096 -C "tjzhanghuanhuan@gmail.com"
4.	回车到底
5.	eval "$(ssh-agent -s)"
6.	ls -a
7.	cd .ssh
8.	ssh-add ~/.ssh/id_rsa
9.	vi authorized_keys  授权可用
10.	esc & sheft : & wq!

#本地公钥复制到服务器
1. 复制本地的 id_rsa.pub的文件内容
2. 进入服务器打开 authorized_keys复制内容
3. vi authorized_keys 
4. i & ctrl v 粘贴 &esc &shift :
5. wq!
6. chmod 600 authorized_keys 更改权限
7. sudo service ssh restart 重启
8. 新开终端再次连接服务器
9. 直接连接成功

#修改默认端口22
1.	sudo vi /etc/ssh/sshd_config
2.	i 
3.	新开端口以防止出问题
4.	找到Port 修改为39999
5.	UseDNS 修改为no
6.	新增一行 AllowUsers zhh_manager
7.	esc & shift : &wq！
8.	sudo service ssh restart 重启
9.	ssh -p 39999 root@120.26.235.4 验证登录

#	禁用root密码等录
1.	sudo vi /etc/ssh/sshd_config
2.	i
3.	PermitRootLogin 修改为 no
4.	PasswordAuthentication 修改为 no
5.	permitEmptyPasswords 修改为 no 
6.	shift : &wq
7.	sudo service ssh restart

#配置iptable防火墙
1.sudo apt-get update && sudo apt-get upgrade

-----------------	
#描述统计
1.	fdisk -l 查看硬盘
2.	df -h 查看硬盘使用情况
3.	ctrl d 退出命令行

#增加用户
1.	adduser zhh_manager
2.	输入密码：空格
3.	个性化信息
4.	gpasswd -a zhh_manager sudo  授权(以sudo的角色调用系统命令，进入到sudo的组里）
5.	sudo visudo
6.	找到 User privilge specification
7.	增加 zhh_manager ALL=(ALL:ALL) ALL 规则生效，任何人，任何组，任何命令
8.	ctrl X & shift Y & enter
9.	service ssh restart 重启数据

1.	新开命令行
2.	输入新的 zhh_manager 登录验证

-----------
#	环境设置
1.	sudo apt-get update
2.	sudo apt-get install vim openssl build-essential libssl-dev wget curl git
3.	安装node.js
4.	搜索node当前版本，并在github搜索nvm
5.	运行	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
6.	nvm
7.	nvm install v8.9.4 或者	nvm install stable
8.	nvm use v8.9.4
9.	nvm alias default v8.9.4
10.	node -v 
11.	npm --registry=http://registry.npm.taobao.org install -g npm  配置淘宝源
12. npm -v
12.	echo fs.inotify.max_user_watches =524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p  增加系统文件监控树
13.	npm --registry=http://registry.npm.taobao.org install -g cnpm  安装cnpm
14.	npm i pm2 webpack gulp grunt-cli -g

----------
#	运维并自动重启node
1. npm install pm2 -g
2. pm2 start app.js
3. pm2 list
4. pm2 show app
5. pm2 logs

#	使用80端口转发原有的其他端口
1.	sudo service apache2 stop
2.	update-rc.d -f apache2 remove
3.	sudo apt-get remove apache2
4.	sudo apt-get update
5.	sudo apt-get install nginx
6.	y
7.	nginx -v
8.	cd /etc/nginx/
9.	ls
10.	cd conf.d
11.	ls
12.	pwd
13.	sudo vi imooc-com-8081.conf
14.	i
15.	配置
>	
		upstream imooc{
			server 127.0.0.1:8081;}
		server {
			listen 80;
			server_name 47.94.10.71;
			location / 
				{
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
			proxy_set_header Host $http_host;
			proxy_set_header X-Nginx-proxy true;
			proxy_pass http://imooc;
			proxy_redirect off;
				}
			}

16.	wq!
17.	cd ..
18.	sudo vi nginx.conf
19.	include 查看是否加载了所有文件
20.	sudo nginx -t
21.	sudo nginx -s reload

#域名指向ip地址
1.	域名信息实名认证
2.	修改DNS地址

----------
#git复制
1.	 git config --global user.name "staAndZhh"
2.	 git config --global user.email "610493710@qq.com"
3.	 git init
4.	 git add .
5. 	 git commit -m "First commit"
6. 	 生成公钥添加rsa_pub到github的ssh中
7.	 git remote add  origin git@gitee.com:staAndZhh/backend-website.git
8.	 git push -u origin master
9.	 git fetch
10.	 git merge origin/master
11.	 git push -u origin master
12.	 服务器复制
13.	 cat id_rsa.pub
14.	 添加公钥到码云
15.	 git clone git@gitee.com:staAndZhh/backend-website.git
#	python开发
##	mysql
1.	sudo apt-get install mysql-server
2.	输入密码 root
3.	mysql -u root -p 
4.	输入密码 root
5.	show databases
6.	exit
7.	更改ip绑定位置
8.	vim /etc/mysql/mysql.conf.d/mysql.cnf
9.	更改 bind-address 127.0.0.1 为 = 0.0.0.0 只是为了连接方便
10.	sudo service mysql restart
11.	ifconfig
12.	依次在mysql下运行
13.	![](https://i.imgur.com/atTqr1e.png)
14.	这样就可以在win环境下连接服务器的mysql
15.	需要配置阿里云安全策略开放公网3306借口
16.	详情配置如下	[http://www.jb51.net/article/121173.htm](http://www.jb51.net/article/121173.htm)
16.	windows下配置
17.	控制面板-程序-启用或者关闭功能-Telnet/TFTP服务器-确定

#	Ubuntub安装双py
1.	安装python的依赖
2.	sudo apt-get install libc6-dev gcc
3.	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm
4.	sudo apt-get update
4.	sudo apt-get install python3
5.	方法2
6.	sudo apt-get install software-properties-common
7.	sudo add-apt-repository ppa:jonathonf/python-3.6
8.	sudo apt-get update
9.	sudo apt-get install python3.6


## py
1.	pip install virtaulenv
2.	pip install virtualenvwrapper
3.	vim ~/.bashrc
4.	![](https://i.imgur.com/hdIp7Br.png)
4.	source ~/.bashrc
5.	workon
6.	makevirtualenv mxonline
7.	pip list
8.	workon mxonline
9.	win10导出为包的文件
10.	进入虚拟环境
9.	pip freeze > requirements.txt
10.	服务器	
11.	vim	requirements.txt 复制内容
12.	pip install -r requirements.txt	服务器安装
13.	sudo apt-get install libmysqlclient-dev
13.	pip install uwsgi
14.	wsgi文件配
15.	上传文件到服务器
16.	进入django项目的文件夹中
16.	uwsgi --http :8000 --module MxOnline.wsgi
17.	如果进入uwsgi的层级目录：
18.	uwsgi --http :8000 --module wsgi
19.	python manage.py runserver
20.	python manage.py runserver 0.0.0.0:8000
21.	uwsgi --http :8000 --wsgi-file test.py
22.	python manage.py runserver 0.0.0.0:8000 #起django
23.	uwsgi --http :8000 --module mysite.wsgi #起uwsgi

##	uwsgi配置nginx
1.	Request > Nginx > uWSGI > Django > uWSGI > Nginx > Response
2.	请求先交由Nginx，如果是静态内容就自己处理了，如果是动态内容就交给uWSGI服务器，uWSGI服务器处理整个Django项目的Python代码，响应请求，原路返回，但是与fastcgi不同，Nginx、uWSGI和Django可以独立部署，然后整合。
3.	ps ax | grep uwsgi
4.	kill 7611 7612 7614

## uwsgi使用 
[http://www.projectsedu.com/](http://www.projectsedu.com/)

## uwsgi 重启
## django重启
sudo fuser -k 8000/tcp
sudo netstat -tulpn | grep:8000
lsof -i:8000
kill -9 PID
ps ax | grep uwsgi
pkill -f uwsgi -9
uwsgi --http :8000 --wsgi-file test.py 
uwsgi --http :8000 --module smbd.wsgi
uwsgi --http :8000 --ini smbd.wsgi
uwsgi -i 你的目录/Mxonline/conf/uwsgi.ini &
uwsgi --ini uwsgi.ini
## reset config
sudo fuser -k 8000/tcp
ps ax | grep uwsgi
pkill -f uwsgi -9
uwsgi -i /home/zhh_manager/.virtualenvs/semirpro/smbd/conf/uwsgi.ini &
sudo nginx -t
sudo /etc/init.d/nginx restart
## nginx关键域
http配置域
upstream配置域
### 层次关系
events {
...
}

http{
...
	upstream{
	...
	}
	server{
	...
		location {
		...
		}
}
}
mail {
...
}
## 部署
###  web Client <=>uWSGI <=> python <=> Django
#### test.py
test.py
uwsgi --http :8000  --uwsgi-file test.py 
#### django
python manage.py runserver 0.0.0.0:8000
#### django <=> uwsgi
uwsgi --http :8000 --module smbd.wsgi
uwsgi --http :8000 --ini smbd.wsgi
#### 命令行配置改为文件配置
chdir =
module = 
http =:8000
http-socker =:8000
master = True
processes = 4
threads = 1
vacuum = true


uwsgi --ini xx/xx/smbd.ini
### nginx <=> uWSGI
uWSGI启动django
nginx反向代理配置
收集静态文件，完成静态文件寻址配置

# the upstream component nginx needs to connect to
upstream django{
# server unix:///path/to/your/mysite/mysite.sock; # for a file socket
server 127.0.0.1:8000; # for a web port socket (we'll use this first)
}
# configuration of the server

server {
# the port your site will be served on
listen      80;
# the domain name it will serve for
server_name	.semir.pro; # substitute your machine's IP address or FQDN
charset     utf-8;

# max upload size
client_max_body_size 75M;   # adjust to taste

# Django media
location /media  {
    alias /home/zhh_manager/.virtualenvs/semirpro/smbd/media;  # 指向django的media目录
}

location /static {
    alias /home/zhh_manager/.virtualenvs/semirpro/smbd/static; # 指向django的static目录
}

# Finally, send all non-media requests to the Django server.
location / {
    proxy_pass	http://django;
#   include     /home/zhh_manager/.virtualenvs/semirpro/smbd/conf/nginx/uwsgi_params; # the uwsgi_params file you installed
}
}