# numpy

## create

### ori

import numpy as np 

np.random.randn(2,3)

np.array([1,2,3]) 	np.array([[1,2,3],[4,5,6]])

np.zeros(10)	np.zeros((3,6)) 

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

## operation

$+-*/ 	np.dot/@	T$

np.dot(arr.T, arr)

### fuction

np.sqrt(arr)

np.exp(arr)

np.maximum(arrx,arry)

arr.mean(axis=1) 		arr.mean(axis=0)		np.mean(arr)

arr.sum()

arr.cumsum()

arr.cumprod(axis=1)

remainder, whole_part = np.modf(arr)

### bool

arr.any()

arr.all()

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

$arr[:,:3]$

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

np.arange(16).reshape((2, 2, 4)).transpose((1, 0, 2))

arr.swapaxes(1,2)

np.meshgrid(arrx,arry)

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

pds.T.apply(lambda x:pd.unique(x),axis=1)

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