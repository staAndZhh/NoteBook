## base
+	pip install scrapy
+	import scrapy
+	scrapy.version_info

## shell
+	scrapy
+	命令：fetch,genspider,runspider,settings,shell,startproject,version,view
+	scrapy startproject example
+	cd example
+	scrapy gensipder example example.com
+	scrapy crawl books -o books.csv
+	scrapy shell http://books.toscrape.com/catalogue/a-light-in-the-attic_1000/index.html
+	自带参数：request,response,fetch(req_or_url),view(response)
+	view(response)
+	sel = response.css('div.product_main')
+	sel.xpath('./h1/text()').extract_first()
+	sel.css('p.price_color::text').extract_first()
+	 fetch('http://books.toscrape.com/')
+	view(response)
+	from scrapy.linkextractors import LinkExtractor
+	le = LinkExtractor(restrict_css='article.product_pod')
+	le.extract_links(response)
+	scrapy crawl books -o books.csv --nolog
## spider
+	name
+	start_urls
+	parser(self,response)
+	yield{key:value}
+	yield scrapy.Request(next_url,callback = self.parse)
+	步骤 01 继承scrapy.Spider。
+	步骤 02 为Spider取名。
+	步骤 03 设定起始爬取点。
+	步骤 04 实现页面解析函数。
###	spider基类实现内容
+	供Scrapy引擎调用的接口， 例如用来创建Spider实例的类方法from_crawler。
+	供用户使用的实用工具函数， 例如可以调用log方法将调试信息输出到日志。
+	供用户访问的属性， 例如可以通过settings属性访问配置文件中的配置。

### 爬虫起始爬取点
+	定义start_urls属性
+	实现start_requests方法

## Request
+	Request(url[, callback, method='GET', headers, body, cookies, meta,
encoding='utf-8', priority=0, dont_filter=False, errback])
+	常用:url,method,header,body,meta

## Response
+	TextResponse(父）
+	HtmlResponse（子）
+	XmlResponse（子）
+	HtmlResponse：url,status,headers,body，text,encoding,request,meta,selector,xpath(query),css(query),urljoin(url)
+	常用：xpath(query),css(query),urljoin(query)

## 页面解析
+	使用选择器提取页面中的数据， 将数据封装后（Item或字典） 提交给Scrapy引擎
+	使用选择器或LinkExtractor提取页面中的链接， 用其构造新的Request对象并提交给Scrapy引擎（下载链接页面）

### Selector
+	BeautifulSoup
+	lxml

###	创建selector
+	from scrapy.selector import Selector
+	from scrapy.http import HtmlResponse
+	selector = Selector(text=text)
+	 response = HtmlResponse(url='http://www.example.com', body=body, encoding='utf8')
+	selector = Selector(response=response)

### 选择数据
+	selector_list = selector.xpath('//h1')
+	selector_list.xpath('./text()')
+	for sel in selector_list:print(sel.xpath('./text()'))
+	 selector.xpath('.//ul').css('li').xpath('./text()')

### 	提取数据
+	extract()
+	re()
+	extract_first()	selectorlist专用
+	re_first() selectorlist专用
+	 selector.xpath('.//li/text()')
+	selector.xpath('.//li/text()').extract()
+	selector.xpath('.//li/b/text()').re('\d+\.\d+')
+	selector.xpath('.//li/b/text()').re_first('\d+\.\d+')

+	from scrapy.selector import Selector
+	from scrapy.http import HtmlResponse
+	 response = HtmlResponse(url='http://www.example.com', body=body, encoding='utf8')
+	selector = Selector(response=response)
+	response.selector
+	response.xpath('.//h1/text()').extract()
+	response.css('li::text').extract()

### XPath常用函数
+	string()
+	contians(str1,str2)
+	from scrapy.selector import Selector
+	text='<a href="#">Click here to go to the <strong>Next Page</strong></a>'
+	sel = Selector(text=text)
+	 sel.xpath('string(/html/body/a/strong)').extract()
+	sel.xpath('string(/html/body/a)').extract()
+	sel.xpath('//p[contains(@class, "small")]')

### CSS选择器
+	 response.css('img')
+	 response.css('div img')
+	response.css('body>div')
+	 response.css('div>a:nth-child(1)')
+	response.css('div:nth-child(2)>a:nth-child(1)')
+	response.css('div:first-child>a:last-child')
+	sel = response.css('a::text')

## 封装数据
+ Item基类
+	Field类
###  拓展基类
+	class ForeignBookItem(BookItem):
+	 translator = Field()

### 元数据
+	authors = Field(serializer=lambda x: '|'.join(x))

## 处理数据
+	ItemPipline
+	清洗数据
+	验证数据有效性
+	过滤重复数据
+	数据入库

### Pipline
+	class PriceConverterPipeline(object):
+	process_item(self, item, spider):
+	return item
+	一个ItemPipeline不需要继承特定基类， 只需要实现某些特定方法， 例如process_item、 open_spider、 close_spider。
+	一个ItemPipeline必须实现一个process_item(item, spider)方法， 该方法用来处理每一项由Spider爬取到的数据， 其中的两个参数：item,spider
+	删除数据 raise scrapy.exceptions.Dropitem

## 链接获取
+ Selector
+	LinkExtractor
+	from scrapy.linkextractors import LinkExtractor
+	le = LinkExtractor(restrict_css='ul.pager li.next')

### LinkExtractor
+	from scrapy.linkextractors import LinkExtractor
+	le = LinkExtractor()
+	links = le.extract_links(response1)
+	 [link.url for link in links]
+	参数：allow,deny,allow_domains,deny_domains,restrict_xpaths,restrict_css,tags,attrs,process_value

## 数据导出
+	JSON (JsonItemExporter)
+	 JSON lines (JsonLinesItemExporter)
+	 CSV (CsvItemExporter)
+	XML (XmlItemExporter)
+	Pickle (PickleItemExporter)
+	Marshal (MarshalItemExporter)

### 参数
+	文件路径
+	数据格式（选用那个exporter)
### 配置方式
+	命令行参数指定：-o -t 参数指定文件路径以及导出数据格式
+	配置文件指定
+	scrapy crawl books -o books.csv
+	head -10 books.csv
+	scrapy crawl books -t csv -o books1.data
+ 	scrapy爬虫会以-t参数中的数据格式字符串（如csv、 json、 xml） 为键， 在配置字典FEED_EXPORTERS中搜索Exporter， FEED_EXPORTERS的内容由以下两个字典的内容合并而成
+	默认配置文件中的FEED_EXPORTERS_BASE
+	用户配置文件中的FEED_EXPORTERS
+	FEED_EXPORTERS = {'excel': 'my_project.my_exporters.ExcelItemExporter'}
+	%(name)s,%(time)s
+	scrapy crawl books -o 'export_data/%(name)s/%(time)s.csv'
+	FEED_URI = 'export_data/%(name)s.data'
+	FEED_FORMAT = 'csv'
+	EED_EXPORT_ENCODING = 'gbk'
+	FEED_EXPORT_FIELDS = ['name', 'author', 'price']
+	FEED_EXPORTERS = {'excel': 'my_project.my_exporters.ExcelItemExporter'}

### 自定义Exporter
+	export_item(self,item)
+	start_exporting(self)
+	finish_exporting(self)

### 文件和图片下载
+	FilesPipline
+	ImagesPipline

### 文件
+	ITEM_PIPELINES = {'scrapy.pipelines.files.FilesPipeline': 1}
+	FILES_STORE = '/home/liushuo/Download/scrapy'
+	file_urls,files

### 自定义文件名字
+	实现一个FilesPipeline的子类， 覆写file_path方法来实现所期望的文件命名规则
+	from scrapy.pipelines.files import FilesPipeline
+	from urllib.parse import urlparse
+	from os.path import basename, dirname, join
+	class MyFilesPipeline(FilesPipeline):
+	def file_path(self, request, response=None, info=None):
+	path = urlparse(request.url).path
+	return join(basename(dirname(path)), basename(path))
+	ITEM_PIPELINES = {
+	#'scrapy.pipelines.files.FilesPipeline': 1,
+	'matplotlib_examples.pipelines.MyFilesPipeline': 1,
+	}

### 图片
+	ITEM_PIPELINES = {'scrapy.pipelines.image.ImagePipeline': 1}
+	IMAGES_STORE = '/home/liushuo/Download/scrapy'
+	image_urls,images	
+	缩略图：	IMAGES_THUMBS={'small':(50,50),'big':(270,270)}
+	过滤：IMAGES_MIN_WIDTH = 110
+	IMAGES_MIN_HEIGHT = 110

##  模拟登录
###	登录
+	方式1: FormRequest()
+	 scrapy shell http://example.webscraping.com/user/login
+	sel = response.xpath('//div[@style]/input')
+	 fd = dict(zip(sel.xpath('./@name').extract(), sel.xpath('./@value').extract()))
+	fd['email'] = 'liushuo@webscraping.com'
+	 fd['password'] = '12345678'
+	 from scrapy.http import FormRequest
+	 request = FormRequest('http://example.webscraping.com/user/login', formdata=fd)
+	方式2： FormRequest.from_response()
+	 fd = {'email': 'liushuo@webscraping.com', 'password': '12345678'}
+	 request = FormRequest.from_response(response, formdata=fd)
+  fetch(request)
+	 view(response)
#### 实践
+	覆写基类的start_requests方法， 最先请求登录页面
+	login方法为登录页面的解析函数， 在该方法中进行模拟登录， 构造表单请求并提交。
+	parse_login方法为表单请求的响应处理函数， 在该方法中通过在页面查找特殊字符串'Welcome Liu'判断是否登录成功， 如果成功， 调用基类的start_requests方法， 继续爬取start_urls
中的页面。
### 验证码
+	图像识别
#### 安装
+	pip install tesseract-ocr
+	pip install pillow
+	pip install pytesseract	
+	from PIL import Image
+	import pytesseract
+	img = Image.open('xx.png')
+	img = img.convert('L')
+	pytesseract.image_to_string(img)

#### 其他方式
+	验证码平台
+	人工
### cookie
+	pip install browsercookie
+	import browsercookie
+	chrome_cookiejar = browsercookie.chrome()
+	firefox_cookiejar = browsercookie.firefox() 
### 动态网页
+	splash
+	pip install scrapy-splash
### Http代理
+	HttpProxyMiddleware
### 分布式爬取
+	Radis
## 数据库存储