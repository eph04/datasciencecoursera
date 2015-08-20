# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis.
# You will be graded by your peers on a series of yes/no questions related to the project.
# You will be required to submit: 
#   1) a tidy data set as described below, 
#   2) a link to a Github repository with your script for performing the analysis, and 
#   3) a code book that describes the variables, the data, and any transformations 
#      or work that you performed to clean up the data called CodeBook.md.
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing see for example this article.
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy 
# S smartphone. A full description is available at the site where the data was obtained: 
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
# 

# 'features_info.txt': Shows information about the variables used on the feature vector.
# 
# 'features.txt': List of all features.
# 
# 'activity_labels.txt': Links the class labels with their activity name.
# 
# 'train/X_train.txt': Training set.
# 
# 'train/y_train.txt': Training labels.
# 
# 'test/X_test.txt': Test set.
# 
# 'test/y_test.txt': Test labels.
# 
# The following files are available for the train and test data. Their descriptions are equivalent. 
# 
# 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
# Its range is from 1 to 30. 
# 
# 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis 
# in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 
# 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
# 
# 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity 
# from the total acceleration. 
# 
# 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for 
# each window sample. The units are radians/second. 



library(plyr)
library(dplyr)
#library(data.table)
library(sqldf)

trainNames <- "train"
testNames <- "test"

rootDir <- "getdata-projectfiles"
testDir <- paste(rootDir,testNames,sep = "/")
trainDir <- paste(rootDir,trainNames,sep = "/")

activity_labels_file <- paste(rootDir,"activity_labels.txt",sep = "/")
features_file <- paste(rootDir,"features.txt",sep = "/")

trainingSet_file <- paste(trainDir,"/X_", trainNames,".txt",sep = "")
trainingLabels_file <- paste(trainDir,"/y_", trainNames,".txt",sep = "")

testSet_file <- paste(testDir,"/X_", testNames,".txt",sep = "")
testLabels_file <- paste(testDir,"/y_", testNames,".txt",sep = "")

features_df <- read.table(features_file,stringsAsFactors = FALSE,header = FALSE,colClasses = c("character"))
activity_labels_df <- read.table(activity_labels_file,stringsAsFactors = FALSE
                                 ,header = FALSE,colClasses = c("character"))

trainingSet_df <- read.table(trainingSet_file,stringsAsFactors = FALSE,header = FALSE,colClasses = c("numeric"))
trainingLabels_df <- read.table(trainingLabels_file,stringsAsFactors = FALSE
                                ,header = FALSE,colClasses = c("character"))
testSet_df <- read.table(testSet_file,stringsAsFactors = FALSE,header = FALSE,colClasses = c("numeric"))
testLabels_df <- read.table(testLabels_file,stringsAsFactors = FALSE,header = FALSE,colClasses = c("character"))

features_df <- tbl_df(features_df)
activity_labels_df <- tbl_df(activity_labels_df)
trainingSet_df <- tbl_df(trainingSet_df)
trainingLabels_df <- tbl_df(trainingLabels_df)
testSet_df <- tbl_df(testSet_df)
testLabels_df <- tbl_df(testLabels_df)

measure_filter <- features_df %>% 
                  select(id_mes=V1,mes=V2) %>%
                  filter(grepl(mes,pattern = "mean()|std()")) %>%
                  mutate(id_mes=as.integer(id_mes))

trainingSet_final <- trainingSet_df %>% select(measure_filter$id_mes)
colnames(trainingSet_final) <- measure_filter$mes


# sqldf::sqldf("select V1,V2 from features_df where lower(V2) like '%mean()%' or lower(V2) like '%std()%'")





































