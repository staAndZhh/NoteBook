#	Scss
1.	sass与scss区别
	1.	文件扩展名不同，Sass 是以“.sass”后缀为扩展名，而 SCSS 是以“.scss”后缀为扩展名
	2.	语法书写方式不同，Sass 是以严格的缩进式语法规则来书写，不带大括号({})和分号(;)，而 SCSS 的语法书写和我们的 CSS 语法书写方式非常类似。
	3.	sass基于Ruby,依靠缩进，不带有{}和；scss与css写法无差别
	>		Sass
	>		$font-stack: Helvetica, sans-serif  //定义变量
		$primary-color: #333 //定义变量
		body
		  font: 100% $font-stack
		  color: $primary-color
		
	>		Scss
	>		$font-stack: Helvetica, sans-serif;
		$primary-color: #333;
		body {
		  font: 100% $font-stack;
		  color: $primary-color;
		}
2.	安装
	1.	ruby -v	
	2.	sass -v
	2.	安装ruby

3.	语法
	+	变量：$width:300px;
		>		$brand-primary : darken(#428bca, 6.5%) !default; // #337ab7
			$btn-primary-color : #fff !default;
			$btn-primary-bg : $brand-primary !default;
			$btn-primary-border : darken($btn-primary-bg, 5%) !default;
	+	嵌套	
	+	父选择器的标识符&
	+	混合
	+	导入
	
#	Less
1.	介绍
	1.	Less is More ,Than css
	2.	动态样式语言，类似jquery，模板，继承，变量
	
2.	安装
	1.	Koala

3.	语法
	+	注释：同css /*是被编译的*/ less /不被编译的/
	+	变量：@test_width:300px;
		> .box{
		> 	width:@test_width;
		> 	background-color:yellow;
		>
		>	.border
		> }
	+	混合：复用，可带参数
		>	.border{
		>		border:solid 5px pink;
		>	}
		>	
		>	.box2{
		>		.box;
		>		margin-left:100px;
		>	}
		>	
		>带参数的
		>	.border_02(@border_width){
		>		border:solid pink @border_width;
		>	}
		>	
		>	使用
		>	.test_border_02{
		>		.border_02(30px);
		>	}
		>	
		>	带默认参数
		>	.border_03(@border_width：10px){
		>		border:solid pink @border_width;
		>	}	
		>	
		>	使用
		>	.test_border_03{
		>		.border_02();
		>	} 
		
	+	匹配模式(相当于js中的if,不完全是；满足条件后调用)
		>	.triangle(top,@w:5px,@c:#ccc){
		>	border-width:@w;
		>	border-color:transparent transparent @c transparent;
		>	border-style:dashed dashed solid dashed;
		>	}
		>
		>	.triangle(bottom,@w:5px,@c:#ccc){
		>	border-width:@w;
		>	border-color:@c transparent transparent transparent;
		>	border-style:solid dashed dashed dashed;
		>	}
		>
		>	默认值
		>	.triangle(@_,@w:5px,@c:#ccc){
		>	width:0;
		>	height:0;
		>	overflow:hidden;
		>	}
		>	
		>   使用： .sanjiao{
		>   	width:0;
		>   	height:0;
		>   	overflow:hidden;
		>   	.triangle(top,100px);
		>   }

		>   使用2： .sanjiao{
		>   	.triangle(top,100px);
		>   }
	+	运算：任何数字，颜色或者变量都可以参与运算，运算被含在括号中
		>	@test_01:300px;
		>	.box_02{
		>	width:(@test_01 -20)*5;
		>	color:#ccc-10;
		>	}
	+	嵌套：&(上一层选择器)对伪类使用hover或者focus，.对连接使用&-item
		>	list{
		>	a{
		>	&:hover{
		>		}
		>		}
		>	}
	+	@arguments
	+	 避免编译~''
	+	!important
		