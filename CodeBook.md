# Codebook - Getting and Cleaning Data

## Description

This codebook contains information about variables, their definitions, data, and transformations on the data.

## Data source

A description of the data used in this project can be found at <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">The UCI Machine Learning Project</a>.

The source data can be downloaded from <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">here</a>.

## Dataset Information

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its
embedded accelerometer and gyroscope, we captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 
70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by 
applying noise filters and then sampled in fixed-width sliding windows 
of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 
signal, which has gravitational and body motion components, was separated 
using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time 
and frequency domain. 

Check the README.txt file for further details about this dataset.

## Attribute Information

For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

## Citing Data

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Transformation Details (from run_analysis.R)

Section 1 merges the training and the test sets to create one data set.
Section 2 extracts only the measurements on the mean and standard deviation for each measurement.
Section 3 uses descriptive activity names to name the activities in the data set
Section 4 appropriately labels the data set with descriptive activity names.
Section 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Transformation Methods

Section 1
* Load the features and activities labels
* Load the training data, name columns
* Cbind the training data
* Load the test data, name columns
* Cbind the test data
* Rbind the training and test data

Section 2
* Create logical vector that assigns TRUE for ID, mean, and stdev columns or FALSE for anything else
* Subset by the logical vector == TRUE

Section 3
* Merge the final dataset with activity type and update column names

Section 4
* Assign descriptive column names to final dataset

Section 5
* Create tidy data set to include just the means and write to table

