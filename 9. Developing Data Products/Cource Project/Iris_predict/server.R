
library(shiny)
library(caret)
library(randomForest)
library(ggplot2)
data("iris")

# build random forest model 
set.seed(1234)
rf <- randomForest(Species ~ ., iris)

shinyServer(function(input, output) {

# reactive for predict Species for input values     
  dataPredict <- reactive({
      new_data <- expand.grid (
          Sepal.Length=input$my_sepal_length, 
          Sepal.Width=input$my_sepal_width ,
          Petal.Length=input$my_petal_length,
          Petal.Width=input$my_petal_width )
      
      my_predict <- predict(rf, new_data)
      my_Species <- as.character( my_predict)
      print(my_Species) })
  
# plot charts    
  output$PetalPlot <- renderPlot({
      
      p <-  ggplot(data=iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
          geom_point(size = 3) +
          ggtitle("Iris distribution by Petal size")+ 
          theme(   plot.title = element_text(color="azure4", size=18, face="bold.italic"))
 # add point with input values
      p <- p +
          geom_point( x = input$my_petal_length, y = input$my_petal_width ,colour = "black" , fill='green' ,size = 7 , shape = 21 )
      print(p)
    
  }) 

  output$SepalPlot <- renderPlot({  
  pp <-  ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point(size = 3) +
      ggtitle("Iris distribution by Sepal size")+ 
      theme(   plot.title = element_text(color="azure4", size=18, face="bold.italic"))
  # add point with input values  
  pp <- pp +
      geom_point( x = input$my_sepal_length, y = input$my_sepal_width ,colour = "black" , fill='green' ,size = 7 , shape = 21 )
  print (pp)
  }) 

# output predicted value for Species    
  output$text1 <- renderText({
      str1 <- paste("Predicted Iris Species : ", dataPredict())
      print(str1)
      
  })
  

})
