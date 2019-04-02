# numpy

## create

### ori

import numpy as np 

np.randow.seed(666)

np.random.randn(2,3)  np.random.randint(0,1,10)

np.random.normal(10,100,(3,5))

np.array([1,2,3]) 	np.array([[1,2,3],[4,5,6]])

np.zeros(10)	np.zeros((3,6)) 

np.fill((3,4),1)

np.empty((2,3,2))

np.arrange(15)

np.linespace(0,1,5)

### choose dtypes

np.array([1,2,3],dtype=np.float64)  np.int32	np.string_	"|S4"	arr1.dtype

arr.astype(np.float64)

### prop

arr.shape

arr.ndim

arr.dtype

arr.size

## operation

$+-*/ %//	np.dot/@	T$

np.dot(arr.T, arr)

arr.copy()

### append

np.concatenate([arrx,arry])

np.concatenate([arrx,arry],axis=1)

np.vstack([arrx,arry]) # 容错更高，列合并 

np.hstack([arrx,arry]) # 行合并

### split

x1,x2,x3= np.split(arrx,[3,7])

x1,x2= np.split(arrx,[2],axis=1)

np.vsplit(arrx,[2])

np.hsplit(arrx,[2])

### fuction

np.sqrt(arr)

np.exp(arr)

np.log2(arr)

arr.T

np.maximum(arrx,arry)   

arr.mean(axis=1) 		arr.mean(axis=0)		np.mean(arr)

arr.sum()    np.sum(arr,axis=1)

np.prod(arr)

np.median(arr)

np.percentile(arr,q=50)

np.var(arr)

np.std(arr)

arr.cumsum()

arr.cumprod(axis=1)

remainder, whole_part = np.modf(arr)

np.tile(arr,(2,1))  # 广播填充

np.linalg.inv(arr)

np.linalg.pinv(arr)

np.argmin(arr)

np.random.shuffle(arr)

np.sort(arr)    arr.sort()

np.sort(arr,axis=1)	np.sort(arr,axis=0)

np.argsort(arr) 	np.argsort(arr,axis=1)

np.partition(arr,3) # 快速排序中间值

np.argpartition(arr,3) 		np.argpartition(arr,2,axis=1)



### bool

arr.any()		np.any(arr<0) 

arr.all()

np.sum(arr<=3)

np.count_nonzero(arr<=3)

### sort

arr.sort()	arr.sort(1) 	np.sort(arr)

### unique

np.unique(arr)

### setoperation

intersect1d(x,y)

union1d(x,y)

setdiff1d(x,y)

setxor1d(x,y)

np.in1d(value,arr)



## sliceing

arr[1:4]

$arr[0][2]$ 	$arr[0,2]$

$arr[:,:3]$       $arr[:,3]$

$arr[:,:-1]$

### boolean index

$arr[names == "xx",:2]$

$arr[names != "xx",:2]$

$arr[~(names == "xx")|(names == "xxx")]$

$arr[arr<0]=0$

$np.where(cond,xarr,yarr)$



### fancy index

$arr[[1,4,3,2]]$

$arr[[1, 5, 7, 2], [0, 3, 1, 2]]$

$arr[[1, 5, 7, 2]][:, [0, 3, 1, 2]]$ 	[:, [0, 3, 1, 2]]表示选中所有行，但是列的顺序要按0,3,1,2来排

## Transoposing

np.arange(8).reshape((4, 2))

arr.reshape(10,-1)

np.arange(16).reshape((2, 2, 4)).transpose((1, 0, 2))

arr.swapaxes(1,2)

np.meshgrid(x,y)

# pandas

from pandas import Serie, DataFrame

#Series

## create

### ori

pd.Series([1,2,3])

pd.Series([1,2,3],index=['d','b','c','a'])

pd.Series({"a":1,"b":2}) 	pd.Series(dict)

pd.Series(dict, index=["a","b","c"])

### prop

pds.values

pds.index

pds.name

pds.index.name

pds.index = ["a","b","c"]

## operation

### del

pds.drop('c')

pds.drop(["b","c"])

### funcion

pds1+pds2 	相同的key对应的数据，会相加

np.exp(pds)

pds.map(format)

### bool

"b" in nps

pds.isnull()

pd.isnull(pd)

pd.notnull(pd)

### sort

pds.sort_values()

pds.rank()  pds.rank(method="first")  obj.rank(ascending=False, method='max')



## sliceing

pds['a']

pds[['a','b','c']]

### boolean index

pds[pds>0]

### index sliceing

pds['b']  pds[2:4]  pds["b","c","d"]  pds[[1,3]] 	pds["b":"d"]行

## unique

pds.unique()

pds.value_counts()

pd.value_counts(obj.values, sort=False)

pds.isin(['b', 'c'])

pd.Index(pd.Series(['c', 'b', 'a'])).get_indexer(pd.Series(['c', 'a', 'b', 'b', 'c', 'a']))



#DataFrame

## create

### ori

pd.DataFrame({"a":["1","2","3"],"b":[1,2,3],"c":[1.2,2.3,3.4]})

pd.DataFrame(data,columns=["year","state","pop"])

pd.DataFrame(data,columns=["year","state","pop"],index=["a","b","c","d","e","f"])

pd.DataFrame({'Nevada': {2001: 2.4, 2002: 2.9},'Ohio': {2000: 1.5, 2001: 1.7, 2002: 3.6}})

### prop

pdf.head()

pdf.columns

pdf.index.name

pdf.columns.name

pdf.values

## sliceing

column:	pdf['year'] 	pdf['debt'] = np.arange(6.)	 pdf.year

row: pdf.loc['three']

## operation

pdf.T

### function

np.abs(pdf)

pdf.apply(lambda x:x.max()-x.min())

pdf.apply(lambda x:x.max()-x.min(), axis="columns")

pdf.applymap(lambda x: '%.2f' % x)

pdf['e'].map(format)

pdf.apply(pd.value_counts)

### sort

pdf.sort_index()  pdf.sort_index(axis=1)  pdf.sort_index(axis=1, ascending=False)

pdf.sort_values(by="b")

pdf.sort_values(by=['a', 'b'])

pdf.rank(axis='columns')

### delete

del pdf["xx"]

pdf.drop(["xx","x"])  行

pdf.drop("xx",axis=1)  pdf.drop(["xx","x"],axis="columns") 列

pdf.drop(["xx","x"],inpleac=True) 

## index

pd.Index(['foo', 'foo', 'bar', 'bar'])	索引可以重复

### reindex

pdf.reindex([xx,x,xxx])

pdf.reindex(range(6),method="ffill") 	填充

pdf.reindex(columns=[xx,x,xxx])

### sliceing

pdf["x"]  pdf[["x","xx"]]  pdf[:2]

pdf[pdf["xx"]>4]

### loc /iloc(rows)

pdf.loc['Colorado', ['two', 'three']]   pdf.loc[:'Utah', 'two']

pdf.iloc[2, [3, 0, 1]]   pdf.iloc[[1, 2], [3, 0, 1]]  

$ pdf.iloc[:, :3][pdf.three > 5]$

### unique

pds.index.is_unique

## fill

pdf.loc[1,"b"] = np.nan

pdf1.add(pdf2,fill_value=0)

## broadcasting

行列数据不同；数据行自动扩展

##summary

pdf.sum()  pdf.sum(axis='columns')  df.mean(axis='columns', skipna=False)

pdf.cumsum()  pdf.idxmax()

pdf.describe()

### unique

pds.unique()

pds.value_counts()

# Matplotlib

import matplotlib as mpl

import matplotlib.pyplot as plt

## base plot

plt.plot(x,y,color="red",linestlye="--",lable="xxx")

plt.xlim(-5,15)	plt.ylim(-5,15)

plt.axis([-1,11,-2,2])

plt.xlabel("xxx")		plt.ylabel("xxx")

plt.legend()

plt.title("xxx")

plt.show()

## scatter

plt.scatter(x,y,alpha=0.5)

plt.show()

# Sklean

from sklearn import dateseets

iris = dateseets.load_iris()

iris.keys()

print(iris.DESCR)

iris.data

iris.data.shape

iris.feature_name

iris.target

#  Import

## csv/txt

pdf= pd.read_csv('../examples/ex1.csv')

pd.read_table('../examples/ex1.csv', sep=',')

pd.read_csv('../examples/ex2.csv', names=['a', 'b', 'c', 'd', 'message'])

pd.read_csv('../examples/csv_mindex.csv',index_col=['key1', 'key2'])

sentinels = {'message': ['foo', 'NA'],'something': ['two']}   pd.read_csv('../examples/ex5.csv',na_values=sentinels)

## xls

xlsx = pd.ExcelFile('../examples/ex1.xlsx')

pd.read_excel(xlsx, 'Sheet1')

pd.read_excel('../examples/ex1.xlsx', 'Sheet1')

## json

pd.read_json()

## myql
# Output
## csv/txt

pdf.to_csv('../examples/out.csv')

## xls

writer = pd.ExcelWriter('../examples/ex2.xlsx')

pdf.to_excel(writer, 'Sheet1')

writer.save()

frame.to_excel('../examples/ex2.xlsx')

##json

pdf.to_json()

pdf.to_json(orient='records')

## mysql

import sqlalchemy as sqla

db = sqla.create_engine('sqlite:///../examples/mydata.sqlite')

pd.read_sql('select * from test', db)

# Random

np.random.permutation(5)

pdf.take(sampler)

pdf.sample(n=3)

# Outline

## find

pdf[(np.abs(pdf) > 3).any(1)]

pds[np.abs(pds) > 3]

## filling

pdf[np.abs(data) > 3] = np.sign(data) * 3

np.sign(pdf)

# Missing

## find

pdf.dropna()   data.dropna(how='all')    data.dropna(axis=1, how='all') 删除行/列

pdf[pdf.notnull()]

data.dropna()

isnull()

notnull()

## filling

pdf.fillna(0)  pdf.fillna(0, inplace=True)

pdf.fillna({1: 0.5, 2: 0})

pdf.fillna(method='ffill')

pdf.fillna(data.mean())

# Choose
## row
### row index
### row name
### row condition
## col
### col index
### col name
### col condition
## row&col
### 


# Transform
## OneSheet
### duplicate 

pdf.duplicated()

pdf.drop_duplicates()

pdf.drop_duplicates(['k1'])  pdf.drop_duplicates(['k1', 'k2'], keep='last')

### typechange

pdf['food'].str.lower()

df['fruit'] = df['fruit'].astype('category')

### maping

meat_to_animal = {
'bacon': 'pig',
'pulled pork': 'pig',
'pastrami': 'cow',
'corned beef': 'cow',
'honey ham': 'pig',
'nova lox': 'salmon'
}

pdf['animal'] = pdf['food'].str.lower().map(meat_to_animal)

pdf['food'].map(lambda x: meat_to_animal[x.lower()])

### replace

pds.replace(-999, np.nan)  

pds.replace([-999, -1000], np.nan)  

pds.replace([-999, -1000], [np.nan, 0])

pds.replace({-999: np.nan, -1000: 0})

### indexChange

pdf.rename(index=str.title, columns=str.upper)
pdf.index = pdf.index.map(transform)

pdf.rename(index={'OHIO': 'INDIANA'},columns={'three': 'pekaboo'})

pdf.rename(index={'OHIO': 'INDIANA'}, inplace=True)

### MutliteIndex

pdf.loc[['b', 'd']]  

pdf.unstack()

pdf.unstack().stack()

pdf.index.names = ['key1', 'key2']

pdf.columns.names = ['state', 'color']

pd.MultiIndex.from_arrays([['Ohio', 'Ohio', 'Colorado'], ['Green', 'Red', 'Green']],
names=['state', 'color'])
### Mulite to One
gp2 = gp1.copy(deep=True)
gp2.columns = gp1.columns.droplevel(0)

gp3 = gp1.copy(deep=True)
gp3.columns = ["_".join(x) for x in gp3.columns.ravel()]


pdf.loc['期中','雷军','测试一']['模拟考','数学']

pdf4['正式考']
### indexLevelSummary

pdf.swaplevel('key1', 'key2')

pdf.sort_index(level=1)

pdf.sort_index(level='color')

pdf.swaplevel(0, 1).sort_index(level=0)

pdf.sum(level='key2')

pdf.sum(level='color', axis=1)

### ColIndex

pdf.set_index(['c', 'd'])

pdf.set_index(['c', 'd'], drop=False)

pdf.reset_index()

### factor

pd.Categorical(['foo', 'bar', 'baz', 'foo', 'bar'])

pd.Categorical.from_codes(codes, categories)

df['fruit'].astype('category')

bins = [18, 25, 35, 60, 100]
cats = pd.cut(ages, bins) cats.codes cats.categories

pd.value_counts(cats)

pd.cut(ages, [18, 26, 36, 61, 100], right=False)

pd.cut(ages, bins, labels=['Youth', 'YoungAdult', 'MiddleAged', 'Senior'])

pd.cut(data, 4, precision=2)

pd.qcut(data, 4)

pd.cut(data, [0, 0.1, 0.5, 0.9, 1.]) # 累进的百分比

### Indicator

pd.get_dummies(pdf['key'])

pd.get_dummies(pdf['key'], prefix='key')

pdf[['data1']].join(pd.get_dummies(pdf['key'], prefix='key'))

bins = [0, 0.2, 0.4, 0.6, 0.8, 1.]

pd.cut(values, bins)

pd.get_dummies(pd.cut(values, bins))

### melt

pd.melt(df, ['key'])

pd.melt(df, id_vars=['key'], value_vars=['A', 'B'])

pd.melt(df, value_vars=['A', 'B', 'C'])

### dcast

pdf.pivot('date', 'item', 'value')

### grouping

pdf.pivot('date', 'item', 'value')

pdf['data1'].groupby(df['key1']).mean()

pdf['data1'].groupby([df['key1'], df['key2']]).mean()

pdf['data1'].groupby([df['key1'], df['key2']]).mean().unstack()

pdf.groupby(['key1', 'key2']).size()

for (k1, k2), group in pdf.groupby(['key1', 'key2']):
print((k1, k2))
print(group)

grouped = pdf.groupby(df.dtypes, axis=1)

for dtype, group in grouped:
print(dtype)
print(group)

pdf.groupby('key1')['data1']

pdf['data1'].groupby(df['key1'])
pdf[['data2']].groupby(df['key1'])

df.groupby(['key1', 'key2'])[['data2']].mean()

pdf.groupby(len).sum()

hier_df.groupby(level='cty', axis=1).count()

#### boarding

grouped_pdf.transform(lambda x: x.mean())

grouped_pdf.transform('mean')

g.transform(lambda x: x.rank(ascending=False))

def normalize(x):
return (x - x.mean()) / x.std()

g.apply(normalize)

### aggregation

pdf.pivot('date', 'item', 'value')

pdf.groupby('key1').agg(lambda x:x.max() - x.min())

pdf_grouped.agg('mean')

grouped_pct.agg(['mean', 'std', peak_to_peak])

grouped_pct.agg([('foo', 'mean'), ('bar', np.std)])

grouped.agg({'tip': np.max, 'size': 'sum'})

grouped.agg({'tip_pct': ['min', 'max', 'mean', 'std'],
'size': 'sum'})

pdf.groupby(['day', 'smoker'], as_index=False).mean()

def get_stats(group):
return {'min': group.min(), 'max': group.max(),
'count': group.count(), 'mean': group.mean()}

frame.data2.groupby(pd.qcut(frame.data1, 10, labels=False)).apply(get_stats).unstack()

### privot

pdf.pivot_table(['tip_pct', 'size'], index=['time', 'day'],columns='smoker')

pdf.pivot_table(['tip_pct', 'size'], index=['time', 'day'],columns='smoker', margins=True)

pdf.pivot_table('tip_pct', index=['time', 'smoker'], columns='day',aggfunc=len, margins=True,fill_value=0)

### crossTable

pd.crosstab(data.Nationality, data.Handedness, margins=True)

### timeseries

### str

pds.str.contains('gmail')

pds.str.match(pattern, flags=re.IGNORECASE)

## TwoSheet
###  left/right merge

pd.merge()

pd.concat()

pd.combine_first()

pd.merge(df1,df2,on="key")
pd.merge(df3, df4, left_on='lkey', right_on='rkey')

pd.merge(df1, df2, on='key', how='left')

pd.merge(df1, df2, how='outer')

pd.merge(left, right, on=['key1', 'key2'], how='outer')

pd.merge(left, right, on='key1', suffixes=('_left', '_right'))

pd.merge(left1, right1, left_on='key', right_index=True)

pd.merge(left1, right1, left_on='key', right_index=True, how='outer')

pd.merge(lefth, righth, left_on=['key1', 'key2'],
right_index=True, how='outer')

left2.join(right2, how='outer')

left2.join([right2, another])

left2.join([right2, another], how='outer')

### row/col combine

pd.concat([pds1,pds2, pds3])  pd.concat([pds1,pds2, pds3],axis=1)

pd.concat([s1, s4], axis=1, join='inner')

pd.concat([df1, df2], ignore_index=True)

df1.combine_first(df2)

# Visualisation
## OriVis
### dot
### line
### bar
### historm

### box



### 
# Model

## KNN

### base

 nearest = np.argsort([sqrt(np.sum(x_train-x)**2) for x_train in X_train])

topK_y =[y_train[i] for i in nearest[:k]]

from collections import Counter

votes  = Counter(topK_k)

votes.most_common(1)

$predict_y = votes.most_common(1)[0][0]$

### scikit-learn

from sklearn.neighbors import KNeighborsClassifier

kNN_classifier = KNeighborsClassifier(n_nerghbors=6)

kNN_classifier.fit(X_train,y_train)

kNN_classifier.predict(x)

### base_train_test

shuffle_indexes = np.random.permutation(len(x))

test_ration = 0.2

test_size = int(len(X)*test_ration)

test_indexes = shuffle_indexes[:test_size]

train_indexes = shuffle_indexes[test_size:]

x_train = X[train_indexes]

y_train = y[train_indexes]

x_test = X[train_indexes]

y_test = y[train_indexes]

### skl_base_train_test

from sklearn.model_selection import tarin_test_split

X_trian,X_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=666)

### base_accuracy

sum(y_true==y_predict)/len(y_true)

### skl_accuracy

from sklearn.metrics import accuracy_score

accuracy_score(y_test,y_predict)

### base_hyper params

#### k

best_score = 0.0

best_k = -1

for k in range(1,11)：

​	kNN_classifier = KNeighborsClassifier(n_nerghbors=6)

​	kNN_classifier.fit(X_train,y_train)

​	score = knn_clf.score(X_test,y_test)

​	if score > best_score:

​		best_k = k

​		best_score = sroce

print ("best_k =", best_k)

print ("best_score =", best_score )

#### weights

best_method = ""

best_score = 0.0

best_k = -1

for method in ["uniform", "distance"]:

​	for k in range(1,11)：

​		kNN_classifier = KNeighborsClassifier(n_nerghbors=6,weights=method)

​		kNN_classifier.fit(X_train,y_train)

​		score = knn_clf.score(X_test,y_test)

​		if score > best_score:

​			best_k = k

​			best_score = sroce

​			best_method = method

print ("best_k =", best_k)

print ("best_score =", best_score )

#### 距离参数p

best_p =  -1

best_method = ""

best_score = 0.0

best_k = -1

for method in ["uniform", "distance"]:

​	for k in range(1,11)：

​		for p in range(1,6)：

​			kNN_classifier = KNeighborsClassifier(n_nerghbors=6,weights=method，p=p)

​			kNN_classifier.fit(X_train,y_train)

​			score = knn_clf.score(X_test,y_test)

​			if score > best_score:

​				best_k = k

​				best_score = sroce

​				best_method = method

print ("best_k =", best_k)

print ("best_score =", best_score )

###skl_hyper params

网格搜索 Grid Search

params_grid = [

{

"weights":["uniform"],

"n_neighbors":[i for i in range(1,11)]

},

{

"weights":["distancce"],

"n_neighbors":[i for i in range(1,11)],

"p":[i for i in range(1,6)]

}

]

from sklearn.model_selection import GridSearchCV

kNN_classifier = KNeighborsClassifier()

grid_search = GridSearchCV(kNN_classifier ,params_grid)

grid_search .fit(X_train,y_train)

grid_search.best_estimator_

grid_search.best_score_

grid_search.best_params_

knn_clf = grid_search.best_estimator_

knn_clf.score(X_test,y_test)

#### more fast &core

grid_search = GridSearchCV(kNN_classifier ,params_grid，n_jobs=-1)

grid_search = GridSearchCV(kNN_classifier ,params_grid，n_jobs=2)

grid_search = GridSearchCV(kNN_classifier ,params_grid，n_jobs=2,verbose=2)

 ### more distance

向量空间余弦相似度

调整余弦相似度

皮尔逊相似系数

Jaccard相似系数

### Feature Scaling

最值归一化：适用于分布有明显边界，受outline影响

均值方差归一化：数据分布没有明显边界，可能存在极端数据值

(x_test-mean_train)/std_train

from sklearn.preprocessing import StandardScaler

standardScaler = StandardScaler()

standardScaler .fit(X_train)

standardScaler.mean_

standardScaler.std_ 		standardScaler.scale_ 

X_train = standardScaler.transform(X_train)

X_test_standard = standardScaler.transform(X_test)

kNN_classifier = KNeighborsClassifier(n_nerghbors=6)

kNN_classifier.fit(X_train,y_train)

score = knn_clf.score(X_test_standard ,y_test)

### Summary

####positive

分类问题

多分类问题&回归问题

思想简单，效果强大

####negative

效率低下;优化：使用树结构：KD-Tree,Ball-Tree

高度数据相关（异常值敏感）；

预测结果不具有可解释性；

维数灾难；优化：PCA

#### KneighborsRegressor

#### process

train-test

scale

model

gridSearch

accuracy

## LR

### base

x_mean = np.mean(x)  	y_mean = np,mean(y)

num,d=0.0 ,0.0

for x_i,y_i in zip(x,y):

​	num+=(x_i -x_mean)*(y_i - y_mean)

​	d+=(x_i - x_mean)**2

a = num/d

b= y_mean - a*x_mean

y_hat = a*x +b

x_predict = 6

y_predict = a*x +b

### arr

num = (x_train - x_mean).dot(y_train -y_mean)

d = (x_train - x_mean).dot(y_train -x_mean)

### evalue

MSE 均方误差 

RMSE 均方根误差 (放大较大的差异)

MAE  平均绝对误差

R Squared  R方

#### base evalue

boston = datasets.load_boston()

bostan.DESCR

bostan.feature_names

x = bostan.data[:,5]

y = bostan.target

 from sklearn.model_selection import train_test_split

X_trian,X_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=666)

from sklearn.linear_model import LinearRegressionlin

linreg = LinearRegressionlin()

reg = LinearRegression()

linreg.fit(X_train, y_train)

reg.a_

reg.b_

reg.predict(x_test)

plt.scatter(x_train,y_train)

plt.plot(x_train,reg.predict(x_train),color="r")

plt.show()

mse_test = np.sum((y_predit-y_test)**2/len(y_test))

from math impot sqrt

rmest_test = sqrt(mes_test)

mae_test = np.sum(np.absolute(y_predict - y_test))/len((y_test)

1-mean_squared_error(y_test,y_predict)/np.var(y_test)

#### skl  evalue

from sklearn.metrics import mean_squared_error,mean_absolute_error,r2_score

mean_squared_error(y_test,y_predict)

mean_absolute_error(y_test,y_predict)

r2_score(y_test,y_predict)

### MLR

#### base

X_b = np.hstack([np.ones(len(X_train),1)),X_train])

theta = np.linalg.inv(X_b.T.dot(X_b)).dot(X_b.T).dot(y_Train)

interception = theta

coef = theta[1:]

X_b_pre = np.hstack([np.ones(len(X_train),1)),X_predict])

X_b_pre.dot(theta)

#### skl

from sklearn.linear_model import LinearRegression

lin_reg = LinearRegression()

lin_reg.fit(X_train,y_train)

lin_reg.coef_

lin_reg.intercept_

#### knn reg

from sklearn.neighbors import KNeighborRegressor

knn_reg = KNeighborRegressor()

knn_reg.fit(X_train,y_train)

knn_reg.score(X_test,y_test)

### Summary

np.argsort(line_reg.coef_)

boston.feature_names

boston.feature_names[np.argsort[lin_reg.coef_]]

参数学习

解决回归

## Gradient Descent

超参数：学习率，初始点

不是有唯一极值点；（多次运行，随机化初始点）

线性回归的损失函数具有唯一最优解

### base

eta = 0.1

epsilon = 1e-8

theta = 0.0

theta_history = [theta]

i_iter =0

while i_iter  < n_iters:

​	gradient = dJ(theta)

​	last_theta = theta

​	theta = theta - eta*gradient

​	theta_history.append(theta)

​	if (abs(J(theta))-J(last_theta)<epsilon):

​		break

​	i_iter +=1

### MLR Gradient

def J(theta,X_b,y):

​	try：

​		return np.sum((y-X_b.dot(theta))**x)/len(X_b)

​	except:

​		return float('inf')

def dJ(theta,x_b,y):

​	res = np.empty(len(theta))

​	res[0] = np.sum(X_b.dot(theta)-y)

​	for i in range(1,len(theta)):

​		res[i] = (X_b.dot(theta)-y).dot(X_b[;,i])

​	return res*2/len(X_b)

### ARR Gradient

X_b.T.dot(X_b.dot(theta) -y)*2/len(X_b)

### Scale

### Stochastic Gradient Descent

学习率 = 1/循环次数

学习率=  1/(循环次数+b)

学习率 = a/(循环次数+b)

模拟退火思想

学习率=  t0/(循环次数+t1)

### skl SGD

from skleanrn.linear_model import SGDRegressor

sgd_reg = SGDRegressor()

sgd_reg.fit(X_train_standard,y_train)

sgd_reg.score(X_test_standard,y_test)

### debug

### Summary

批量梯度下降法

随机梯度下降法（跳出局部最优解,更快的运行速度,随机特点运用：随机森林）

小批量梯度下降法

## PCA

非监督学习，数据降维，降噪

使用方差定义样本距离

均值归0

每个向量在轴上的投影平方和最大

求出第一主成分

向量减去第一主成分，然后迭代求取第二主成分

### GD_PCA

中心化  X-np.mean(X,axis=0)

np.sum((X.dot(w)**2))/len(X)

X.T.dot(X.dot(w))*2./len(X)

第二主成分：X2[i] = X[i] - X[i].dot(w)*w

X2= X - X.dot(w).reshape(-1,1)*w

### skl_PCA

from sklearn.decompositon import PCA

pca = PCA(1)

pca.fit(X)

pca.components_

pca.transform(x)

pca.inverse_transform(pca.transform(x))

pca.explained_variance_ratio_

pca = PCA(0.95)

## 

## PLR

from sklearn.preprocessing import PolynomialFeatures

poly = PolynomialFeatures(degree=2)

poly.fit(X)

X2 = poly.transform(X)

lin_reg = LinearRrgression()

lin_reg.fit(X2,y)

lin_reg.predict(X2)

### Pipeline

from sklearn.pipline import Pipeline

poly_reg = Pipline(

("poly",PolynomialFeatures(degree=2)),

("std_scaler",StandardScaler()),

("lin_reg",LinearRegression())

)

poly_reg .fit(x,y)

poly_reg.fit(X,y)