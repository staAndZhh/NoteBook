# 定义
+	服务器端的脚本你语言
# 基础
##  base
+	写在<?php  ?>中
>	 <?php print 'hello world' ?>
	 
+	嵌套html
>		<?php if ($expression == true): ?>
  	This will show if the expression is true.
	<?php else: ?>
  	Otherwise this will show.
	<?php endif; ?> 

+	变量赋值$xx =xx;

+	分隔符为；
+	单行注释#//
+	多行注释/**/
## 数据类型
+	标量：boolean,integer,float,string,
+	复合类型：array,object
+	特殊类型：resource,NULL
+	伪类型：mixed,number,callback
+	伪变量：$..
+	var_dump() gettype() settype()
>		<?php
	$a_bool = TRUE;   // a boolean
	$a_str  = "foo";  // a string
	$a_str2 = 'foo';  // a string
	$an_int = 12;     // an integer
	echo gettype($a_bool); // prints out:  boolean
	echo gettype($a_str);  // prints out:  string
	// If this is an integer, increment it by four
	if (is_int($an_int)) {
	    $an_int += 4;
	}
	// If $bool is a string, print it out
	// (does not print out anything)
	if (is_string($a_bool)) {
	    echo "String: $a_bool";
	}
	?> 

### boolean
+	false:0,0.0,空字符，空字符串，空数组，空对象，NULL，空标记
>		<?php
	var_dump((bool) "");        // bool(false)
	var_dump((bool) 1);         // bool(true)
	var_dump((bool) -2);        // bool(true)
	var_dump((bool) "foo");     // bool(true)
	var_dump((bool) 2.3e5);     // bool(true)
	var_dump((bool) array(12)); // bool(true)
	var_dump((bool) array());   // bool(false)
	var_dump((bool) "false");   // bool(true)
	?> 
### 字符串
+	单引号
+	双引号：变量会被解析
###	数组
+	键值对
+	array(key => value,....)或者[]
+	key可以是整数或者string，不能是数组和对象
+	array['xx'][xxx']
+	删除数组值：unset($arr[5]);
>		<?php
	$array = array(
	    "foo" => "bar",
	    "bar" => "foo",
	);
	// 自 PHP 5.4 起
	$array = [
	    "foo" => "bar",
	    "bar" => "foo",
	];
	?> 
	<?php
	$array = array("foo", "bar", "hallo", "world");
	var_dump($array);
	?> 

###	对象
+	new创建
>		<?php
	class foo
	{
	    function do_foo()
	    {
	        echo "Doing foo."; 
	    }
	}
	$bar = new foo;
	$bar->do_foo();
	?> 
### 类型强转
>		<?php
	$foo = (int) $bar;
	$foo = ( int ) $bar;
	?> 

##	控制流
###	if
+	if () {} elseif () {} else {}
>		<?php if($variable == 'S') {?> 
	<input name="blah" type="radio" value="Y" checked="checked"> Yes 
	 <input name="blah" type="radio" value="N"> No 
	<?php } else {?> 
	<input name="blah" type="radio" value="Y"> Yes 
	 <input name="blah" type="radio" value="N" checked="checked"> No 
	<?php }?> 
### while
+ while () {}
+ do {} while()

### for
+	foreach (array_expression as $xx) {}
>		<?php
	$arr = array(1, 2, 3, 4);
	foreach ($arr as &$value) {
	    $value = $value * 2;
	}
	// $arr is now array(2, 4, 6, 8)
	unset($value); // 最后取消掉引用
	?> 

## 面向对象
### 函数
+	支持可变函数
>		<?php
	function makecoffee($type = "cappuccino")
	{
	    return "Making a cup of $type.\n";
	}
	echo makecoffee();
	echo makecoffee(null);
	echo makecoffee("espresso");
	?> 

### 匿名函数
+	function (){}
>		<?php
	$greet = function($name)
	{
	    printf("Hello %s\r\n", $name);
	};
	$greet('World');
	$greet('PHP');
	?> 