library(dplyr)
library(readr)
library(qdap)
## Read in the column names for the data and activities
featurenames <- read.table("./UCI HAR Dataset/features.txt", sep = " ", colClasses = c("integer", "character"))
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ", colClasses = c("integer", "character"))
tolower(activitylabels$V2) -> activitylabels$V2
sub("_", "", activitylabels$V2) -> activitylabels$V2

## Read in the test data, subject id and activity labels
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric", col.names = c(featurenames$V2), nrows = 3000)
subjectid <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = "numeric", col.names = "subject")
activitytype <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses = "numeric", col.names = "activity")
testconsolidated <- cbind(subjectid,activitytype,testdata)

## Read in the training data, subject id and activity labels
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric", col.names = c(featurenames$V2), nrows = 7400)
subjectid2 <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = "numeric", col.names = "subject")
activitytype2 <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses = "numeric", col.names = "activity")
trainconsolidated <- cbind(subjectid2,activitytype2,traindata)

## Combine test and training data sets into one
rawcon <- rbind(testconsolidated, trainconsolidated)
## Provide descriptive names for activities
rawcon$activity <- factor(rawcon$activity, labels = activitylabels$V2)
## Select columns with mean and standard deviation data
meansd <- select(rawcon, subject, activity, matches("[Mm]ean|[Ss]td"), -starts_with("angle"))
## Rename and clean up variable names to be more meaningful
patterns <- c("^t{1}","^f{1}", "BodyBody", "Acc", "Gyro", "Mag", "gravity","Freq")
replacements <- c("time", "frequency","Body","Accelerometer", "Gyroscope", "Magnitude", "Gravity","frequency")
names(meansd) <- mgsub(patterns, replacements, names(meansd), fixed = F)
names(meansd) <- gsub(".","",names(meansd), fixed = T)
write_csv(meansd, "./tidydata.csv")

## Group by subject and activity and apply mean function to remaining columns to generate newdataset
newdataset <- aggregate(meansd[,3:81], by = list(subject=meansd$subject , activity=meansd$activity), mean)
write_csv(newdataset, "./tidydata2.csv")