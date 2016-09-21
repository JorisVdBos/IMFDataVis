source("RawData/loadData.R")
source("plotFunc.R")

library(shiny)
library(rCharts)
options(RCHART_LIB = 'morris')

shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring the IMF statistics data"),

  # Sidebar with a checkbox for country and checkbox for statistic
  sidebarLayout(
    sidebarPanel(
      "This app works with a data set that was taken from the IMF website.
      Below you can choose a country and the available statistics will be loaded
      automatically into the second selection box. The app filters the data according
      to the chosen options and will display a graph for you!",
      # Options
      selectInput("country", "Country or region:", CountryChoices, 
                  selected = "World", multiple = FALSE, selectize = TRUE),
      uiOutput("statisticDD"),
      # Information table
      tableOutput("info")
    ),
    
    
    # Main with the plot
    mainPanel(
      showOutput("plot", lib = "morris")
    )
  )
))

