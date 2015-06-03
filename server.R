options(rgl.useNULL=TRUE)

library(shiny)
#library(shinyRGL)
#library(rgl)

source('helpers.R')

# Get data
manifolds <- list()
manifolds$sol <- genSolenoid(500)
manifolds$swiss <- genSwissRoll(500)
manifolds$bunny <- readRDS('data/bunny.rds')

shinyServer(function(input, output) {
  
  #output$mani <- renderWebGL({
  #  points3d(x=swissr$x, y=swissr$y, z=swissr$z, color=swissr$c, size=6)
  #  axes3d()
  #})
  
  output$dm <- renderPlot({
    dm.plot(manifolds[[input$mani]]$D, 10^(input$al), 10^(input$eps),
            manifolds[[input$mani]]$c.scale)
  })
  
})
