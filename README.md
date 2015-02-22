Assumptions:
  1 - The analysis was performed in R (v3.1.2)
  2 - The script run_analysis.R asumes that the Samsung data is available
      in the working directory in an unzipped UCI HAR Dataset folder.
  3 - The package 'sqldf' is installed.

Note:
  This file is an overview of the analysis. It may contain some implementation
  details but please note that the intended purpose is to explain how the analysis
  was done. The implementation details (programing explanations) are mentioned in
  the run_analysis.R file as comments. 
  
Analysis Overview:
  We were required to include the following in the analysis:
    1 - Merges the training and the test sets to create one data set.
    2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
    3 - Uses descriptive activity names to name the activities in the data set
    4 - Appropriately labels the data set with descriptive variable names. 
    5 - From the data set in step 4, creates a second, independent tidy data set with the average
        of each variable for each activity and each subject.

  The data given in the UCI HAR Dataset Folder was used in the analysis. Note that notall the
  datasets were used, only those files were included which I thought to be helpfull in the
  required analysis.

Steps of the script:
The analysis script performs the following steps:
01 - Load all the required files
02 - Merge the test and traing sets
03 - Extract those columns which is either mean or standard deviation
04 - 
