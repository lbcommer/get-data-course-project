---
title: "README.md"
output: html_document
author: lbcommer
date: "18/08/2015"
---

# Introduction

This repository correspond to Coursera ["Getting and Cleaning Data"](https://www.coursera.org/course/getdata) course project. 

The data used in this project can be downloaded here
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Course project says:
```
You should create one R script called run_analysis.R that does the following. 

1. You should create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```

Repository contains this:

* run_analysis.R script
* CodeBook.md : code book with data variables description
* dataset.txt : file with tidy data set created in step 5 of course project  

# Script run_analysis.R

## Requierements 

* dplyr package must be installed in the enviroment
* data for the course project must be downloaded and unziped:
so, a directory "UCI HAR Dataset" must be in the same working directory than run_analysis.R script. 

This is the structure directory with the files used by the script:

```
 +-- run_analysis.R
 |
 +-- UCI HAR Dataset
     |
     +-- features.txt
     |
     +-- activity_labels.txt
     |
     +-- test
     |    |
     |    -- y_test.txt
     |    |
     |    -- X_test.txt
     |    |
     |    -- subject_test.txt        
     +-- train
         |
         -- y_test.txt
         |
         -- X_test.txt
         |
         -- subject_test.txt          
```

## Script explanation 

run_analysis.R code is full commented itself. It does not requiere any parameter and can be excuted in this way:

```
source("run_analysis.R")
```

Script execution produces this variable asignation:

* data1: dataset created in step 1 of the course project instructions
* data2: dataset created in step 2 of the course project instructions
* data3: dataset created in step 3 of the course project instructions
* data4: dataset created in step 4 of the course project instructions
* data5: dataset created in step 5 of the course project instructions


### data1 (step 1)

"run_analysis.R" combine test and train data. Subject and Activity variables are added as columns

### data2 (step 2)

We keep only feature variables with "main()" or "std()" contained in its name. 

### data3 (step 3)

Activity factor levels are used instead numbers for activities

### data4 (step 4)

Feature variable names are renamed with this rule:

* "t" at the beginning is expanded to "time"
* "f" at the beginning is expanded to "frecuency"
* "mean()" is changed to "Mean"
* "std()" is changed to "Std"
* "BodyBody" is expanded to "Body"
* "Gyro" is expanded to "Gyroscope"
* "Acc" is expanded to "Accelerometer"
* "Mag" is expanded to "Magnitude"
* "-" chars are removed

### data5 (step 5)

The average (mean function) of each variable for each activity and each subject is calculated
 
# dataset.txt

dataset.txt contains the tidy data created in step 5 of course project (variable data5). It was created with the execution of:

```
write.table(data5, file="dataset.txt", row.names=FALSE)
```


To view dataset.txt this code can be used:

```
data <- read.table("dataset.txt", header = TRUE) 
View(data)
    
```

# References
1. Site where data used in the course project can be downloaded:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>


2. Samsung data used in the course project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>