# Slide 1

library(caret)
library(randomForest)
library(ggplot2)

data("iris")
head(iris)


# Split data to testing and training sets
set.seed(1234)
inTrain = createDataPartition(iris$Species, p = 0.8)[[1]]
training = iris[inTrain, ]
testing = iris[-inTrain, ]

rf <- randomForest(Species ~ ., training)
predictions <- predict(rf, testing)

# The most importance variebles
importance(rf)

table(predictions, testing$Species)
print(rf)

new_data <- expand.grid (Sepal.Length=3, Sepal.Width=4 ,Petal.Length=1.3,Petal.Width=0.2 )
my_predict <- predict(rf, new_data)
my_Species <- as.character( my_predict)


# Slide 3 ( reaction )


p <-  ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
    geom_point(size = 3) +
    ggtitle("Iris distribution by Petal size")+ 
    theme(   plot.title = element_text(color="blue", size=14, face="bold.italic"))



# set point on the chart with my values of Petal.Length and Petal.Width
p <- p +
    geom_point( x = 1.3, y = 0.4 ,colour = "black" , fill='green' ,size = 7 , shape = 21 )
print (p)

pp <-  ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
    geom_point(size = 3) 
print (pp)