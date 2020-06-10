# Source scripts, load libraries, and read data sets at the beginning of app.R 
# outside of the server function. Shiny will only run this code once, which is 
# all you need to set your server up to run the R expressions contained in server.

library(shiny)
library(maps)
library(mapproj)

# load data
counties <- readRDS("data/counties.rds")

# source helper function 
source("helpers.R")

# Define UI ----
ui <- navbarPage("Les élections (POLXXXX)",
                 tabPanel("Stat. descriptives",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Sélectionnez une variable pour obtenir des statistiques descriptives."),
                              selectInput("var",
                                          label = "Variable...",
                                          choices = list("% blancs",
                                                         "% noirs",
                                                         "% hispaniques",
                                                         "% asiatiques"),
                                          selected = "% blancs"),
                              sliderInput("range",
                                          label = "Étendue désirée:",
                                          min = 0, max = 100, value = c(0,100))
                            ),
                            mainPanel(plotOutput("map"))
                          )
                          ),
                 tabPanel("Tableaux croisés"),
                 tabPanel("Analyses multivariées"),
                 tabPanel("Description des variables")
  
)

# Define server logic ----
server <- function(input, output) {
  
  output$map <- renderPlot({ 
    data <- switch(input$var,
                   "% blancs" = counties$white,
                   "% noirs" = counties$black,
                   "% hispaniques" = counties$hispanic,
                   "% asiatiques" = counties$asian)
    
    color <- switch(input$var,
                    "% blancs" = "darkgreen",
                    "% noirs" = "black",
                    "% hispaniques" = "darkorange",
                    "% asiatiques" = "darkviolet")
    
    legend = switch(input$var,
                    "% blancs" = "% blancs",
                    "% noirs" = "% noirs",
                    "% hispaniques" = "% hispaniques",
                    "% asiatiques" = "% asiatiques")
    
    percent_map(data, color, legend, max = input$range[1], min = input$range[2])
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
# runApp("appli-cours")
