
library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Set Iris size"),
  
  # Sidebar with a slider input for size of Iris
  sidebarLayout(
    sidebarPanel(
       sliderInput("my_petal_length",
                   "Petal.Length:",
                   min = 0,
                   max = 8,
                   value = 1,
                   step = 0.1),
       sliderInput("my_petal_width",
                   "Petal.Width:",
                   min = 0,
                   max = 3,
                   value = 1,
                   step = 0.1),
       sliderInput("my_sepal_length",
                   "Sepal.Length:",
                   min = 4,
                   max = 8,
                   value = 5,
                   step = 0.1),
       sliderInput("my_sepal_width",
                   "Sepal.Width:",
                   min = 2,
                   max = 5,
                   value = 3,
                   step = 0.1) ,
       h5("Set Iris Petal and Sepal size to predict Species. Also you can see training data on the charts with place (green point) of input values.
          Each time when you change the values the Species will be predicted with help of Random Forest model.")
    ),
    
    # Show a server calculations with charts
    mainPanel(
       h3(textOutput("text1")),
       plotOutput("PetalPlot"),
       plotOutput("SepalPlot")
       
       
    )
  )
))
