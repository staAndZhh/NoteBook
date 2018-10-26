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
+   dictA.keys() dictA.values()
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
