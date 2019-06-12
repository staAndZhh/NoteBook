# 概念

分类：分布式，集中式

发展：本地-服务器-分布式



git特点：

1.存储直接快照，而非比较差异

2.断网继续工作，不影响

3.分支管理，瞬间切换

###  仓库

### 引用

本质是指针 git/refs/

#### 分支

#### 标签



### 工作区

#### 工作目录

#### 版本库

#### 暂存区

index

包含文件索引的目录树，二进制文件

tree对象，指向不同的blob,tree哈希值

记录文件名和文件状态信息（时间戳，文件长度）



### 对象

commit	:  指向某个tree,标记项目某个特定时间点状态

tree：类似目录，管理tree和blob

tag：标记一个提交 commit

blob：存储文件数据，通常是一个文件,文件快照

内容寻址的文件系统

对象都存储在 .git/objects/中

版本库3种状态：modified,stated,commit

工作区中的文件状态：untracked,tracked

#### blob

git能追踪文本文件 ，不能追踪二进制文件

git show SHA1

对象名是由哈希计算结果生成

#### tree

包含：mode,对象类型，SHA1值，名字

#### commit



## 内容

30个常用命令

原理：1个仓库

2个引用：分支，标签

3个工作区：工作目录，暂存区，版本库

4大git对象：commit,tree,global,tag

# 安装

win:Cywin(Linux的模拟环境)，Msysgit

Linux:Wine

apt-get install git 

# 文件管理

## 创建

git init

git config --global user.name "wit"

git config --global user.email "wit.wang@qq.com"

git config --global color.ui true

git config --global alias.it init

## 暂存区

git add . 

## 版本库

git commit -m "xxxx"

git commit -a -m "xxxx"

## 查看提交历史

git log 

git show  adadaeregvsf adsd

git diff

git clone git@github.com:xxxxxx/xxx/xx.git

### 修改最后一次提交

git commit --amend

#### 删除文件

git rm -f file.c(工作目录和暂存区删除)

git rm --cached file.c（暂村区删除，工作目录保留）

git reset --soft HEAD^(撤销提交到暂存区)

git reset --mixed HEAD^(撤销提交到工作区)

git reset --head SHA1 （工作区，暂存和版本库还原）

# 历史管理

# 分支

git branch new

git branch

git checkout new

touch main.txt

git add .

git commit -m 'branch'

git checkout master

git log

git checkout new

git log

# 标签

里程碑

git tag v1.0

git tag

git log --oneline

git tag

git tag -d v1.1

git show v1.0

# 远程仓库

# 实战

