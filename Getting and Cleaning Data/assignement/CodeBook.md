# CodeBook

This is a the code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.

## The input data
### Source:

* Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Source data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### The Input Data Set Information
#### Creators:
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
* - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
* - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws


#### Experiment information:
* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
* Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
* The experiments have been video-recorded to label the data manually. 
* The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### The input data

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## What does the script ```run_analysis.R ``` does?

This script:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How ```run_analysis.R``` implements the above steps:

### Get the data
* Require / Install the needed libraries
* Supose that the data is in the current folder

### Load the data
* Load the test and the train data
* Load the features and activity labels.

### Merge the data
* Add the activities labels to the test and train activity data
* Rename the test and the train data from the feature data
* Create the final labeled data by adding the activities labels and the subject data to the test and the train data

### Mean and Standard deviation
* Extract the mean and standard deviation by column.

### Tidy Data
* Group the data by activity and subject and compute mean and standard deviation
* Write the tidy data to a file

## The Script Output:

### Activity Labels (act):

WALKING (value 1): subject was walking during the test
WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
SITTING (value 4): subject was sitting during the test
STANDING (value 5): subject was standing during the test
LAYING (value 6): subject was laying down during the test
