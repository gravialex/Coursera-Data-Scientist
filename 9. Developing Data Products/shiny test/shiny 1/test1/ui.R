#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("My Shiny App"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(img(src = "Zombie.jpg", height = 152, width = 212),
                 selectInput("var", 
                             label = "Choose a variable to display",
                             choices = c("Percent White", "Percent Black",
                                         "Percent Hispanic", "Percent Asian"),
                             selected = "Percent White") ,
                 sliderInput("range", 
                             label = "Range of interest:",
                             min = 0, max = 100, value = c(0, 100)) 
    ),
    mainPanel(     
    )
    
    )
    

  )
)

