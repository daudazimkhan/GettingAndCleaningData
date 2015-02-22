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
        This script store the above required dataframe in object: completeData
    2 - Extracts only the measurements on the mean and standard deviation for each measurement.
        This script store the above required dataframe in object: extractedData
    3 - Uses descriptive activity names to name the activities in the data set.
        This script store the above required dataframe in object: combinedData
    4 - Appropriately labels the data set with descriptive variable names.
        This script store the above required dataframe in object: stepFourData
    5 - From the data set in step 4, creates a second, independent tidy data set with the average
        of each variable for each activity and each subject.
        This script store the above required dataframe in object: finalDS

  The data given in the UCI HAR Dataset Folder was used in the analysis. Note that notall the
  datasets were used, only those files were included which I thought to be helpfull in the
  required analysis.

Flow of the script:
The analysis script performs the following steps:
01 - Load all the required files.
02 - Merge the test and traing sets.
03 - Extract those columns which are either mean or standard deviation.
04 - Replaced activities with their descriptive names.
05 - Add subject Number and Activity Performed (Columns) the extracted data.
06 - Label the column names (variables)
07 - Make a dataframe containing the average of each feature for each activity-subject pair. This
      step results in WIDE tidyData which we were required to submit. The data is tidy as it meets
      all the princeples of week1 (Each variable you measure should be in one column, Each different
      observation of that variable should be in a different row).
08 - Unimportant objects are removed and only the following objects are kept:
      a - completeData
      b - extractedData
      c - combinedData
      d - stepFourData
      e - finalDS
