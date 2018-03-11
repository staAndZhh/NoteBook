# demo
+	py3.6把pandas的dataframe存入数据库
	1.	安装包：pymysql，sqlalchemy

>		temp_df = pd.read_excel(namepath,sheet_name,index_col=None)
	from sqlalchemy import create_engine
	connection = create_engine('mysql+pymysql://root:@localhost:3306/data_input?charset=utf8')
	pd.io.sql.to_sql(temp_df,sheet_name,connection,index=False,index_label=False)

+	pandas
+	读取xlsx文件导入数据库

>		#coding:utf-8
	import pandas as pd
	import numpy as np
	import os,sys,xlrd,pymysql
	from sqlalchemy import create_engine
	def input_sql(filedf,name):
	    temp_df = pd.read_excel(filedf,name,index_col=None)
	    connection = create_engine('mysql+pymysql://root:@localhost:3306/data_input?charset=utf8')
	    pd.io.sql.to_sql(temp_df,name,connection,index=False,index_label=False,if_exists='replace')
	    print (filedf,'is inputing')	
	base_path = "C:\\Users\\hasee\\Desktop\\SemirNews\\导入sql\\"
	excels_names = [item.split(".xlsx")[0] for item in os.listdir(os.path.dirname(base_path)) if item.endswith(".xlsx")]
	namepaths = [os.path.join(base_path,item) for item in os.listdir(os.path.dirname(base_path)) if item.endswith(".xlsx")]
	sheet_names_tuple = [(namepath,item.name) for namepath in namepaths for item in xlrd.open_workbook(namepath).sheets()]
	[input_sql(item[0],item[1])for item in sheet_names_tuple]

+	嵌套列表flatten
>		li=[[1,2],[3,4],[5,6]]
	print [j for i in li for j in i]

>		from itertools import chain
	print list(chain(*li))
	
>		a=[[1,2],[3,4],[5,6]]
	t=[]
	[t.extend(i) for i in a]

>		li=[1,[2],[[3]],[[4,[5],6]]]
	def flat(tree):
	    res = []
	    for i in tree:
	        if isinstance(i, list):
	            res.extend(flat(i))
	        else:
	            res.append(i)
	    return res

>		def flatten(seq):
	    s=str(seq).replace('[', '').replace(']', '') #当然也可以用正则
	    return [eval(x) for x in s.split(',') if x.strip()]

>		flat=lambda L: sum(map(flat,L),[]) if isinstance(L,list) else [L]
>		
>		from Tkinter import _flatten
		li=reduce(lambda *x:list(x),range(2,6),[1])
		print li
		print _flatten(li)
		#Out:
		#[[[[[1], 2], 3], 4], 5]
		#(1, 2, 3, 4, 5)