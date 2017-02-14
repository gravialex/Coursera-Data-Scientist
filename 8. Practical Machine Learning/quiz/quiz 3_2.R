library(AppliedPredictiveModeling)
data(segmentationOriginal)
suppressMessages(library(caret))

inTrain <- createFolds(y = segmentationOriginal$Case, k = 10, list = TRUE) # 60% training


sapply(inTrain, length)
training <- segmentationOriginal[inTrain, ]
testing <- segmentationOriginal[-inTrain, ]
dim(training)
dim(testing)

Question 2

If K is small in a K-fold cross validation is the bias in the estimate of out-of-sample (test set) accuracy smaller or bigger? If K is small is the variance in the estimate of out-of-sample (test set) accuracy smaller or bigger. Is K large or small in leave one out cross validation?

Solution: 
    The bias is larger and the variance is smaller. Under leave one out cross validation K is equal to the sample size.
