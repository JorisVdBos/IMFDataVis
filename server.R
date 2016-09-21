library(shiny)

shinyServer(function(input, output){
  
  # Which statistic is available
  getCountry <- reactive({input$country})
  output$statisticDD <- renderUI({
    selectInput("statistic", "Statistic:", 
                IFS[Country.Name == getCountry()]$Indicator.Name)
  })
  output$distPlot <- renderPlot({
  #plot(make)
  })

})
