# 分布式爬虫搜索引擎
## 流程
+   环境
+  爬虫
    +   spider，item，itemloader，pipline，feedexport，crawlspider
+   反爬虫
    +   验证码，ip频率，user-agent切换
+   进阶
    +   原理，中间件开发
    +   动态网站，selenium和phantomjs集成，scrapy log 配置，emall发送，scrapy信号
+   分布式
    +   scrapy-redis分布式爬虫，bloom-filter集成到scrapy-redis中
+   es搜索
    + es+django使用，搜索引擎

# 环境
+ **pycahrm**
+ pycharm.sh
+ vim ~/.bashrc
+   最后一行添加
+ alias pycharm="bash /home/xx/xx/xx/bin/pycharm.sh"
+ source ~/.bashrc
+   pycharm
+ sudo apt-get install mysql-server
+ ps aux|grep mysqld
+ mysql -uroot -p 
+ show database
+ vim /etc/mysql/mysql.conf.d/mysqld.cnf
+ bind-address=0.0.0.0
+ ** mysql**
+ sudo service mysql restart
+ 设置外部IP访问权限设置
+ GRANT ALL PRIVILEGES ON *.* TO 'root'@%'IDENTIFIED BY 'root' WITH GRANT OPTION；
+ flush privileges；
+ 新建mysql数据库
+   scrapyspider
+   字符集：倒数第二 utf8-utf8 unicode，排序规则：utf8-general-ci
+   ** virtaulenv**
+   pip install virtualenv virtualenvwrapper
+   pip install -i https://pypi.douban.com/simple/ django
+   virtualenv scrapytest
+   当前目录下的虚拟环境
+   activate.bat
+   virtualenv -p ~/xx/xx/xx/py3.6/python.exe py3
+   **virtaulenvwrapper**
+   workon
+   mkvirtaulenv py3Scrapy
+   默认c盘user/envs
+   新建系统环境变量
+   WORKON_HOME:E:/ENVS
+   workon py3Scrapy
+   重启cmd
+   deactivate
+   pip install scrapy
+   makevirtualenv --python=~/xx/xx/xx/py3.6/python.exe py3
+   workon
+   ** ubuntun virtaulenv** 
+   sudo apt-get install python-virtualenv python-virtualenvwrapper
+   virtualenv py2
+   source activate
+   virtualenv -p /usr/bin/python3 py3
+   cd py3.bin
+   source activate
+   ** virtaulenvwrapper** 
+   sudo find / -name virtualenvwrapper.sh
+   vim ~/.bashrc
+   最后一行添加
+   export WORKON_HOME=$HOME/.virtualenvs
+   source /xx/xx/xx/bin/virtualenvwrapper.sh
+   保存并 source ~/.bashrc
+   makevirtualenv py2
+   makevirtualenv --python=/usr/bin/python3 py3Scrapy

# 技术选型
+   scrapy框架
+   request+ beautifulsoup 库
+   框架中可以增加库
+   scrapy基于twisted，性能是最大优势
+   方便扩展，内置许多功能
+   scrapy内置css和xpath selector方便，bsoup缺点慢
## 网页分类
+   静态网页
+   动态网页
+   webservice（restapi）
## 爬虫做什么
+   搜索引擎
+   推荐引擎
+   机器学习样本
+   数据分析样本
## 正则表达式
## 网站的url结构设计
## 深度优先和广度优先
+   深度优先：递归
+   广度优先： 队列
## url去重策略
+   放在数据库中
+   放在set中
+   url进行md5等方法哈希后保存在set中（scrapy采用的方法）
+   用bitmap方法，把访问过的url通过hash函数映射到某一位
+   bloomfilter方法对bitmap进行改进，多重hash函数降低冲突
## 字符串编码
+   ascii unicode
+   utf-8可变长编码，英文1个字节，汉字3个字节
+   unicode在内存中处理更便捷
+   utf-8保存和数据传输时更节省空间
+ decode：把其他编码转化为unicode的编码，decode()原来的编码
+   win中 '中文'.decode('gb2312').encde('utf-8')
+   linux中 '中文'.decode('utf8').encde('utf8')
+   sys.getdefaultencoding():ascii
+   u'中文'.encde('utf8')
+   py2中需要在文件开头声名：# encoding：utf-8
+   py3中可以直接：'xx'.encoding('utf-8')
## cookier和session
+   http无状态协议
+   记住未登陆用户的浏览状态
+   cookie 浏览器的本期存储状态
+   不安全 所以有了服务器端的session
+   session有时间限制
# Scrapy使用
## 调试
+   更改settings配置：ROBOTSTXT_OBEY = False
+   /home/zhh/developer/python/workspace/ArticleSpider目录下新建main.py文件
+   位于scrapy.cfg的同一层级
>   import sys,os
from scrapy.cmdline import execute
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
execute(["scrapy","crawl","jobble"])
+  断点打在parser函数的pass部分，debug使用对main文件
+  查看response返回的内容
## Scrapy Shell
+   命令行 scrapy shell http://python.jobbole.com/89178/
+   title = response.xpath("xx/xx/text()")
+   title.extract()[0]
+   create_data = response.xpath("xx/xx/xx/text()")
+   create_data.extract()[0].strip().replace(".","").strip()
+   response.xpath("//span[contians(@class，'xx')]/xx/text()").extract()[0]
+   import re 
+   re.match(r'.*(\d+).*'),'xx'）
+   response.css(".entry-header h1::text").extract()
+   response.css(".entry-header a::attr(href)").extract_first()
## xpath&CSS选择器
+   scrapy提供了基于lxml的xpath和css语法
+   节点关系：父，子，兄弟，先辈，后代
## 伯乐在线
+   scrapy startproject ArticleSpider
+   cd  ArticleSpider
+   scrapy genspider jobble blog.jobble.com
###   ** spide 编写**
+   获取文列表页的url并交给scrapy下载解析
    +   from scrapy.http import Request
    +   from urlparser import parse
    +    yield Request(url=parse.urljoin(response.url,post_url),callback=self.parse_detail))
+   获取下一页的url并交给scrapy下载，下载完成后交给parse
    +   if next_url
    +   yield Request(url=parse.urljoin(response.url,next_url),callback=self.parse))
+   Request的参数传递
    +   Requset(meta={'front_image_url'：xx})
    +   response.meta.get('front_image_url',xx)
###  ** items 编写 **
+   Item编写
+   class AriticleItem(scrapy.Item):
+     title = Scrapy.Field()
+   Item填充
+    Item['xx'] = xx
+     yield Item
### ** piplines 编写**
+  setting中打开pipline设置 ：数字小，先执行
+   ** 添加图片的pipline **
+   scrapy.piplines.image.ImagePipline:1
+   item['front_image_url'] = [xx]
+   添加pic配置在settings中
+   IMAGE_URLS_FIELD = 'front_image_url'
+   IMAGE_STORE = os.path.join(os.path.abspath(os.path.dirname(__file__)),'images')
+   IMAGE_MIN_HEIGHT = 100
+   IMAGE_MIN_WEIGHT = 100
+   ** 自定义图片 pipline**
+   继承 imagepipline
+   重要方法：get_media_requests(),item_completed()
+   重写方法：item_cpmpleted(self,results,item,info):
+   for ok,value in results:
+   image_file_path = value['path']
+   item['front_image_path'] = image_file_path
+   return item
+   ** 数据保存 pipline**
+   ** 自定义 JsonPipline**
+   init 中打开json文件
+   process_item 中写入json到文件中，并返回 return 
+   spider_closed 方法中 关闭文件
+   ** 集成的 JsonPipline 方法**
+   from scrapy.exporters import JsonItemExporter
+   init 
+   self.file self.exporter = JsonItemExporter(self.file,xx,xx) self.exporter.start_exporting()
+   close_spider
+   self.exporter.finish_exporter() self.file.close()
+   process_item
+   self.exporter.export_item(item） return item
+   ** 自定义mysqlpipline **
+    pip install pymysql
+   init 新建 conn和cursor
+   process_item cursor语句执行数据库插入，并提交
+   同步操作
+   ** 异步操作mysqlpipline **
+   配置中写入mysql配置
+   MYSQL_HOST = 
+   MYSQL_DBNAME = 
+   MYSQL_USER = 
+   MYSQL_PASSWORD = 
+   得到mysql配置信息
+ @classmethod from_settings host = settings['MYSQL_HOST'] xxx pass
+   异步操作
+  from twisted.enterprise import adbapi
+   from_settings:
+   dbpool = adbapi.ConnectPool('MySQLdb',**dbparms)
+   return cls(dbpool)
+   init  self.dbpool = dbpool
+   process_item 
+   self.dbpppl.runInteraction(self.do_insert,item)
+   query.addErrback(self.handle_error)
+   do_insert(self,cursor,item) cursor.execute(insert_sql,xx) cousor.commit()
+   handle_error(self,failure) print (failure)
+   扩展 scrapy-djangoitem
### item-loader
+   ** 原始状态 **
+   from scrapy.loader import ItemLoader
+   item_loader生成item
+   item_loader = ItemLoader(item=xx(),response =response)
+   item_loader.add_css('title','xx/xx::text()')
+   item_loader.add_xpath('url',response.url)
+   item_loader.add_value()
+   item_xx = item_loader.load_item()
+   ** 添加item处理函数 **
+   item文件中
+  from scrapy.loader.processors import MapCompose,TakeFirst
+   title = scrapy.Field(input_processor = MapCompose（add_jobble),output_processor = TakeFirst())
+    title = scrapy.Field(input_processor = MapCompose（lambda x:x+'xx',add_jobble))
+   add_jobble() 自定义函数
+   每次都要取第一个
+   **自定义item_loader**
+   from scrapy.laoder import ItemLoader
+   class xxItemLoader(ItemLoader):
+   default_output_processor = TakeFirst()
+   特殊：output_processor = Mapcompose(Join(","))
+   特殊:图片 url处理： 特殊：output_processor = Mapcompose(lambda x:x)

## 知乎爬虫
### selenium模拟知乎登陆
### request模拟登陆
+   1th：第一次请求获得 post的url和xsrf-code数据，登陆之后获取cookie
+   2nd：请求附带cookie得到数据
+   pip install request
+   try: import cookielib except:   import http.cookiejar as cookielib
+   import re
+   session = request.session()
+   session.cookies = cookielib.LWPcookieJar(filename='xx')
+   session.post()
+   session.cookies.save()
### 验证码识别
+   获取图片验证码，本地存储，人工输入
###  scrapy提前登陆
+   **spider**
+   重写 start_request方法
+   start_request return [scrapy.Request('xx',callback= self.login)]
+   login函数    return [scrapy.For
mRequest(url=xx,formdata = {'xx':xx},callback = check_login]
+   check_login函数  for url in self.start_urls: yield self.make_requests_from_url(url) 
+   check_login函数  for url in self.start_urls: yield scrapy.Request(url,dont_filter=True,heeaders = self.header) 
### shell
+   scrapy sshell -s USER_AGENT = 'xxx' http://xxxxx
## 拉勾爬虫
+   添加工具类环境变量到setting配置中
+   import os,sys
+  sys.path.insert(0,os.path.join(os.path.dirname(os.path.dirname(__file__))),'articlespider')
+   scrapy genspider --list
+   scrapy genspider -t crawl lagou www.lagou.com
+   ** 源码分析**
+   start_request,parse_start_url,process_results
+   重要方法： parse_response
+   **  spider **   
+   编写Rule(LinkExtractor(allow=("xx"),callback = 'parse_job',follow = True))
#   反爬虫
+   user-agent
+   ip池
+   cookies
+   账号登陆
+   验证码
+   动态网站，js动态生成
+   selenium和phatojs模拟操作
## user-agent更换
### 单独配置
+   整体自定义配置
+   setting中添加 user_agent_list 
+   user_agent_list = ['xx','xx']
+   from setting import user_agent_list
+   random_agent = user_agent_list[random.randint(0,len(user_agent_list)-1)]
+   self.headers['User-agent'] = random_agent
### 整体配置
+   **  自己的agent库**
+   DOWNLOADER_MIDDLEWARES = {}
+   scrapy源码中downloadermiddlewares中有useragent类
+   自定义RandowUseragentMiddle
+   重写 init方法
+    重写 @classmethod from_crawler(cls,crawler):
+    重写 process_request()方法
+   **  agent类库**
+   pip install fake-useragent
+   重写 init方法:super() self.ua = UserAgent()
+    重写 @classmethod from_crawler(cls,crawler):
+    重写 process_request()方法 request.headers.setdefault('User-agent',self.ua.random)
+   配置是否random
+   settings配置 RANDOM_UA_TYPE = 'random'
+   init self.ua_type = crawler.settings.get('RANDOM_UA_TYPE','random')
+   process_request def get_ua():return getattr(self.ua,self.ua_type)  
+   request.headers.setdefault('User-agent',get_ua())
## ip代理
+   process_request request.meta['proxy'] = 'http://xx.xx.xx.xx:xxxx'
###  自定义爬虫工具类
+   **自定义ip工具类**
+   使用request爬取西刺网站ip
+   插入到数据库
+   读取数据库中的代理ip
+   判断ip的可用性，删除无效ip
+   from scrapy.selector import Selector
+   **工具类ip代理**
+   pip install scrapy_proxies
+   官方代理：收费 pip install scrapy-crawlera
+   Tor浏览器：实现ip代理
## 验证码识别    
+   编码实现 tesseract-ocr
+   在线打码
+   人工打码
## cookie禁用，限制速度，自定义spider的setting配置
+   cookie
+   settings配置
+   COOKIE_ENABLED = False
+   自动限制速度
+   DOWNLOAD_DELAY = 10 
+   在独立的spider类中添加（和start_url平级别）
+   custom_settings = {"COOKIES_ENABLE"：True}
## 动态网站抓取
### 常用插件
+   pip install selenium 
+   chromdriver不加载图片
+   chrom_opt = webdirver.ChromOptions()
+   prefs ={'profile.managed_default_content_settings.imags':2}
+   browser = webdriver.Chrom(chrome_options =chrom_opt )
+   phantomjs
+   多进程情况下性能下降很严重
+   **selenium集成**
+   **下载中间件**
+   process_request: return HtmlResponse(url = browser.current_rul,body = borwser.page_source,encoding = 'utf-8',request = request)
+   init: self.browser = webdriver.Chrom() super()
+   无法关闭
+   ** 放在spider中**
+   import scrapy.xlib.pydispatch import dispathcher
+   from scrapy import signals 
+   init: self.browser = webdriver.Chrom() super()
+   dispathcher.connect(self.spideer_closed,signals.spider_closed)
+   spider_closed(self,spider):self.borwser.quit()
### 其他动态网页
+   **pyvirtualdisplay**
+   pip install pyvirtualdisplay
+   from pyvirtualdisplay import Display
+   display = Display(visible=0,size=(800,600))
+   display.start()
+   browser = webdriver.Chrome()
+   browser.get()
+   **scrapy-splash**
+   支持分布式
+   **selenium-grid**
+   **splinter**
## 暂停和重启
+  crawl spider lagou -s JOBDIR = job_info/001
+   暂停是接受 ctrl-c 或者 kill -f main.py
+   也可以在settings文件中设置
+   JOBDIR = "job_info/001"
+   也可以在每个spider的custom_settings中设置
+   ctrl+c
+   crawl spider lagou -s JOBDIR = job_info/001