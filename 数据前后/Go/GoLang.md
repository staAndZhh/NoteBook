# 导读
## 特点
+	无对象，无继承多态，无泛型，无try catch
		有接口，函数式编程，CSP并发模型（goroutine + channel)

	#	结构
		语法
		demo
		综合案例

## 课程概述
+	base:变量，选择，循环，指针，数组，容器
		面向借口：结构体，duck typing,组合
		函数式编程：闭包，例题
		工程化：组员管理，错误处理，测试和文档，性能调优
		并发编程：gorouting和channel,调度器，例题
		简单分布式爬虫

## 项目结构
+	单任务版
		并发版本
		分布式版本

	#	安装
		golang
		IDE：GoLand,LiteIDE

# 基本语法
## 定义变量
+	 var a,b,c bool
		var s1,s2 string = "hello","world"
		可放在函数内，或者直接放在包内
		使用var()集中定义变量
		编译器可自动定义类型
		var a，b,i,s1,s2 = true,false,3,"hello","world"
		使用：=定义变量(省略var)
		a，b,i,s1,s2 := true,false,3,"hello","world"
		只能在函数内使用
## 要点
+	变量类型写在变量名之后
		编译器可推测变量类型
		没有char,只有rune
		原生支持复数类型
		for,if后面没有括号
		if条件里也可以定义变量
		没有while
		switch不需要break,可以直接switch多个条件
		函数返回值类型写在最后面
		可以返回多个值
		只有可变参数列表


## 内建变量类型
+	bool,string
		(u)int,int8，int16,int32,int64,uintptr
		byte,rune
		float32,float64,complex64,complex128

##  强制类型转换
+	类型转换是强制的
		var a,b int = 3,4
		var c int
		c= int(math.Sqrt(float64(a*a + b*b)))

## 常量定义
+ const filename = "abc.txt"
		const数值可作为各种类型使用
		const a,b = 3,4
		var c int = int(math.Sqrt(float64(a*a + b*b)))

## 常量定义枚举类型
+	普通枚举类型
		自增枚举类型

## 条件语句
+ if的条件里可以赋值
+ if的条件里赋值的变量作用域就在这个if语句中
+ switch会自动break,除非使用fallthrough
		switch后面可以没有表达式

## 循环语句
+	for的条件里不需要括号
		for条件里可以省略初始条件，结束条件，递增表达式

## 函数
+	函数可以返回多个值
		函数返回多个值时可以起名字
		仅用于非常简单的函数
		对于调用者而言没有区别
		函数可作为参数
		可以传入可变参数
		func sum(numbers ...int)int 

## 指针
+	go的指针不能运算
		值传递&引用传递
		go语言只有值传递一种
		指针表示使用 arr *[5] int 
		指针地址引用使用 &arr1

# 数据结构
## 数组
+	数量写在类型前面
		可通过_省略变量
		如果只要i,可以写成 for i := range numbers
		[10] int 和[20] int 是不同的类型
		调用func f(arr [10]int)会拷贝数据
		go一般不使用数组和数组指针：用切片

## range
+	意义明确，美观
		c++ 没有类似功能

## 数组切片
+	slice本身没有数据，slice是对array的视图
		slice可以reslice,s1 = arr[2：5] s1 = s1[2:]
		slice可以向后扩展，不可以向前扩展
		s[i]不可以超越len(s),向后扩展不可以超过底层数组cap(s)
		len(s),cap(s)
		s = append(s,11)
		向slice添加元素时如果超过cap,系统会重新分配更大的底层数组
		由于值传递的方式，必须接受append的返回值 s = append(s,val)
## 切片
+	s [] int
		s := [] int {2,4,6,8}
		s:= make([] int,16)
		s:= make([] int,10,32)
		copy(s2,s1)
		s2 = append(s2[:3],s2[4:]...)
		s2 = s2[1:]
		s2 = s2[:len(s2) -1 ]

## Map
+	map[K]V,map[K1]map[K2]V
		map[key]
			m:= map[string] string{
		"name":"zhh",
		"course":"golang",
		"site":"imooc",
	}

		m := make(map[string]int)
		key不存在时获得value类型的初始值
		用value,ok:=m[key]判断是否存在
		delete(m,"name")
		range遍历key,或者遍历key,value
		遍历无序，需要手动对key排序
		len(m)长度
		map使用哈希表，必须可以比较相等
		除了slice,map,function的内建类型都可以作为key
		Struct类型不包含上述字段，也可以作为key

## 字符串处理
+	leetcode网站，编程练习
		rune 相当于go的char
		使用range遍历pos,rune对
		for i,ch := range [] rune(s)
		for _,b := range [] byte(s)
		使用utf8.RuneCountInString获得字符数量
		用len获得字节长度
		用[]byte获得字节
		其他字符串操作strings.xx
		Fileds,Split,Join
		Contains,Index
		ToLower,ToUpper
		Trim,TrimRight,TrimLeft

# 面向对象
+	go语言仅支持封装，不支持继承和多态
		继承和多态通过接口来做
		go语言没有class,只有struct
		type TreeNode struct{
	Left,Right *TreeNide
	Value int
}
			var root treeNode
		root = treeNode{value:3}
		root.left = &treeNode{}
		root.right = &treeNode{5,nil,nil}
		root.right.left = new(treeNode)
			nodes := [] treeNode {
		{value:3},
		{},
		{6,nil,&root},
	}
		不论地址还是结构本身，一律使用.来访问成员
		没有构造函数，通过工厂函数来控制
		func createNode(value int) *treeNode {
	return &treeNode{value:value}
}
		root.Left.Right = createNode(2)
		工厂函数返回了局部变量的地址
		func (node treeNode) print()  {
	fmt.Print(node.value)
}
		func (node *treeNode) setValue(value int)  {
	node.value = value
}
		func print(node treeNode)  {
	fmt.Print(node.value)
}
		显示定义和命名方法接收者
		只有使用指针才可以改变结构内容
		nil指针也可以调用方法
		func (node *treeNode) setValue(value int)  {
	if node == nil{
		fmt.Println("seting value to nil node")
		return 
	}
	node.value = value
}
		func (node *treeNode) traverse()  {
	if node == nil{
		return
	}
	node.left.traverse()
	node.print()
	node.right.traverse()
}

	#	值接受&指针接收
		改变内容必须使用指针接收者
		结构过大也考虑使用指针接收者
		一致性：如有指针接收者，最好都是指针接收者
		值接收者是go语言的特点
		值/指针接受者均可接收值/指针

	#	封装
		使用命名封装
		名字使用CamelCase
		首字母大写public:包
		首字母小写private：包
		每个目录一个包
		main包包含可执行入口
		为结构定义的方法必须放在同一个包内
		可以是不同文件

	#	扩展
		定义别名
		使用组合

## GoPath&第三方包
+	go get
		gopm获取无法下载的包
		目录结构：src,pkg,bin文件

## 接口
+	 鸭子类型
		描述事物的外部行为而非内部结构
		对使用者来说
		go属于结构化类型系统，类似duck typing
		接口定义
		go语言的接口是由使用者定义的
		type Retiever  interface {
	Get(url string) string 
}
		接口的实现是隐式的
		只要实现接口里的方法即可
