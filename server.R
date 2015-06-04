library(shiny)

source('helpers.R')

# Get data
manifolds <- list()
manifolds$sol <- readRDS('data/sol.rds')
manifolds$swiss <- readRDS('data/swiss.rds')
manifolds$bunny <- readRDS('data/bunny.rds')

shinyServer(function(input, output) {
  
  output$dm <- renderPlot({
    dm.plot(manifolds[[input$mani]]$D, 10^(input$al), 10^(input$eps),
            manifolds[[input$mani]]$c.scale)
  })
  
})