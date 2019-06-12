# 录制宏
+	excel 显示录制宏的工具栏
+	更改安全性，信任中心
+	录制宏，并相对引用
+	把宏绑定到按钮上
# 编写宏
+	alt + F11
+	工程：一个工作簿
	+	excel对象：sheet对象，thisWorkbook对象
	+	窗体对象
	+	类模块对象
	+	模块对象
## 立即窗口
+	视图：调出立即窗口
+	鼠标在模块上--立即窗口运行： Range("A1:B10").Value = "EXCEL VBA"
## VBA程序
+	sub过程
+	function过程
## 创建
+	插入模块
+	插入子过程
+	运行：运行子过程
## 数据&数据类型
+	注释： '''
+	数据类型：文本，数值，日期，逻辑，错误
+	VBA
	+	布尔
	+	整数
		+ 字节
		+	整数
		+	长整数
	+	小数
		+	单精度
		+	双精度
		+	货币
		+	小数
	+	字符串
		+	定长
		+	边长
	+	日期
	+	对象
	+	变体
	+	用户自定义
## 变量&常量
+	声明
	+	Dim 变量名 As 数据类型
	+	Private/Public/Static 变量名 As 数据类型
+	赋值
	+	let 变量名 = 数据
+	对象
	+	set 对象名称 = 存储对象名称
	+	Dim sht As Worksheet
	+	set sht = ActiveSheet
+	强制声明
	+	method1:Option Explicit
	+	method2：工具-选项-要求变量声明
+	作用域
	+	单个过程：本地变量：Dim，Static
	+	单个模块：模块级变量 Dim，Private；写在sub外面
	+	所有模块：公共变量 Public；写在sub外面
## 变量存储
## 数组
+	同类型的多个变量的组合
+	创建
	+	public/Dim 数组名称（a to b） As	数据类型   
    +	Dim arr（1 To 100） As Byte
	+	Dim arr（99） As Byte
	+	Dim arr(1 To 3, 1 To 5) As Integer
+	赋值
	+	arr(20) = 56
+ 动态数组
	+	不能重新定义数据类型
	+	Dim 数组名称 （） As 数据类型	
	+	ReDim arr （1 to a） 
+	赋值好的数组
	+	Dim arr as Variant
	+	arr = Array（1,2,3,4,5）
+	数组转移数据
	+	Dim arr As Variant
	+	arr = Range("A1:C3").Value
	+	Range（"E1:G3").Value = arr	 
+	数组函数
	+	最大索引号：	UBound(数组名称） 
	+	LBound(数组名称）                                                                        
## 常量
+	Const 常量名称 As 数据类型 = 存储在常量中的数据
+	Const p As Single = 3.14
##对象，集合&属性方法
+	Application.Workbooks("Book1").Worksheets("Sheet2").Range("A2")
+	活动的工作簿： Worksheets("Sheet2").Range("A2")
+	活动的工作表： Range("A2")
+	Worksheets("Sheet2").Range("A2").Font.Color
+	Range("A1").Select
+	工具-选项-编辑器-自动列出成员变量
### 方法提示
+	.
+	Ctrl+J
## 运算
+	+	- * / \ ^ Mod
+	=	<>	<	<=	>= Is Like
+	And Or Not Xor Eqv Imp
## 内置函数
+	函数提示：VBA.
## 控制流
+	If ... Then ... Else ... End If
+	If ... ElseIf ... ElseIf .. Else ... End If
+	Select Case ... Case Is ... Case Is ... Case Else ... End Select
+	For 循环变量 = 初始值 to 终止数值 Step 步长值 ... Exit For... Next 循环变量名
+	For Each 变量 In 集合名称/数组名称 ... Exit For ... Next 元素变量
+	Do [While 循环条件] ... [Exit Do] ... Loop
+	Do ... [Exit Do] ... Loop [While 循环条件]
	+	If i>5 Then  Exit Do
+	Do [Until 循环条件] ... [Exit Do] ... Loop
+	Do ... [Exit Do] ... Loop [Until 循环条件]
+	标签：... If ... Then GoTo 标签名
+	With ... EndWith
## sub函数
+	[Private/Public] [Static] Sub 名称([参数列表]) ... End Sub
+	Sub放在模块对象中
+	私有模块： Option Private Module
+	sub引用
	+	method1：过程名，参数1，参数2
	+	method2：Call 过程名（参数1，参数2）	
	+	method3：Application.Run 表示过程名的字符串（字符串变量),参数1，参数2，...
### 参数传递
+	地址传递：Sub 名称（参数 As Integer)
+	数值传递：Sub 名称（ByVal 参数 As Integer)
## function函数
+	插入-过程-函数
+	需要将结果保存在过程名称中
+	Funciton Fun()
+	Fun = ...
+	End Function
+	插入-函数-用户定义-使用函数
## 自定义函数重新计算
+	Application.Volatile True
## 注释
+	换行 _
+	多行写为一行 :
+	注释 '' 或者 Rem
## VBA对象
+	Application
+	Workbook
+	Worksheet
+	Range
## demo
+	Cells.ClearContents
+	Application.ScreenUpdating = False
+	Application.DisplayAlerts = False
+	Application.WorksheetFunction.CountIf(Range("A1:A2")，">100")
## Application
+	Application.ScreenUpdating = False
+	Application.DisplayAlerts = False
+	Application.WorksheetFunction.CountIf(Range("A1:A2")，">100")
+	Application.Caption = "xxx"
+	Applicaton.Selection.value = 300
## Workbook对象
+	Workbooks.Item(3) /Workbooks(3)/Workbooks("book1")/Workbooks("book1.xlsm").Name
+	.Name .Path .FullName 
+	.Add .Open .Activate .Save .SaveAs .SaveCopyAs .Cloase
## WorkSheet对象
+	Worksheets.Add before:= Worksheets(1)
+	Worksheets.Add Count:= 3
+	.Name .Delete .Count
+	.Activate .select
+	.Copy .Move .Visible
## Range对象
+	Range("A1:A10,A4:E6").Select
+	Range("A1:A10 A4:E6").Select
+	ActiveSheet.Cells(3,4).Value =20
+	Range.("A4:E6").Cells(2,3) = 100
+	ActiveSheet.Cells.Select
+	ActiveSheet.Rows("3:3").Select
+	ActiveSheet.Columns("3:3").Select
+	.Offset .Resize .UsedRange .CurrentRegion
+	Range("A1").Cut Destination := Range("H1")
## 事件
+	生命周期函数
+	开发工具-Bisual Basic-this worksheet -通用 - 选择生命周期
# UI
+	表单控件
+	ActiveX控件
## 控件
## 对话框
## 窗体
## 窗体事件
## 控件设置
# 代码调优
## VBA错误
## VBA状态
## excel调试
## 错误运行
+	On Error GoTo
+	On Error Resume Next
## 调试tips
