## Importing the training and test data in R
wd<-getwd()
X_test<-read.table(paste0(wd,"/test/X_test.txt"))
X_train<-read.table(paste0(wd,"/train/X_train.txt"))


activity_test<-read.table(paste0(wd,"/test/y_test.txt"))
activity_train<-read.table(paste0(wd,"/train/y_train.txt"))


subject_test<-read.table(paste0(wd,"/test/subject_test.txt"))
subject_train<-read.table(paste0(wd,"/train/subject_train.txt"))

## merge test and training data
mergeX<- rbind(X_test,X_train)
mergeActivity<- rbind(activity_test, activity_train)
mergeSubject<- rbind(subject_test, subject_train)

## Relabel column names to be descriptive 
features<-read.table("features.txt")
# View(features) #will use this table to assign column names
feature_names<-paste(as.character(features$V1),as.character(features$V2)) # attaching numbers to feature names to ensure
# that each column name is unique. Some column names are repeats but the data in them is different. 

library(data.table)
setnames(mergeX, names(mergeX), feature_names)

##select only measurements on the mean and standard deviations for each measurement
mergeX_musig<-select(mergeX, matches("mean|std"))

dataset<-data.frame(mergeSubject, mergeActivity, mergeX_musig)
library(dplyr)
dataset<-tbl_df(dataset)
dataset<-rename(dataset, SubjectID=V1, Activity=V1.1) ##gave descriptive column names to subject id and activity

## give descriptive names to activities
activity_labels<-read.table("activity_labels.txt")
dataset<-mutate(dataset,Activity=cut(dataset$Activity,breaks=c(0.5,1.5,2.5,3.5,4.5,5.5,6.53),labels=as.character(activity_labels$V2)))

##---------now we have full labelled data as per the requirements of points 1-4 in assignment-----------------------##

dataset2<-aggregate(mergeX_musig, by=list("SubjectID"=dataset$SubjectID, "Activity"=dataset$Activity), FUN=mean, na.rm=TRUE) 

## save final result 
write.table(dataset2, file="Dataset2.txt", row.name=FALSE)