### knn

#### demo

as.data.table(scale(test))

library(class)

test_pred <- knn(train,test,classlabel,k)

library(gmodels)

CrossTable(x=test_labels,y=test_pred,prop.chisq=FALSE)

### NaiveBayes

独立性假设

#### 拉普拉斯估计

频率表中每个计数加上一个较小的值

4/20  10/20 0/20  12/20 20/100

5/24   11/24 1/24  13/24  20/100

#### 数值特征离散化

#### demo

library(e1071)

m <- naiveBayes(train, class, laplace=0)

p <- predict(m,test,type='class')

m <- naiveBayes(train, class, laplace=1)

### descsionTree

#### ID3

#### C4.5

#### C5.0

熵，基尼系数，卡方统计量，增益率

#### 最佳分割

#### 剪枝

##### 预剪枝

##### 后剪枝

#### demo

library(C50)

m <- C5.0(train,class, trials = 1, costs = NULL)

p <- predict(m,test)

#### adboost

m <- C5.0(train,class, trials = 10, costs = NULL)

#### 代价函数

m <- C5.0(train,class, trials = 10, costs = matrix(c(0,1,4,0),nrow=2))

### 规则学习

#### 1R

##### demo

library(Rweka)

m <- OneR（class ~ predictors + cap_color, data = mydata )

p <- predict(m, test)

#### IREP

library(Rweka)

m <- JRip(class ~ predictors, data= mydata)

m <- JRip(class ~ ., data= mydata)

### CART

分类回归树

library(rpart)

m <- rpart(dv~iv, data = mydata)

p <- predict(m,test, type = 'vector')

library(rpart.plot)

rpart.plot(m,digits=3)

predict(m,test)

### MR

模型树

library(RWeka)

m <- M5P(dv~iv, data= mydata)

###  LR

pairs()

library(psych)

pairs.panels()

#### demo

m <- lm(dv~iv,data=mydata)

p <- predict(m,test)

#### 添加非线性

#### 数值转二进制

#### 相互影响

m <- lm(dv~iv+iv2+iv3:iv5,data=mydata)

### RNN

#### demo

library(neuralnet)

m <- neuralnet(target~predictors, data= mydata, hidden = 1)

p <- compute(m,test)

m$neurns

m$net.results

### SVM

#### demo

library(klaR)

library(kernlab)

m <- ksvm(target~predictors, data = mydata, kernel = "rbfdot", c=1)

p <- predict(m,test, type = 'response')

### Apriori

#### demo

library(arules)

m <- apriori(data = mydata, parameter=list(support = 0.1,confidence = 0.8,minlen = 1))

inspect(m)

### Kmeans

#### demo

library(stats)

kmeans(mydata,k)

### Judge

#### 混淆矩阵

准确度

错误率

library(caret)

confusionMatrix(predict_type,real_type)

#### Kappa

library(vcd)

Kappa(table(result_real,result_predict))

#### 灵敏度

真阳性

#### 特异性

真阴性

library(caret)

sensitivity(predict,real,position="spam")

#### 精确度

#### F度量

#### ROC曲线

library(ROCR)

performance(pred)

### sample

#### 保持法

library(caret)

crateDataPartition(data_type,p=0.75,list = FALSE )

#### k-fold

library(caret)

createFolds(data_type,k=10)

#### bootstrap

### optimize

#### 自动调参

#### ensemable

##### bagging

##### boosting

##### 随机森林

