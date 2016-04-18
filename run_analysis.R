library(plyr)
library(tidyr)
library(dplyr)
getwd()
setwd("F:/Class3/Project/data")
##Create data sets from the downlowed data

x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/Y_train.txt")
subjtrain<-read.table("./train/subject_train.txt")
subjtest<-read.table("./test/subject_test.txt")
features<-read.table("./features.txt")
label<-read.table("./activity_labels.txt")
x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/Y_test.txt")
## Update the acitvity lables 
train_label<-left_join(y_train,label, by= c("label"="V1"))
test_label<-left_join(y_test,label, by= c("label"="V1"))



names(subjtest)<-"subject"
names(subjtrain)<-"subject"
names(y_train)<-"label"
names(y_test)<-"label"
##Remove prenthaites and commas from coloumn name

names(x_test) <-features[,2]
names(x_test)<-gsub("\\)","",names(x_test))
names(x_test)<-gsub("\\(","",names(x_test))
names(x_test)<-gsub("\\,","-",names(x_test))
names(x_train)<- features[,2]
names(x_train)<-gsub("\\)","",names(x_train))
names(x_train)<-gsub("\\(","",names(x_train))
names(x_train)<-gsub("\\,","-",names(x_train))


## udpate subjects and activity lables to train and test data sets
mergxtrain<- x_train
mergxtrain['subject'] <-subjtrain[,1]
mergxtrain["label"] <- train_label[,2]

mergxtest<-x_test
mergxtest["subject"] <- subjtest[,1]
mergxtest["label"] <- test_label[,2]

## Merge taring and test data sets 
mergdata<-join(mergxtrain,mergxtest,type='full')
## Get column  mean and standard devation data sets
fil <-subset(features, grepl("mean", V2) |grepl("std", V2) )
subdata<-select(mergdata,subject,label,fil$V1)

write.table(subdata,file="subdata.txt", row.names = FALSE) 


avgdata <-
  subdata  %>%
  group_by(,"subjet","label")%>%
   mean(,3:81)%>%
  print
   
