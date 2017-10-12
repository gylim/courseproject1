# Code Book
## Content
1. Data
2. Transformations
3. Variables
## Data
Raw data was taken from the "Human Activity Recognition Using Smartphones Dataset Version 1.0" as made available via https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. For more information on how the experimental data was obtained, please refer to the README.txt in the zip file.
## Transformations
### Importing Data
Raw data was loaded into R primarily using `read.table()`. Column names for measurements were derived by reading "features.txt" into the R object `featurenames` and subsetting the second column when reading in the test and training data. Columns for `subject` and `activity` were appended to the left of the training and test data sets by calling `cbind()`.
### Merging Data
The training and test data sets were then merged using `rbind()` to create a single data frame `rawcon`
### Processing
1. Activity labels from "activity_labels.txt" were cleaned up with `tolower()` and `sub()` before replacing the activity numbers in the `rawcon$activity` with descriptive labels e.g. walking, laying etc. by using `factor()`
2. `subject`, `activity` and other columns containing mean or standard deviation data were sub-setted from `rawcon` using `select()` to generate a smaller data.frame `meansd`
3. Variable names in `meansd` were cleaned up using `mgsub()` (to expand abbreviations) and `gsub()` (to remove the period "." character) and the resultant data.frame written with `write.table()` to "tidydata.txt"
4. An independent data.frame is generated from `meansd` by using the `aggregate()` function to group the data by `subject` and `activity` before applying the `mean()` function to remaining columns to generate `newdataset`, which is printed to "tidydata2.txt" with `write.table()`.
**The pipe operator `%>%` was not used as the `qdap` package masks the function of the operator.**
## Variables
Out of the original 561 measurements done on the experiment's subjects for the various activities, only those measurements for which a mean or standard deviation were calculated are available in this dataset, a total of 79 measurements not including the `subject` and `activity` columns used to separate the data. Variables with the angle between two vectors were omitted as these values were taken to be irrelevant to the required scope of the assignment. For more information on how each measurement was collected or calculated, please refer to "features_info.txt" in the "./UCI HAR Dataset/" directory.
### subject
Identity of the group of volunteers, numeric with a range of 1 to 30.
### activity
Type of activity undertaken by each volunteer; factor variable with 6 levels: walking, walkingupstairs, walkingdownstairs, sitting, standing and laying.
### Remaining measurements
All remaining measurements in `tidydata.csv` are identical with that found in the original dataset, with column names expanded and additional symbols removed for better readability. In `tidydata2.csv` column averages are taken for each measurement, grouped by `subject` and `activity`, but naming conventions are identical as with `tidydata.csv` A table of the substitutions made is shown below:

Original Dataset | tidydata.csv/tidydata2.csv 
---------------- | ---------------------------
f                | frequency
t                | time
Acc              | Accelerometer
BodyBody         | Body
Gyro             | Gyroscope
Mag              | Magnitude

Comparison between the some of the old and new names after cleaning up is shown below:

Original Dataset           | tidydata.csv/tidydata2.csv 
-------------------------- | -----------------------------------
tBodyAcc-mean()-X/Y/Z      | timeBodyAccelerometermeanX/Y/Z
tBodyAcc-std()-X/Y/Z       | timeBodyAccelerometerstdX/Y/Z
tGravityAcc-mean()-X/Y/Z   | timeGravityAccelerometermeanX/Y/Z
tGravityAcc-std()-X/Y/Z    | timeGravityAccelerometerstdX/Y/Z
tBodyAccJerk-mean()-X/Y/Z  | timeBodyAccelerometerJerkmeanX/Y/Z
tBodyAccJerk-std()-X/Y/Z   | timeBodyAccelerometerJerkstdX/Y/Z
tBodyGyro-mean()-X/Y/Z     | timeBodyGyroscopemeanX/Y/Z
tBodyGyro-std()-X/Y/Z      | timeBodyGyroscopestdX/Y/Z
tBodyGyroJerk-mean()-X/Y/Z | timeBodyGyroscopeJerkmeanX/Y/Z
tBodyGyroJerk-std()-X/Y/Z  | timeBodyGyroscopeJerkstdX/Y/Z
tBodyAccMag-mean()         | timeBodyAccelerometerMagnitudemean
tBodyAccMag-std()          | timeBodyAccelerometerMagnitudestd
tGravityAccMag-mean()      | timeGravityAccelerometerMagnitudemean
tGravityAccMag-std()       | timeGravityAccelerometerMagnitudestd
tBodyAccJerkMag-mean()     | timeBodyAccelerometerJerkMagnitudemean