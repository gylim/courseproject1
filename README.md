# courseproject1
## Introduction
There are a total of 3 files in this repo:
1. README.md - This file, which explains what each of the files contains or does.
2. CodeBook.md - The codebook for the data, describing the variables, the data, and the transformations performed to clean up the data.
3. run_analysis.R - The R script used to clean up data and write two files:
  a. A tidy, merged data set named "tidydata.csv" containing only measurements of the mean or standard deviation for each measurement
  b. An independent data set "tidydata2.csv" containing averages of each measured variable grouped by activity and subject

## Running the Script
**Pre-requisites:**
* The data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip must be downloaded and unzipped to a folder named "UCI HAR Dataset" within the working directory
* dplyr, readr and qdap packages must be installed beforehand. Run ` install.packages(c("readr","qdap","dplyr"))` if necessary.  
After ensuring that the raw data has been downloaded into the correct sub-directory within the working directory, source the script into R and run it.
