Assumptions:

  1 - The analysis was performed in R (v3.1.2)
  
  2 - The script run_analysis.R asumes that the Samsung data is available
    in the working directory in an unzipped UCI HAR Dataset folder
    
  3 - The package 'sqldf' is installed
  
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

01 -  Load all the required files from "UCI HAR Dataset" folder:

        a - "test\\X_test.txt"
        
        b - "train\\X_train.txt"
        
        c - "test\\Y_test.txt"
        
        d - "train\\Y_train.txt"
        
        e - "test\\subject_test.txt"
        
        f - "train\\subject_train.txt"
        
        g - "features.txt"
        
        h - "activity_labels.txt"

02 -  Merge the test and traing sets.

      X_train data is merged with X_test data by rbind() and stored in object completeData.
      Both X_train data and X_test data have 561 columns. Therefore completeData has 561
      columns. The number of rows in X_train data and X_test data are 7352 and 2947
      respectively. Therefore, completeData has 10299 (7352 + 2947) records.
      
03 -  Extract those columns which are either mean or standard deviation.

      The features.txt has 561 records. These are the features whose measurements are given
      in the completeData. This step extract only those columns which are measurment on
      standard deviation or mean. Here I assume that the required features are those which
      contain a pattern like 'std()' or 'mean()' or 'meanFreq()'. This results in extraction
      of only 79 out of 561 columns. The new dataframe is stored in object: extractedData.
      
04 -  Replace activities with their descriptive names.

      The activity information is given in Y_train and Y_test for X_train and Y_train
      respectively. The script combines them by rbind() to get activity information for
      extractedData. But the information is represented as numbers from 1 to 6. There is
      another file activity_labels which maps activity number to activity description.
      With the help of that file, the activities are replaced with their descriptive names.
      
05 -  Add subject Number and Activity Performed (Columns) the extracted data

      The script combines the dataset subject_train and subject_test  to get subject
      information for each record of the extractedData. Then the columns "Subject Number"
      and "Activity Performed" are added to the extractedData by cbind() and stored in a
      new object combinedData. The combinedData has 81 (79 + 2) columns.
      
06 -  Label the column names (variables)

      Here the script gets the names of the 79 features. Then make them more understandible
      using gsub(). Creates a dataset stepFourData (a copy of combinedData) and label its
      column names with the names returned from gsub(). They are 79 and we have 81 columns.
      Actually, it labels column 1 and column 2 as "SubjectNumber" and "ActivityPerformed"
      respectively and column 3 to 81 as that returned from gsub(). The data of this step
      is in object stepFourData.
      
07 -  Make a dataframe containing the average of each feature for each activity-subject pair

      This step results in a WIDE tidyData which we have to submit. The data is tidy as it
      meets all the princeples of week1 (Each variable you measure should be in one column,
      Each different observation of that variable should be in a different row).
      
08 -  Unimportant objects are removed and only the following objects are kept

        a - completeData
        
        b - extractedData
        
        c - combinedData
        
        d - stepFourData
        
        e - finalDS
