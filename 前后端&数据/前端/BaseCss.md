# 选择器
+   元素：html {color:black;}
+   id：#red {color:red;}
+   类：.center {text-align: center}
+   属性：a[href][title] {color:red;}
+   后代：h1 em {color:red;}
+   子元素：    h1 > strong {color:red;}
+   选择器分组：h2, p {color:gray;}
+   相邻兄弟：h1 + p {margin-top:50px;}
+   伪类：a:hover {color: #FF00FF}	
+   伪元素：p:first-line
  {
  color:#ff0000;
  font-variant:small-caps;
  }
+   派生：
+   li strong {
    font-style: italic;
    font-weight: normal;
  }
+   # sidebar p {
	font-style: italic;
	text-align: right;
	margin-top: 0.5em;
	}
+   div#sidebar {
	border: 1px dotted #000;
	padding: 10px;
	}
+  .fancy td {
	color: #f60;
	background: #666;
	}

# margin 方式
+   margin:25px 50px 75px 100px; 上右下左
+   margin:25px 50px 75px; 上,左右,下
+   margin:25px 50px; 上下，左右
+   margin:25px; 所有的
# 定位
+   普通流、浮动和绝对定位
+   块级框从上到下一个接一个地排列，框之间的垂直距离是由框的垂直外边距计算出来
+   static,relative,absolute,fixed
# flex
+   older:display+position+float
+   new:flex

# vh
+    vw  相对于视口的宽度。视口被均分为100单位的vw
+   vh  相对于视口的高度。视口被均分为100单位的vh
+   vmax 相对于视口的宽度或高度中较大的那个。其中最大的那个被均分为100单位的vmax
+   vmin 相对于视口的宽度或高度中较小的那个。其中最小的那个被均分为100单位的vmin

# calc
+   动态计算长度
+   width: calc(100% - 10px)

# div水平居中
+  m1
    +   body设置css内容居中样式（css text-align:center）
    +   然后布局最外层DIV盒子时候使用 margin:0 auto(对象上下间隔为0，左右间隔自动)
