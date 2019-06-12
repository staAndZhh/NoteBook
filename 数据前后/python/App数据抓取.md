# App数据抓取实战
#------------------------char1 -------------
# 导学
## 目的
+   安卓模拟器环境搭建
+   抓包神器
+   自动化控制工具使用
+   py爬取app数据
+   基于docker的多app数据抓取系统
## 作用
+   数据分析
+   用户画像
+   统计系统
+   商业竞争
##   难点&容易点
+	
+   需要反编译,分析加密算法
+   可能加固过,需要脱壳,反编译,分析加密算法,抓取信息
+   破解签名,证书,设备绑定等方法,找到隐藏的加密算法
## 技术储备
+   py爬虫
+   java 基础
+   android开发基础
+   app逆向
+   app脱壳
+   破解加密算法
## 安装
+   夜神,genomition
+   fidder  
+   mitmproxy
+   SSL
+   appium
+   Docker
## demo
+   豆果美食
+   抖音
+   快手
+   今日头条
## 架构
+   mongoDB --appium-python-client -- http通信 -- docker --appium-- 快手
#-----------------------------char 2-------------
#  win10环境搭建
## catalogue
+   安卓模拟器的安装和介绍
+   fiddler
+   mitmproxy
+   packet capture
+   appium
+   docker
## content
###　安卓模拟器的安装和介绍
+   google　的ＡＶＤ
+   genymotion
+  夜神模拟器（选择，仅仅支持win１０）
### 夜神安装
+ 夜神多开器

+ 开启root

+ 更改手机型号

+ 下载手机应用
+ 软件安装（应用，拖拽，adb）

### genymotion
+   开启cpu虚拟化
+   软件下载
+   下载手机镜像
+   安装amt工具
### fiddler安装
+   fiddler ,win/linux, 网页/app ,调试一般,功能多
+   mitmproxy,win/linux/mac,网页/app,调试一般,功能多
+   packerCapture(一个App),安卓,app端,调试简单,功能少
####    fiddler
+   一个web调试代理平台,监控和修改web数据流
+   功能强大(pc多浏览器,手机端)
+   优点
    +   查看所有数据流
    +   手动或自动修改任意请求和响应
    +   解密https数据流方便查看和修改
+   缺点
    +   只支持http,https,ftp,websocker数据流协议
    +   无法监测或修改其他数据:SMTP,POP3
    +   无法处理请求和相应超过2G的数据
####   下载
#### 设置抓取浏览器数据包
+   tools --- options --- 抓取https --- 确定https请求 --- 安装证书  actions
+   options --- conccetions --- 端口号:8889 --- 允许远程链接(手机抓取)
+   chrome 安装 Switch Omega 插件 --- 插件设置 --- 新建模式 --- 使用代理服务器访问
### mitmproxy安装
+      用于中间人攻击的proxy
+   MITM:man-in-the-middle-attack
+   类似正常代理,保障服务端和客户端通信
+   拦截/修改:请求,和返回
+   可以载入自定义py脚本
#### 安装
+   win
    +   基于py环境
    +   win需要安装mico visual c++ 14.0以上的
+   linux 
    +   基于python安装即可
+   pip install mitmproxy
+   mitmproxy --verion
+   win中还需要安装
+   pip install mitmdump  mitmweb
+   mitmdump --version
+   mitmweb --version
+   终端中输入mitmweb,显示为web的图形化界面
#### 启动
+   终端中输入 mitmproxy（只能linux使用，win不能使用）
+   默认监听 8080端口
+   打开浏览器,设置谷歌浏览器监听插件配置:端口改为8080
+   安装证书
+   输入:mitm.it
+   下载相应的证书,导入到对应的系统中
+   下一步-下一步-下一步-不设置密码-下一步-证书选择路径：所有证书都放在下列存储-受信任的根证书颁发机构-下一步-完成-确定
+   重启浏览器
#### 使用

+   mitmproxy
+   上下移动：鼠标在终端中移动,选择浏览的网站
+   回车确定：选择对应的信息
+   tab 选择：选择对应的响应与请求信息
+   esc+q： 返回抓包流信息
+   mitmdump
+   mitmdump -w test.txt
+   设置端口为8080
+   mitmweb
+   web页面展示
+   设置端口8080，访问页面
### PacketCapture 抓包app
+   安卓上的一款免root的app,用于捕获http/https
  的网络流量嗅探工具
+   仅仅用于抓取app数据
+   使用android提供的vpnservice api,实现中间人攻击
+   特点:
+   无root 抓包
+   捕获网络数据包,记录他们,使用中间人技术对ssl进行解密,无须root权限
+   安装ssl证书
#### 使用

+   选择需要抓包的app
+   确定网络请求
+   开始抓包
+   确定抓取-结束-查看
### Appium移动端自动化测试工具
+   自动化测试开源工具,支持ios和android平台原生,web,和混合应用
+   跨平台工具,同一套代码测试,提高代码复用性
+   appium类库封装了标准的selenium客户端类库
+   appium 客户端类库实现了mobile json wire protocol,w3c webdiver spec协议
+   定义了官方协议的扩展,为appium用户提供了方便的接口实现各种设备动作(安装,卸载app)
+   特点
+   选择了client/server设计模式
+   扩展了webdirver协议
+   支持多语言(ruby,py,bide,oc,php,rebotFramework)
####　安装
+   win
+   服务端
+   appium.io 下载server端
+   也可以通过node.js安装
+   安装node 安装npm
+   npm install -g appium
+   打开win10开发者模式，安装.net3.5,安装win-10-sdk,安装驱动，设置权限
#### 使用

+ 设置ip和端口号，打开

### docker安装和简单使用
+   更高利用系统资源
+   更快启动时间
+   一致运行环境
+   持续交付和部署
+   轻松迁移
### 安装
+   method1:docker for win  需要开启h-v（win10专业版）
+   method2:docker -toolbox（通用）
    +   使用toolobox安装
+   docker version
+   docker run hello-world （本地是否存在镜像，否则远程拉取）
+   docker  run -it ubuntu bash
+   ls
+   exit
+   ctrl+s
+   docker ps -a  （查看当前所有容器，以及运行状态）
+   docker images （查看多少个镜像）
+   docker rmi hello-world （删除images镜像名字）
#------------------------char3 -------------
# 抓包工具使用
## cata
+   fiddler
+   mitm
## content
### fiddler

+ 保存

+ 编辑
+ 标记
+ 查找

### tools

+ options
+ 设置https，解析https；
+ actions:安装证书-可信任的证书-浏览器-高级-证书-查看-可信任的机构
+ 设置端口
+ 浏览器安装 Proxy SwitchOmega

### rules设置

+ 隐藏img请求
+ 自动打断点
+ 代理认证
+ 去掉所有的加密协议
+ 性能测试：慢速网络

### 工具栏

+ 注释
+ 流重放
+ 流执行
+ 流模式：缓存，流动
+ 选择进程抓取
+ 截图

#### sesion设置

+ 设置断点-修改-运行

#### 断点拦截
+   请求拦截
+   bpu  xxx.baidu.com  
+   清除拦截
+   bpu
+   响应拦截
+   bpa  xxx.baidu.com  
+   bpa
+   请求重定向
+   选中左侧网站-选择右侧autoResponder
+   RuleEditor
+   修改数据
+   确认
####   手机抓包设置
+   设置中更改模拟器为:桥接模式
+   查看并修改无线网络
+   左键长按,修改代理配置
+   更改代理ip为电脑ip,端口号为fiddler设置的端口号
+   设置fiddler的options为:remote 请求only,允许抓取远端网页  
+   模拟器打开浏览器
+   安装fiddler证书
+   手机浏览器输入ip:xxxx.xxxx.xxxx.xxxx:8889
+   下载fiddler的ssl证书
+   浏览网址
+   测试数据
### mitm抓包设置

+ Linux

+    mitmproxy
+    mitmdump
+    mitmweb
+    设置端口号
+    mitmproxy   
+    mitmproxy   -p 8889
+    ifconfig
+    模拟器设置ip地址和端口号 wireSSD
+    模拟器输入网址 mitm.it 下载证书
+    模拟器:设置 安全 受信任的证书
+    终端: z 清除屏幕
+    终端: 鼠标上下键移动选择请求 enter 确定 q退出
##### 数据包过滤

+ f
+ 过滤所有请求响应是200

+   f c 200
+   set view_filter = !(-c 200)
+   f
+   f d baidu.com
+   f
+   f ~m post & ~m baidu.com
+   f
#####    断点拦截

+ i
+ 断点是百度，方式是get

+   i   baiducom    & m get
+   enter
+   访问网址
+   e 修改参数
+   d 删除
+   e url qq.com
+   e
+   q 返回
+   a 请求
#### mitmdump

+ 可以和py脚本交互

+ win命令行中
+   mitmdump
+   mitmdump -p 8889
+   mitmdump -p 8889 -s test.py
+   test.py输入
>   from mitmproxy import ctx
  def request(flow):
      print (flow.request.headers)
      ctx.log.info(str(flow.request.headers))
      ctx.log.warning(str(flow.request.url))
      ctx.log.warning(str(flow.request.host))

>   from mitmproxy import ctx
  def response(flow):
      ctx.log.info(str(flow.response.status_code))
      ctx.log.info(str(flow.response.text))

+   mitmdump 每换一个电脑ip就需要重新安装证书
#------------------------char4 -------------
## catalogue
+   分析数据包
+   py多线程-线程池抓取
+   代理ip隐藏爬虫
+   数据保存在mongodb中
## content
+   豆果美食数据抓取
#### 路径分析
+   筛选主题host
+   路径:热门食材 -- 土豆 -- 做过最多 
+   筛选出3个数据包
#### py爬虫食材页
+  import requests
+`  请求头文本替换为字段
+   sublimetext
+   (.*?):(.*)
+   "$1":"$2",
+   replace all
+   复制为header
+   可以去掉的key:mac,android-id,pseudo-id,imsi,lon,lat,cid,cookie,content-length,session,时间戳
+   request.head(url,header,data)
#### py爬虫菜谱页
+   from multiprocessing improt Queue
+   Quene().put(data)
#### py爬虫做过最多
####    py爬虫详情页
####    数据库入库
####    py多线程
####    py代理配置
####    py爬虫总结
#------------------------char５ -------------
#   移动端数据抓取
## catalogue
+   安卓开发工具安装
+   adb安装
+   uiautomatorviewer安装
+   appium安装
+_  app自动化工具登录
## content
###   安卓开发工具安装  
####   jdk 8安装

jdk安装

jre安装

环境变量：path,classpath，java_home配置

输入：java,javac

####    android studio 安装   

24.1.1 as安装

环境变量设置：Android-Home

#####   **adb工具**

+ 安卓调试桥

+    adb start-server
+    adb version
+    adv devices
+    打开模拟器的开发者模式
+    系统设置,版本号,一直单击 
+    adb  devices
+    adb -s  xxxx:xxxx  shell 
+    进入底层系统
+    安装
+    adb -s  xxxx:xxxx  install  xx/xx/xx/xx.apk
+    adb -s  xxxx:xxxx  shell
+    cd data/app
+    卸载
+    adb -s  xxxx:xxxx  un.install  xx.xx.xx.xx(包名)
+    adb connect xxxx:62001
+    列出所有的安装包
+    adb shell pm list package
+    adb push xxx/xx.txt  /sdcard
+    adb pull /sdcard xxx/xx.txt 
+    adb shell screencap  /sdcard/xx.png 
##### uiautomatorviewer工具
+   ** sdk下的uiautomatorviewer工具**
+   android 4.3时候发布的测试工具
+   UI测试,普通的手工测试,点击每个控件查看输出结果是否符合预期
+   uiautomatorviewer 一个图形界面工具用来扫描和分析应用的ui控件,在tools目录
+   uiautomator 一个测试的java库,包含创建ui测试的各种api和执行自动化测试的引擎
+ ** appium自动化工具详讲**
+   开源自动化测试框架,可用于原生,混合和移动web应用测试
+   使用webdriver协议驱动ios,安卓应用
+   安装 appium
+   **inspector**
+   **desired capability**
+   配置appium会话,告诉appium想要的自动化平台和应用程序
+   配置key
+   platformName:Android
+   platformVersion:4.4.2
+   deviceName:127.0.0.1:62001
+   appPackage:com.xx.xx
    +   aapt.exe dump badging xx/xx/xx.apk
    +   aapt.exe dump badging xx/xx/xx.apk | find "launchable-activity"
    +   adb shell 
    +   logcat | grep cmp=
+   appActivity:com.xx.xx.xx.splashactivity
+   noReset True 
+   保存设置
+   startsession
+   录制:眼睛图标
+   开始录制--send keys ---输入账号密码 ---tab 进入首页
### 登录考研帮
#### 登录
+   使用uiautomatorviewer测试
+   使用py操作appium,appium操作数据登录并滑动
+   设置 --应用-- 找到app -- 清除数据
+   pip install Appium-Python-Client
+   from appium import webdriver
+   driver = webdriver.Remote('http://localhost:47223/we/hub",{"platformName":
"xx"})
+   driver.find_element_by_xpath("xx/xx").click()
#### 滑动
+    获取屏幕大小
+   得到鼠标的初始停留值并开始滑动
+   driver.swipe(x1,y1,x2,y2)
#------------------ char 6-----------
# 抖音实战
## cate
+   内容
+   路径
## content
###  数据混淆
+   通过字体把数据数字换成新的字体
+   method1:数值对换
+   method2:字体解析
###　SSL pinning
+   ssl证书绑定
### Xposed框架＆JustTruestMe组件
+   禁用和绕过ssl证书检查的
+   手机必须获取root权限，真实手机可能变砖
+   可以刷机为自带xposed框架的系统