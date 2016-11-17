library(knitr) 
library(ggplot2) 
library(datasets) 

# clear environment variable 
rm(list=ls(all=TRUE)) 

###  Exploratory Data Analysis
# Take a look at what the datasets consists of 
head(mtcars) 
summary(mtcars)


# Convert the categorical variables into factors 
# We don't transform vs and am as factor because they only have a 2-state value 
mtcars$cyl <- factor(mtcars$cyl) 
mtcars$gear <- factor(mtcars$gear) 
mtcars$carb <- factor(mtcars$carb) 

str(mtcars)



#The dataset has 32 observations of 11 variables. We will do a quick analysis on the variables 
#to gain some insight on the distribution of mpg and the two modes of transmission.
summary(mtcars$mpg)

# We mainly focus on the relationship between variables mpg (Miles/(US) gallon) and am (Transmission). Box plot shows that there's a good separation of groups based on gas mileage.
boxplot(mpg ~ am, data = mtcars, col = "orange",  xlab = "Transmission (0 = automatic, 1 = manual)" , ylab="MPG",
        main="Boxplot of MPG vs. Transmission")

#### Regression model
# Distribution of Manual and Automatic transmission Vehicles.

full_model <- lm(mpg ~ ., data = mtcars)
best_model <- step(full_model, direction = "both")

## The best model obtained from the above computations consists of the variables, cyl, wt and hp as confounders and am as the independent variable. Details of the model are depicted below.
summary(best_model)

# From the above model details, we observe that the adjusted \(R^2\) value is 0.84 which is the maximum obtained considering all combinations of variables. Thus, we can conclude that more than 84% of the variability is explained by the above model.

# In the following section, we compare the base model with only am as the predictor variable and the best model which we obtained earlier containing confounder variables also.

base_model <- lm(mpg ~ am, data = mtcars)
anova(base_model, best_model)

# Looking at the above results, the p-value obtained is highly significant and we reject the null hypothesis that the confounder variables cyl, hp and wt don’t contribute to the accuracy of the model.

## Residuals
par(mfrow = c(1, 1))
plot(best_model)

leverage <- hatvalues(best_model)
tail(sort(leverage),3)


t.test(mpg ~ am, data = mtcars)
