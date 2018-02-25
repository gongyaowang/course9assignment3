#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
   
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 >0, mtcars$mpg - 20, 0)
  mtcars$power2mpg <- mtcars$mpg^2 
  model1 <- lm(hp ~ mpg + power2mpg, data = mtcars)
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg = mpgInput, power2mpg = mpgInput^2))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    model2Tno <- ifelse(input$noforModel2 > 25, 20, ifelse(input$noforModel2 < 17, 20, input$noforModel2))
    predict(model2, newdata = data.frame(mpg = mpgInput,
                                         mpgsp = ifelse(mpgInput - model2Tno >0,
                                                        mpgInput - model2Tno, 0)))
  })

    output$plot2 <- renderPlot({
    mpgInput <- input$sliderMPG
    model2Tno <- ifelse(input$noforModel2 > 25, 20, ifelse(input$noforModel2 < 17, 20, input$noforModel2))
    
    xlab <- ifelse(input$show_xlab, "Miles Per Gallon", "")
    ylab <- ifelse(input$show_ylab, "Horsepower", "")
    main <- ifelse(input$show_title, "Car MPG vs. Horsepower Models", "")

    plot(mtcars$mpg, mtcars$hp, xlab = xlab,
         ylab = ylab, main = main, bty = "n", pch = 16,
         xlim = c(10, 35), ylim = c(50, 350))
    if(input$showModel1){
#      abline(model1, col = "red", lwd = 2)
      mpgvalues <- seq(10, 35, 0.1)
      model1lines <- predict(model1, list(mpg=mpgvalues, power2mpg=mpgvalues^2)
      )
      lines(mpgvalues, model1lines, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        mpg =10:35, mpgsp = ifelse(10:35 - model2Tno > 0, 10:35 - model2Tno, 0)
      ))
      lines(10:35, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })


})
