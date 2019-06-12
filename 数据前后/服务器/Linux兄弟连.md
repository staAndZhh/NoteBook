# 发展史
## Unix和Linux
### base
+ 1969肯汤姆森开发了uni系统；后来谣传为unix系统
+ 1971汤姆森的同事丹尼斯里奇发明了c语言
+ unix绝大部分源代码使用c语言重写
+ 很好支持TCP/IP协议
### 版本
+ AIX ibm
+ HP-UX hp
+ Solaris sun
+ Linux  
### Linux
+ 1991芬兰大学生李纳斯和社区共同完善，李纳斯自己的unix
+ Linux是开源软件，源代码开放的unix
+ 被企鹅咬过，吉祥物
+ 最早发行的只是内核
+ 2.6.18，主.次.小版本，一般次版本是基数是开发版，偶数是稳定版
### 发行版本
+ **redhat系列**
+ centos：完全免费：主流的服务器版本，fedora：个人版，suse，红旗，mandriva，turbolinux：企业版
+ **debian系列**
+ ubuntu，knoppix
+ 主要区别：软件安装区别
### 开源软件
+  apache，nginx，mysql，php，samba，MongoDB，python，ruby，sphinx
+ 使用，研究，散布自由
### 支持互联网的开源技术
+ LAMP 
+ linux，apache，mysql，php
### tip小建议
+ **注意事项**
+ linux严格区分大小写
+ linux所有内容以文件形式保存，包括硬件：硬盘/dev/sd
+ linux不靠扩展名来区分文件，靠文件权限；但是有约定俗成的习惯
+ linux所有存储设备都必须挂载之后才能使用，包括硬盘，u盘，光盘
+ windows下的程序不能直接在linux中安装和使用
+ **目录结构**
+ /bin/ 存放系统命令的目录，普通和超级用户都可以执行
+ /sbin/ 超级用户才可执行
+ /usr/bin/
+ /usr/sbin/
+ /boot/ 系统启动目录，保存系统启动相关的文件
+ /dev/ 设备文件保存目录
+ /etc/ 配置文件保存位置，系统内所有采用默认安装rpm安装的服务的配置文件全部保存在这个目录里。用户账号密码，服务启动脚本，常用服务的配置文件等
+ /home/普通用户的家目录
+ /lib/ 系统得函数库
+ /lost+found/ 系统意外崩溃或者关机时，产生的文件碎片在这里
+ /media/ 挂载目录，多媒体设备
+ /mnt/ u盘，移动硬盘
+ /misc/ NFC服务的共享目录
+ /opt/ 第三方安装的软件保存位置，一般保存在/usr/local/目录中
+ /proc/ 虚拟文件系统，运行时内存信息
+ /sys/ 虚拟文件系统，内核相关信息
+ /root/ 超级管理员家目录
+ /srv/ 服务数据目录
+ /tmp/ 临时文件目录，临时文件，所有文件可以访问和写入
+ /usr/ 系统软件资源目录unix software resource，系统软件安装在这里
+ /var/ 动态资源保存位置，缓存，日志，和软件运行产生的文件
+ **服务器管理和维护建议**
+ 远程服务器不允许关机，只能重启
+ 重启时应该关闭服务
+ 不要在服务器访问高峰运行高负载命令
+ 远程配置防火墙时不要把自己提出服务器
+ 指定合理的密码规范并定期更新
+ 合理分配权限
+ 定期备份重要数据和日志 
# linux常用命令
## 文件处理
+ 命令 [-选项] [参数]
+ ls -la  /etc
+ 个别命令不遵循这个格式
+ 多个选项可以写在一起
+ 简化选项与完整选项 -a 等于 --all
+ ls list /bin/ls 所有用户 显示目录文件
+ ls -a 显示所有文件 -lh 详细信息显示，人类可识别 -d 查看目录属性本身 -i 查看文件id
### 命令格式
+ 命令 [-选项] [参数]
### 目录处理
+ mkdir 所有用户  mkdir 目录 -p递归创建
+ mkdir -p /tmp/janpan/movie
+ cd shell内置命令  所有用户 cd 目录
+ cd /tmp/japan/bo cd..
+ pwd 显示当前目录 /bin/pwd 所有用户  
+ rmdir /bin/rmdir 删除空目录
+ cp  复制文件或目录，可以同时改名字 /bin/cp 所有用户 cp -rp [原文件或目录][目标目录] -r 复制目录 -p 保留文件属性
+ cp /etc/xx.cong /tmp 复制文件
+ cp /etc/xx.cong /etc/xxx.cong  /tmp
+ mv /bin/mv 所有用户 mv [原文件或目录][目标目录] 剪切文件，改名 
+ rm /bin/rm 所有用户 rm -rf  -r 删除目录 -f 强制执行
### 文件处理
+ touch /bin/touch 所有用户 创建空文件 touch xxx.list
+ touch "xx xx" 创建带空格的文件
+ cat /bin/cat 所有用户 浏览文件 -n 显示行号 cat /etc/issue
+ tac 浏览文件 倒过来显示
+ more  /bin/more 所有用户 分页显示内容 空格/f 翻页 enter 换行
q/Q 退出 more /etc/services
+ less 向上翻页 其他同more 可以用 pageup 上翻页 上箭头 上翻行 /输入内容 进行搜索 n 查找下一个
+ head  显示文件的前几行 -n 指定行数 head -n 20 /etc/services
+ tail  显示文件的后面几行 -n 指定行数 -f 动态显示文件末尾内容 tail -n 18 /etc/services
### 链接
+ ln 创造链接 ln -s [原文件][目标文件] 生成软链接
+ ln -s /etc/issure /tmp/issure.soft 软链接
+ 软链接 类似win中的快捷方式
+ 硬链接 相当于 cp -p 但是同步更新，原文件丢失，硬链接依然存在
+ 硬链接识别：通过i节点，不能跨分区，不能针对目录使用
+ 硬链接使用：实时备份
## 权限管理
+ chmod 更改文件或者目录的权限 
+ chmod [{ugoa} {+-=}{rwx}][文件或者目录]
+ chmod [model=421][文件或者目录]
+ -R 递归修改
+ chmod u+x,g+w a.list
+ chmod g=rwx a.list
+ chmod 640 a.list
+ chmod -R 777 /tmp/a
+ chown [用户][文件或目录] 改变文件或者目录的所有者
+ chown zhh zhang.list
+ chgrp [用户组][文件或目录] 改变文件或者目录的所属组
+ chgrp  othergroup xx.list
+ umask [-S] 以rwx显示新建文件的缺省权限
+ umask -S
+ umask 023
## 文件搜索
## 帮助
## 用户管理
+ useradd zhh
+ groupadd  xxx
+ passwd xxx
+ 
## 压缩解压
## 网络
## 关机重启