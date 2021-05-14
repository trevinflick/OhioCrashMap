library(shiny)
library(leaflet)

shinyServer(function(input, output, session) {

    df <- reactive(
        clean_data %>%
            filter(
                is.null(input$year) | CrashYear %in% input$year,
                is.null(input$county) | County %in% input$county,
                BicycleRelated == input$bike | PedestrianRelated == input$pedestrian
            )
    )
    
    ## Interactive Map ###########################################
    
    # Create the map
    output$map <- renderLeaflet({
        leaflet(df()) %>%
            addTiles() %>%
            addMarkers(clusterOptions = markerClusterOptions(),
                       popup = paste("Date:", df()$CrashDate, "<br>",
                                     "Time:", df()$CrashTime, "<br>",
                                     "City:", df()$CityVillageTownshipName, "<br>",
                                     "Weather:", df()$Weather, "<br>",
                                     "Narrative:", df()$Narrative))
    })
    
    

    ## Data Explorer ###########################################
    
    output$crash_table <- DT::renderDataTable({
        
        DT::datatable(clean_data,
                      options = list(columnDefs = list(list(
                          targets = 14, visible = FALSE
                      )), buttons = c('colvis','copy', 'csv', 'excel'), dom = 'Bfrtip'), 
                      extensions = 'Buttons'
            )
    })
    
})
