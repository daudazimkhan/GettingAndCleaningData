# ---------------------------------------------------------------------------------

# Step 01: Merges the training and the test sets to create one data set.

# Step 02: Extracts only the measurements on the mean and standard deviation for
# each measurement.

# Step 03: Uses descriptive activity names to name the activities in the data set.

# Step 04: Appropriately labels the data set with descriptive variable names.

# Step 05: From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

# ---------------------------------------------------------------------------------

# Loading the data sets
testData <- read.table(file = "UCI HAR Dataset\\test\\X_test.txt")
trainData <- read.table(file = "UCI HAR Dataset\\train\\X_train.txt")

testLabels <- read.table(file = "UCI HAR Dataset\\test\\Y_test.txt")
trainLabels <- read.table(file = "UCI HAR Dataset\\train\\Y_train.txt")

testSubjects <- read.table(file = "UCI HAR Dataset\\test\\subject_test.txt")
trainSubjects <- read.table(file = "UCI HAR Dataset\\train\\subject_train.txt")

features <- read.table(file = "UCI HAR Dataset\\features.txt")
activityLabels <- read.table(file = "UCI HAR Dataset\\activity_labels.txt")

# Step 01--------------------------------------------------------------------------
# merging test & training sets
completeData <- rbind(testData,trainData)
# Step 01 resulted in the dataframe named: completeData
# ---------------------------------------------------------------------------------

# getting the row rumbers of all entries which contain std or mean in features Dataframe
library(sqldf)

rownums_std_mean <- sqldf("select V1 from features where V2 like '%std()%' OR V2 like '%mean()%' OR V2 like '%meanFreq()%'")
# The above just returned 79 out of 561 features
rownums_std_mean <- as.numeric(rownums_std_mean[,1])

# Step 02--------------------------------------------------------------------------
# extracting mean & std columns
extractedData <- completeData[,rownums_std_mean]
# Step 02 resulted in the dataframe named: extractedData
# ---------------------------------------------------------------------------------

# Step 03--------------------------------------------------------------------------
# Now replacing each of the activity number with its corresponding descriptive name
activityNumbers <- rbind(testLabels,trainLabels)
activityData <- activityNumbers
for (i in 1:nrow(activityNumbers))
{
        for (j in 1:nrow(activityLabels))
        {
                if (activityNumbers[i,1]==activityLabels[j,1])
                {
                        activityData[i,1] <- as.character(activityLabels[j,2])
                        break
                }
        }
}

# Adding Subject & Activity Column to the extracted dataframe
subjectNumbers <- rbind(testSubjects, trainSubjects)
combinedData <- cbind(subjectNumbers,activityData,extractedData)
# Step 03 resulted in the dataframe named: combinedData
# ---------------------------------------------------------------------------------

# Step 04--------------------------------------------------------------------------
# Labeling the Variables (Column Headings)
columnNames <- as.character(levels(features[rownums_std_mean,2]))[features[rownums_std_mean,2]]
columnNames <- gsub("BodyBody","Body",gsub('-','',gsub('\\()','',columnNames)))

stepFourData <- combinedData
colnames(stepFourData) <- c("SubjectNumber", "ActivityPerformed", columnNames)

# Step 04 resulted in the dataframe named: stepFourData
# ---------------------------------------------------------------------------------

# Step 05--------------------------------------------------------------------------
k <- split(stepFourData, stepFourData[,2])

finalDS <- data.frame(stepFourData[NULL,], row.names=NULL)
colnames(finalDS) <- c("SubjectID","Activity",colnames(finalDS)[3:81])
for (i in 1:6)
{
        for (j in 1:max(k[[i]][[1]]))
        {
                
                finalDS[nrow(finalDS)+1,3:81] <- colMeans(k[[i]][k[[i]][,1]==j,3:81])
                finalDS[nrow(finalDS),1] <- j
                finalDS[nrow(finalDS),2] <- k[[i]][1,2]
        }
}
# Step 05 resulted in the dataframe named: finalDS
# ---------------------------------------------------------------------------------

# Removing intermediate data and keeping just the required data of each step
remove(activityData,activityLabels,activityNumbers,features,subjectNumbers,testData,testSubjects,testLabels,trainData,trainLabels,trainSubjects,columnNames,i,j,k,rownums_std_mean)

# The Following data is kept:
# Step 01: completeData
# Step 02: extractedData
# Step 03: combinedData
# Step 04: stepFourData
# Step 05: finalDS
