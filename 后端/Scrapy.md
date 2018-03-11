#Knowledge
+	Spider
+	Selector
+	Item
+	ItemPipline
+	LinkExtractor
+	Exporter
+	下载文件图片
+	模拟登陆
+	动态页面
+	存入数据库
+	Http代理
+	分布式爬虫
# baseSpider
## start
+	pip install pypiwin32
+	scrapy startproject article
+	cd article
+	scrapy genspider jobbole blog.jobbole.com
+	更改settings配置 ROBOTSTXT_OBEY = False
+	在scrapy.cfg文件同级别下新建main文件
+	>		# -*- utf-8 -*-
		from scrapy.cmdline import execute
		import sys
		import os
		sys.path.append(os.path.dirname(os.path.abspath(__file__)));
		execute(["scrapy","crawl","jobble"]);

## 配置Spider
+	配置Spider的start_urls
+	配置parser函数下载response.body

## 配置使用Selenium和phatoform
+	setttings配置
	>	DOWNLOADER_MIDDLEWARES = {
    'myproject.middlewares.CustomDownloaderMiddleware': 543,
    'scrapy.downloadermiddlewares.useragent.UserAgentMiddleware': None,
}

## 配置使用RandomAgent

##	配置使用动态Ip

##	ScrapyShell
+	scarpy shell http://xxx.html

------------------
#	Demo1
1.	spider
	+	parser
		+	detail_url
			> 	yield Request(url = parse.urljoin(response.url,post_url),callback= self.parser_detail)
		+	next_url 
			>	 	yield Request(url = parse.urljoin(response.url,next_url),callback= self.parser)
		+	传递meta信息 image_url
			>		yield Request(url = parse.urljoin(response.url,post_url),meta = {'font_image_url':image_url}callback= self.parser_detail)
		+	获取meta信息
			>		response.meta.get('font_image_url',"")
		+	Item填充
			> 	 items = xxItem()
				 items['title'] = titile
				 items['title'] = titile
				  yield items
2.	图片下载
	+	pip install pillow
	+	通过scarpy的imagePipline
	+	Setting中添加ITEM_PIPLINES
		+	'scrapy.piplines.images.ImagePipline:1
		+	数字越小越先
	+	Seting中添加配置url来源,url路径
		+	IMAGES_URLS_FIELD = 'font_image_url'
		+	project_dir = os.path.abspath(os.path.dirname(__file__))
		+	IMAGE_STORE = os.path.join(project_dir,'image')
	+	Setting中设置宽高
		+	IMAGE_MIN_HEIGHT = 100
		+	IMAGE_MIN_WIDTH = 100
2.	piplines
	+	spider 中传递yield items时自动传递item到pipline
	+	settings 中打开piplines的设置
	+	主要用来数据存贮和处理
	+	imagepipline
		+	class iamgepipline(scrapy.piplines.images.ImagePipeline):
			+	get_media_requests(self,item,info):
			+	item_completed(self,results,item,info):
				+	图片存储路径在results中
				+	for ok value in results:
				+	if 'front_iamge_path' in item:
				+	image_file_path = value['path']
				+ 	item['front_iamge_path'] = image_file_path
				+	return item 
	+  JsonWithEncodingPipline
		+	![](https://i.imgur.com/GraBkQC.png)
	+	JsonItemExporter
		+	![](https://i.imgur.com/izxoTqb.png)
	+	同步MysqlPipline
		+	pip install mysqlclient
		+	![](https://i.imgur.com/UA5vG7v.png)
	+	异步MysqlPipline
		+	Setting配置mysql属性
			+	![](https://i.imgur.com/BnqEg46.png)
		+	from twisted.enterprise import adbapi
		+	建立连接池
		+	连接池操作
		+	错误处理
		>			class MysqlTwistedPipline(object):
			    def __init__(self, dbpool):
			        self.dbpool = dbpool
			    @classmethod
			    def from_settings(cls, settings):
			        dbparms = dict(
			            host = settings["MYSQL_HOST"],
			            db = settings["MYSQL_DBNAME"],
			            user = settings["MYSQL_USER"],
			            passwd = settings["MYSQL_PASSWORD"],
			            charset='utf8',
			            cursorclass=MySQLdb.cursors.DictCursor,
			            use_unicode=True,
			        )
			        dbpool = adbapi.ConnectionPool("MySQLdb", **dbparms)
			        return cls(dbpool)
			    def process_item(self, item, spider):
			        #使用twisted将mysql插入变成异步执行
			        query = self.dbpool.runInteraction(self.do_insert, item)
			        query.addErrback(self.handle_error, item, spider) #处理异常
			    def handle_error(self, failure, item, spider):
			        # 处理异步插入的异常
			        print (failure)
			    def do_insert(self, cursor, item):
			        #执行具体的插入
			        #根据不同的item 构建不同的sql语句并插入到mysql中
			        insert_sql, params = item.get_insert_sql()
			        print (insert_sql, params)
			        cursor.execute(insert_sql, params)

4.	items
	+	baseItem
		> 	class xxItem(scrapy.Item):	
				xx = scrapy.Field()
				xx = scrapy.Field()
5.	itemloader
	+	from scrapy.loader import ItemLoader
	+	新建ItemLoader
	+	添加规则
	+	解析规则
	+	![](https://i.imgur.com/kdikbGq.png)
	
6.	item(结合itemloader)添加自定义处理
	+ from scrapy.loader.processors import MapCompose,TakeFirst，Join
	+	![](https://i.imgur.com/cjQRujt.png)
	+	自定义ItemLoader
	+	多个字段取第一个元素
	+ from scrapy.loader import ItemLoader
	+	class ArticleItemLoader(ItemLoader):
		+	default_output_processor = TakeFirst()
	+	更改spider中的ItemLaoder为ArticleItemLoader
	+	>		def add_jobbole(value):
			    return value+"-bobby"
			def date_convert(value):
			    try:
			        create_date = datetime.datetime.strptime(value, "%Y/%m/%d").date()
			    except Exception as e:
			        create_date = datetime.datetime.now().date()
			    return create_date
			def get_nums(value):
			    match_re = re.match(".*?(\d+).*", value)
			    if match_re:
			        nums = int(match_re.group(1))
			    else:
			        nums = 0
			    return nums
			def return_value(value):
			    return value
			def remove_comment_tags(value):
			    #去掉tag中提取的评论
			    if "评论" in value:
			        return ""
			    else:
			        return value
			class ArticleItemLoader(ItemLoader):
			    #自定义itemloader
			    default_output_processor = TakeFirst()
			class JobBoleArticleItem(scrapy.Item):
			    title = scrapy.Field()
			    create_date = scrapy.Field(
			        input_processor=MapCompose(date_convert),
			    )
			    url = scrapy.Field()
			    url_object_id = scrapy.Field()
			    front_image_url = scrapy.Field(
			        output_processor=MapCompose(return_value)
			    )
			    front_image_path = scrapy.Field()
			    praise_nums = scrapy.Field(
			        input_processor=MapCompose(get_nums)
			    )
			    comment_nums = scrapy.Field(
			        input_processor=MapCompose(get_nums)
			    )
			    fav_nums = scrapy.Field(
			        input_processor=MapCompose(get_nums)
			    )
			    tags = scrapy.Field(
			        input_processor=MapCompose(remove_comment_tags),
			        output_processor=Join(",")
			    )
			    content = scrapy.Field()

#	Demo2
1.	cmder
2.	CrawlSpider
	+	scrapy genspider --list
	+	scrapy genspider -t  crawl lagou www.lagou.com
	+	继承CrawlSpider
	+	配置setting文件添加根目录
	>	import sys
		BASE_DIR = os.path.dirname(os.path.abspath(os.path.dirname(__file__)))
		sys.path.insert(0, os.path.join(BASE_DIR, 'ArticleSpider'))
3.	源码分析
	+	Rule
	+	LinkExtractor
	+	crawpsplder重写了parse函数，自己不用重写
	+	核心函数 self._parse_response(response,parse_start_url.**kw,fllow= True)
	+	是否有 callback:parse_start_url 
	+	有的话：调用	_process_result(response,callback)
	+	迭代处理函数
	+	是否 follow and _fillow_links
	+	_requests_to_follow（提取url并去重）
	+	解析rule调用process_links进行提前处理
	+	发起Request(回调函数_response_downloaded)
	+	回调函数：结果给_parse_response，调用回调
4.	Rule
	+	link_extractor:lxml_extractor：FilteringLinkExtractor:HtmlLinkExtractor
5.	LinkExtractor
----------------------
# 动态网页
1. Selenium
	+	pip install selenium
	+	安装不同的driver
	+	selenium python查看文档
	+	使用
	+	![](https://i.imgur.com/YfMfjQY.png)
	
	+	模拟登陆
		+ borwser.find_element_by_css_selector('xx').send_keys("")
		+	borwser.find_element_by_css_selector('xx').click()
	+	滑动到低端
		+ borwser.execute_script("window.scrollTo(0,document.body.scrollHeight);  var lenofPage = document.body.scrollHeight; return lenofPage;")
	+	设置chromdriver不加载图片
		+	![](https://i.imgur.com/mOOTNmh.png)
		+ borwser = webdriver.Chrom(exeechtabel_path = xx,chrom_options = chrom_opt)

2.	phantomjs
	+	无界面浏览器，多进程下性能下降很快
	+	driver = webdriver.PhantomJS()
	+	print (driver.page_source)

3.	Selenium集成到Scrapy中
	1. base
		+ 填写中间件
		+	![](https://i.imgur.com/JP45eZ4.png)
		+	return HtmlResponse(url = browsaer.current_url,	body = browser.page_source, encoding ='utf-8',request = request)
		+	配置settings
	2.	类变量
		+	多次打开浏览器不好
		+ 	配置浏览器为类变量
		=	![](https://i.imgur.com/jrXmDPx.png)
	3.	spider变量&信号量
		+	![](https://i.imgur.com/x8By27U.png)
4.	其他动态技术
	1.	pyvirtualdisplay(linux下)
		+	pip install pyvirtualdisplay
		+	![](https://i.imgur.com/prbBv7F.png)
	2.	Splash(Scrapy官网推荐）
		+	支持分布式
	3.	SeleniumGrid(支持分布式）
		+	支持分布式
	4.	splinter(类似于Selenium)
5. Scrapy 暂停和重启
	1.	原理：保存状态
	2.	在和xx.cfg同级目录下新建文件夹job_info
	3.	不同的spider和不同的run不能共用同一个目录
	4.	接受暂停命令(win linux)：ctrl+c 
	5.	接受暂停命令linux:kill -f mian.py
	6.	终端输入： scrapy crawl lagou -s JOBDIR=job_info/001
	7.	ctrl+C
	8.	重新启动： scrapy crawl lagou -s JOBDIR=job_info/001

#	Scrapy反爬虫
1. 概念
	+	![](https://i.imgur.com/8LploK4.png)
2.	对抗
	+	![](https://i.imgur.com/10c7B2i.png)
3.	Scrapy流程
	+	![](https://i.imgur.com/FRWfmRg.png)
4.	Request和Respoonse
5.	随机更换
6.	
	+	用户代理
		1.	base 写在每个spider中
		2.	downloadmiddleware
			+	系统默认的
			+	![](https://i.imgur.com/8WYA15B.png)
			
			+	自定义meddleware
			+	自定的权限数据数字写大，覆盖前面的
			+	setting中添加 user_agent_list = [xx]
			+	![](https://i.imgur.com/LGqVUYr.png)
			+	fale-useragent
			+	pip install fake-useragent
			+	[http://fake-useragent.herokuapp.com/browsers/0.1.4](http://fake-useragent.herokuapp.com/browsers/0.1.4)
			+	![](https://i.imgur.com/qfX2iYx.png)
			+ setting中天机 RANDOW_UA_TYPE = 'random'
			+	![](https://i.imgur.com/xjT3FaB.png)

6.	随机更换ip代理池
	+ request.meta['proxy']="http://xxx.xxx.xx.xxx:8081"
	+	获取ip代理池并入库
	+	自定义proxyMiddle
	+	>		import requests
			from scrapy.selector import Selector
			import MySQLdb
			conn = MySQLdb.connect(host="127.0.0.1", user="root", passwd="root", db="article_spider", charset="utf8")
			cursor = conn.cursor()
			def crawl_ips():
			    #爬取西刺的免费ip代理
			    headers = {"User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0"}
			    for i in range(1568):
			        re = requests.get("http://www.xicidaili.com/nn/{0}".format(i), headers=headers)
			        selector = Selector(text=re.text)
			        all_trs = selector.css("#ip_list tr")
			        ip_list = []
			        for tr in all_trs[1:]:
			            speed_str = tr.css(".bar::attr(title)").extract()[0]
			            if speed_str:
			                speed = float(speed_str.split("秒")[0])
			            all_texts = tr.css("td::text").extract()
			            ip = all_texts[0]
			            port = all_texts[1]
			            proxy_type = all_texts[5]
			            ip_list.append((ip, port, proxy_type, speed))
			        for ip_info in ip_list:
			            cursor.execute(
			                "insert proxy_ip(ip, port, speed, proxy_type) VALUES('{0}', '{1}', {2}, 'HTTP')".format(
			                    ip_info[0], ip_info[1], ip_info[3]
			                )
			            )
			            conn.commit()
			class GetIP(object):
			    def delete_ip(self, ip):
			        #从数据库中删除无效的ip
			        delete_sql = """
			            delete from proxy_ip where ip='{0}'
			        """.format(ip)
			        cursor.execute(delete_sql)
			        conn.commit()
			        return True
			    def judge_ip(self, ip, port):
			        #判断ip是否可用
			        http_url = "http://www.baidu.com"
			        proxy_url = "http://{0}:{1}".format(ip, port)
			        try:
			            proxy_dict = {
			                "http":proxy_url,
			            }
			            response = requests.get(http_url, proxies=proxy_dict)
			        except Exception as e:
			            print ("invalid ip and port")
			            self.delete_ip(ip)
			            return False
			        else:
			            code = response.status_code
			            if code >= 200 and code < 300:
			                print ("effective ip")
			                return True
			            else:
			                print  ("invalid ip and port")
			                self.delete_ip(ip)
			                return False
			    def get_random_ip(self):
			        #从数据库中随机获取一个可用的ip
			        random_sql = """
			              SELECT ip, port FROM proxy_ip
			            ORDER BY RAND()
			            LIMIT 1
			            """
			        result = cursor.execute(random_sql)
			        for ip_info in cursor.fetchall():
			            ip = ip_info[0]
			            port = ip_info[1]
			            judge_re = self.judge_ip(ip, port)
			            if judge_re:
			                return "http://{0}:{1}".format(ip, port)
			            else:
			                return self.get_random_ip()
			# print (crawl_ips())
			if __name__ == "__main__":
			    get_ip = GetIP()
			    get_ip.get_random_ip()
	+	scrapt-proxies
	+	scrapy-crawlera(官网提供的收费的ip池）
	+	tor网络
7.	验证码识别
	+ 	tesseract-ocr
	+	在线打码
	+	人工打码
8.	限速措施
	+	setting: COOKIES_ENABLED = False
	+	自动限速
		+	setting: DOWNLOAD_DELAY = 10
		+	AUTOTHROTILE_ENABLED = True
	+	不同的spider设置不同的settings值
		+  cls.custom_settings = {}
		+	![](https://i.imgur.com/lmxQAp2.png)

----------------------
##

### 原理	
+	start_requests
	+	spider中的start_request
	+	![](https://i.imgur.com/zJpxeV7.png)