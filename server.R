library(shiny)

shinyServer(function(input, output){
  
  # Find which statistics are available for this country
  getCountry <- reactive({input$country})
  
  # Render the second selectInput with only the available statistics
  output$statisticDD <- renderUI({
    selectInput("statistic", "Statistic:", 
                IFS[Country.Name == getCountry()]$Indicator.Name)
  })
  
  # Render the information table
  output$info <- renderTable({
    plotInfo(input$country, input$statistic)
  }) 
  
  # The plot
  output$plot <- renderChart2({
    plot <- mPlot(x = "date", y = "value", type = "Line", 
                  data = makeTs(input$country, input$statistic))
    plot$set(pointSize = 0, lineWidth = 1)
    return(plot)
  })
  
})
