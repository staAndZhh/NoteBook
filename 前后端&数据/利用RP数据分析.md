##	数据创建
+	py:	
	>	df df_empty = pd.DataFrame(columns=['A', 'B', 'C', 'D']) 
+	R:
	> 空df data.frame(x=numeric(0),y=integer(0),z=character(0))
##	数据获取
###	csv/txt
+	py:	pandas
+	R:	readr readxl openxlsx xlsx
>		read_xxx() read.xxx()  
	data.table::fread()
	py:pd.read_csv()
	py:pd.read_clipboard()
###	excel
>		readxl::read_excel() read_xls()  read_xlsx()
	openxlsx::read.xlsx()
###	粘贴板
>		read.table("clipboard",header=T,sep=',')
>		pd.read_clipboard()	
###	sql
+	py：(MySQLdb2.7)(pymysql3.6) sqlalchemy 
+	py:使用curser或者pandas操作数据库
+	R:RMySQL RODBC
>		sqlalchemy写数据：
	from sqlalchemy import create_engine
	temp_df = pd.read_excel(namepath,sheet_name,index_col=None)
	connection = create_engine('mysql+pymysql://root:@localhost:3306/data_input?charset=utf8')
	sqlalchemy读数据：
	pd.read_sql_query('select * from t_line ',con = engine)
	读整张表：
	pd.read_sql_table(table_name = 't_line',con = engine,parse_dates = 'time',index_col = 'time',columns = ['a','b','c'])
	pd.io.sql.to_sql(temp_df,sheet_name,connection,index=False,index_label=False)
	pymysql读取:
	import pymsql
	db= pymysql.connect(host="localhost",user="root",  
    password="123456",db="test",port=3307)  
	cur = db.cursor() 
	sql = "select * from user"  
	cur.execute(sql)
	或者：pd.read_sql(sql,db)

>		library(RMySQL) 
>		con <- dbConnect(MySQL(),host="127.0.0.1",dbname="smnews",user="root",password="") 
	dbListTables(con)
	dbSendQuery(con,'SET NAMES gbk')
	data <-as.data.table(fetch(res,-1))
    dbClearResult(res)
    dbDisconnect(con)
	读数据：
	new_his_to11 <- data.table(dbReadTable(con,'history_tem'))
	写数据：
	 fruits <-data.frame(id=1:5,name=c("苹果","香蕉","梨子","玉米","西瓜"),price=c(8.8,4.98,7.8,6,2.1),status=c("无","打折","无","售罄","批发"))  
	 dbListTables(con)  
	 dbWriteTable(con,"fruits",fruits)  
	 dbListTables(con) 

>		library(RODBC)
	channel <- odbcConnect("mysql_data", uid = "root", pwd = "123456")
	sqlTables(channel) #查看你在上面所选数据库中的所有表
	data <- sqlFetch(channel, "users") #将使用的数据库中的表users连接到R，这样就实现了在R中操作数据库中的数据
	sqlSave(channel, mtcars) #将R中的数据存储到Mysql
	sq <- sqlQuery(channel, "select mpg from mtcars") #在R中通过sql语句提取数据



##	数据存储
###	csv/txt
###	excel
###	sql
+	包：同数据读取
+	R：read换为write
+	py:pd.to_xxx
###	粘贴板
>		R:clip <- pipe("pbcopy", "w")
	write.table(data, file=clip,sep="\t",row.names = FALSE)
	py:tem_lei.to_clipboard()
##	Read
+	R：	[,]
+	Py:	[] loc[,] iloc[,]

###		行
+	直接列 1d
+	行列	 loc 2d
+	数值行列 iloc 2d 
+	df["A"] df.A
+	df[0:3]	df['20130102':'20130104']
###		列
+	df.loc[:,['A','B']] 多列
+	df.loc['20130102':'20130104',['A','B']]	行列2d
+	df.loc['20130102',['A','B']]	行列1d
+	df.loc[dates[0],'A']  df.at[dates[0],'A']  标量
+	position	数值索引
+	df.iloc[3]
+	df.iloc[3:5,0:2] df.iloc[[1,2,4],[0,2]]
+	df.iloc[1:3,:]	df.iloc[:,1:3]
+	df.iloc[1,1] 	df.iat[1,1]
+	布尔索引
+	df[df.A > 0]	df[df > 0]
+	df2[df2['E'].isin(['two','four'])]
+	值设置
+	df.at[dates[0],'A'] = 0
+	df.iat[0,1] = 0
+	df.loc[:,'D'] = np.array([5] * len(df))
###	筛选
+	py
+	df.isin(['b','c'])
+	df[df.E.isin(['a','c'])]
+	df[df[某列].isin(条件)&df[某列].isin(条件)]
+	df.isin({'某列'：[条件],'某列':[条件],})
+	df[df.isin({'D':[0,3],'E':['a','d']})]
###	反筛选
+	py
+	在前面加上 ~
###		表

##	Update
###		行
###		列
+	py
	+	del pd['xx']
+	R
	+	data.table::df[,":="(xx = null),] 

###		表
###		多表

##	Adapt
###		行

###		列
###		表
###		多表

##	Delete
###		行
###		列
###		表
###		多表


##	数据聚合
###	melt(1d)
###	dcast(2d)
###	透视表(3d)
## 	数据转换
+	py
	+	pd_df.to_dict()
	+	to_excel、to_csv、to_sql、to_pickle
+	R

-------------
#	操作
## 判断2数据框是否完全相同
+	py
	+	df1.eq(df2).values.all()
	+ 	df1.gt(df2).values.all()
	+	(df1==df2).values.all()
	+	any()
	+	all()
+	R
	+	内容是否相同：identical(a, b) 
	+	哪一列的结果有差别：all.equal(a1, a2) 
	+	match(a1, a2)
	+	具体是哪行哪列有差别：which(a1!=a2, arr.ind = TRUE)
	+ 	all(df$xx==df1$xxx)
### 求长度
+	py
	+	len
	+	pd.xx.unique().shape[0]
+	R
	+	length 向量 
	+	nchar	元素字串



###	数据行/列概述
+	py
	+	pd.head()
	+	pd.tail(10)
	+	pd.dtypes
	+	loandata.describe().astype(np.int64).T
+	R
	+	head(df)
	+	tail(df,10)
	+	str(df)
###	数据值概述
+	py
	+ 	pd.describe()
	+	pd.列名.vuale_counts()
+	R
	+	fivenum(df$数值列名)
	+	table(df$数值列名）
	+	table(cut(df$数值列名，breaks=c(0,5,10,100))

###	维度/行/列
+	py
	+	pd.shape
	+	pd.shape[0]
+	R
	+	dim(df)
	+	nrow(df) ncol(df)


###	行/列改名字
+	py
	+	pd.columns = [xx,xx,xx]
	+	pd.rename(columns = {"旧名":"新名"，"旧名":"新名"}，inplace = True)
	+	pd.reindex()
+	R
	+	dplyr::rename(df,新名=旧名)
	+	data.table::setnames(df,旧名，新名）
###	更改顺序
+	py
	+	df = df[['xx_b','xx_a','xx_d','xx_c']]
+	R
	+	data.table::setcolorder(df,c(oldxx,...),c(newxx,...))
	+	dplyr::select(df,c(-xx,xx,xx))
###	空值查找/处理
+	py
	+	Ser.isnull()
	+	Ser.dropna()
	+	Ser[Ser.notnull()]
	+	pd.isnull()
	+	pd.dropna(how='all')
	+	pd.fillna(0)
	+	df.fillna({1: 0.5, 3: -1})
	+	pd.isna(df1)
+	R
	+	data.table::df[is.na(xx),,]
	+	lentgh(is.na(df$xx))
	+	x[is.na(x)]<-0
###	离群值
+	py
	+	pd[(np.abs(pd) > 3).any(1)]
 	+	pd[np.abs(pd) > 3] = np.sign(pd) * 3
###	去重处理
+	py
	+	pd.列名.unique()
	+	pd.duplicated()
	+	pd.drop_duplicates()
	+	pd.drop_duplicates(['xx'])
+	R
	+ 	df[!duplicated(df),] 行数据去重
	+	unique(df$xx) 向量去重
	+	df[!duplicated(df$xx,df$xxx),] 多行数据索引去重
###	计数	
###	缺失值处理
+	py
	+	Ser.fillna(xxx)
+	R
	+	 ts[is.na(ts)]<-0
	+	 ts[ts==0]<-100
###	值替换
+	py
	+ Ser.replace(xx，xx)
	+ Ser.peplace([xx,xx],[xx,xx])
	+ Ser.peplace({xx:xxx,xx：xxx})
+	R
	+	
###	数值变因子
+	py
	+ cats = pd.cut([1,2,3,4,5],[1,3])
	+ cats.labels 
	+	cats.levels
	+ group_names = ['Youth', 'YoungAdult', 'MiddleAged', 'Senior']
	+ pd.cut(ages, bins, labels=group_names)
	+ pd.cut(data, 4, precision=2)
	+	pd.qcut(data, 4)
	+	pd_f['xx'] = pd.cut(pd_f['xxx'],[-np.Inf,xx,xx,xx,np.Inf],labels=	['xx_a','xx_b','xx_c','xx_d'])
+	R
	+ cut（df$xx,c(1,4,10))
###	因子变数字
###	条件匹配	
+	py
	+ np.where(条件，pd_1,pd2)
	+ pd1.combine_firest(pd2) #打补丁，填补NaN值
###	列类型转换
+	py
	+ pd['xx'] = pd['xx'].astype(np.int64)
	+ pd['xx'] = pd.to_datetime(pd['xx'])
	+ pd['xx'] = pd['xx'].map(lambda x:str(x))
	+ pd_df['xx'] = pd_df['xx'].astype('str')
	+ pd_df[['xx','xxx']] = pd_df['xx','xxx'].astype('str')
	+ df[['xx','xx']] = df[['xx','xx']].apply(pd.to_numeric)
+	R
###	列合并/列拆分
+	py
	+ 文本用str
	+	数值直接运算
	+ df['xx'].str.cat(df['xx'],sep='-')
	+ df['xx'].str.cat([df['xx'].map(str),df['xxx'].map(str)],sep='-')

###	列值汇总
+	py
	+	pd.apply(lambda x:x.max()-x.min()，axis=1)
	+	def f(x):
			return Series([x.min(),x.max()],index=['min','max'])
	+	pd.apply(f)
+	R
	+	data.table::df[is.na(xx),":="(xx=max(xx)),]
###	列值计算
+	py
	+	format = lambda x: '%.2f' % x
	+	pd.applymap(format)
	+	pd['xx'].map(format)
+	R
###	列转换
+	py
	+	meat_to_animal = {'bacon': 'pig','pulled pork': 'pig',
  'pastrami': 'cow',
  'corned beef': 'cow',
  'honey ham': 'pig',
  'nova lox': 'salmon'
}
	+	pd['animal'] = pd['food'].map(str.lower).map(meat_to_animal) #列匹配
	+	data['food'].map(lambda x: meat_to_animal[x.lower()])
+	R
	+
###	集合数据交叉并补
+	py
	+ 	set	
	+	set1.add(set2).update()
	+	set1&set2 	
	+	set1|set2
	+	set1 - set2
	+	np.array
	+	np.intersect1d(arr1,arr2)
	+	np.union1d(arr1,arr2)
	+	np.setdiff1d(arr1,arr2)
	+	np.setxor1d(arr1,arr2)	对称差
+	R
	+	union(vec,vec)
	+	intersect(vec,vec)
	+	setdiff(vec1,vec2)	属于vec1不属于vec2的元素
	+	vec %in% vec2
###	统计类函数计算
+	py
	+	df.mean()	df.mean()
+	R
	+	max() min()  min(a[a!=min(a)])
###	特定行列数据
###	条件数据
###	排名/排序
+	py
	+	Ser.sort_index()
	+	Ser.rank(ascending=False, method='max')
	+	pd.sort_index(by=['xx', 'xx'],axis=1, ascending=False)
	+	pd.sort(['xx'],ascending = False).head(10)
	+	lc.sort(["xx","xxx"],ascending=False)	
	+	lc.loc[lc["xx"] == "xx"].head()
	+	lc.loc[lc["xx"] == "B", ["xx", "xx", "xx"]].head()
	+	lc.loc[lc["xx"] == "B", ["xx", "xx", "xx"]].sort(["xx"])
	+	lc.loc[(lc["xx"] == "B") & (lc["xx"]>5000), ["xx", "xx" , "xx", "xx","xx", "xx"]].head()
	+ 	pd.rank(axis =1)
+	R
###	条件排序
###	分组排序
###	数据拼接/合并
###	vlookup
###	sumifs
+	py
	+ lc.loc[lc["grade"] == "B",].loan_amnt.sum()
	+ lc.loc[lc["grade"] != "B",].loan_amnt.sum()
	+ lc.loc[(lc["grade"] == "B") & (lc["loan_amnt"] > 5000)].loan_amnt.sum()
###	countifs
+	py
	+	lc.loc[lc["grade"] == "B"].loan_amnt.count()
	+ lc.loc[(lc["grade"] == "B") & (lc["loan_amnt"] > 5000)].loan_amnt.count()
###	averageifs
+	py
	+	lc.loc[(lc["grade"] == "B") & (lc["loan_amnt"] > 5000)].loan_amnt.count()
	+	lc.loc[(lc["grade"] == "B") | (lc["loan_amnt"] > 5000)].loan_amnt.mean()
###	maxif/minif
+	py
	+  lc.loc[lc["grade"] == "B"].loan_amnt.max()
	+	lc.loc[lc["grade"] != "B"].loan_amnt.min()
###	满足条件的行号
###	元素占列的占比
###	元素占行的占比
###	二维频数表
+	py
	+	pd.ix('xx').vaule_counts()
	+	pd.apply(pd.value_counts).fillna(0)
	+   pd.get_dummies(df['index'])
	+	pd.crosstab(df["xxx"],df["xxx"],margins=True)
+	R
	+	table(df$xx)
###	表合并
+	py
	+	pd.merge(xx, xxx, how='', )
	+	pd.concat([pd_l,pd_r])
	+	pd_l.join(pd_r,on= ,how= )
	+	pd_l.join([pd_r1, pd_r2])
###	宽表/长表
+	py
	+	pd.stack()	#to 1d
	+	pd.unstack()  #to	2d
	+	pd.set_index([xx,xx]).unstack(xx)	#to 	2d
+	R
	+	melt()
	+	dcast()
###	透视表
+	py
	+	pd.pivot(xx,xx,xx)
	+	pd.pivot_table(data,index=[xx,xx],values=[xx],aggfunc=[np.sum,np.mean,len])
	+	pd.pivot_table(data,index=[xx,xx],values=[xx_a,xx_b],aggfunc={'xx_a':'np.sum','xx_b':''np.mean})
+	R
	+	melt()
	+	dcast()
###	分组聚合
+	py
	+	df['xx'].groupby(df['xxx']).mean()
	+	df['xx'].groupby([df['xx'],df['xxx']]).mean().unstack()
	+	df.groupby(['key1', 'key2']).size()
	+	pieces = dict(list(df.groupby('key1')))
	+	pieces['xx']
	+	grouped = df.groupby(df.dtypes, axis=1)  # 在横轴上分组
	+	dict(list(grouped))
	+	df.groupby(['key1', 'key2'])[['data2']].mean()
	+	mapping = {'a': 'red', 'b': 'red', 'c': 'blue',
           'd': 'blue', 'e': 'red', 'f' : 'orange'}
	+	by_column = people.groupby(mapping, axis=1)
	+	by_column.sum()
	+	map_series = Series(mapping)
	+	people.groupby(map_series, axis=1).size()
	+ 	df.groupby('key1').apply(mean)
	+	df.groupby('key1').agg(['mean','sum'])
	+	df.groupby('key1').agg(['xx':np.max,'size':'sum'])
	+	常用函数：count sum	mean	median	min	max	prod first last
	+ 	自己聚合函数
		+	def peak_to_peak(arr):
    			return arr.max() - arr.min()
		+	df[['xx','xxx']].groupby(df['x']).agg(peak_to_peak)
	+	df.groupby(['xx','xxx']).agg('mean')
	+	df.groupby(['xx','xxx']).agg(['mean','std',peak_to_peak])
	+	df.groupby(['xx','xxx']).agg([('xx','mean'),('xxx',np.std)])  # 分组汇总不同的:元祖
	+	df.groupby(['xx','xxx']).agg({'xx'：np.max,'xxx':'sum'})  # 分组汇总不同的：字典
	+	df.groupby(['xx','xxx']).agg({'xx':['min','max','mean','std'], 'xxx':'sum'})

###	apply
+	py
	+		def top(df, n=5, column='tip_pct'):  # 自定义函数
    +		return df.sort_index(by=column)[-n:]
	+		top(pd_df, n=6)
	+	pd_df.groupby('xx').apply(top)
	+	tips.groupby('xx').apply(top, n=1, column='xxx')
	+	fill_mean = lambda g : g.fillna(g.mean())
	+	pd_df.groupby(group_key).apply(fill_mean)	# 自定义函数
	+	fill_values = {'East':0.5, 'West':-1}
	+	fill_func = lambda g : g.fillna(fill_values[g.name])	
	+	data.groupby(group_key).apply(fill_func)
### 多重索引变化为列
+	py
	+	pd_df.groupby(['key1','key2'], as_index=False).sum()
	+	pd_df.reset_index(level=['key1','key2'])
	+	pd_df.reset_index(level=['key1','key2']).reset_index()
	+	pd_df.reset_index(level=['key1','key2']).reset_index(drop=False) # 不带索引的那一列
	+	print(pd_df.index)
	+	print(pd_df.set_index(["C"]).reset_index().index) 
	+	print(data.set_index(["C"]).reset_index().columns) 

### 交叉验证
+	py
	+	from sklearn import cross_validation as cv
	+	train_data, test_data = cv.train_test_split(df, test_size=0.25)	

### 列变行数字转置
+	py
	+	train_data_matrix = np.zeros((n_users, n_items))
	+	for line in train_data.itertuples():
	+		train_data_matrix[line[1]-1, line[2]-1] = line[3]	    
	+	test_data_matrix = np.zeros((n_users, n_items))
	+	for line in test_data.itertuples():
	+	    test_data_matrix[line[1]-1, line[2]-1] = line[3]

### 求行/列的百分比
+	py
+	R
	+	table()
	+	prop.table(x,1)

----------------
# 图表

