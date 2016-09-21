library(shiny)

shinyServer(function(input, output){
  
  # Which statistic is available
  getCountry <- reactive({input$country})
  output$statisticDD <- renderUI({
    selectInput("statistic", "Statistic:", 
                IFS[Country.Name == getCountry()]$Indicator.Name)
  })
  output$info <- renderTable({
    plotInfo(input$country, input$statistic)
  }) 
  output$plot <- renderPlot({
  plot(makeTs(input$country, input$statistic), ylab="")
    
  })

})
