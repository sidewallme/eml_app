library(shiny)
library(data.table)
library(RWeka)
library(partykit)
library(rpart)


shinyServer(function(input, output) {

    #download.file("https://raw.githubusercontent.com/sidewallme/2015-Rose-Hulman-Competition/master/myields.csv", method = 'curl', destfile = 'myields.csv')
    yields <- fread("myields.csv")
    m5pTree <- M5P(yield ~ sacchariflorus + sinensis , data = yields)
    rtree <- rpart(yield ~ sacchariflorus + sinensis + sinensis.Hybrid + giganteus +
                     lat + lon + fertilizer_n + irrigated + planting_density, 
                   data = yields)
    #plot(as.party(rtree),tp_args=list(id=FALSE))
    output$scaplot <- renderPlot({
      #m5pTree <- M5P(yield ~ sacchariflorus + sinensis + sinensis.Hybrid + giganteus +
                       #lat + lon + fertilizer_n + irrigated + planting_density, 
                     #data = yields)
      var <- input$var
      if(input$species =="all"){
        xdata <- yields[[var]]
        #plot(xdata, yields$yield)
        plot(as.party(rtree),tp_args=list(id=FALSE))
        #plot(rtree)
      }else{
        sp <- input$species
        spdata <- yields[yields[[sp]] == 1, ]
        xdata <- spdata[[var]]
        plot(xdata, spdata$yield)
        #plot(m5pTree)
      }
      
    })

    
    output$summaries <- renderPrint({
      summary(yields)
    })
    
    output$table <- renderDataTable({
      yields
    }, options=list(pageLength=10))
    
  })
#}
#)