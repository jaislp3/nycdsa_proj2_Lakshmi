# server.R

shinyServer(function(input, output, session) {

  ####################By country#####################################
  ###line
  lineReact = reactive({
    lineChart(us_aid, input$country, input$year, input$obli)
  })
  
  output$line = renderPlotly({
    lineReact()
  })
  #####rchart Sector
  rchartsecReact = reactive({
    rsecChart(us_aid, input$country, input$year) 
            
  })
  
  output$rchartsector = renderPlotly({
    rchartsecReact()
  })
  ###rchart Impl
  rchartimplReact = reactive({
    rimplChart(us_aid, input$country, input$year) 
            
  })
  
  output$rchartimpl = renderPlotly({
    rchartimplReact()
  })
  
  
  #######################AID by Sector#####################################
  
  ###linesec
  linesecReact = reactive({
     linesecChart(us_aid, input$sect, input$secyear, input$oblisec) 
                 
    })
  
  output$linesec = renderPlotly({
    linesecReact()
    })
  #####rchart Country
  rchartcountryReact = reactive({
    rcountryChart(us_aid, input$sect, input$secyear) 
             
  })
  
  output$rchartcountry = renderPlotly({
    rchartcountryReact()
  })
  ###rchart Impl
  rsecchartimplReact = reactive({
    rsecimplChart(us_aid, input$sect, input$secyear) 
    
  })
  
  output$rsecchartimpl = renderPlotly({
    rsecchartimplReact()
  })
  
  
  

  
  
  
  } ) #########first line end
