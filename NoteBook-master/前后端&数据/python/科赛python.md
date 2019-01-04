#------char2 数据类型-----------
## boolean
+   True False
+ operation: is not
## integer & float
+   operation：
    +   3/2 3//2 
    +   ipmort math
    +    pow(2,3) math.ceil(3.4) math.floor(3.4)
## String
+   str is immutable
+   operation:
    +   str(3)
+   method(obj):
    +   'abc'.capitalize()
    +   'abc'.upper().lower()
    +   'abc'.find('bc')
    +   'abc'.find('d')
+   formatting
    +   name = 'xx' 'hello %s'%(name)
    +   name = 'xx' age=12 '%s age is %.2f'%(name,age)
## List
+   Muatable，Iterable，Sequece Type
+   create and modify:
    +   [] list() [].append(1)
+   index and sliciing:
    + index:  0- length-1
    + [1,2,3,4,5] 
    +   len(A) A[0] A[1:4]
+   Itrerable:
    +   一次一个，循环的时候需要
    +   for item in A[3:4]: print(item)
+   not all same type of item
    + [1,2].append('1')
+   list('abc') list((1,2,3))
+   method:
    +   A.sort(reverse = True) modify A
    +   sorted(A) not modify A
## tuple
+   和list相似
+   immutable
+   可以有重复元素
+   sequence type
+   tuple([1,2,3]) input must be iterable
+   typle() () 1, (1,)
+   A[0] A[：：] A[:-1] A[::-1]
## set
+   unordered
+   contain hashable elements (is immutable),elements must is hashable
+   no repetition
+   not a sequence type  
+   set([1,1,2]) set(['a','b']) len(A) 
+   set([[1],[2]]) is wroing
+   operation:
    +   in & | - A.add(1) A.remove(1)
## Common operations on List,Set,Tuple
+     x in my_object
+   len(x)
+   for x ini my_object
## Dictionary
+   very fast for look up O(1) compared to O(n)
+   Mapping Type 
+ keys
    +   arbitary values 任意值
    +   must be hashable immutable 
    +   also call index
+   value
    +   no restricitons,can be mutable 无限制
+   function(a,b,c)
+   function(1,2,3)  function(c=3,a=1,b=2) function(1,c=3,b=2)
+   {'A':1,'B':2} dict() dict(A=1,B=2) dict([('A',1)],[('B',2)])
+   dictA['A']=2
+   for key in dictA: print(key)
+   dictA.keys() dictA.values() dictA.items()
## Range 
+   start,stop,step
+   list(range(10)) list(range(0,10,3)) list(range(0,-10,-1)) list(range(0)) list(range(1,0))
+   5 in range(10) rangeA[1]
## Hashable
+   哈希函数
+    hash('apple')
+   不同的数据可以放在同一个hash中
## HashTable
+   hash 有方法 hash() eq()
+   py所有的immutable 都是hashable，mutable containers are not hashable
## Loop and Conditionals
+   if: elif: else:
+   for x in range(xx): 知道什么时候停止video/av34514551
+   while x<xx: 可以和for loop呼唤，不知道什么时候停止不许while，必须有停止条件
## 2D list,List Aliasing,Shallow or Deep Copy
+   A=[1,2] B=A[:] A is B True
+   A=[[1,2],[3,4]] B=A[:] B[1][2]=100 A is B False A[0] is B[0] True A[1] is B[1] True
+   DeepCopy
+   import copy 
+   B = copy.copy(A)
+   B = copy.deepcopy(A)
## function
+   def function_name(arg1,arg2,arg3): return result
#----------- char2 myself------------
#------char3 机器学习-----------
+   feature
+   DataSplitting & Cross Validation
+    Training Set & Test Set
+   数据集非常少
+   Leave one out
+   K-fold cross validation
+   supervised learning
    +   classification
    +   Regression
+   unsupervised machine learning
    +   Clustering 
+   Semi-Supervised Machine Learning
    +   Reinforcement Learning
#------char4 A numpy-----------
## create
+   numpy array 只保存一个type
+   np.array([1,2,3,4.0])
+   np.array([1,2,3,4],dtype='int')
+   np.zeros(5,dtype=int)
+   np.ones((2,2),dtype=float)
+   np.full((1,2),2.333)
+   np.random.normal(0,1,(3,3))
+   np.arrange(0,10,2)
+   np.linespace(start,end,total_length,dtype=int))
+   np.linespace(start,end,total_length)
+   x = np.random.randint(10,size=(2,2))
## 属性
+   x.ndim
+   x.shape
+   x.size
+   x.dtype
+   np.iinfo(np.int64).max
+   x.reshape(1,-1)
## 切片
+   x.reshape(1,4)
+   x.shape
+   x.flatten()
+   x[-1]
+   x[0]
+   x[1:3]
+   np.random.seed(0)
+   y = np.random.randint(10,size=(3,4,5))
+   y[1,2,3]
+   x[start:stop:step]
+   x[1:4:2]
+   x[::2]
+   x[::-1]
## 深复制
+   z = y[:,:,:].copy()
## 向量化
+    使用np.sum()而不是sum()
+   np.max()
+   x.min()
## 广播
+   规则1:2个array维度不同,dim小的会被升维度,左边加1,直到维度相同
+   规则2:2个array的shape无论哪一个dim都不同,有1为唯独的array的那个方向拉长到和另外一个匹配
+   规则3:如果以上哪一个规则都不满足,返回error
## boolean Masking
+   a = np.array([1,2,3,4,5,6])
+   a <3
+   np.count_nonzero(a<3)
+   np.sum(a<3)
+   a = np.array([[1,2,3],[4,5,6])
+   np.sum(a<3,axis =1)
+   np.sum(a<3,axis =0)
+   (a<3)&(a>1)
+   and 和 or是整个物体,大于0的数字都是true
+   & | 是bit-wise,np里面一个bool就看做一个bit
+   np里面用and or 会出现错误
## Fancy Indexing
+   np.array([1,2,3,4,5])
+   x[[1,4,5]]
+   x[[1,2,3],[4,5,6]]
+   x[[1,2,3]] -=100
+   A caveat
+   x[1,2,4,4,4]+=1 不会在索引4加3次
+   np.add.at(x,[1,2,4,4,4],1)才可以
##　sorting
+   np.sort(x)
+   x.sort()
+   index = np.argsort(x)
+   x[index]
+   np.sort(x,axis=0)
#------char4 B pandas-----------
+   基本数据结构:series,DataFrame
+   data = pd.Series([1,2.0,3.0])
+   data.index
+   data.value
+   list(data.items())
+   data = pd.Series([1,2,3],index=['a','b','c'])
+   data[0] 
+   data['a']
## Series 和dictionary
+     pd.Series({'a':1})
+  data[['a','b']]
+   data[[0,1]]
+   data[0:1]
## loc
+   数字为index时候
+   data.loc[1:3] explicit index
+   data.iloc[1:3] implicit index
## DataFrame
+   daf.index
+   daf.columns
+   可以根据a list of dictionary 创建 dafaframe
+   或者根据np.array创建
+   index类似array是immutable
+   index类似set,但是可以重复元素
+   daf.T
+   daf.iloc[:2,:3]
+   daf[daf['xx']>1]
## Operation
+   SerA.add(SerB,fill_value=0)
+   fill = A.stack().mean()
+   A.add(B,fill_value =fill)
+   A - A.iloc[0]
+   A.subtract(A['A'],axis=0)
## Missing Value
+   None or NaN 都可能当做null
+   np.nan 是当做float
## MultiIndex
+   daf.stack()
+   pd.merge(df1,df2,on="xx")
+   pd.merge(df1,df2,left_on="xx",right_on="xx").drop("xx",axis=1)
## Aggretions and Group
+   daf.head()
+   每一个groupby的group都是一个series或者是df
+   daf.groupby('xx').mean()
## Pivoting
+   daf.pivot_table('xx',index='xx',columns='xx')
+   大量数据的Filter，可以用pd.eval()或者df.query()
#------char5  matplotlib-----------
+   %matplotlib inline
+   plt.show()
+   import matplotlib.pyplot as plt
+   plt.style.use('seaborn-whitegrid')
+   