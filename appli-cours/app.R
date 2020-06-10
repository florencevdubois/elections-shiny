# Source scripts, load libraries, and read data sets at the beginning of app.R 
# outside of the server function. Shiny will only run this code once, which is 
# all you need to set your server up to run the R expressions contained in server.

library(shiny)
library(datasets)
library(tidyverse)
library(stargazer)

# load data
opinion <- read.csv("data/opinion.csv") 

# source helper function 
source("helpers.R")

# Define UI ----
ui <- navbarPage("Les élections (POL 3015)",
                 tabPanel("Accueil"),
                 tabPanel("Description des variables"),
                 tabPanel("Statistiques descriptives",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Explorez les variables *continues* de la banque de données."),
                              selectInput("var_cont",
                                          label = "Sélectionnez une variable...",
                                          choice = c("year" = 2,
                                                     "age" = 3), 
                                          selected = "year")),
                            mainPanel(h2("Résumé de la variable continue"),
                                      h5("'Min.' est la plus petite valeur. '1st Qu.' est le premier quartile. 'Median' est la médiane. 'Mean' est la moyenne. '3rd Qu.' est le troisième quartile. 'Max.' est la valeur maximal. 'NA's' dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_cont"),
                                      plotOutput("hist_cont"))
                            ),
                          sidebarLayout(
                            sidebarPanel(helpText("Explorez les variables *catégorielles* de la banque de données."),
                                         selectInput("var_cat",
                                                     label = "Sélectionnez une variable...",
                                                     choice = c("cohort" = 4,
                                                                "s_id" = 5), 
                                                     selected = "cohort")),
                            mainPanel(h2("Résumé de la variable catégorielle"),
                                      h5("Ce tableau indique combien de répondants ont sélectionné chaque catégorie de la variable. 'NA's' dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_cat"),
                                      plotOutput("hist_cat"))
                            ),
                          sidebarLayout(
                            sidebarPanel(helpText("Explorez les variables *dichotomiques* de la banque de données."),
                                         selectInput("var_dicho",
                                                     label = "Sélectionnez une variable...",
                                                     choice = c("pref_defence" = 6,
                                                                "pref_childcare" = 7),
                                                     selected = "pref_defence")),
                            mainPanel(h2("Résumé de la variable dichotomique"), 
                                      h5("'Min.' est la plus petite valeur. '1st Qu.' est le premier quartile. 'Median' est la médiane. 'Mean' est la moyenne. '3rd Qu.' est le troisième quartile. 'Max.' est la valeur maximal. 'NA's' dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_dicho"),
                                      plotOutput("hist_dicho"))
                          )
                          ),
                 tabPanel("Tableaux croisés"),
                 tabPanel("Analyses multivariées")
  
)

# Define server logic ----
server <- function(input, output) {

  # outputs, descriptives statistics (tables)  
  output$sum_cont <- renderPrint({
    
    summary(opinion[, as.numeric(input$var_cont)])
  })
  
  output$sum_cat <- renderPrint({

    table(opinion[, as.numeric(input$var_cat)], useNA = "always")
  })
  
  output$sum_dicho <- renderPrint({
    
    summary(opinion[, as.numeric(input$var_dicho)])
  })
  
  # outputs, descriptive statistics (figures)
  output$hist_cont <- renderPlot({
    
    x <- opinion[, as.numeric(input$var_cont)]
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram() + 
      labs(title = names(opinion[as.numeric(input$var_cont)]),
           x = names(opinion[as.numeric(input$var_cont)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_cat <- renderPlot({
    
    x <- opinion[, as.numeric(input$var_cat)]
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram(stat = "count") + 
      labs(title = names(opinion[as.numeric(input$var_cat)]),
           x = names(opinion[as.numeric(input$var_cat)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_dicho <- renderPlot({
    
    x <- opinion[, as.numeric(input$var_dicho)]
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram() + 
      labs(title = names(opinion[as.numeric(input$var_dicho)]),
           x = names(opinion[as.numeric(input$var_dicho)]),
           y = "Nombre d'observations") +
      scale_x_continuous(breaks = c(0,1)) +
      theme_minimal()
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
# runApp("appli-cours")
# library(rsconnect)
# rsconnect::deployApp('appli-cours')
