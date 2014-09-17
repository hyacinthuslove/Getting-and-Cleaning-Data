################################################################################
# Course: Getting and Cleaning Data 
# Author: Peggy Ong
# Date  : 16 Sep 2014
################################################################################

# Initial Setup
require(reshape2)
require(plyr)
require(stringr)

# Data files are unzipped into C:/Coursera/Getting-and-Cleaning-Data/Project/Data
# Set Working Directory
setwd("C:/Coursera/Getting-and-Cleaning-Data/Project")

################################################################################
# 1. Merges the training and the test sets to create one data set.
#
features <- read.table("./data/features.txt")
activity_label <- read.table("./data/activity_labels.txt")

# Activity - Combine the test and train files then label single column
# dataset as activity_label
y_test <- read.table("./data/test/y_test.txt")
y_train <- read.table("./data/train/y_train.txt")
y_data <- rbind(y_test,y_train)
names(y_data) <- "activity_label"

# Subject - Combine the test and train files then label single column
# dataset as subject
subject_test <- read.table("./data/test/subject_test.txt")
subject_train <- read.table("./data/train/subject_train.txt")
subject_data <- rbind(subject_test,subject_train)
names(subject_data) <- "subject"

# Features - Combine the test and train files then label 561-column
# dataset using features[,2]
X_test <- read.table("./data/test/X_test.txt")
X_train <- read.table("./data/train/X_train.txt")
X_data <- rbind(X_test,X_train)
names(X_data) <- features[,2]

# Inertia files are not included as only mean and std deviation are required

################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement. 

X_data_mean <- subset(X_data, select=names(X_data[grep('()?mean\\()()?',names(X_data))]))
X_data_std <- subset(X_data, select=names(X_data[grep('()?std\\()()?',names(X_data))]))
data <- cbind(y_data, subject_data, X_data_mean, X_data_std)

################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
#
for (i in 1:6){ 
     data$activity[data$activity_label==i] <- as.character(activity_label[,2][i])
}

data$activity_label <- NULL
data <- data[c(1,length(data),2:(length(data)-1))]

################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
#
#
# Remove () from all column names

new_name <- sub("\\()","",names(data[grep(('?\\()?-?'),names(data))]),)
index_range <- grep(('?\\()?-?'),names(data))

j <- 1

for (i in index_range){

     names(data)[i] <- new_name[j]
     j <- j + 1
}


################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#    using write.table() row.name=FALSE

data2 <- melt(data, id=1:2,na.rm=TRUE)
data3 <- dcast(data2, activity + subject ~ variable, fun.aggregate=mean)
new_name <- names(data3)[3:length(data3)]

j <- 1   
for (i in 3:length(data3)){
     names(data3)[i] <- paste0(new_name[j],"_Average")
     j <- j + 1
}

write.csv(data3, "./data/data.txt", row.names=FALSE)
