data_features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
data_features <- as.character(data_features[,2])

data_train.X <- read.csv('./UCI HAR Dataset/train/X_train.txt',sep='', header = FALSE)
data_train.Y <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE)
data_train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)

data_train <-  data.frame(data_train.subject, data_train.X, data_train.Y)
names(data_train) <- c('subject', data_features, 'activity')

data_test.X <- read.csv('./UCI HAR Dataset/test/X_test.txt',sep='', header = FALSE)
data_test.Y <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE)
data_test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)

data_test <- data.frame(data_test.subject, data_test.X, data_test.Y)
names(data_test) <- c('subject', data_features, 'activity')

# Merges the training and the test sets to create one data set.
data_merged <- rbind(data_train, data_test)
# Extracts only the measurements on the mean and standard deviation for each 
# measurement.
select_feature <- grep('mean|std', data_features, value = TRUE)
data_measure <- data_merged[,c('subject',select_feature,'activity')]
# Uses descriptive activity names to name the activities in the data set
activity_names <- read.csv('./UCI HAR Dataset/activity_labels.txt',
                           header = FALSE, sep = ' ')
activity_names <- as.character(activity_names[,2])
data_measure$activity <- activity_names[data_measure$activity]
# Appropriately labels the data set with descriptive variable names.
data_names <- names(data_measure)
data_names <- gsub("[(][])]","",data_names)
data_names <- gsub("^t", "Time-",data_names)
data_names <- gsub("^f","Frequency-", data_names)
data_names <- gsub("Acc","Accelerometer", data_names)
data_names <- gsub("Gyro","Gyroscope", data_names)
data_names <- gsub("Freq","Frequency", data_names)
data_names <- gsub("Mag","Magnitude", data_names)
names(data_measure) <- data_names
# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
tidy_data <- aggregate(data_measure[,data_names[-c(1, length(data_names))]], 
                       by = list(activity = data_measure$activity, 
                                 subject = data_measure$subject),
                       FUN = mean)
write.table(tidy_data,"tidy_data.txt")