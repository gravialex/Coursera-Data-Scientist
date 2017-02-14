library(AppliedPredictiveModeling)
data(segmentationOriginal)
suppressMessages(library(caret))

inTrain <- createDataPartition(y = segmentationOriginal$Case, p = 0.6, 
                               list = FALSE) # 60% training

training <- segmentationOriginal[inTrain, ]
testing <- segmentationOriginal[-inTrain, ]
# 2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings. (The outcome class is contained in a factor variable called Class with levels "PS" for poorly segmented and "WS" for well segmented.)
set.seed(125)
modFit <- train(Class ~ ., method = "rpart", data = training)

print(modFit$finalModel)
plot(modFit$finalModel)
text(modFit$finalModel, cex=.8)

inTrain <- segmentationOriginal$Case == "Train" 
trainData <- segmentationOriginal[inTrain, ] 
testData <- segmentationOriginal[!inTrain, ]

dim(trainData)
dim(testData)
dim(training)
dim(testing)
