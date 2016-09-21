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
      selectInput("country", "Country or region:", CountryChoices, 
                  selected = "World", multiple = FALSE, selectize = TRUE),
      uiOutput("statisticDD"),
      tableOutput("info")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
))

