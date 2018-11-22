# char1 ----------------
### 魔法命令
+   %paste
+   %cpaste
+   %run xx.py
+   %timeit
+   魔法函数帮助 %magic 
+   魔法函数列表  %lsmagic
+   输入历史 %history -n 1-4
+   %history？
### 输出结果应用
+   print(In[1])
+   Out[2]*2+Out[3]
+   历史记录 print(_)
+   历史记录2次 print(__)
+   历史记录3次 print(___)
+   Out[2]等价于_2
+   禁止输出：结尾加;
### 执行shell命令
+   ！开头
+   !ls
+   !pwd
+   contents = !ls
+   directory = !pwd
+   msg = 'hellp from py'
+   !echo {msg}
+   自动魔法函数 ！cd %cd cd
+   其他自动魔法函数 cat cp env ls man mkdir more mv pwd rm rmdir
### 错误和调试
+   %xmode
+   %xmode Verbose
+   %debug
+   up 
+   down
+   %pdb on
# char2 numpy base----------------
### 创建
+   import array 
    array.array('i',list(range(10)))
+   np.array([1,2,3])
+   np.array([1,2,3],dtype='float32')
+   np.array([range(i,i+3) for i in [1,2,3]])
+   **空数组**
+   np.zeros(10,dtype=int)
+   np.ones((3,4),dtype=float)
+   np.full((3,5),3.14)
+   np.range(0,20,2)
+   np.linespace(0,1,5)
+   np.random.random((3,3))
+   np.random.normal(0,1,(3,3))
+   np.random.int(0,1,(3,3))
+   np.eye(3)
+   np.empty(3)
### 数据类型
+   int16
+   float16
+   bool
+   complex64
## 数组操作

### 属性
+   a.ndim
+   a.shape
+   a.size
+   a.dtype
+   a.itemsize
+   a.nbytes
### 索引
+   a[0] a[-1] a[-2]
+   a[0,0] a[2,1] a[2,-1]
+   a[0,0]=12
+   **切片**
+   a[:5] a[4:7] a[::2] a[1::2] a[::-1]
+   a[:2,:3] a[::3,::2]
+   a[:3,:2].copy()
### 变形
+ np.arrange(1,10).reshape((3,3))
+   x[:,np.newaxis]
### 拼接和分裂
+   np.concatenate([x,y,z],axis=1)
+   np.vstack([x,y])
+   np.hstack([x,y])
+   **分裂**
+   np.split([1,2,3,4,5,6,7,8,9],[3,3])
+   n
