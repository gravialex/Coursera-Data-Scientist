library(caret)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

dim(vowel.train) ; dim(vowel.test)
str(vowel.train) 
head(vowel.train)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
mod_rf <- train(y ~ ., data = vowel.train, method = "rf")
mod_gbm <- train(y ~ ., data = vowel.train, method = "gbm")
pred_rf <- predict(mod_rf, vowel.test)
pred_gbm <- predict(mod_gbm, vowel.test)

# Extract accuracies for (1) random forests and (2) boosting
confusionMatrix(pred_rf, vowel.test$y)$overall[1]
confusionMatrix(pred_gbm, vowel.test$y)$overall[1]


pred_id <- (pred_rf == pred_gbm)
confusionMatrix(vowel.test$y[pred_id], pred_gbm[pred_id])$overall[1]  # не точно , должно быть 0.63

