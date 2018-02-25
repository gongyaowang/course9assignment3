#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Fun Application"),
  
  # Sidebar  
  sidebarLayout(
    sidebarPanel(
      h3("1. Options to customize the figure"),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title"),

      h3("2. Options to adjust models"),
      checkboxInput("showModel1", "Show/Hide Model 1 line", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2 line", value = TRUE),
      numericInput("noforModel2", "MPG number for Model 2?", 
                   value = 20, min = 17, max = 25, step = 1),
      
      h3("3. Show predicted Horsepower"),
      sliderInput("sliderMPG", "What is the MPG of the car?",
                  10, 35, value = 20)
    ),

    # Show a plot 
    mainPanel(
      plotOutput("plot2"),

      h3("Predicted Horsepower from Model 1:", style = "
        font-weight: 500; line-height: 1.1; 
         color: red;"),
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2:", style = "
        font-weight: 500; line-height: 1.1; 
         color: Blue;"),
      textOutput("pred2")
    )
  )
))
