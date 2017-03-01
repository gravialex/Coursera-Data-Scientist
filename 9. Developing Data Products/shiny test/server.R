#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
      if(input$p=='a'){
          i<-1
      }
      
      if(input$p=='b'){
          i<-2
      }
      
      if(input$p=='c'){
          i<-3
      }
      
      if(input$p=='d'){
          i<-4
      }
      
      x    <- iris[, i]
      
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
      
    
  })
  
})
