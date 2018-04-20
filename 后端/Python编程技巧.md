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
+	iter(xx) __iter__()  可迭代对象
+	getitem() 序列借口
+	next() 迭代器对象
+	可迭代对象 返回 迭代器对象

#	字符串
#	文件IO
#	数据编码与处理
# 	类与对象
# 	多线程与多进程
#	装饰器