library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

dim(vowel.train); dim(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)

library(randomForest)
modvowel <- randomForest(y ~ ., data = vowel.train)
order(varImp(modvowel), decreasing = T)
