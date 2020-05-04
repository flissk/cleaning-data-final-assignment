#reading data

#get working directory
rm(list = ls())
setwd("/Users/phyllisho/Desktop/Coursera R stuff go fliss/data")

#download dataset and unzip
filename <- "uci_har_dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#load all txt files in zip 
list.files("./uci_har_dataset")

#define path
path = file.path("uci_har_dataset")

#create file with all 28 files in original zip 
files = list.files(path, recursive=TRUE)

#Q2 Appropriately labels the data set with descriptive variable names.

#training 
train_set <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
train_label <- read.table(file.path(path, "train", "y_train.txt"),header = FALSE)
train_subject <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)

#test 
test_set <- read.table(file.path(path, "test", "X_test.txt"),header = FALSE)
test_label <- read.table(file.path(path, "test", "y_test.txt"),header = FALSE)
test_subject <- read.table(file.path(path, "test", "subject_test.txt"),header = FALSE)

#features 
features = read.table(file.path(path, "features.txt"),header = FALSE)

#activity labels （6 obs, 2 variables, 1 / walking, 2 / running etc..)
activityLabels = read.table(file.path(path, "activity_labels.txt"),header = FALSE)

# Q3 Uses descriptive activity names to name the activities in the data set
colnames(train_label) <- "activity_num"
colnames(train_subject) <- "subject"
colnames(train_set) = features[,2] #the entire features column no. 2 becomes the col names for train_set - same no. of variables (561)

colnames(test_label) <- "activity_num"
colnames(test_subject) <- "subject"
colnames(test_set) = features[,2]

activityLabels <- c("activity_num", "activity_type")

# Q1 Merges the training and the test sets to create one data set.
merged_train <- cbind(train_label, train_subject, train_set) 
merged_test <- cbind(test_label, test_subject, test_set)

#overall merge
finalmerge_df <- rbind(merged_test, merged_train)

#Q2 Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)

#overall merge
finalmerge_df <- rbind(merged_test, merged_train)

#identify column names that contain mean() or std()
colnames_mean_std <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

#subset df by selected df names
subset_df_names<-c(as.character(colnames_mean_std), "subject", "activity_num") #convert to text string
subset_df <-subset(finalmerge_df,select=subset_df_names)

#Q5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subset_df #recap: the dataset in question
df_averaged <- aggregate( . ~ subject + activity_num, data = subset_df, FUN = mean )

#write out both datasets
setwd("/Users/phyllisho/Desktop/Coursera R stuff go fliss")
write.table(subset_df, "subset_df.txt", row.names = FALSE )
write.table(df_averaged, "averaged_df.txt", row.names = FALSE )
