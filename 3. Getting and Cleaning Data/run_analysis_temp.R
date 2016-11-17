##  Clear all variables
rm(list = ls(all = TRUE))

#configure working directory 
#getwd() 
setwd('./UCI HAR Dataset/')

# Step 1
# Merge test and training data sets

# Import data from files
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Read data descriptions from files 
features  <- read.table('./features.txt',header=FALSE)
activity_labels <- read.table('./activity_labels.txt',header=FALSE)

# Assigin column names to the data 
colnames(activity_labels) <- c('activityId','activityType') 
colnames(subject_test) <- "subjectId" 
colnames(X_test) <- features[,2]  
colnames(y_test) <- "activityId" 
colnames(subject_train) <- "subjectId" 
colnames(X_train) <- features[,2]  
colnames(y_train) <- "activityId"

# Create final test and training data sets
test_data <- cbind(y_test,subject_test,X_test)
train_data <- cbind(y_train,subject_train,X_train)

# Merge the training and the test sets to create one data set
merged_data <- rbind(test_data , train_data)

# check result
col_names <- colnames(merged_data)
col_names
nrow(merged_data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Create logical vector with TRUE values for mean & std  and FALSE for all others
name_vector <- grepl ("mean\\(\\)", col_names) | grepl ("-std\\(\\)", col_names)

# check names in vector
summary (name_vector)
colnames (merged_data[name_vector == TRUE])

# get subset with required column names
# and add first two columns ( activityId & subjectId )
merged_data_2 <- cbind(merged_data[,1:2], merged_data[name_vector == TRUE])
str(merged_data_2)

# 3. Use descriptive activity names to name the activities in the data set
# Merge the merged_data_2 set with the activity_labels table to add activity names 
merged_data_3 <- merge(merged_data_2,activity_labels,by="activityId",all.x=TRUE) 
col_names_3 <- colnames(merged_data_3)
str(merged_data_3)

# 4. Appropriately labels the data set with descriptive variable names. 
# Cleaning column names

    names(merged_data_3) <- gsub("\\()","",names(merged_data_3)) 
    names(merged_data_3) <- gsub("-std","_StdDev",names(merged_data_3)) 
    names(merged_data_3) <- gsub("-mean","_Mean",names(merged_data_3)) 
    names(merged_data_3) <- gsub("^(t)","time_",names(merged_data_3)) 
    names(merged_data_3) <- gsub("^(f)","freq_",names(merged_data_3)) 
    names(merged_data_3) <- gsub("BodyBody","Body",names(merged_data_3)) 
    names(merged_data_3) <- gsub("Mag","Magnitude",names(merged_data_3))
    names(merged_data_3) <- gsub("Acc","Accelerometer",names(merged_data_3))

names(merged_data_3)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# copy data to tidy data set final_data  with reodering columns (set activityType as the first column)

final_data <- merged_data_3 [c(length(merged_data_3), 1, 3:length(merged_data_3)-1)] 
colnames(final_data)
# Agregate the final_data table to include the average of each variable for each activity and each subject
library(plyr)
final_data <- aggregate( . ~activityType+activityId+subjectId, final_data , FUN=mean) 

str(final_data)

write.table(final_data, file = "tidydata.txt",row.name=FALSE)

## create codebook

