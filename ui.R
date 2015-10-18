library(shiny)
library(markdown)
library(data.table)
library(RWeka)
library(partykit)


shinyUI(navbarPage("Miscanthus",
                   tabPanel("Plot",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("species", "Choose species:", 
                                            choices = c("all", "sacchariflorus", "sinensis", "sinensis.Hybrid", "giganteus")),
                                
                                radioButtons("var", "Variable",
                                             c("MAT"="MAT", "PET"="PET", "SOLAR" = "SOLAR", 
                                               "MAP" = "MAP", "YEAR" = "year", "LAT" = "lat", 
                                               "LON" = "lon", "FERTILIZER" = "fertilizer_n", 
                                               "DENSITY" = "planting_density", "IRRIGATED" = "irrigated")
                                )
                              ),
                              mainPanel(
                                plotOutput("scaplot")
                              )
                            )
                   ),

                   tabPanel("Summaryss",
                            verbatimTextOutput("summaries")
                   ),
                   navbarMenu("More",
                              tabPanel("Table",
                                       dataTableOutput("table")
                              )
                   )
))