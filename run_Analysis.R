# As described on course website, goal of run_Analysis.R is
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.

# Install library
require(plyr)

# Download data
dataURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, destfile="./Samsungdata.zip")

# Unzip data and set working directory
unzip("Samsungdata.zip")
setwd("./UCI HAR Dataset")

# Start with reading of training files
subjecttrain<-read.table("./train/subject_train.txt",header=FALSE)
xtrain<-read.table("./train/X_train.txt",header=FALSE)
ytrain<-read.table("./train/y_train.txt",header=FALSE)

# Read feature and activity type table
features<-read.table("./features.txt",header=FALSE)
activity<-read.table("./activity_labels.txt",header=FALSE)

# Label data correctly
colnames(subjecttrain)<-c("subjectID")
colnames(activity)<-c("activityID", "activitytype")
colnames(features)<-c("featureID", "feature")
colnames(xtrain)<-features[,2]
colnames(ytrain)<-"activityID"

# Merge tables using cbind
mergedtrain<-cbind(subjecttrain,ytrain,xtrain)

# Remove unused data
rm(subjecttrain,ytrain,xtrain)

# Do the same again with test data
subjecttest<-read.table("./test/subject_test.txt",header=FALSE)
xtest<-read.table("./test/X_test.txt",header=FALSE)
ytest<-read.table("./test/y_test.txt",header=FALSE)

# Label data correctly
colnames(subjecttest)<-c("subjectID")
colnames(xtest)<-features[,2]
colnames(ytest)<-"activityID"

# Merge tables using cbind
mergedtest<-cbind(subjecttest,ytest,xtest)

# Remove unused data
rm(subjecttest,ytest,xtest)

# Merge the test and train datasets using rbind
fulldataset<-rbind(mergedtrain,mergedtest)

# Remove unused data
rm(mergedtrain,mergedtest)

# Find columns with mean and std in it
meanandstdfeatures<-grep("-(mean|std)\\(\\)",features[,2])

# Add two to account for the first two columns of the full dataset
meanandstdfeatures<-meanandstdfeatures+2

# Select only initial columns or mean and std features
fulldataset<-fulldataset[,c(1:2,meanandstdfeatures)]

# Merge activity names 
fulldataset<-join(fulldataset,activity)

# Replace the numbers in column activityID with the description
fulldataset$activityID<-fulldataset$activitytype

# Remove activity type column
fulldataset$activitytype<-NULL

# Create the table with the average data
averagedata<-ddply(fulldataset,.(subjectID,activityID),function(x)colMeans(x[,3:68]))

# Write the table
write.table(averagedata,"./tidyData.txt",row.names=TRUE,sep='\t')