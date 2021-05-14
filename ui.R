library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
navbarPage("Ohio Pedestrian & Bicyle Related Fatal Crashes", id="nav",
           
           tabPanel("Interactive map",
                    div(class="outer",
                        
                        tags$head(
                            # Include our custom CSS
                            includeCSS("styles.css")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map", width="100%", height="100%"),
                        
                        # Shiny versions prior to 0.11 should use class = "modal" instead.
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      
                                      h2("Crash navigation"),
                                      
                                      selectInput("year", label = "Year", choices = c(2021,2020,2019,2018), multiple = TRUE),
                                      selectInput("county", label = "County", choices = ohio_county, multiple = TRUE),
                                      checkboxInput("pedestrian", label = "Pedestrian Related", value = TRUE),
                                      checkboxInput("bike", label = "Bicycle Related", value = TRUE)
                                      ),
                                      
                        ),
                        
                        tags$div(id="cite",
                                 'Data from ', tags$em('Ohio Department of Public Safety'), 'Data from 01/01/2018 - 04/30/2021.'
                        )
                    ),
           tabPanel("Data explorer",
                    hr(),
                    DT::dataTableOutput("crash_table")
           ),
           
           
           conditionalPanel("false", icon("crosshair"))
)


