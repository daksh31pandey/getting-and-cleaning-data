##getting data
library(dplyr)
filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
 
## Assigning the data frames

Features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
Activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
Subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = Features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
Subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = Features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##merging training and test dataset

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(Subject_train, Subject_test)
Merged_Data <- cbind(Subject, Y, X)

##extraction of measurement of mean and std
Tidy_data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

##changing activity code to activity name
Tidy_data$code <- Activities[Tidy_data$code, 2]

##changing variable name appropriatly
names(Tidy_data)[2] = "activity"
names(Tidy_data)<-gsub("Acc", "Accelerometer", names(Tidy_data))
names(Tidy_data)<-gsub("Gyro", "Gyroscope", names(Tidy_data))
names(Tidy_data)<-gsub("BodyBody", "Body", names(Tidy_data))
names(Tidy_data)<-gsub("Mag", "Magnitude", names(Tidy_data))
names(Tidy_data)<-gsub("^t", "Time", names(Tidy_data))
names(Tidy_data)<-gsub("^f", "Frequency", names(Tidy_data))
names(Tidy_data)<-gsub("tBody", "TimeBody", names(Tidy_data))
names(Tidy_data)<-gsub("-mean()", "Mean", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-std()", "STD", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-freq()", "Frequency", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("angle", "Angle", names(Tidy_data))
names(Tidy_data)<-gsub("gravity", "Gravity", names(Tidy_data))

##creating tidy data set
Final_data <- Tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Final_data, "FinalData.txt", row.name=FALSE)

