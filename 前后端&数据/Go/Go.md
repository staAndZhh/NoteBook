#安装
1.	windows官网下载集成包
2.	GOPATH环境变量配置：是WorkSpace的位置

#helloworld
>		package main
	import "fmt"
	func main() {
   	/* 这是我的第一个简单的程序 */
   	fmt.Println("Hello, World!")
	}
	命令行：go run hello.go 
	main:主程序入口
	import:导入包
	func:函数命名

#语法
变量命名

	var variableName type
	var vname1, vname2, vname3 type
	var variableName type = value
	var vname1, vname2, vname3 type= v1, v2, v3
	var vname1, vname2, vname3 = v1, v2, v3
	vname1, vname2, vname3 := v1, v2, v3
	_, b := 34, 35
	:=简短声明，省略type和var
	_ 丢弃变量，垃圾回收
	已声明但未使用的变量会在编译阶段报错

常量

	const constantName = value
	const Pi float32 = 3.1415926
	const Pi = 3.1415926
	const i = 10000
	const MaxThread = 10
	const prefix = "astaxie_"

布尔类型

	var isActive bool // 全局变量声明
	var enabled, disabled = true, false // 忽略类型的声明
	func test() {
		var available bool // 一般声明
		valid := false // 简短声明
		available = true // 赋值操作
				}

整数类型
	
	无符号和带符号两种：int或者uint
   
字符串
	
	string
	Go中的字符串都是采用UTF-8字符集编码。
	字符串是用一对双引号（""）或反引号（` `）反引号表示多行字符串
	字符串是不可变的
	var frenchHello string // 声明变量为字符串的一般方法
	var emptyString string = "" // 声明了一个字符串变量，初始化为空字符串
	no, yes, maybe := "no", "yes", "maybe" // 简短声明，同时声明多个变量
	japaneseHello := "Ohaiou" // 同上
	frenchHello = "Bonjour" // 常规赋值

	s := "hello"
	c := []byte(s) // 将字符串 s 转换为 []byte 类型
	c[0] = 'c'
	s2 := string(c) // 再转换回 string 类型
	fmt.Printf("%s\n", s2)
	
分组声明
	
	const(
		i = 100
		pi = 3.1415
		prefix = "Go_"
		)
 	
	var(
	i int
	pi float32
	prefix string
	)