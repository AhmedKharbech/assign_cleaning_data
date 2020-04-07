#Reading features and activities lables data

features<-read.table("./UCI HAR Dataset/features.txt",col.names = c("id_feature","feature_name"))
activities<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("id_activity","activity_name"))

#reading training data

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(X_train)<-features$feature_name

y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(y_train)<-c("id_activity")

X_train$activity<-y_train$id_activity #add a colum to X_train to refer to the activity

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)<-c("id_subject")

X_train$subject<-factor(subject_train$id_subject)# add a column to X_train to refer to the subject

# reading test data

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X_test)<-features$feature_name

y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(y_test)<-c("id_activity")

X_test$activity<-y_test$id_activity #add a colum to X_test to refer to the activity

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)<-c("id_subject")

X_test$subject<-factor(subject_test$id_subject)# add a column to X_test to refer to the subject


#merge  training and test sets
merged_dataset <- rbind(X_test, X_train)

#Filter the merged dataset to get only the measurements on the mean and standard deviation for each measurement
filtered_colnames<-grep(pattern = "std\\()|mean\\()|activity|subject",colnames(merged_dataset),value = T)#filter column names

filtered_dataset<-merged_dataset[,filtered_colnames] #assign only the measurement on the mean and 



#Uses descriptive activity names to name the activities in the data set
#We can add it directly by merging the filtered dataset with the activities dataset

filtered_dataset<-merge (filtered_dataset,activities,by.x = "activity",by.y = "id_activity")

#creates a second, independent tidy data set with the average of each variable for each activity and each subject
features.columns = grep("std\\(\\)|mean\\(\\)", colnames(filtered_dataset), value=TRUE)
melted_data_set<-melt(filtered_dataset,id=c("activity_name","subject"),measure.vars = features.columns)
tidy_dataset<-dcast(melted_data_set,formula = activity_name+subject~variable,mean)


#writing the tidy dataset into a txt file

write.table(tidy_dataset,"tidy_dataset.txt")









