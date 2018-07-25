#	数据结构
###	列表，字典，集合：条件筛选
+	列表：filter  filter(lambda x:x>0,data)
+	列表：列表解析 [x for x in data if x>0]
+	字典：字典解析 {k：v for k,v in d.iteritems() if v>90}
+	集合：集合解析 {x for x in s if x % 3 ==0 }
### 元组每个元素命名
+	定义枚举类 
	>	 	NAME,AGE,SEX,EMAIL=xrange(4) 
	>	 	student[NAME]= 4

+	collections.namedtuple 
	>	 	from collections import namedtuple
	>	 	Student = namedtuple('student',['name','age','sex','email'])
	>	 	s = Student('Jim',16,'male','xx@163.com')
	>	 	s.name
### 统计词词频
+	原始方法
	>		dict.fromkeys(data,0)
	>		for x in data: c[x]+=1
+	collections.Counter
	>		from collections import Couter
	>		c2 = Couter(data)
	>		c2.most_common(3) c2[20]
### 字典中值大小对字典排序
+	原理：sorted方法（sorted排序的是iter对象，字典的iter是键值，所以要用元组：元组排序先前后后）
+	zip元组化
	>		sorted(zip(d.itervalues(),d.iterkeys()))
+	sorted的key参数
	> 		sorted(d.items(),key= lambda x: x[1])
### 找到多个字典中的公共键
+	set操作：找字典的keys，所有字典的keys,reduce取交集
	>		reduce(lambda a,b:a&b,map(dict.viewkeys,[s1,s2,s3]))
###	有序字典
+	OrderedDict 代替Dict
	>		from collections import OrderedDict
### 用户的历史记录功能
+	队列结构 collections.deque 双端循环队列 pickle 存储
	>		from collections import deque
	>		history = deque([],5)
	>		history.append()
	>		import pickle
	>		pickle.dump(q,open('history','w')
	>		pickle.load(file)
#	迭代器&生成器
###	可迭代对象
+	第一步:iter(xx) __iter__()  可迭代对象，迭代协议的接口
+	第二步：getitem() 序列借口
+	
###	迭代器对象
+	next() 
+	可迭代对象 返回 迭代器对象
+	for循环
+ 	iter()得到对象
+	调用iter对象的next()方法，StopIteration
+	实现迭代器对象
+	WeatherIterator(实现next()方法）
+	实现可迭代对象
![](https://i.imgur.com/IxCh3s1.png)

![](https://i.imgur.com/Evli3LL.png)

###		生成器对象
+	包含yield的对象
+	生成器对象也是可迭代和迭代器对象，实现了 __iter()__和next()方法
+	__iter__方法实现生成器函数，每次返回一个元素
![](https://i.imgur.com/rVxRpN0.png)

###		反向迭代
+	reverse(list)
+	list[::-1]
+	iter()的反向操作 reversed() 反向操作迭代器
![](https://i.imgur.com/U7pKn1l.png)

###		迭代器对象的切片操作
+ itertool.islice,返回迭代器对象切片的生成器
>		l	 = range(20)	
>		t = iter(l)		
>		for x in islice(t,5,10)): print x
		for x in islice(t,5,10)): print x

###	一个for语句迭代多个可迭代对象
+	并行zip
	>	for a,b in zip([1,2,3],('a','b','c'，'d'))
+	串行 itertools.chain
	>		from itertools import chain
	>		chain([1,2,3,4],['a','b','c'])
#	字符串
### 多个字符串分隔符分割
+	单一分隔符：str.split()
+	多个分割符：split()连续使用& re.split()
+	![](https://i.imgur.com/igvhCNA.png)

+	re.split(r'[,;\t|]+',str)
###	判断字符串a是否以字符串b开头或者结尾
+	str.startswith()
+	str.endswith(('xx','xxx))
### 调整字符串的文件格式
+  re.sub()字符串替换，正则表达式的捕获组，然后调整顺序
>  	log = open('xx').read()
>  	re.sub('(\d{4})-(\d{2})-(\d{2})',r'\2/\3\1'.log)
>  	re.sub('(?P<year>\d{4})-(?P<month>\d{2})-(?P<day>\d{2})',r'\g<month>/-\g<day>-/\g<year>'.log)
###	多个小字符串拼接为一个大的字符串
+	迭代列表使用+（str.__add__(s1,s2))
+	str.join()（''.join(['abc','123','xyz'])
+	数字拼接
+	''.join([str(x) for x in l])
+	''.join(str(x) for x in l)
### 	字符串左右居中对齐
+	str.ljust() str.rjust() str.center()
+	format()方法
+	str.format(20,"<20") >20 =20
+	w = max(map(len,d.keys())) for k in d : k.ljust(w),d[k]
###	去掉字符串中不需要的字符
+	str.strip() str.lstrip() str.rstrip()
+	切片+拼接
+		str.replace()	re.sub()
>		str.translate()
>		str.strip('-+')
>		import re re.sub('[\t\r]','',s)
>		import string
>		string.maketrans('abcxyz',xyzabc')
>		str.translate(string.maketrans('abcxyz',xyzabc'))
>		str.translate(None,'\t\r\n')
>		unicode.translate(dict.fromkeys(['xx','xx'])
#	文件IO
###	文件读写
+	py2:写入文件前对unicode编码，读入文件后对二进制字符串解码
+	py3:open指定文本模式，encoding指定编码格式
#	数据编码与处理
### 读取csv数据
+	标准库的csv模块，使用其中的reader和writer完成csv读写
![](https://i.imgur.com/MwpNLIu.png)
### 读取json数据
+	标准库中json中的loads和dumps实现json数据的读写
### xml文档
+	标准库中的xml.etree.ElementTree的parse/write函数
![](https://i.imgur.com/akeUuSX.png)
### 读写excel文件
+	第三方库 xlrd和xlwt
![](https://i.imgur.com/k3tgm00.png)
# 	类与对象
### 派生内置不可变类型并修改实例化行为
+	自定义元组：只保留int且值大于0
	>	继承元组，__new__（cls)先于__init__执行
	>	重写__new__方法
+	![](https://i.imgur.com/7UNIAsM.png)
###	创建大量实例节省内存
+	定义类的__slot__属性，声明实例属性名字的列表
+	__slot__阻止属性的动态绑定
+	![](https://i.imgur.com/N12TB7Q.png)
+	多了__dict__
+	p1.__dic__['xx'] = xx
###	对象支持上下文管理
+	实现上下文管理协议
+	实现__enter__,__exit__方法（with开始和结束时调用）
	>	with xx(xx) as client:
+	__enter__方法的返回值 as client
	>	__exit(self,exc_type,exc_val,exc_tb):
+	__exit__方法返回True,不会向外面抛出异常
### 创建可管理的对象属性
+	getset方法的类似
+	形式上是属性访问，实际上是调用方法
+	使用property函数为类创建可管理属性，fget/fset/fdel对应相应属性访问
+	![](https://i.imgur.com/U9b1pjK.png)
###	让类支持比较操作
+ 	重载实现__lt__,__le__,__gt__,__ge__,__eq__,__ne__方法
+	使用标准库下的functools下的类装饰器total_ordering可以简化
+	r1<r2 r1.__lt__(r2)
+	![](https://i.imgur.com/e11s25U.png)
+	定义抽象基类让所有图形实现比较方法
+	![](https://i.imgur.com/kH7OREG.png)
### 用描述符对实例属性进行类型检查
+	对实例变量名指定类型
+	赋值不正确时抛出异常
+	描述符：任何包含__get__,__set__,__delete__其中一个的方法
+	![](https://i.imgur.com/xqk1NGi.png)
>	p = Person()
>	p.name = "Bob"
>	print p.name
>	p.age = "17"
### 环状数据结构管理内存
+	垃圾回收器通过引用计数回收垃圾对象
+	sys.getrefcount(a)-1
+	使用标准库weakref,创建能访问对象但不增加引用计数的对象
>	weakref.ref(a)
	
+	![](https://i.imgur.com/3Td9EOk.png)
### 实例方法名字的字符串调用方法
+	使用内置函数getattr通过名字在实例上获取方法对象，调用
+	使用标准库operator下的methodcaller函数调用
+	![](https://i.imgur.com/EUrAx8j.png)

>	from operator import methodcaller
>	s ='abc123abc456'
>	methodcaller('find','abc',4)(s)
# 	多线程与多进程
###	多线程
+	标准库threading.Thread创建线程，在每一个线程中下载并转换一只股票数据
+	函数式使用
>	from threading import Thread
>	t = Thread(target = handle, args = (1,))
>	t.start()
+	自定义线程类使用
>	from threading import Thread
>	class MyThread(Thread):
>	def __init__(self,sid):
>	Thread.__init__(self)
>	self.sid = sid
>	def run(self):
>	handle(self.sid)
>	t = MyThread(1)
>	t.start()

+	线程等待 t.join()
>	threads = []
>	for i in xrange(1,11）：
>	t = MyThreads(i)
>	threads.append(t)
>	t.start()
>	for t in threads:
>	t.join()
>	print 'main thread'

+	IO密集型和CPU密集型操作
+	python不适合CPU密集型:GIL全局解释器锁

###	线程间通信
+	下载：IO密集型操作
+	转换：CPU密集型操作
+	多线程下载：下载后，下载线程把下载数据安全的传递给转换线程(1个）
+	使用Queue.Queue，线程安全的队列 from Queue import Queue
+	Download线程把下载数据放入队列，Convert线程从队列中提取数据
+	下载线程
+	![](https://i.imgur.com/2TAdYuD.png)

+	转换线程
+	![](https://i.imgur.com/8uddXGR.png)
+	def run(self):
+	![](https://i.imgur.com/iZSXC1M.png)
###	线程间事件通知
+	打包线程：转换线程每生产100个xml文件，打包线程打包；打包完成；打包线程通知转换线程；转换线程继续转换
+	线程间事件通知，标准库中的Threading.Event；
+	等待事件一端调用wait，等待事件；
+	通知事件一端调用set,通知事件；
+	![](https://i.imgur.com/PNenIq6.png)

+	只能停止一次：需要 e.clear()
>	TarThread.__init__(self,cEvent,tEvent):
>	def run(self):
>	while True:
>	self.cEvent.wait()
>	self.tarXML()
>	self.cEvent.clear()
>	self.tEvent.set()

+	![](https://i.imgur.com/rcBR49O.png)

+	设置打包线程为守护线程
+	self.setDaemon(True)

+	![](https://i.imgur.com/oM2Lkqc.png)
###	线程本地数据
+	threading.local创建线程本地数据空间，其下属性对每一个线程独立存在
+	![](https://i.imgur.com/dyNK87s.png)

+	![](https://i.imgur.com/727gJUC.png)
+	![](https://i.imgur.com/vWDEe4O.png)
###	线程池
+	防止线程过多
+	py3线程池实现，标准库里的concurrent.futures下的ThreadPoolExecutor
+	对象的submit和map方法可以启动线程池中的线程执行任务
+	![](https://i.imgur.com/KRJr0Xh.png)

+	多个任务时会阻塞，并后续执行
###	多进程
+	处理cpu密集型的任务，可以使用多进程模型
+	标准库中的multiprocessing.Process可以启动子进程执行任务
+	操作接口，进程间通信，同步与Threading.Thread类似
+	from multiprocessing import Process
+	Process(f,args).start().join()
+	多个进程间的子空间是独立的
+	进程间通信
+	![](https://i.imgur.com/br528e6.png)
+	Pipe通信
+	c1,c2 = Pipe()
+	c1.send('abc') c2.recv()
+	c2.send('xyz')	c1.recv()
+	![](https://i.imgur.com/hfqixnH.png)

+	线程和进程的区别
+	![](https://i.imgur.com/tDc3Wm8.png)

#	装饰器
### 如何使用装饰器
+	重复计算的子问题
+	定义装饰器函数，生成一个在原来函数基础上添加新功能的函数，替代原函数
+	![](https://i.imgur.com/0x0XsfI.png)
+	包裹函数cache+ 添加其他函数
+	![](https://i.imgur.com/8JQUDOA.png)
###	被装饰的函数保存元数据
+	元数据：__name__,__doc__,__module__，__defaults__(默认参数）,__closure__
+	标准库 functools的装饰器wraps装饰内部包裹函数，指定把原函数的某些属性，更新到包裹函数上
+	![](https://i.imgur.com/U6gsLIu.png)
###	定义带参数的装饰器
+	定义参数检查装饰器：根据参数定制化一个装饰器，看做生产装饰器的工厂，每次调用，返回一个特定的装饰器，然后用它去修饰其他函数
+	from inspect import signature
+	signature(f).parameters["a"].kind
+	sig.bind(str,int,int)
+	sig.bind_partical(str)
+	![](https://i.imgur.com/qhthyU2.png)
### 属性可修改的装饰器
+	统计被装饰函数单次调用运行时间，时间>xx,计入log日志；可运行时修改timeout
+	py3
+	![](https://i.imgur.com/uCc4kxS.png)
+	py2
+	![](https://i.imgur.com/qAsxcfJ.png)
###	类中定义装饰器
+	![](https://i.imgur.com/SCDgoEj.png)
+	![](https://i.imgur.com/arLZBnT.png)