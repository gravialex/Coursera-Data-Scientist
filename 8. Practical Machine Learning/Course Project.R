library(caret)
library(corrplot)

# 1. import the data from the URLs
training_dat = read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv" , na.strings = c("NA", ""))
test_dat = read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", na.strings = c("NA", ""))

# Exploring Data Analysis

dim(training_dat) ; dim(test_dat)
str(training_dat)
table(training_dat$classe)


# Cleaning the data
# There are further unnecessary columns that can be removed. The column  X  contains the row numbers. The column  user_name  contains the name of the user. Of course, these variables cannot predictors for the type of exercise.

# Furthermore, the three columns containing time stamps ( raw_timestamp_part_1 ,  raw_timestamp_part_2 , and  cvtd_timestamp ) will not be used.

# The factors  new_window  and  num_window  are not related to sensor data. They will be removed too.

# # Remove Near Zero Values columns

training_subdat <- training_dat[ , names(training_dat)[!nearZeroVar(training_dat, saveMetrics=TRUE)$nzv]]
str(training_subdat)

# Remove columns with NA
colsNAs <- colMeans(is.na(training_subdat))
indx <- !colsNAs
training_subdat <- training_subdat[indx]

str(training_subdat)

# remove columns which aren't predictors:
# x ( unique row ID ) ,
# user_name , raw_timestamp_part_1 , raw_timestamp_part_2 , cvtd_timestamp, num_window
training_subdat <- training_subdat[, -c(1:6)]
dim(training_subdat)

# split the training set into two for cross validation purposes. Use the caret 
# to randomly subsample 75%  for training set and 25% to testing set.
# 2. Split data to testing and training sets
inTrain = createDataPartition(training_subdat$classe, p = 0.75)[[1]]
training = training_subdat[inTrain, ]
testing = training_subdat[-inTrain, ]
dim(training) ; dim(testing)



# remove those variable which have high correlation

descrCorr <- cor(training[, 1:52])


highCorr <- findCorrelation(descrCorr, 0.90)
training <- training[, -highCorr]
testing <- testing[, -highCorr]


# 3. Prediction modeling
# set seed
set.seed(12345)

# Setting the parameters for model preprocessing 
fitControl <- trainControl(method = "cv", 
                           number = 5, 
                           repeats = 3 , 
                           preProcOptions="pca")

# training models
fit_rf <- train(classe ~ ., method = "rf", data = training , trControl = fitControl )
fit_lda <- train(classe ~ ., method = "lda",  data = training)
fit_boosted <- train(classe ~ ., method = "gbm",  data = training , trControl = fitControl)
fit_nb <- train(classe ~ ., method = "nb",  data = training , trControl = fitControl)

# test models 
prediction_rf <- predict(fit_rf, testing)
prediction_boosted <- predict(fit_boosted, testing)
prediction_lda <- predict(fit_lda, testing)
prediction_nb <- predict(fit_nb, testing)



# Measuring Models Accuracy

Accuracy <- c(confusionMatrix(prediction_rf, testing$classe)$overall[1],
              confusionMatrix(prediction_boosted, testing$classe)$overall[1],
              confusionMatrix(prediction_lda, testing$classe)$overall[1],
              confusionMatrix(prediction_nb, testing$classe)$overall[1])
ModelType <- c("Random Forest","Boosted Tree","Linear Discriminant","Naive Bayes")
PerformanceTable <- data.frame(ModelType,Accuracy)
PerformanceTable

# Out-of Sample Accuracy for Random Forest
confusionMatrix(prediction_rf, testing$classe)
# Next we predict the classe category for the 15 test cases from the test dataset using Random Forest model
plot(varImp(fit_rf) , top = 15 , main="Top 15 the most importance variebles")

# Making Predictions

predictions <- predict(fit_rf, test_dat)

# Conclusion
test_dat [,c("user_name","raw_timestamp_part_1","raw_timestamp_part_2", "cvtd_timestamp", "num_window","classe")]
table(test_dat$classe)




