
The process of getting and cleaning data is as followed:

# download and upzip data:
```R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"smartphone.zip",mode = "wb")
unzip("smartphone.zip")
```

# cleaning data and export a tidy dataset using run_analysis.R

- Merges the training and the test sets to create one data set.In this step, we read the data from UCI HAR Dataset folder for both training and testing dataset. We create the training and testing dataset by combinding the label-data, subject-data, and the feature data from "y_train.txt","subject_train.txt" and "X_train.txt". We combine the train and test data into one dataset call data_merged.We assign the feature names to the feature columns variable using the info in "features.txt".
  
- Extracts only the measurements on the mean and standard deviation for each measurement. We select the column containing only mean and std information and store the new data frame in data_measured. 
  
- Uses descriptive activity names to name the activities in the data setWe rename the acitivity index to activity names following "activity_labels.txt".
  
- Appropriately labels the data set with descriptive variable names. We rename the variable name to the full name to make the names more readable.

- From the data set in the last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject called "tidy_data.txt"

