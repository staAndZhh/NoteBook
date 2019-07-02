新手用 WHERE 子句进行条件分支，高手用 SELECT 子句进行条件 分支。 

### case

#### 重新编码

SELECT CASE pref_name WHEN '德岛' THEN '四国' WHEN '香川' THEN '四国' WHEN '爱媛' THEN '四国' WHEN '高知' THEN '四国' WHEN '福冈' THEN '九州' WHEN '佐贺' THEN '九州' WHEN '长崎' THEN '九州' ELSE '其他' END AS district, SUM(population) FROM PopTbl GROUP BY district; 



#### 按人口数量等级划分都道府县 

SELECT CASE WHEN population < 100 THEN '01' WHEN population >= 100 AND population < 200 THEN '02' WHEN population >= 200 AND population < 300 THEN '03' WHEN population >= 300 THEN '04' ELSE NULL END AS pop_class, COUNT(*) AS cnt FROM PopTbl GROUP BY CASE WHEN population < 100 THEN '01' WHEN population >= 100 AND population < 200 THEN '02' WHEN population >= 200 AND population < 300 THEN '03' WHEN population >= 300 THEN '04' ELSE NULL END; 



####  分类汇总 

--男性人口

SELECT pref_name, SUM(population) FROM PopTbl2 WHERE sex = '1' GROUP BY pref_name; 

-- 女性人口 SELECT pref_name, SUM(population) FROM PopTbl2 WHERE sex = '2' GROUP BY pref_name; 



SELECT pref_name, 

​	-- 男性人口

​	 SUM( CASE WHEN sex = '1' THEN population ELSE 0 END) AS cnt_m,

 	-- 女性人口 

​	SUM( CASE WHEN sex = '2' THEN population ELSE 0 END) AS cnt_f FROM PopTbl2 GROUP BY pref_name; 

#### UPDATE 语句里进行条件分支 

UPDATE Salaries SET salary = CASE WHEN salary >= 300000 THEN salary * 0.9 WHEN salary >= 250000 AND salary < 280000 THEN salary * 1.2 ELSE salary END; 

#### CASE 表达式调换主键值 

UPDATE SomeTable SET p_key = CASE WHEN p_key = 'a' THEN 'b' WHEN p_key = 'b' THEN 'a' ELSE p_key END WHERE p_key IN ('a', 'b'); 

#### 表匹配

SELECT course_name, CASE WHEN course_id IN (SELECT course_id FROM OpenCourses WHERE month = 200706) THEN '○' ELSE '×' END AS "6 月", CASE WHEN course_id IN (SELECT course_id FROM OpenCourses WHERE month = 200707) THEN '○' ELSE '×' END AS "7 月", CASE WHEN course_id IN (SELECT course_id FROM OpenCourses WHERE month = 200708) THEN '○' ELSE '×' END AS "8 月" FROM CourseMaster; 

#### 在 CASE 表达式中使用聚合函数 

### 自连接

#### 笛卡尔积

-- 用于获取可重排列的 SQL 语句 

SELECT P1.name AS name_1, P2.name AS name_2 FROM Products P1, Products P2; 

SELECT P1.name AS name_1, P2.name AS name_2 FROM Products P1, Products P2 WHERE P1.name <> P2.name; 

SELECT P1.name AS name_1, P2.name AS name_2 FROM Products P1, Products P2 WHERE P1.name > P2.name; 

SELECT P1.name AS name_1, P2.name AS name_2, P3.name AS name_3 FROM Products P1, Products P2, Products P3 WHERE P1.name > P2.name AND P2.name > P3.name; 

#### 删除重复行

DELETE FROM Products P1 WHERE rowid < ( SELECT MAX(P2.rowid) FROM Products P2 WHERE P1.name = P2. name AND P1.price = P2.price ) ; 

#### 不一致的记录

SELECT DISTINCT A1.name, A1.address FROM Addresses A1, Addresses A2 WHERE A1.family_id = A2.family_id AND A1.address <> A2.address ; 

#### 排序

SELECT name, price, RANK() OVER (ORDER BY price DESC) AS rank_1, DENSE_RANK() OVER (ORDER BY price DESC) AS rank_2 FROM Products; 



SELECT P1.name, P1.price, (SELECT COUNT(P2.price) FROM Products P2 WHERE P2.price > P1.price) + 1 AS rank_1 FROM Products P1 ORDER BY rank_1; 

### having

#### 查询缺失编号的最小值 

SELECT MIN(seq + 1) AS gap FROM SeqTbl WHERE (seq+ 1) NOT IN ( SELECT seq FROM SeqTbl); 

#### 众数

SELECT income, COUNT(*) AS cnt FROM Graduates GROUP BY income HAVING COUNT(*) >= ALL ( SELECT COUNT(*) FROM Graduates GROUP BY income); 

#### 极值

#### 中位数

#### 查找不为空

### 关系除Apriori

### 外连接

#### 水平展开求交叉表 

#### 水平展开

### 关联子查询

### 集合运算

### exits



