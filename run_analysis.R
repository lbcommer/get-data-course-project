library(dplyr)

# Load feature and activity names
features <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Load test data
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Set variable names for test data
names(testLabels) <- c("activity")
names(testSubject) <- c("subject")

# compound test data
test <- cbind(testSet, testSubject, testLabels)

# Load train data
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Set variable names for train data
names(trainLabels) <- c("activity")
names(trainSubject) <- c("subject")

# compound train data
train <- cbind(trainSet, trainSubject, trainLabels)

# 1. Merges the training and the test sets to create one data set.
data1 <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# we take only variables with mean() or std() in its name (their index position)
meanAndStdColumnIndex <- grep("mean\\(\\)|std\\(\\)", features[,2], value = FALSE)
data2 <- select(data1, c(meanAndStdColumnIndex,subject,activity))

# 3. Uses descriptive activity names to name the activities in the data set

data3 <- mutate(data2, activity=activityLabels[activity,2])

# 4. Appropriately labels the data set with descriptive variable names. 

# The output of step 4 will be stored in data4 variable
data4 <- data3 

# we take only variables with mean() or std() in its name (their name)
meanAndStdColumnNames <- grep("mean\\(\\)|std\\(\\)", features[,2], value = TRUE)

## This function rename a feature variable name to a more descriptive name
renameFeaturesVars <- function (s)
{
    output <- sub("^t", "time", s)
    output <- sub("^f", "frecuency", output)
    output <- sub("\\-mean\\(\\)", "Mean", output)
    output <- sub("\\-std\\(\\)", "Std", output)
    output <- sub("BodyBody", "Body", output)
    output <- sub("Gyro", "Gyroscope", output)
    output <- sub("Acc", "Accelerometer", output)
    output <- sub("Mag", "Magnitude", output)
    output <- sub("\\-", "", output)
    output
}

meanAndStdColumnDescriptiveNames <- renameFeaturesVars(meanAndStdColumnNames)
colnames(data4)[seq(meanAndStdColumnNames)] <- meanAndStdColumnDescriptiveNames


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# we use dplyr with summarise_each function (http://stackoverflow.com/questions/21644848/summarizing-multiple-columns-with-dplyr)
data5 <- data4 %>% group_by(subject, activity) %>% summarise_each(funs(mean))

print(data5)

# we can write result into file dataset.txt with:
# write.table(data5, file="dataset.txt", row.names=FALSE)

