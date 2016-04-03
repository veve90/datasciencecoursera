#
# 1. Merges the training and the test sets to create one data set.
#
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropriately labels the data set with descriptive variable names.
#    From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
#
#

# ####################################################################"
# Install needed libraries
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# #####################################################################
# Download data
filePath <- "./data/mobileData.zip"
folderName <- "./data"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(folderName)){dir.create(folderName)}
download.file(fileURL,destfile=filePath, method="curl")

# unzip the data
unzip(filePath)
# The dataset includes the following files:
#   =========================================
#   
#   - 'README.txt'

# - 'features_info.txt': Shows information about the variables used on the feature vector.

# - 'features.txt': List of all features.

# - 'activity_labels.txt': Links the class labels with their activity name.

# - 'train/X_train.txt': Training set.

# - 'train/y_train.txt': Training labels.

# - 'test/X_test.txt': Test set.

# - 'test/y_test.txt': Test labels.

# The following files are available for the train and test data. Their descriptions are equivalent. 

# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

# - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

# - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

# - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 




# #################################1. LOAD DATA ###################################
# 2947 obs, data.frame of 561 variables
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
# 2947 obs, factor of 6 levels
testData_act <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
# 2947 obs, data.frame of 1 variable
testData_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)


trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# #################################2. ADD LABELS TO DATA #############################
# This file links the class labels with their activity name.
# Factor if 6 levels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)


# List of all features.
# data.frame of 561 obs and 2 variables
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("act")
colnames(trainData_act)<-c("act")
colnames(testData_sub)<-c("subj")
colnames(trainData_sub)<-c("subj")


# Create final labeled data
testData <- cbind(testData,testData_act)
finalTestData <- cbind(testData,testData_sub)
trainData <- cbind(trainData,trainData_act)
finalTrainData <- cbind(trainData,trainData_sub)

# #################################2. MERGE TEST AND TRAIN #############################
bigData <- rbind(finalTestData,finalTrainData)

# #################################3. EXTRACT MEAN AND STD #############################
bigData_mean <- sapply(bigData,mean,na.rm=TRUE)
bigData_sd <- sapply(bigData,sd,na.rm=TRUE)

# #################################3. SECOND DATA #############################
DT <- data.table(bigData)
tidy<-DT[,lapply(.SD,mean),by="act,subj"]
write.table(tidy_data, file = "./tidy_data.txt")



