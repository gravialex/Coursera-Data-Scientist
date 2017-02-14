set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[ -inTrain,]
dim(training) ; dim(testing)

set.seed(325)
library(e1071)
library(forecast)

mod_svm <- svm(CompressiveStrength ~ ., data = training)
pred_svm <- predict(mod_svm, testing)

accuracy(pred_svm, testing$CompressiveStrength)
