## Getting and Cleaning Data: Course Project

# Creates one R script called run_analysis.R that executes the following on the UCI HAR data set:
# 1. Merges the training and the test data sets to create one data set.
# 2. Extracts only the mean and standard deviation measurements for each measurement. 
# 3. Usilizes descriptive activity names to name the activities in the new data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in created in the above steps, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library(dplyr)

# Set working directory
setwd('C:/Coursera/gettingandcleaningdata_cp');


## 1
# Read in the data from files
features = read.table('./features.txt',header=FALSE)
activity_type = read.table('./activity_labels.txt',header=FALSE)
subject_train = read.table('./train/subject_train.txt',header=FALSE)
x_train = read.table('./train/x_train.txt',header=FALSE)
y_train = read.table('./train/y_train.txt',header=FALSE)

# Assigin column names to the data
colnames(activity_type) = c('activityId','activityType')
colnames(subject_train) = "subjectId"
colnames(x_train) = features[,2]
colnames(y_train) = "activityId"

# Merge y_train subject_train and x_train to create the final training dataset
training_data = cbind(y_train,subject_train,x_train)

# Read in the test data
subject_test = read.table('./test/subject_test.txt',header=FALSE)
x_test = read.table('./test/x_test.txt',header=FALSE)
y_test = read.table('./test/y_test.txt',header=FALSE)

# Assign column names to the test data imported above
colnames(subject_test) = "subjectId"
colnames(x_test) = features[,2]
colnames(y_test) = "activityId"

# Merge x_test y_test and subject_test to create the final test dataset
test_data = cbind(y_test,subject_test,x_test)

# Merge training and test datasets to create a final data set
final_data = rbind(training_data,test_data)

# Create a col_names vector from the final_data
col_names = colnames(final_data);


## 2
# Create a logical Vector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
log_vec = (grepl("activity..",col_names) | grepl("subject..",col_names) | grepl("-mean..",col_names) & !grepl("-meanFreq..",col_names) & !grepl("mean..-",col_names) | grepl("-std..",col_names) & !grepl("-std()..-",col_names))

# Subset final_data table based on the logical vector
final_data = final_data[log_vec==TRUE]


## 3
# Merge final_data set with acitivity_type
final_data = merge(final_data,activity_type,by='activityId',all.x=TRUE)

# Update column names
col_names = colnames(final_data) 


## 4 

for (i in 1:length(col_names)) 
{
    col_names[i] = gsub("\\()","",col_names[i])
    col_names[i] = gsub("-std$","StdDev",col_names[i])
    col_names[i] = gsub("-mean","Mean",col_names[i])
    col_names[i] = gsub("^(t)","time",col_names[i])
    col_names[i] = gsub("^(f)","freq",col_names[i])
    col_names[i] = gsub("([Gg]ravity)","Gravity",col_names[i])
    col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_names[i])
    col_names[i] = gsub("[Gg]yro","Gyro",col_names[i])
    col_names[i] = gsub("AccMag","AccMagnitude",col_names[i])
    col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_names[i])
    col_names[i] = gsub("JerkMag","JerkMagnitude",col_names[i])
    col_names[i] = gsub("GyroMag","GyroMagnitude",col_names[i])
}

# Assign descriptive column_names to final_data
col_names = colnames(final_data)


## 5
# Remove activity type column
fdnoact = final_data[,names(final_data) != 'activityType']

# Summarize fdnoact table to include just the mean of each variable
tidy_data = aggregate(fdnoact[,names(fdnoact) != c('activityId','subjectId')],by=list(activityId = fdnoact$activityId,subjectId = fdnoact$subjectId),mean)

# Merge tidy_data with activity_type
tidy_data = merge(tidy_data,activity_type,by='activityId',all.x=TRUE)

# Export the tidy_data set 
write.table(tidy_data, './tidy_data.txt',row.names=TRUE,sep='\t')
