#Linux的常用命令：
	ls 		显示当前文件夹目录 ll -->详细信息 ls -a 显示所有文件 ls -lhSr
	w		查看登录的帐号，还可以查看cpu负载情况，who am i ,who 看的信息少些
	last		查看过去用户登录信息，lastlog //用户最后登录的日期
	cd		切换目录 cd - -->返回上一目录 cd ~ -->用户文件夹  cd / -->更目录
			cd .. 上一层目录  dirname ~baidu--> /home basename ~baidu--> baidu
	pwd		显示当前目录
	shutdown -h 10 	(Root下)10分钟后关闭系统
	halt		通用立即关闭系统
	useradd bbc	添加用户	passwd abc 更改用户密码
	clear/Ctrl+L	清屏，把命令行清屏,相当于Windows的CLS命令
	dhclient		获取上网地址	ifconfig 查看网络参数
	Ctrl+Alt+F2	切换到全命令模式，即CLI命令行
	Ctrl+Alt+F1	跳回GUI界面
	tab		自动补全

	vi index.html	编辑指定文本文件	Esc+ :wq 保存退出
	mv 1.html 2.htm 	移动文件，相当重命名
	unalias cp			解除cp覆盖文件提示确认
	cp -r file1 dir1 dir2	将文件file1和目录dir1复制到dir2
	echo		把内容写入文件，echo "Hello World">>index.html
				echo -n "please input a value:" #不换行
	mkdir		新建文件夹 mkdir -p admin/model ，递归创建文件夹
	rmdir		删除文件夹 rmdir -p admin/model ，递归删除空文件夹
	rm		删除文件  rm -rf admin -->递归删除文件

	data		显示日期，示例:data "+%Y-%m-%d %H:%I:%S"
	cal		显示当前日历，含星期的日历 cal 1-28 2016
	cat		显示里面的内容 示例：cat index.html
	touch		修改属性 touch -t 0902211033 qq 修改qq文件夹的最后修改时间
	more		cal 2017 |more 分屏显示数据，回车/空格控制显示
			more index.html 分页看文件q退出
			less index.html 查看文件，可以查找,/ 搜索 n 向下 N向下 q退出
			tail -5 index.html 显示后5行	head -3 index.html 显示前三行
	find		find / -user qq 查找用户的文件 find / -name qq 查找qq文件名
			find / -size +6000k
			find / -name index.html -exec rm -rf {} \; 查找文件并执行命令
			find / -nouser -exec rm -ri {} \; //删除没有用户的文件和文件夹
			find /var/www/html -type d -exec chmod 0755 {} \;//目录更改权限
			find /www/html ! -type -d -exec chmod 640 {} \;//修改文件权限
	which		which passwd  查找passwd位置   whereis ls 查看命令位置
			updatedb 更新数据库
	locate		locate index.html 查看普通文件
	du		查看目录大小, du -sh
	netstat		netstat -tnulp  //查看tcp监听端口,数字显示，并且显示PID
	grep		grep -vxFf a.log b.log >diff.log //比较两个日志的不同

#	Linux的目录结构：
	bin		常用命令
	sbin		超级管理员命令，shutdown -h now等
	boot		启动方式
	dev		设备文件
	etc		配置文件夹
	home		用户目录，不含Root
	usr		字体，帮助文档，相当windows目录
	lib		共享函数库
	mnt		默认挂载区

#	Shell简单使用：
	shell 		用户与内核沟通的中间人
	GUI		图形化SHELL
	CLI		命令行SHELL

#	简单的SSH登录设置命令-远程登录：
	vi /etc/selinux/config -->修改 SELINUXTYPE=disabled  //跳过安全检查

	vim /etc/sysconfig/network-scripts/ifcfg-eth0	//固定IP
	修改添加如下：
	ONBOOT=yes
	BOOTPROTO=static
	NETMASK=255.255.255.0
	IPADDR=192.168.0.115
	GATEWAY=192.168.0.1
	DNS1=8.8.8.8

	用SSH登录Linux，工具如PuTty:192.168.0.115:22
	使用SSH远程复制：把本地文件复制到远程主机
	Linux下：ssh 192.168,0.116
	本地文件：scp index.html root@192.168.0.115:/tmp
	useradd -s /sbin/nologin tom  //添加用户，不能登录ssh
	usermod -s /sbin/nologin doobo //修改用户不能ssh登录

#	权限（帐号、角色-组、其它人）：
	-rw-rw-r--		rw-所有者	rw- 所属组 r-其他人---664
	umask -S		显示默认权限
	r w s		4 2 1  读-4 写-2 执行-1
	chmod		修改权限 chmod 777 b.sh  chmod o-w b.sh 文件的其它用户除去写权限

	rwx--目录		w-新建-改名-删 x-进去 r-读文件列表 rx一般一块用
	注意：对文件的删、更名等权限属于该文件的所在目录的权限，与该文件权限无关

	chown		修改文件的所有者 chown root index.html
			或者 chown root:root index.html  //修改所有者和用户组
			chown -R root:root admin  //修改admin内所有文件和文件夹的所属用户
	/etc/shadow	用户密码文件 15855:0:9999:7::: 注册时间，多少天才能修改密码，多
			少天必须修改密码，提前几天通知，后面宽限多少天，帐号失效时间
	chgrp		chgrp hd www 更改文件用户组 groupadd hd 创建组 groupdel hd 删除组
	usermod		修改用户信息 usermod -G hd doobo 给doobo添加附加组
				   usermod -G '' doobo 删除doobo的附加组
			usermod -L doobo 锁定用户 usermod -U doobo 解锁用户
			passwd -l doobo 锁定用户  passwd -u doobo  解锁用户
	userdel		删除用户 userdel doobo --》userdel -r doobo删除doobo和它的home目录
	chage		修改用户的属性，chage -m 3 doobo //多长时间才能修改密码
			chage -M 10 doobo 多长时间必须修改密码
			chage -W 2 doobo 密码到期前多长时间提醒我
			chage -I 5 doobo 密码到期后宽限5天
			chage -E 2018-2-20 doobo 帐号密码什么时候失效 0 立刻失效 -1 不失效
	SUID设置		chmod 4755 /usr/biin/passwd  chmod 2755 indexdir //给目录设置sgid
			chmod 1777 indexdir //只能删除自己建立的文件 设置sbit
	acl		setfacl -m u:u2:rwx acldir //给u2添加特殊权限
			setfacl -m g:hd:rwx acldir  //给组添加特殊权限
			setfacl -m m:r acldir  //给目录的mask添加读权限，相交其它权限
			getfacl acldir//获取acldir目录的acl列表 ，只支持ext2到ext4格式磁盘
	sudo		/etc/sudoers  //visudo 进行编辑  doobo ALL=(ALL)  ALL 能任何地方，
			替代任何用户，执行所有的命令，相当root帐号，但需要sudo passwd qq
			doobo ALL=(root) /sbin/halt,/sbin/shutdown -h now  //添加指定命令
			但必须使用sudo 加指定的命令执行
			doobo ALL=(root) !/usr/bin/passwd,!/usr/bin/passwd root,
			/usr/bin/passwd [a-zA-Z0-9]*  //给用户修改密码权限，不能修改root
			Cmnd_Alias BAN = /sbin/shutdown -h now,!/usr/bin/passwd,...
			baidu ALL=(root) BAN  //别名批量设置权限
			User_Alias BANUSER = doobo,qq,baidu  //用户分组设置权限
			%hd  ALL=(root) BAN  //给hd组添加权限
	pkill		pkill -kill -t pts/1 //踢出用户，通过w获取pts/1的值
	write		write doobo pts/0 --》hello --》Ctrl+D //给用户发送消息
	wall		wall "system will shutdown!"  //广播发送消息



#	环境变量，不在当前目录寻找
	echo $PATH			输出环境变量
	PATH=$PATH:/home/baidu	添加环境变量
	./a.sh			执行当前文件夹内的脚本，必须加./
	whereis ls			查看ls的所属文件
	//软连接-快捷方式：
	ln -s /user/local/baidu/baidu.sh /usr/bin/baidu


#	Linux磁盘分区：
	sync	同步内存数据到磁盘
	df	分区 df -h
	fdisk	显示磁盘 fdisk -l
		fdisk /dev/sdb //选择磁盘分区
		n //新增分区
		1 p //主分区 +5G //设置分区大小
		t //修改分区结构  L//显示分区格式代码
	mkfs	格式化 mkfs -t ext4 /dev/sdb1
	mount	挂载 mkdir /mnt/sdb1 mount /dev/sdb1 /mnt/sdb1
		卷标挂载 e2label /dev/sdb1 web //起卷标
		         mount -L "web" /www	//用卷标挂载
		mount /dev/cdrom /media	//挂载光驱
	umount	弹出 umount /dev/sdb1
	lsof	查看占用     lsof /mnt/sdb1
	fatab	自动挂载，vim /etc/fstab 添加行：/dev/sdb1 /www ext4 defaults 0 0
		卷标自动挂载：LABEL=www /www ext4 defaults 0 2
		模拟挂载	    mount -a //出错会提示

#	忘记root密码的解决方案和fstab文件查错
	重启或启动---》》按...--》》按e--》选择kernel --》按e--》》输入single回车--》按b
	mount -n -o remount,rw /	//重新挂载根分区，可读可写
	会进入单用户模式，使用passwd root 既可以修改root密码

#	压缩与解压缩，备份etc目录：
	zip passwd.zip passwd  //压缩单个文件 zip -r passwd.zip passwd 递归压缩，压缩文件夹
	unzip passwd.zip	  //解压缩
	gzip	passwd	  //压缩文件   gzip -r etc	递归压缩文件
	gzip -d	passwd.gz	  //解压缩
	bzip2	passwd	  //压缩文件，不能递归压缩，自动删除源文件
	bzip2 -d  passwd.bz2   //解压缩，自动删除压缩包 -k 保留
	tar 	-j bzip2压缩	-z gzip压缩	-f 设置文件名
		-c 新建打包文件	-v 显示执行过程
		tar zcvf /tmp/root/passwd.tar.gz /tmp/root/passwd 压缩文件
		tar zxvf passwd.tar.gz //解压缩，必须指定类型z或者j
		tar zxvf passwd.tar.gz -C ~qq //解压到用户qq目录下
#	vim的常用方法：
	1、yum install vim 安装vim  Esc 普通模式，命令输入
	2、:set nu		显示行号  :set nonu  :set tabstop=2
	3、i 当前插入  I行首插入 a 下一字符 A 行尾 o  下一行 O 上一行 u 撤销
	   dd 剪切 p或P 粘贴  yy 复制  3yy 复制3行 5dd 剪切3行
	4、:sh	退回命令行，exit继续进入编辑器 :sp b.txt 新开窗口 ctrl+w 上下键 切换编辑区
	5、! 强制执行命令 :q! :wq! :x!
	6、:w  b.txt 另存为
	7、:0 :1 :2546 跳转到行 :/qq 查找qq :/n 向下查找 :?f 向上查找
	8、:1,5s/$f/$a/g  从第一行到第五行执行替换，把$f替换为$a，全局替换
	   :1,5s/$a/$b/gc 	每次提示确定
	9、:r b.txt	把b.txt的数据导入进来
	10、:set autoindent  自动缩进 cd --> vi .vimrc --> set nu set autoindent set tabstop=2

#	软件安装与常用设置：
	wget	wget http://www.memcached.org/files/memcached-1.4.34.tar.gz //下载文件
	tar --> ./configure --prefix=/usr/local/memcached--> make --> make install
						或 make && make install
	ldconfig	//添加动态函数库到内存
	/etc/ld.so.conf //动态函数包含的目录 vi /etc/ld.so.conf
	rpm	//安装特定软件，有数据库记录 rpm -qa  //显示安装的rpm软件
		rpm -ivh mysql_686.rpm //安装rpm包
		rpm -qa | egrep -i '^tree'  //查找以tree开头不屈服大小写的软件名
		rpm -e 软件包名	//删除安装的软件包
	yum	yum install vim	//通过源安装软件
		修改yum的源地址：
		cd /etc/yum.repos.d/ --> rm -rf *
		http://mirrors.163.com/  //从新源下载新配置文件
		wget -O /etc/yum.repos.d/CentOS-Base.repo
			http://mirrors.aliyun.com/repo/Centos-6.repo
		放入/etc/yum.repos.d/目录下
		yum clean all
		yum makecache  //更新源地址
		yum search mysql //搜索软件
		yum erase mysql  //卸载软件
		yum -y update >/tmp/yum.log  & 更新系统，正常和错误的
			信息多输出到文件，并且后台运行


#	任务计划，定时执行：
	yum install at -->service atd start  //d是守护的意思mysqld、atd
	at 12:49  --> touch /tmp/12.49.test --> ctrl+D 退出命令编辑
	at -l	查看已经创建的任务 at -c 2 查看任务详细 at -d 4 删除任务
	ls -ld / >/tmp/ls.txt  //把命令执行成功的结果输出到文件
	vi /etc/at.allow  //配置允许执行at的用户 at.deny  //配置禁止执行at
	crontab	//周期性的任务
		crontab -e  //添加任务
		/etc/crontab  //管理员添加任务
		crontab -l  //查看任务 crontab -r 删除任务
		*/5 * * * *  ls / >>/tmp/ls.log //每五分钟执行一次
		0 * * * *	每小时执行  0 0 * * 0  每周执行  0 0 1 1 *  每年执行
		0 0 * * *  每天执行    0 0 1 * *  每月执行
		32 20 6,10 * *  每月的6号10号的20：32分执行命令
	watch	watch cat /tmp/cron.log  //每两秒执行一下命令

#	进程管理
	进程	运行中的程序
	ps	查看服务 ps aux  或 ps aux |grep atd 或ps -l
	pstree	进程关系树形显示pstree -p //显示进程ID -u 显示用户关系
	jobs	查看后台进程
	top	系统资源占用显示，用户数、内存、CPU、缓存信息等
		shift+m 按内存使用大小排序 shift+p 按CPU排序
		top -n 3 只刷新3次，就停止 top -d 10 10秒刷新一次
		top -b -d 1 >/tmp/top.log //-b能写入文本，-d只跑一次
	kill	kill 1890  //结束进程，不保证绝对杀死
		kill -9 1890 //强制结束进程
	pkill	pkill -9 ls  //按照进程的名字删除
	killall	killall -9 -i ls //按名字删，有确认提示
	uptime	显示系统当前时间的用户数和CPU使用情况
	程序-->载入内存+CPU（进程）-->服务  //临时工和门卫的关系
	错误输出重定向 find / -name \*root\* 2>/dev/null //不显示错误信息
	正确输出重定向 find / -name \*root\* 1>/tmp/find.log

#	linux的启动流程和服务的开机启动和关闭：
	1、开机进入BOIS
	2、选择启动磁盘、搜索MBR，进入系统，init pid 1
	3、加载/etc/rc.sysinit  磁盘检测、网卡等
	4、根据/etc/inittab文件，执行/etc/rc.d/rc*.d对应的文件，
		定义启动级别,图形，命令行界面，K不启动服务
	5、再执行/etc/rc.d/rc.local,出现登录界面,可以添加开机启动命令
	6、chkconfig --list	//查看对应的服务在不同等级开启的情况
	 	chkconfig --level 35 mysqld on  //3和5等级，mysql开启
	7、/etc/init.d/	所有服务所在目录，可以自己添加服务
		对应/etc/rc.d/init.d/ 的文件夹

#	VNC与图形化远程桌面配置：
	系统必须支持图形桌面
	yum install tigervnc-server.i686  //安装vnc
	下载realvnc登录软件，能在不同平台远程登录
	Linux配置VNC服务：
		vi /etc/sysconfig/vncservers
		VNCSERVERS="2:doobo 3:mysql 4:root"
		vncpasswd doobo	//设置doobo的vnc密码，在doobo下设置
		/etc/init.d/vncserver start //启动vnc
		service iptables stop    //关闭防火墙，防止连接失败
		service iptables status  //查看防火墙状态
		ps axf | grep vnc/iptables  //查看进程
	VNC_View  使用192.168.0.116:2登录，不需要填写其它的信息

#	samba服务器的使用
	yum -y install samba
	//开特权，关闭防火墙
	vi /etc/samba/smb.conf
		security = share  -101行
		找到Share Definitions，添加共享信息-250行
		[doobo]
		path=/tmp
		public=yes  //匿名共享设置成功
	testparm /etc/samba/smb.conf	//检测配置文件是否正确
		security = user  -101行
		smbpasswd -a doobo	//给用户设置smb密码
		writable = yes	//赋予写权限
		create mode=0666	//修改分享文件的权限
		directory mode=755	//修改目录的权限
		valid users=doobo,qq //允许指定用户进入
		valid user=@code	//只允许code组的用户进入

#	IpTables的配置与使用（防火墙配置）:
	ACCEPT	让数据进来		DROP	丢弃数据包不告知
	REJECT	丢弃并告知
	iptables -P INPUT DROP	//修改默认进来的包丢弃
	iptables -A INPUT -j DROP	//丢弃所有进来的数据包
	iptables -F	//清楚所有过滤规则
	iptables -L -n --line-number //按序号有行号显示规则
	iptables -A INPUT -s 192.168.3.200 -j DROP  //添加末尾阻止ip进入
	iptables -I INPUt -s 192.168.3.202 -j DROP  //插入头部规则
	intables -D INPUT 1		//删除第一条进入规则
	iptables -A INPUT -p tcp --dport 22 -j ACCEPT  //允许TCP的22号端口
	iptables -A INPUT -i eth0 -j DROP //配置指定网卡的规则

	iptables -A OUTPUT -o eth0 -j DROP  //阻止指定网卡数据出站
	iptables -A OUTPUT -p tcp --sport 80 -j DROP //阻止端口数据输出
	应用：
	iptables -A INPUT -p icmp -j DROP  //禁止ping服务器
	service iptables save	//保存规则到本地，重启依然有效
	iptables-save>/etc/sysconfig/iptables //保存到文件，重启有效
	telnet 192.168.3.120 25 //测试对应端口是否打开，ctrl+] 异常退出 ctrl+D 退出
	编写脚本：
	IPT="/sbin/iptables"

	$IPT -F
	$IPT -P INPUT DROP
	$IPT -P FORWARD DROP
	$IPT -P OUTPUT DROP

	$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

	$IPT -A INPUT -p tcp --dport 22 -j ACCEPT
	$IPT -A OUTPUT -p tcp --dport 22 -j ACCEPT

	$IPT -A INPUT -i lo -j ACCEPT
	$IPT -A OUTPUT -o lo -j ACCEPT

	#$IPT -A INPUT -p icmp -j ACCEPT 禁止Ping服务器
	$IPT -A OUTPUT -p icmp -j ACCEPT

	$IPT -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
	#$IPT -A INPUT -p udp -m udp --sport 53 -j ACCEPT

	$IPT -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT
	$IPT -A INPUT -p tcp --dport 80 -j ACCEPT

	$IPT -A INPUT -p tcp --dport 21 -j ACCEPT
	$IPT -A INPUT -p tcp --dport 10020:10040 -j ACCEPT

	$IPT -A OUTPUT -p udp --dport 123 -j ACCEPT

	#$IPT -A INPUT -j REJECT --reject-with icmp-host-prohibited
	#$IPT -A FORWARD -j REJECT --reject-with icmp-host-prohibited

	service iptables save
	service iptables restart

#	web服务器之httpd的安装调试
	yum -y install httpd httpd-devel
	paachectl start //启动apache	service httpd start  /etc/init.d/httpd start
	vi /etc/httpd/conf/httpd.conf	//apache的主配置文件
		ServerTokens Minor //配置成不显示服务器信息
		ServerSignature Off/EMail//不显示服务信息或显示管理员邮箱
		Timeout 60		//超时时间60秒
		KeepAlive Off	//是否持久化连接，一次连接多个资源
		ServerName localhost  //设置服务器名字
		Options FollowSymLinks 开启软链接，Options -FollowSymLinks 禁止软链接
		Options -Indexes	//不能查看网站目录列表
		UserDir public_html  //能访问home下的public_html目录，如.../~doobo/
		NameVirtualHost *:80 //多虚拟主机必开的配置项，匹配域名
	var/log/httpd/	//apache的日志文件目录
	var/www/html	//apache的默认网站根目录
##	多虚拟主机配置：
	//主配置开启NameVirtualHost *:80
	vi /etc/httpd/conf.d/virtual.conf
	<VirtualHost *:80>
    		ServerAdmin admin@163.com
    		DocumentRoot /var/www/html
    		ServerName www.hd.com
    		ErrorLog logs/www.hd.com-error_log
    		CustomLog logs/www.hd.com-access_log common
	</VirtualHost>
	<VirtualHost *:80>
    		ServerAdmin admin@163.com
    		DocumentRoot /bbs
    		ServerName bbs.hd.com
    		ErrorLog logs/bbs.hd.com-error_log
    		CustomLog logs/bbs.hd.com-access_log common
	</VirtualHost>
##	重点（Tomcat和apache反向代理）：
	yum install gcc-c++	//编译jatka环境
	yum install httpd-dev.rpm //扩展所需的apxs
	jakarta-tomcat-connectors-1.2.15-src.tar.gz //下载转发包
	tar xzvf jakarta-tomcat-connectors-1.2.15-src.tar.gz
	cd jakarta-tomcat-connectors-1.2.15-src/jk/native
	./configure --with-apxs=/usr/bin/apxs
	make
	cp ./apache-2.0/mod_jk.so /etc/httpd/modules/
	在/usr/local/apache2/conf.d/下面建立两个配置文件mod_jk.conf和workers.properties
	vi mod_jk.conf
	JkWorkersFile /etc/httpd/conf.d/workers.properties
	JkLogFile /tmp/mod_jk.log
	# Set the jk log level [debug/error/info]
	JkLogLevel info
	# Select the log format
	JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
	# JkOptions indicate to send SSL KEY SIZE,
	JkOptions +ForwardKeySize +ForwardURICompat -ForwardDirectories
	# JkRequestLogFormat set the request format
	JkRequestLogFormat "%w %V %T"
	JkMount /myapp/* worker1 #*/
	JkMount /*.jsp worker1 #*/
	vi workers.properties
	#Defining a worker named worker1 and of type ajp13
	worker.list=worker1
	# Set properties for worker1
	worker.worker1.type=ajp13
	worker.worker1.host=localhost
	worker.worker1.port=8009
	worker.worker1.lbfactor=50
	worker.worker1.cachesize=10
	worker.worker1.cache_timeout=600
	worker.worker1.socket_keepalive=1
	worker.worker1.socket_timeout=300
	在/etc/httpd/conf/http.conf里面开启
	LoadModule jk_module modules/mod_jk.so
	在tomcat的server.xml中的Host之中添加
	<Context path="" docBase="/var/www/html" debug="0" reloadable="true" crossContext="true"/>

#	RewriteEngine图片防盗链和伪静态：
##	a、基本示例：开启RewriteRule
    <VirtualHost *:80>
    	ServerAdmin admin@163.com
    	DocumentRoot /var/www/html
    	ServerName 192.168.3.120
    	ErrorLog logs/localhost-error_log
    	CustomLog logs/localhost-access_log common
    	RewriteEngine On
    	RewriteRule (.*)\.jsp$ http://192.168.3.120/index.html
     </VirtualHost>
>##	 b、伪静态、防盗链使用，动态添加规则-->开启AllowOverride：
      <VirtualHost *:80>
    	ServerAdmin admin@163.com
    	DocumentRoot /var/www/html
    	ServerName 192.168.3.120
    	ErrorLog logs/localhost-error_log
    	CustomLog logs/localhost-access_log common
    	<Directory /var/www/html>
         		Options FollowSymLinks
         		AllowOverride All
   	</Directory>
      </VirtualHost>
      vi /var/www/html/.htaccess  //编辑规则文件，放/var/www/html下
		RewriteEngine On
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteCond %{REQUEST_FILENAME} !-d
		RewriteRule .? /404.html [L]
		#配置请求不是文件或目录的直接跳到404.html
		RewriteCond %{REQUEST_FILENAME} \.(gif|jpeg|png|jpg)$ [NC]
		RewriteCond %{HTTP_REFERER} !^$
		RewriteCond %{HTTP_REFERER} !^http://192.168.3.120
		RewriteCond %{HTTP_REFERER} !baidu\.com [NC]
		RewriteRule \.(jpg|jpeg|png|gif|bmp) error.jpg
		#图片防盗链，只对网站有用，本地无效
		RewriteCond %{REQUEST_URI} ^/allow
		RewriteCond %{REQUEST_FILENAME} \.swf$ [NC]
		RewriteCond %{HTTP_REFERER} !^$
		RewriteCond %{HTTP_REFERER} !baionew\.com [NC]
		RewriteRule (.*) /allow/error.swf [R=301,NC,L]
		#swf防盗链
		#RewriteRule ^(\d+).html$ index.html?nid=$1 [L]
		#RewriteRule ^(\d+)_(\d+)\.do$ next.html?cid=$1&nid=$2
		#把数组转换成对应的nid的值，实现伪静态
		#RewriteRule \.(jpg|jpeg|png|gif|bmp) noimg.htm
		#不能访问所有图片

#	Swap的基本配置：
	free -m	//查看内存使用情况，含虚拟内存
	swapon -s	//cat /proc/swqps查看虚拟内存含文件和分区的详细信息
	mkswap /dev/sdb2	//设置交换分区磁盘
	swapon /dev/sdb2	//启用指定交换分区，记得写入/etc/fstab
	交换文件的配置方案：
	dd if=/dev/zero of=/swapfile bs=1024k count=2048 //创建2G交换文件
	mkswap /swapfile	//设置交换文件
	swapon /swapfile	//启用交换文件
	/swapfile swap swap defaults 0 0	//写入/etc/fstab,开机引导启动
	//删除交换分区或文件
	swapoff	/dev/sdb2	//关闭交换分区
	vi  /etc/fstab	删除对应项目
	fdisk 或 rm	删除对应文件或分区

#	VSFTP的搭建与配置：
	yum -y install vsftpd
	vi /etc/vsftp/ftpusers	//配置不允许登录ftp的帐号
	vi /etc/vsftp/user_list	//配置允许登录或者不允许登录，须配置vsftp.conf
	vi /etc/vsftp/vstfp.conf
		pasv_min_port=10020
		pasv_max_port=10040		//限制端口，便于配置iptables
		anonymous_enable=YES		//允许匿名用户
		anon_upload_enable=YES	//允许匿名用户上传文件，目录须加写权限
		chroot_local_user=YES	//允许改变目录
		chroot_list_enable=YES	//允许查看列表
	vi chroot_list_file=/etc/vsftpd/chroot_list //上面2项为YES，则里面的用户可以改变目录
	//配置ftp目录，网速,端口等，/etc/vsftp/vsftp.conf
	local_root=/ftp		//配置所有帐号默认访问目录
	max_per_ip=1		//最大连接数，同时登录用户数
	local_max_rate=20480		//限制最大速度20K

#	NTP配置，时间同步
	date +"%Y-%m-%d %H:%M:%S"	//格式化时间
	date -s 22:30:22		//设置时间
	hwclock -r			//查看硬件时钟
	hwclock -s			//把硬件时钟同步到软件时钟date
	hwclock -w			//把软件时钟写入硬件时钟
	yum install -y ntp		//安装NTP时间同步服务
	/usr/sbin/ntpdate  0.asia.pool.ntp.org>/tmp/ntp.log && /sbin/hwclock -w//同步时间
	//写入crontab，实现时间同步，或者开启ntp服务，不能同时使用

#	UBuntu系统的安装和Pear Linux及fedora的介绍
	apt-cache search mysql	//ubuntu搜索软件
	apt-get install mysql	//ubuntu安装软件
	.deb			//ubuntu的软件包后缀名

#	redis安装与配置：
	a、下载redis源码包
	b、安装gcc-c++环境	yum install gcc-c++
	c、解压源码：tar -zxvf redis-3.0.0.tar.gz
	d、进入解压后的目录：make
	e、安装到指定目录： make install PREFIX=/usr/local/redis
		一般安装目录下会有bin目录，就安装成功
    redis的启动与关闭：
	[root@itheima bin]# ./redis-server
	强制关闭：Ctrl+c
	正常关闭：[root@itheima bin]# ./redis-cli shutdown
    后端启动：
	[root@itheima bin]# cp /root/redis-3.0.0/redis.conf ./  拷贝配置文件到bin目录
	修改redis.conf文件，将daemonize改为yes
	[root@itheima bin]# ./redis-server redis.conf //启动redis
    	强制关闭：[root@itheima bin]# kill -9 5071
	正常关闭：[root@itheima bin]# ./redis-cli shutdown

    客户端启动：
	启动客户端命令：[root@itheima bin]# ./redis-cli -h 127.0.0.1 -p 6379
	//外部连接注意防火墙配置安全问题

    Redis的集群配置：
	集群管理工具（redis-trib.rb）是使用ruby脚本语言编写的
	yum install ruby	安装ruby
	yum install rubygems
	gem install redis-3.0.0.gem	安装ruby和redis接口，百度获取，版本不同
	新建集群目录：redis-cluster
	将redis-3.0.0包下src目录中的redis-trib.rb文件拷贝到redis/redis-cluster/
	cp redis-trib.rb  /usr/local/redis/redis-cluster
	端口设计如下：7001-7006
	[root@itheima redis19]# cp bin ./redis-cluster/7001 –r	复制出一个7001机器
	[root@itheima 7001]# rm -rf appendonly.aof dump.rdb	 如果存在持久化文件，则删除
	配置redis.conf的集群参数：cluster-enable yes	port 7001 	//7002-7006多一样配置好
	启动7001-7006这六台机器-脚本-注意赋给脚本运行权限 chmod 744 redis-start.sh：
		cd 7001
		./redis-server redis.conf
		cd ..
		cd 7002
		./redis-server redis.conf
		cd ..
		cd 7003
		./redis-server redis.conf
		cd ..
		cd 7004
		./redis-server redis.conf
		cd ..
		cd 7005
		./redis-server redis.conf
		cd ..
		cd 7006
		./redis-server redis.conf
		cd ..
  	利用rb语言脚本自动配置集群
	./redis-trib.rb create --replicas 1 10.10.10.65:7001 10.10.10.65:7002 10.10.10.65:7003
	10.10.10.65:7004 10.10.10.65:7005 10.10.10.65:7006
		/为每个节点配置一个备份节点，前三个为主节点，后三个为备份节点
	[root@itheima 7001]# ./redis-cli -h 192.168.242.137 -p 7001 -c	连接集群
		cluster info	查看集群信息
		cluster nodes	查看集群节点
	注意防火墙的安全配置

	停止集群
	社区并没有提及集群的停止方法，经过实验后发现可以通过先停止所有从节点，再停止所有主节点
	的方式完成此功能。如果先停止主节点的话，
	可能会触发自动failover。启动时先启动所有主节点，再启动所有从节点。启动时将从cluster-
	config-file中获取节点之前的角色。

	升级集群
	从节点升级很简单，只需要先停止节点服务，然后启动更新后版本即可。如果此过程中有客户端正
	在使用此节点，当发现不可用时会重连到其它
	从节点或者主节点。
	如果升级主节点，过程稍微麻烦一点，可以按照下列步骤：
	1. 使用cluster failover命令执行手动failover，将主节点转换为从节点；
	2. 对转换后的从节点进行升级；
	3. 再次执行手动failover，将从节点转换为主节点。
	上述步骤只能对一个主节点进行升级，其余主节点升级，按照这些步骤执行多次即可。