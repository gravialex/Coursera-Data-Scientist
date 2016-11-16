library(datasets)
data(iris)

#mean(iris [iris$Species == "virginica" ,], iris$Sepal.Length)

iris_v <- iris [iris$Species == "virginica" ,]
summary (iris_v)

# 1. BUT need round
round (mean (iris_v$Sepal.Length), digits = 0)


# 2. Ok
apply(iris[, 1:4], 2, mean)


# 3. Exept - with(mtcars, tapply(mpg, cyl, mean))   !!!  ???
library(datasets)
data(mtcars)

sapply(split(mtcars$mpg, mtcars$cyl), mean) 
tapply(mtcars$mpg, mtcars$cyl, mean)
tapply(mtcars$cyl, mtcars$mpg, mean)

apply(mtcars, 2, mean)
sapply(mtcars, cyl, mean)

tapply(mtcars$hp, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))
mean(mtcars$mpg, mtcars$cyl)
lapply(mtcars, mean)
split(mtcars, mtcars$cyl)
# 4. Right BUT need round
x <- 209.21429 - 82.63636
round(x, digits = 0)


debug(ls)
ls()
# NOT: You will be prompted to specify at which line of the function you would like to suspend execution and enter the browser.
# Will try : Execution of 'ls' will suspend at the beginning of the function and you will be in the browser.