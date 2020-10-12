# Source scripts, load libraries, and read data sets at the beginning of app.R 
# outside of the server function. Shiny will only run this code once, which is 
# all you need to set your server up to run the R expressions contained in server.

# good resource: https://juliescholler.gitlab.io/files/M2/M2-CM3-Shiny.html#12

#### prep ####
library(shiny)
library(datasets)
library(tidyverse)
library(stargazer)

#### load data ####
opinion <- read.csv("data/opinion.csv") 

#### prep ####
# all variables
variables <- c("cohort" = 5, "survey id" = 4,  "year" = 2, "age" =  3, "pref defence" = 6, "pref childcare" =  7)
# categorical variables
categorical_variables <- c("cohort" = 5, "survey id" = 4)
# dichotomous varibales
dichotomous_variables <- c("pref defence" = 6, "pref childcare" =  7)
# continuous variables
continuous_variables <- c( "year" = 2, "age" =  3)
# categorical and dichotomous variables (for cross tabs)
cat_dicho_variables <- c(categorical_variables,  dichotomous_variables)
# dependent variables only (dichotomous or continuous)
dependent_variables <- c(continuous_variables, dichotomous_variables)

#### source helper function ####
#source("helpers.R")

#### Define UI ####
ui <- navbarPage("Les élections (POL 3015)",
                 #### welcome panel ####
                 tabPanel("Accueil",
                          fluidPage(
                            h3("Bienvenue sur l'application web du cours POL 3015: Les élections!"),
                            p("Cette application vous offre une interface pour mener les analyses statistiques de votre travail final. Via les différents onglets, vous pouvez analyser les variables contenues dans la base de données du sondage que vous avez mené plus tôt cette session.", style = "font-size:16px"),
                            p("L'onglet", em("Description des variables"), "présente la liste de toutes les variables qui se trouvent dans la banque de données.", style = "font-size:16px"),
                            p("Utilisez l'onglet", em("Statistiques descriptives"), "pour connaître la distribution des variables (étendue, moyenne, médiane, etc.), créer des histogrammes et consulter les tableaux de fréquences.", style = "font-size:16px"),
                            p("L'onglet", em("Tableaux croisés"), "vous permet de croiser des variables catégorielles et/ou dichotomiques pour voir combien de répondant.e.s se trouvent dans chaque catégorie de réponse.", style = "font-size:16px"),
                            p("Enfin, l'onglet", em("Analyses multivariées"), "vous permet de faire les analyses de régression que vous présenterez dans votre travail final. Choisissez les variables ddépendante, indépendante et de contrôle, faites l'analyse, puis rapportez et interprétez les résultats dans votre travail de session.", style = "font-size:16px"),
                            p("Bonne exploration!", style = "font-size:16px"),
                            p(br()),
                            p("Ruth Dassonneville, Professeure agrégée, Département de science politique de l'Université de Montréal; enseignante du cours POL 3015", style = "font-size:14px"), 
                            p("Gestion de la banque de données par Alexandra Jabbour, doctorante en science politique à l'Université de Montréal", style = "font-size:14px"),
                            p("Programmation de l'application web par Florence Vallée-Dubois, doctorante en science politique à l'Université de Montréal", style = "font-size:14px"))
                            ),
                 #### codebook panel ####
                 tabPanel("Description des variables",
                          fluidPage(
                            p("Cette liste comprend toutes les variables du sondage mené par les étudiant.e.s du cours POL 3015 (automne 2020). 
                              Choisissez parmi ces variables pour mener les analyses qui vous permettront de répondre à votre question de recherche. 
                              Il y a des variables socio-démographiques (comme l'âge des répondant.e.s, leur niveau d'éducation, etc.), 
                              des variables qui permettent de mesurer les comportements politiques des répondant.e.s (Votent-ils? Pour qui votent-ils? etc.),
                              des variables qui mesurent leurs attitudes envers les autres (XXX, XXX, etc.) et plusieurs autres variables pertinentes.
                              L'échantillon est de XXX répondant.e.s, mais certaines personnes n'ont pas répondu à toutes les questions du sondage.
                              Le sondage a été mené entre le X et le X octobre 2020 via un recrutement non-probabiliste.", style = "font-size:16px"),
                            h3("Liste des variables"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"),
                            p(strong("Variable:", style = "font-size:16px"), "Description", style = "font-size:16px"))
                 ),
                 #### descriptive statistics panel ####
                 tabPanel("Statistiques descriptives",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Explorez les variables", strong("continues"), "de la banque de données."),
                              selectInput("var_cont",
                                          label = "Sélectionnez une variable...",
                                          choice = c(Choisissez='', continuous_variables))),
                            mainPanel(h3("Résumé de la variable continue"),
                                      p(em("Min"), "est la plus petite valeur.", 
                                        em("1st Qu."), "est le premier quartile.",
                                        em("Median"), "est la médiane.", 
                                        em("Mean"), "est la moyenne.",
                                        em("3rd Qu."), "est le troisième quartile.", 
                                        em("Max."), "est la valeur maximale.",
                                        em("NA's"), "dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_cont"),
                                      plotOutput("hist_cont"))
                            ),
                          sidebarLayout(
                            sidebarPanel(helpText("Explorez les variables", strong("catégorielles"), "de la banque de données."),
                                         selectInput("var_cat",
                                                     label = "Sélectionnez une variable...",
                                                     choice = c(Choisissez='', categorical_variables))),
                            mainPanel(h3("Résumé de la variable catégorielle"),
                                      p("Ce tableau indique combien de répondants ont sélectionné chaque catégorie de la variable.", 
                                        em("<NA>"), "dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_cat"),
                                      plotOutput("hist_cat"))
                            ),
                          sidebarLayout(
                            sidebarPanel(helpText("Explorez les variables", strong("dichotomiques"), "de la banque de données."),
                                         selectInput("var_dicho",
                                                     label = "Sélectionnez une variable...",
                                                     choice = c(Choisissez='', dichotomous_variables))),
                            mainPanel(h3("Résumé de la variable dichotomique"), 
                                      p(em("Min"), "est la plus petite valeur.", 
                                        em("1st Qu."), "est le premier quartile.",
                                        em("Median"), "est la médiane.", 
                                        em("Mean"), "est la moyenne.",
                                        em("3rd Qu."), "est le troisième quartile.", 
                                        em("Max."), "est la valeur maximale.",
                                        em("NA's"), "dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
                                      verbatimTextOutput("sum_dicho"),
                                      plotOutput("hist_dicho"))
                          )
                          ),
                 #### crosstabs panel ####
                 tabPanel("Tableaux croisés",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Sélectionez deux variables pour créer un tableau croisé."),
                              selectInput("var1",
                                          label = "Sélectionnez une variable pour les lignes...",
                                          choice = cat_dicho_variables),
                            selectInput("var2",
                                        label = "Sélectionnez une variable pour les colonnes...",
                                        choice = cat_dicho_variables)),
                            mainPanel(h3("Votre tableau croisé"),
                                      tableOutput("crosstab"))
                          )
                          ),
                 #### regressions panel ####
                 tabPanel("Analyses multivariées",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Sélectionez une variable dépendante, une variable indépendante et (si nécessaire) des variables de contrôle pour l'analyse de régression."),
                              selectInput("dv",
                                          label = "Sélectionnez une variable dépendante...",
                                          choice = c(Choisissez='', dependent_variables)),
                              selectInput("iv",
                                          label = "Sélectionnez une variable indépendante...",
                                          choice = c(Choisissez='', variables)),
                              selectInput("controls",
                                          label = "Sélectionnez une ou des variables de contrôle...",
                                          multiple = T,
                                          choices = c(Choisissez='', variables))),
                            mainPanel(h3("Résultats de votre analyse de régression"),
                                      tableOutput("regression"),
                                      verbatimTextOutput("test"))
                          ))
  
)

#### Define server logic ####
server <- function(input, output) {

  #### outputs, descriptives statistics (tables) ####
  output$sum_cont <- renderPrint({
    
    validate(need(input$var_cont, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    summary(opinion[, as.numeric(input$var_cont)])
  })
  
  output$sum_cat <- renderPrint({

    validate(need(input$var_cat, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    table(opinion[, as.numeric(input$var_cat)], useNA = "always")
  })
  
  output$sum_dicho <- renderPrint({
    
    validate(need(input$var_dicho, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    summary(opinion[, as.numeric(input$var_dicho)])
  })
  
  #### outputs, descriptive statistics (histograms) ####
  output$hist_cont <- renderPlot({
    
    validate(need(input$var_cont, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- opinion[, as.numeric(input$var_cont)]
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram(fill = "navyblue",  binwidth = .3) + 
      labs(x = names(opinion[as.numeric(input$var_cont)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_cat <- renderPlot({
    
    validate(need(input$var_cat, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- opinion[, as.numeric(input$var_cat)]
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram(stat = "count",fill = "navyblue") + 
      labs(x = names(opinion[as.numeric(input$var_cat)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_dicho <- renderPlot({
    
    validate(need(input$var_dicho, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- opinion[, as.numeric(input$var_dicho)] 
    
    ggplot(opinion, aes(x = x)) + 
      geom_histogram(fill = "navyblue", stat = "count") + 
      labs(x = names(opinion[as.numeric(input$var_dicho)]),
           y = "Nombre d'observations") +
      scale_x_continuous(breaks = c(0,1)) +
      theme_minimal()
  })
  
  #### outputs, crosstabs ####
  output$crosstab <- renderTable(as.data.frame.matrix(table(opinion[, as.numeric(input$var1)], opinion[, as.numeric(input$var2)], useNA = "always")), rownames = T)
  
  #### outputs, regressions ####
  # set-up for reactive output --- we specify that the regression should include only y and x if there are no controls,
  # if there is one control, the regression shoud include y, x and the control
  modelfits <- reactive({
    if(length(input$controls) == 0){
      y <- opinion[, as.numeric(input$dv)]
      x <- opinion[, as.numeric(input$iv)]
      
      model <- lm(y ~ x, data = opinion) %>% 
        broom::tidy() %>% 
        mutate(term = ifelse(term == "(Intercept)", "constante", 
                             ifelse(term == "x", names(opinion[as.numeric(input$iv)]), 
                                    ifelse(str_detect(term, "x"), str_remove(term, "x"), term)))) %>% 
        rename(` ` = term,
               Coefficient = estimate,
               `Erreur-type` = std.error,
               `Statistique t` = statistic,
               `Valeur p` = p.value)
    }
    if(length(input$controls) >= 1){
      y <- opinion[, as.numeric(input$dv)]
      x <- opinion[, as.numeric(input$iv)]
      control <- opinion[, as.numeric(input$controls)]
      datatemp <- data.frame(y,x,control)
      
      model <- lm(y ~ ., data = datatemp) %>% 
        broom::tidy() %>% 
        mutate(term = ifelse(term == "(Intercept)", "constante", 
                             ifelse(term == "x", names(opinion[as.numeric(input$iv)]), 
                                    ifelse(str_detect(term, "x"), str_remove(term, "x"), 
                                           ifelse(term == "control", names(opinion[as.numeric(input$controls)]), 
                                                  ifelse(str_detect(term, "control"), str_remove(term, "control"), term)))))) %>% 
        rename(` ` = term,
               Coefficient = estimate,
               `Erreur-type` = std.error,
               `Statistique t` = statistic,
               `Valeur p` = p.value)
    }
    model
  })
  
  output$regression <- renderTable({
    
   validate(
     need(input$dv, 'Les résultats apparaîtront lorsque vous aurez sélectionné une variable dépendante.'),
     need(input$iv, 'Les résultats apparaîtront lorsque vous aurez sélectionné une variables indépendante.')
     )
   
   modelfits()
   
  })
  
  # ici --- trouver comment ajouter les contrôles ! et s'ils ne sélectionnent pas tous le même nombre de comtrôle
  output$regression2 <- renderPrint({
    
    y <- opinion[, as.numeric(input$dv)] 
    x <- opinion[, as.numeric(input$iv)]
    #controls <- opinion[, as.numeric(input$controls)]
    
    fit <- lm(y ~ x, data = opinion) # + controls
    #names(fit$coefficients) <- c("Intercept", opinion$iv)
    summary(fit)
    #summary(lm(y ~ names(opinion[as.numeric(input$iv)]), data = opinion))
  })
  
}


##### Run the app ####
shinyApp(ui = ui, server = server)
# runApp("appli-cours")
# library(rsconnect)
# rsconnect::deployApp('appli-cours')
