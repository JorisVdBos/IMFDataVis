source("RawData/loadData.R")
source("plotFunc.R")

library(shiny)
library(ggplot2)

shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring the IMF statistics data"),

  # Sidebar with a checkbox for country and checkbox for statistic
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Country or region:", CountryChoices, 
                  selected = NULL, multiple = FALSE, selectize = TRUE),
      uiOutput("statisticDD")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      "Plot"
    )
  )
))

