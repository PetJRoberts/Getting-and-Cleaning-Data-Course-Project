## Introduction

This project takes a number of different datasets, and merges them together. The dataset was taken from the site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code 'R_Analysis.R' does the following as determined by the inital spec:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data
The datasets used were as follows:
1. 'subject_test.txt'
2. 'X_test.txt'
3. 'y_test.txt'
4. 'subject_train.txt'
5. 'X_train.txt'
6. 'y_train.txt'

Additionally the files 'features.txt' and 'activity_labels.txt' described how the activity ID and features were represented in the data given'.

## Workflow
The code:
1. Loads the library, plyr,
2. Downloads and unzips the data.
3. Reads the training input files described above and labels them appropriately based on the features.txt file.
4. Merges the subject, x and y training files using cbind
5. Repeats the process with the test input files
6. Binds the traning and test merged datasets
7. Determines the features that are applicable to mean and standard deviation
8. Truncates the dataset to include only these variables
9. Replaces the activity ID with the activity name
10. Uses ddply to create a new dataset containing the mean values for each subject and activity
11. Writes these values to the table tidyData.txt

## Variables