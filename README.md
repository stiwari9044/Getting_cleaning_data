**This script processes the Human Activity Recognition data to report mean for each subject for each activity for each feature.**

*your working directory should be* **UCI HAR Dataset folder** 

In the first step, the research data which is saved in X_test and X_train is read into R. 
the y_train and y_test identify the associated activity such as Walking,  Sitting etc described in activity_labels provided with the data. 

The features are on columns therefore, rbind is used to combine X_test and X_train. Next, feature names are obtained from features.txt and applied to column names by using setnames in data.table package. 

Finally, as per the requirement of the assignment, I have chosen feature columns that correspond to either mean or std. 

To make it a tidy dataset, patient ID is extracted from subject_test and subject_train.txt, which is again combined with rbind taking care of the order. 

The activity labels are extracted from activity_labels and the numeric representation of activity is replaced by the actual labels using cut function. 

Finally, aggregate function is used to subset data by rows by specifying factors on the basis of which we are cutting the data: here we cut by SubjectID and Activity. 