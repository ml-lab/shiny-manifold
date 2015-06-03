library(shiny)
#library(shinyRGL)

shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1(strong("Visualizing Diffusion Maps with Shiny")), windowTitle = "Shiny Manifolds"),
  # Dislpay the subtitle
  fluidRow(column(12, "There's a ", a("post on henry.re", href = "http://henry.re/"), " too", br(), br())),
  
  # Sidebar with input for manifold and diffusion map parameters
  withMathJax(),
  sidebarLayout(
    sidebarPanel(
      helpText("First choose the toy manifold you want to work with.
               To view it, use the Plot View menu."),
      selectInput('mani',
                  "Toy manifold:",
                  choices = list("Bunny Images" = 'bunny',
                                 "Toroidal Solonoid" = 'sol',
                                 "Swiss Roll" = 'swiss'),
                  selected = 1),
      helpText(br(), "Now we'll set the two main parameters
               for the diffusion maps algorithm. If you were viewing the 
               manifold, use the Plot View menu."),
      sliderInput('eps', "\\(\\log\\varepsilon\\), the diffusion kernel width",
                  min = -6, max = 6, step = 0.1, ticks = F, value = 0.8),
      sliderInput('al', "\\(\\log\\alpha\\), the sampling density influence",
                  min = -1, max = 1, step = 0.1, ticks = F, value = 0),
      helpText(br(), "Do you want to see the manifold data* or the diffusion map representation?"),
      selectInput('view',
                  "Plot view:",
                  choices = list("Diffusion maps" = 1,
                                 "Manifold data" = 2),
                  selected = 1),
      helpText(em("* Note: shinyRGL is currently broken, so only static images of the toy
                  manifolds can be shown right now. Interactive plots will be back when
                  shinyRGL is working."))
    ),
    
    # 
    mainPanel(
      conditionalPanel(
        condition = "input.view == 1",
        plotOutput('dm', height = 500, width = 500)
      ),
      conditionalPanel(
        condition = "input.view == 2 && input.mani == 'bunny'",
        img(src = "bunny.gif", height = 500, width = 500)
      ),
      conditionalPanel(
        condition = "input.view == 2 && input.mani == 'sol",
        img(src = "solenoid.png", height = 500, width = 500)
      ),
      conditionalPanel(
        condition = "input.view == 2 && input.mani == 'swiss",
        img(src = "swiss.png", height = 500, width = 500)
      )
    )
  )
))
