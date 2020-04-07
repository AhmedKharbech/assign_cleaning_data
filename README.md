"Getting and Cleaning Data" Project

Initial data for research

The script analyzes the data from UCI HAR Dataset.

The files used:

features.txt - includes the descriptions for features measured
train/X_train.txt - includes the measurements of the features in train set (one row - 1 measurement of 561 features)
test/X_test.txt - includes the measurements of the features in test set
train/subject_train.txt - subject for each measurement from the train set
test/subject_test.txt - subject for each measurement from the test set
train/y_train.txt - activity (from 1 to 6) for each measurement from the train set
test/y_test.txt - activity (from 1 to 6) for each measurement from the test set


The logic behind the script

Script involves the following stages:

Downloads to R ids and descriptions for features being measured in experiment from file features.txt.

Independently loads complete data for train and test sets. Let's revoke these loading process considering train set:
a. Firstly loads the measurements from X_train.txt as a data frame
b. For these data frame column names are updated to be more user friendly using features description loaded on the previous stage. (STEP 4: Appropriately label the data set with descriptive variable names of Course Project
c. activity labels and subjects for measurements are also loaded from files X_train/y_train.txt and Xtrain/subject_train.txt and added to data frame as a separated columns.

Similar steps are made for test dataset.

The 2 datasets are merged together.

To extract measurements that involves only mean and standard deviation values script uses grep, that finds column names that includes "mean()" or "std()" 


To provide descriptive values for activity labels a new variable "activity_name" is added to dataset,by merging the dataset with the activities dataset (STEP 3)

Creates a melted data frame using activity_name and subject as ids, after that mean values for all variables are calculated using dcast() function.