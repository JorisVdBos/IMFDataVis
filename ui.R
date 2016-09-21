source("RawData/loadData.R")
source("plotFunc.R")

library(shiny)
library(rCharts)

shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring the IMF statistics data"),

  # Sidebar with a checkbox for country and checkbox for statistic
  sidebarLayout(
    sidebarPanel(
      # Options
      selectInput("country", "Country or region:", CountryChoices, 
                  selected = "World", multiple = FALSE, selectize = TRUE),
      uiOutput("statisticDD"),
      # Information table
      tableOutput("info")
    ),
    
    
    # Main with the plot
    mainPanel(
      plotOutput("plot")
    )
  )
))

