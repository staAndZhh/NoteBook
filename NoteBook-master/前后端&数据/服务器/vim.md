# 优雅玩转vim
## catalogue
### vim和vi
### vimrc
### 不同模式
### 基础入门
+   寄存器
+   adur
+   组合规律
### 高级功能
+   缓冲区&多文件编辑
+   多窗口与标签分组
+   文本对象和宏
+   visual模式

## content
### vim和vi
+   vim = vi + improved
    +   多级撤销
    + 语法高亮和自动补全
    +   支持多种插件
    +   通过网络协议(http/ssh)编辑文件
    +   多文件编辑
    +   可以编辑压缩格式文件(gzip,zip等)
### vimrc
+   rc = run command
+   系统级别vimrc 和用户级别vimrc
+   每一行作为一个命令执行
#### 使用
+   vim test.txt
+   :version
+   vim ~/.vimrc
+   注释"
+   :set autoindent
### 不同模式
+   四种模式
+   普通模式
    +   打开默认模式
    +   移查删改
+   可视化模式
+   对一块区域进行操作
    +   v    
+   插入模式
    +   添加文本
    +    i 
+   命令模式
    +   和普通模式类似
    +   可以输入命令
    +   先esc再 :
    +   输入命令 : version
#### 基本操作
+   光标移动
    +   hijk 左右下上
    +   $   行尾
    +   ^/0 行首
+   字符移动
    + w,b,e,ge 正,反(头),正反(尾)
+   跳转
    +   ctrl f 下一页
    +   ctrl b  上一页
    +   ctrl d/u  向下,上翻半页
    +   gg 文件行首
    +   <line number> gg/G 指定行
    +   G 文件最后一行
    +   {g} + ctrl-g/G 查看文件信息
+   缩进
    +   >> :> 右缩进
    +   m,n /:m>(n-m+1) m到n行缩进
    +   m>n 等价 :m,m+n-1> m行开始到共n行缩进一次
+   删除,复制与粘贴
    +   delete:剪切,yank:复制,put 粘贴
    +   dyp
    +   yy复制整行
    +   u,ctrl-r 撤销,重复之前操作
### 基础入门
####  寄存器
+   无名寄存器
+   数字寄存器
+   有名寄存器
+   黑洞寄存器
+   :register
####   组合规律
+   yw 复制当前光标单词
+   y2w 复制正向2单词
+   pp 粘贴到光标前
+  调换字符   F {space} x p
+   行剪切 dd 
+   组合 [count]operation([count]{motion})
+   删除一个单词 dw
+   d$=D 删除光标到行尾字符
+   d^  删除光标到行首字符
+   dd
+   {n}dd
+   5dw
+   3w
+   D3w 
+   2d3w 
### 高级功能
####   缓冲区&多文件编辑
    +:files :buffers :ls
+   多窗口与标签分组
+   文本对象和宏
+   visual模式