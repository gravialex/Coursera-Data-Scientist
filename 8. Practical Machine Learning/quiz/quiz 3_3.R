library(pgmm)
data(olive)
olive = olive[, -1]

str(olive)
dim(olive)

treeModel <- train(Area ~ ., data=olive, method="rpart")
print(treeModel$finalModel)
plot(treeModel$finalModel)

newdata = as.data.frame(t(colMeans(olive)))

predict(treeModel, newdata)
# 2.875. It is strange because Area should be a qualitative  
# variable - but tree is reporting the average value of Area as  
# a numeric variable in the leaf predicted for newdata 
