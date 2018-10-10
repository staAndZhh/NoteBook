# 知识点
+	对象
+	魔法方法
+	py序列协议
+	dict和set
+	迭代器&生成器
+	socket
+	对象引用可变性垃圾回收
+	元类编程
+	进程线程
+	异步io协程
+	asyncio并发编程

## 对象
###	一切皆对象
+	py中类和函数也是对象：一等公民
	+	赋值给一个变量
	+	添加到集合对象中
	+	作为参数传递给函数
	+	可作为函数的返回值(装饰器）
+	代码和模块也是对象
###	type,object和class关系
+	type
	+	生成类
	+	返回一个数据类型

+	type-int-1
+	type-class-obj
+	class是由type类生成的类
+	object是所有类必须继承的基类
+	object是顶层基类
+	type也是一个类
+	type.__bases__ object
+	type(object)  type
+	object.__bases__ ()
+	obj是type的实例
+	type是type的实例
+	type继承了obj
+	type创建了所有对象
+	Python的世界中，object是父子关系的顶端，所有的数据类型的父类都是它；type是类型实例关系的顶端，所有对象都是它的实例的。
### 内置对象
+	对象特征
	+	身份id，类型，值
+	None(全局只有一个）
+	数值：int,float,complex,bool
+	迭代类型:for遍历
+	序列类型：list,range,tuple(()),str,array,bytes
+	映射（dict)
+	集合:set,frozenset
+	上下文管理类型:with语句
+	其他：模块类型，class和实例，函数，方法，代码，obj,type,elipsis（...),notimplemented对象

## 魔法函数
+	什么是魔法函数
+	数据模型以及影响
+	魔法函数浏览
+	魔法函数意义
+	不是由继承来的
+	python解释器会自动调用

### 定义
+	__xx__的函数：内置函数
+	魔法函数是为了增强对象的特性：--len--，--getitem--

### 魔法函数浏览
+	非数学运算
	+	字符创表示：repr,str
	+	集合序列相关：len，getitem，setitem,delitem,contians
	+	迭代相关：iter,next
	+	可调用：call
	+	上下文管理：enter,exit
	+	数值转换：abs,bool,int,float,hash,index
	+	元类相关：new,init
	+	属性相关：get,set,delete
	+	协程:await,aiter,anext,aenter,aexit
+	数学运算
	+	一元：neg,pos,abs
	+	二元：lt,le,eq,ne,gt,ge
	+	算术:add,sub,mul,truediv,floordiv,mod,divmod,pow
	+	反向算术：radd,rsub,rmul
	+	增强算术：
	+	位运算
	+	反向位置运算
	+	增强赋值位运算

## 类和对象
+	鸭子类型
+	抽象基类（abc模块）
+	instance和type区别
+	类变量和实例变量
+	类和实例属性
+	数据封装和私有属性
+	对象自省机制
+	super调用
+	mixin继承
+	with语句
+	contextlib上下文管理
+	类方法，静态方法，实例方法

### 鸭子类型
+	py用鸭子类型实现其他语言中的多态
+	只要实现对应的魔法函数就能调用

### 抽象基类
+ 	抽象基类类似java中的借口
+	必须实现抽象基类中的方法，抽象基类不能实例化
+	不同的魔法函数赋予类不同的特性
+	不需要继承指定的类
+	鸭子类型+魔法函数=协议
+	hasattr(com,"__len__")
+	其他语言 isinstance(com,Sized)
+	强制某个子类比必须实现某些方法
+	需要一个抽象基类，指定子类必须实现某些方法
+	可以使用isinstance()
+	import abc
+	class CacheBase(metaclass = abc.ABCMeta):
+	@abc.abcstractmethod
+	def get(sekf,key,value):
+	pass
+	from collections.abc import *
+	推荐使用多继承少使用抽象基类

###	instance和type
+	推荐使用isinstance少使用tpye
+	isinstance能够检查继承链
+	is判断id是否相同，是否是相同的一个对象
+	==判断两个值是否相同
+	B继承A，type(b) is B T,type(b) is A F
+	isinstance 都为T

### 类变量和实例变量
+	实例变量 __init__方法中： self.xx
+	类变量	class中的变量 类名.xx
+	实例变量可以访问类变量
+	类不能访问实例变量
+	实例.xx 改变类变量会新建xx放在实例中：并不会改变类变量
+	类变量更改，会整个更改
+	类变量和实例变量是独立的

### 类属性和实例属性
+	属性查找顺序 A.__mro__
+	新式类，继承类的属性查找方法

### 类静态实例方法
+	实例方法 class 中的 def xxx(self):
+	静态方法 @ staticmethod def xxx(xxx): return 类名.xxx
+	静态方法调用：类.静态方法；把方法的命名空间变为类的命名空间
+	类方法 @ classmethod def xxx(cls,xxx): return cls.xxx
+	类方法调用：类.类方法；传递cls
+	静态方法和类方法的区别
+	静态方法不会访问到 class 本身 - 它基本上只是一个函数，在语法上就像一个方法一样，但是没有访问对象和它的内部（字段和其他方法），相反 classmethod 会访问 cls， instancemethod 会访问 self。
+	子类覆盖了父类的静态方法，子类的实例继承了父类的static_method静态方法，调用该方法，还是调用的父类的方法和类属性。
+	子类的实例继承了父类的class_method类方法，调用该方法，调用的是子类的方法和子类的类属性。

### 数据封装
+	私有属性：__xx （变形为实例.__类名__属性）
+	私有属性只能在类的公共方法中使用
+	私有属性实际上是对类名进行变形
+	能解决继承时的命名冲突

### 自省机制
+	通过一定的机制查询到对象的内部结构
+	__dict__查询对象自身属性
+	dict可以动态读取
+	dir()获取对象的所有属性：只有属性名称，没有属性值

### super
+	super(B,self).__init__()
+	super().__init__()
+	super()不是调用父类的构造方法
+	super()调用的是mro中下一个顺序的类型的构造函数
+	xx.__mro__

### 多继承的使用
+	mixin模式：混合模式（组合模式）
+	每个mixin类的功能单一
+	不和基类关联，可以和任意基类组合，基类可以不和mixin关联就能初始成功
+	在mixin中不要使用super这种用法
+	tips:Mixin尽量以minix结尾
###	with上下文管理器
+	try:except：else: finally:
+	如果try里面的异常没有被except捕捉到，且没有raise，将被else捕捉
+	读取文件时如果文件出现异常，不管怎样都要在finally中关闭文件
+	如果try,except,finally都有return 语句，如果try中有异常：根据压入堆栈的顺序，最后一定是先返回finally中的return语句
+	python是根据协议编程的
+	with协议：enter,exit

###	contextlib上下文管理
+	把一个函数变成一个上下文管理器
+	import contextlib
+ @contextlib.contextmanager
+	contextlib修饰的函数必须是一个生成器
+	@contextlib.contextlib
+	def file_open(xx):
+	enter_xxx
+	yield {}
+	exit_xxx
+	with file_open() as f_opened:
+		print ('xxx')

## 自定义序列类
+	序列类型分类
+	序列的abc继承
+	序列的+，+=和extend
+	可切片对象
+	bisect管理可排序序列
+	列表使用
+	列表，生成器，字典推导式
### 序列类型的分类
+	容器：list,tuple,deque
+	扁平：str,bytes,bytearray,array.array
+	可变：list,depue,bytearray,array
+	不可变：str,tuples,bytes
###	序列的abc继承
+	from collections import abc
+	Sequence(Reviesed，Collections)
+	Collections(Sized,Iterable,Containers)
+	Sized:len
+	Iterable:iter
+	Containers:contains
+	MutedSequence(Sequence)
+	setitem,getitem

###	序列的+，+=和extend
+	+连接2个list，+的符号2边必须都是list
+	+=就地加,符号2边只要是序列类型就可以
+	+=：iadd:extend(iterable)
+	extend:直接修改原来的，没有返回值
+	a.append([1,2])添加一个值
+	append添加一个值，extend添加一个序列

###	可切片对象
+	列表切片返回的是一个新元素
+  	a_list[len(a_list):] = [9] 
+	a_list[:0] = [1,2]
+	a_list[3:3] = [4]
+	a_list[::2] = [0]*3
+	a_list[:3] = []
+	del a_list[:3]
+	自定义支持切片操作的不可修改Group
+	必须实现getitem(self,item)方法
+	reversed
+	getitem
+	len
+	iter
+	contains 
+	切片操作：自动初始化一个slice传递给getitem

### 已排序序列管理bisect
+	import bisect
+	可修改的序列都可以
+	用于处理已经排序的序列，用来维持已经排序的序列，升序
+	inter_list =[]
+	bisect.insort(inter_list,3)
+	bisect.insort(inter_list,4)
+	bisect.insort(inter_list,5)
+	bisect.bisect_left(inter_list,3)

###	列表使用
+	list和array区别
+	array只能存放指定的数据类型
+	array,deque
+	array.array("i").append(1)
### 列表，生成器，字典推导式
+	列表生成式性能高于列表
+ 	list(生成器）=列表生成器
## set和dict
+  继承关系
+	dict用法
+	dict子类
+	set和frozenset
+	dict和set原理
### 继承关系
+	 form collections.abc import Mapping
### 方法
+	clear()
+	copy() 浅拷贝：源文件受到影响
+	import copy
+	copy.deepcopy()
+	dict.fromkeys()
+	get()
+	dict.items()
+	dict.setdefault()
+	dict.update()
###	子类
+	from collections import UserDict
+	from collections import defaultDict
### set和frozenset
+	set()
+	{'xx','xxx'}
+	set.add()
+	set1.difference(set2)
+	& | - 
+	frozenset可以作为set的key
### 原理
+	dict的key或者set的值都必须是可以hash的
+	不可变对象都是可以hash的。str,frozenset，typle自己实现的类hash
+	dict内存花销大，查询速度快
+	自定义对象，或者python内部对象都是用dict包装的
+	dict存储顺序和元素添加顺序有关
+	添加数据可能改变已有数据的顺序
## 对象引用
+	变量
+	is和==
+ 	del
+	经典错误
### 变量
+	py对象的实质是一个指针
+	先生成对象，然后在贴便利贴
###	is和==
+	a = [1,2,3,4] b=[1,2,3,4] a==b True,a is b False
### del和垃圾回收
+	cpython垃圾回收采用引用计数
+	del是把引用计数变为0
###	经典的错误
+	参数使用默认的空的list,list是可变的对象
+	传递list或者dict对象到函数中，很容易被改变

##  元类编程
+	property动态属性
+	getattr,getattribute
+	属性描述符和查找过程
+	new,和init
+	自定义元类
+	元类实现简单orm
### property
+	属性描述符
+	@property  def age(self):
+	@age.setter  def age(self,value):
### getattr和getattribute
+	getattr 查找不到属性的时候调用
+	getattr调用getattrubute
### 属性描述符和查找过程
+	实现get,set,delete中的任何一个方法
+	属性描述符进行参数检查
### new和init区别
+	new在init之前
+	new控制对象的生成过程，在对象生成之前
+	init用来生成对象
+	如果new方法不返回对象，不会调用init函数

## 多线程与多进程
### GIL
+	global interpreter lock
+	类似于c语言中的一个线程
+	gil使得一个时刻只有一个线程在cpu上执行字节码，无法将多个线程映射到多个CPU上执行
+	gil根据执行的字节码行数以及时间片释放gil
+	gil在进行io操作时会主动释放
### 线程
+	操作系统调度的最小单元：线程
+	io操作：多线程和多进程差别不大
+	 主线程结束：关闭子线程
	+	thread.setDaemon(True)
+	子线程阻塞
	+	thread.join()
### 线程间通信
+	共享变量
+	线程安全的队列from queue import Queue
### 线程同步问题
+	线程锁
+	锁会影响性能
+	锁会引起死锁 A（a b) B（b a)
+	from threading import Lock
+	lock = Lock()
+	global lock lock.release() lock.acquire()
+	可重入的锁
+	from threading import RLock
+	同一个线程可以多次acquire,但是acquire的此时一定要和release相等
### condition线程同步
+	条件变量，用于复杂的线程同步
+	from threading import Condition
+	acquire,realease,wait,notify
+	with方法只能通过nofity才能唤醒
+	condition有2层锁，一把底层锁在线程调用wait的时候释放，上边的锁会在每次调用wait的时候分配一把并放在cond的等待队列中。等待notify方法的唤醒
>	with self.cond:
>	sefl.cond.wait()
>	self.cond.notify()
###	Semaphore线程信号量
+	用于控制进入数量的锁
+	文件读写，写一般一个线程；读可以允许有多个
+	内部使用condition,在wait之前进行条件的判断
+	Queue内部使用的condition
+	限制爬虫数量
+	sem = threading.Semaphore(3)
+	sem.accquire() #调用一次数量减一次
+	sem. release()
###	线程池
+	数量控制，主线程获取子线程的状态或者返回值
+	让多线程和多进程编码借口一致
>	from concurrent import futures
>	from concurrent.futures import ThreadPoolExecutor
>	ThreadPoolExecutor(2).submit(f,(3)).done()
+	submit是立即返回
+	done用于判定某个人物是否完成
+	result可以获取task阻塞后的执行结果
+	task.cancel取消任务的执行
+ 	获取已经成功的task返回
+	from concurrent.futures import as_completed
>	all_task = [executor.submit(xx,(url)) for url in urls]
>	for furture in as_completed(all_task):
>		data = furture.result()

+	通过executor获取已经完成的task
>	for furture in executor.map(get_html,urls):
>	data = furture.result()

+	让所有的子线程执行完成后再开始执行主线程的任务
+	from concurrent.futures import wait
+	wait(all_task)

###	线程池源码
+	Future:task的返回容器
+	如何跟新，怎么更新状态？异步编程的核心
+	把函数和运行结果放在轮询器里面，交给主线程使用

###	多进程编程
+	多进程编程
+	win环境：多进程编程一定要放在main函数中运行
+	os.fork()只能用于Linux环境中
+	线程会通过全局变量共享数据
+	子进程会完全拷贝父进程的数据和环境，气候的操作时完全隔离的
+	from current.futures import ProcessPoolExecutor
+	import multiprocessing
+	进程池
+	pool = multiprocessing.Pool(multuprocessing.cpu_count())
+	pool.apply_async(f,args)
+	for  result in pool.imap(f,args):print（result）
+	for  result in pool.imap_unordered(f,args):print（result）
+	pool.join()
+	pool.get()

###	进程间通信
+	共享全局变量不适用于多进程，适用于多线程
+	from multiprocessing import Process，Queue
+	from multiprocessing import Manager （Manager().Queue())
+	多进程里的queue能用通信，但是不能用于进程池的通信	
+	pool中的进程间通信，要使用Manager中queue
+	Pipe实现管道通信
+	pipe只能适用于2个进程
+	pipe性能高于queue
+	c1,c2 = Pipe()
+	pipe.send()
+	pipe.recv()
+	进程之间的共享内存
+	progresss_dict = Manager().dict()

#	协程
###  并发，并行，同步，异步，阻塞，非阻塞
+	并发：一个时间段内，几个程序在同一个cpu上运行，但是任意时刻只有一个程序在cpu上运行
+	并行：任意时刻点上，多个程序同时运行在多个cpu上
+	同步：代码调用IO操作时，必须等待IO操作完成才返回的调用方式
+	异步：代码调用IO操作时，不必须等待IO操作完成才返回的调用方式（多线程）
+	阻塞：调用函数时当前线程被挂起。
+	非阻塞：调用函数时当前线程不会被挂起，而是立即返回。
###	C10K问题和io多路复用（select,poll,epoll)
+	Unix下的5种IO模型
+	阻塞式IO，非阻塞式IO，IO复用，信号驱动式IO，异步IO（POSIT的aio_系列函数）
+	select,poll,epol是IO多路复用的机制
+	本质是同步IO
+	select:writefds,readfds,exceptfds
+	pool:pollfd
+	epoll：使用红黑树进行数据查询
###	epoll&回调&事件循环方式url
###	回调之痛
###	C10M问题和协程
+	协程：有多个入口的函数，可以暂停的函数，可以向暂停的地方传入值
+	生成器（yield)--协程
###	生成器的send和yield from
+	启动生成器的方法：next(),send
+	send可以传值进入生成器，同时可以重启生成器执行到下一个生成器
+	在调用send发送非None值之前，必须启动一次生成器
+	gen.send(None)
+	next(gen)
+	其他方法:throw,close
+	gen.close()在下一次调用时，执行出现异常
+	异常是向上抛的
+	GeneratorExeception 继承BaseException
+	throw方法
+	gen.throw(Exception,"downloading fail")
+	需要自己捕捉
+	yield from iterable
###	生成器如何协程
###	async和await原生协程
# 	asyncio并发编程
###		事件循环
###	call_函数族
###	ThreadPoolExcutor
###	asyncio模拟http
###	future和task
###	同步和通信
###	高并发爬虫
