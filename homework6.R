load('/Users/jiadawei/Desktop/fall materials/BA HW6/DSBchurn.Rda')
set.seed(3478)
train=sample(1:nrow(churn),nrow(churn)*0.667) 
churn.train=churn[train,] 
churn.test=churn[-train,] 
library(rpart)
# big tree
fit<-rpart(stay~.,data=churn.train,control=rpart.control(xval=10,minsplit=2,cp=0)) 
churn.pred=predict(fit,churn.test,type="class") 
churn.actual=churn.test$stay 
confusion.matrix1=table(churn.pred,churn.actual) 
confusion.matrix1
FNR.big=1187/(1187+2146)  
FPR.big=1348/(1348+1979) 
accuracy.big=(1979+2146)/6660
profit1=(1/2*1000-400)*510000+490000*1000-510000*100*FPR.big-196000000*FNR.big
# Pruned Tree
fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]
fit.post=prune.rpart(fit,cp= 0.002298851)
pdf("pruned tree.pdf")
plot(fit.post,uniform=T,compress=F,margin=0.1,branch=0.6)
text(fit.post,use.n=T,all=T,cex=0.6)  
dev.off()
churn.pred=predict(fit.post,churn.test,type="class") 
churn.actual=churn.test$stay 
confusion.matrix2=table(churn.pred,churn.actual) 
confusion.matrix2
FNR.p=1152/(1152+2181) 
FPR.p=922/(2405+922)  
accuracy.p=(2405+2181)/6660
profit2=51000000+490000*1000-51000000*FPR.p-196000000*FNR.p
#Best Threshold Pruned Tree
library(ROCR)
churn.pred=predict(fit.post,churn.train,type="prob")
churn.pred.score=prediction(churn.pred[,2],churn.train$stay) 
churn.pred.perf=performance(churn.pred.score,"tpr","fpr") 
plot(churn.pred.perf,colorize=T,lwd=4)
abline(0,1)
churn.auc=performance(churn.pred.score,"auc")
churn.auc@y.values
churn.cost=performance(churn.pred.score,measure="cost",cost.fn=196000000,cost.fp=51000000)
plot(churn.cost) 
churn.cost@x.values[[1]][which.min(churn.cost@y.values[[1]])] # find the best cutoff
churn.pred.test=predict(fit.post,churn.test,type="prob")
churn.pred.test.cutoff=ifelse(churn.pred.test[,2]<0.2068036,'LEAVE','STAY')
confusion.matrix3=table(pred=churn.pred.test.cutoff,actual=churn.test$stay) 
confusion.matrix3
FNR.t=975/(975+2358) 
FPR.t=1076/(1076+2251) 
accuracy.t=(2251+2358)/6660
profit3=51000000+490000*1000-51000000*FPR.t-196000000*FNR.t
FNR<-c(FNR.big,FNR.p,FNR.t)
FPR<-c(FPR.big,FPR.p,FPR.t)
accuracy<-c(accuracy.big,accuracy.p,accuracy.t)
expectedvalue<-c(profit1,profit2,profit3)
table<-cbind(FNR,FPR,accuracy,expectedvalue)
row.names(table)<-c("big tree","pruned tree","best threshold tree")
table

