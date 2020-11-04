# Source scripts, load libraries, and read data sets at the beginning of app.R 
# outside of the server function. Shiny will only run this code once, which is 
# all you need to set your server up to run the R expressions contained in server.

# good resource: https://juliescholler.gitlab.io/files/M2/M2-CM3-Shiny.html#12

#### prep ####
library(shiny)
library(datasets)
library(tidyverse)
library(stargazer)
library(knitr)
library(modelsummary)

#### load data ####
d <- read.csv("data/sondage_recoded.csv") %>% dplyr::select(-X)

# categorical variables - 101 variables
categorical_variables <- c("Emploi" = 3, 
                           "Revenu" = 4,
                           "Genre" = 5,
                           "Citoyenneté" = 6,
                           "Ethnie" = 7,
                           "Éducation" = 9,
                           "Religion" = 10,
                           "Réseau social" = 11,
                           "Résidence" = 12,
                           "Province" = 16, 
                           "Classe sociale" = 18,
                           "Résidence parents - province" = 21,
                           "Residence parents - pays" = 22,
                           "Climat social" = 23,
                           "Covid - satisfaction" = 24,
                           "Covid - gestion" = 26,
                           "Covid - jeunes" = 28,
                           "Covid - politiques" = 29,
                           "Immigration - ouverture" = 30, 
                           "Immigration - Syrie" = 31,
                           "Climat - économie" = 32,
                           "Transition énergétique - taxes" = 33,
                           "Climat - impacts" = 34,
                           "Confiance - police" = 35,
                           "Sécurité - quartier" = 36,
                           "Sécurité - gouvernement" = 37,
                           #"Sécurité - immigration" = 38,
                           "Sécurité - frontières" = 39, 
                           "Immigration - quotas" = 40,
                           "Mninorités - partis" = 41,
                           "Corruption" = 42,
                           "Mondialisation" = 45,
                           "Économie - évaluation sociotropique" = 46,
                           "Économie - évaluation égotropique" = 47,
                           "Économie - statisfaction" = 48,
                           "Économie - préoccupation" = 49,
                           "Économie - critères" = 50, 
                           "Économie - confiance (Canada)" = 51,
                           "Économie - confiance (France)" = 52,
                           "Immigration - confiance (Canada)" = 53,
                           "Immigration - confiance (France)" = 54,
                           "Représentation des minorités" = 56,
                           "Importance - écologie" = 64,
                           "Inquiétude - attentats" = 65,
                           "Satisfaction envers la démocratie" = 67,
                           "Satisfaction Gouvernement" = 68, 
                           "Institutions démocratiques" = 69,
                           "Vote - démonstration" = 70,
                           "Confiance - Chef de l'État" = 71,
                           "Altruisme - politiques" = 72,
                           "Education civique" = 73,
                           "Écoles" = 74,
                           "Compréhension - élites" = 75,
                           "Importance vote" = 76,
                           "Importance - représentation" = 77, 
                           "Disproportion électorale" = 78,
                           "Partis - vote" = 79,
                           "Votes - objectif" = 80,
                           "Vote - délais" = 81,
                           "Réédition de comptes" = 82,
                           "Intérêt - politique US" = 85,
                           "Engagement politique" = 87,
                           "Proche parti" = 88,
                           "Représentation = partis" = 94, 
                           "Mode de scrutin" = 95,
                           "Changement scrutin" = 96,
                           "Sources d'information" = 104,
                           "Réseaux sociaux - cause" = 105,
                           "Médias traditionnels" = 106,
                           "Consultation sondage - 1" = 107,
                           "Consultation sondage 2 - Canada" = 108,
                           "Consultation sondage 2 - France" = 109,
                           "Principale source" = 110, 
                           "Engagement - réseaux sociaux" = 111,
                           "Abonnements - personnalités" = 112,
                           "Fréquence utilisation" = 113,
                           "Contact - information" = 115,
                           "Plateforme" = 116,
                           "Couverture - influence" = 117,
                           "Médias - neutralité" = 118,
                           #"Influence des médias sur l'élection" = 119,
                           "Biais médias" = 120, 
                           "Chaînes - indépendance" = 121,
                           "Niveau d'information" = 122,
                           "Confiance contenu RS" = 125,
                           "Confiance - TV et radio" = 126,
                           "Confiance - presse écrite" = 127,
                           "Site - parti" = 128,
                           "Like - parti" = 129,
                           "Vote habitude" = 146,
                           "Vote - anciens présidents" = 166, 
                           "Aucune préférence" = 168,
                           "Préférence - parti" = 169,
                           "Satisfaction mode de scrutin" = 170,
                           "Vote - chance favoris" = 171,
                           "Motivation" = 173,
                           "Vote - premier choix" = 174,
                           "Stratégie - vote 2" = 175,
                           "Autre choix - fréquence" = 176, 
                           "Refus de voter pour un parti - Canada" = 177,
                           "Refus de voter pour un parti - France" = 178)

# dichotomous varibales - 44 variables
dichotomous_variables <- c("Minorité" = 8, 
                           "Naissance pays résidence" = 13,
                           "Cohabitation" = 14,
                           "Droit de vote" = 15,
                           "Né.e dans votre province de résidence" = 17,
                           "Classe sociale - parents" = 19,
                           "Langue" = 20,
                           "Covid - accès aux soins" = 25,
                           "Déficit" = 55,
                           "Sophistication - États-Unis" = 130, 
                           "Sophistication - Freeland" = 131,
                           "Sophistication - Legault" = 132,
                           "Sophistication - Macron" = 133,
                           "Sophistication - Pence" = 134,
                           "Sophistication - Singh" = 135,
                           "Participation" = 136,
                           "Québec 2018 - CAQ" = 137,
                           "Québec 2018 - PQ" = 138,
                           "Québec 2018 - PLQ" = 139, 
                           "Québec 2018 - QS" = 140,
                           "Québec 2018 - PVQ" = 141,
                           "Québec 2018 - Autre" = 142,
                           "Québec 2018 - Bulletin nul" = 143,
                           "Québec 2018 - Pas voté" = 144,
                           "Vote - US" = 145,
                           "Vote - même parti" = 147,
                           "Intention de vote France - République en marche" = 148,
                           "Intention de vote France - Républicains" = 149, 
                           "Intention de vote France - Verts" = 150,
                           "Intention de vote France - PS" = 151,
                           "Intention de vote France - RN" = 152,
                           "Intention de vote France - France insoumise" = 153,
                           "Intention de vote Canada - Libéral" = 154,
                           "Intention de vote Canada - Conservateur" = 155,
                           "Intention de vote Canada - NPD" = 156,
                           "Intention de vote Canada - Bloc" = 157,
                           "Intention de vote Canada - Vert" = 158,
                           "Intention de vote Canada - Autre" = 159,
                           "Intention de vote Québec - CAQ" = 160,
                           "Intention de vote Québec - PQ" = 161,
                           "Intention de vote Québec - PLQ" = 162,
                           "Intention de vote Québec - QS" = 163,
                           "Intention de vote Québec - PVQ" = 164,
                           "Intention de vote Québec - Autre" = 165)

# continuous variables - 32 variables
continuous_variables <- c("Année de naissance" = 1, 
                          "Âge" = 2,
                          "Covid - inquiétude" = 27, 
                          "Corruption - participation" = 43,
                          "Corruption - évaluation des partis" = 44, 
                          "Enjeux - chômage" = 57,
                          "Enjeux - environnement" = 58, 
                          "Enjeux - immigration" = 59,
                          "Enjeux - économie" = 60, 
                          "Enjeux - éducation" = 61,
                          "Enjeux - santé" = 62,
                          "Importance - immigration" = 63,
                          "Idéologie" = 66,
                          "Importance - chef" = 83, 
                          "Intérêt politique" = 84,
                          "Connaissances - politique US" = 86, 
                          "Importance traits" = 89,
                          "Traits - importance - intégrité" = 90, 
                          "Traits - importance - leadership" = 91,
                          "Traits - importance - compétence" = 92, 
                          "Traits - importance - empathie" = 93,
                          "Vote parti nationaliste" = 97, 
                          "Intégration localité" = 98,
                          "Thermomètre partis - Libéral" = 99, 
                          "Thermomètre partis - Conservateur" = 100,
                          "Thermomètre partis - NPD" = 101, 
                          "Thermomètre partis - Bloc" = 102,
                          "Thermomètre partis - Parti vert" = 103, 
                          "Inscription réseaux sociaux" = 114,
                          "Effet - débats" = 123, 
                          "Importance débats TV" = 124,
                          "Vote stratégique" = 167,
                          "Importance compétence" = 172)

# dependent variables
dependent_variables <- c("Idéologie" = 179,
                         "Vote - parti nationaliste" = 180,
                         "Participation" = 181,
                         "Québec 2018 - CAQ" = 182,
                         "Québec 2018 - PQ" = 183,
                         "Québec 2018 - PLQ" = 184,
                         "Québec 2018 - QS" = 185,
                         "Québec 2018 - Vert" = 186,
                         "Québec 2018 - Autre" = 187,
                         "Québec 2018 - Bulletin nul" = 188,
                         "Québec 2018 - Pas voté" = 189,
                         "Vote - US" = 190,
                         "Intention de vote France - République en marche" = 191,
                         "Intention de vote France - Républicains" = 192,
                         "Intention de vote France - Verts" = 193,
                         "Intention de vote France - PS" = 194,
                         "Intention de vote France - RN" = 195,
                         "Intention de vote France - Insoumise" = 196,
                         "Intention de vote Canada - Liberal" = 197,
                         "Intention de vote Canada - Conservateur" = 198,
                         "Intention de vote Canada - NPD" = 199,
                         "Intention de vote Canada - Bloc" = 200,
                         "Intention de vote Canada - Vert" = 201,
                         "Intention de vote Canada - Autre" = 202,
                         "Intention de vote Québec - CAQ" = 203,
                         "Intention de vote Québec - PQ" = 204,
                         "Intention de vote Québec - PLQ" = 205,
                         "Intention de vote Québec - QS" = 206,
                         "Intention de vote Québec - Vert" = 207,
                         "Intention de vote Québec - Autre" = 208,
                         "Vote - anciens présidents" = 209,
                         "Vote stratégique" = 210,
                         "Changement de scrutin" = 211)

# categorical and dichotomous variables (for cross tabs)
cat_dicho_variables <- c(categorical_variables,  dichotomous_variables)

# dependent variables only (dichotomous or continuous)
#dependent_variables <- c(continuous_variables, dichotomous_variables)
#dades[2:13] <- lapply(dades[2:13], as.numeric)

# all variables
variables <- c(categorical_variables, dichotomous_variables, continuous_variables)

# chanhe class of categorical and dichotomous variables
d[cat_dicho_variables] <- sapply(d[cat_dicho_variables], as.factor)

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
                            p("Programmation de l'application web (Shiny App) par Florence Vallée-Dubois, doctorante en science politique à l'Université de Montréal", style = "font-size:14px"),
                            HTML("Site inspiré de l'application créée par Dave Armstrong pour <a href='https://quantoid.shinyapps.io/CES_2020/'>analyser les données de l'étude électorale canadienne</a>"))
                            ),
                 #### codebook panel ####
                 #<a href='mailto:dave.armstrong@uwo.ca'>Dave Armstrong</a>
                 tabPanel("Description des variables",
                          fluidPage(
                            p("Le codebook ci-dessous comprend toutes les variables du sondage que vous avez mené cet automne.", style = "font-size:16px"),
                            p("Veuillez vous référer à ce codebook pour savoir comment chaque variable a été codée. Par exemple, certaines variables comprennent les choix de réponses", 
                              em('Très satisfait, Satisfait, Peu satisfait, Très insatisfait,'), "codés 1, 2, 3, et 4. Gardez toujours cela en tête lors de votre exploration des variables
                              dans les onglets", em("Statistiques descriptives, Tableaux croisés"), "et", em("Analyses multivariées."), style = "font-size:16px"),
                            p("Vous devez choisir parmi ces variables pour mener les analyses qui vous permettront de répondre à votre question de recherche. 
                              Il y a des variables socio-démographiques (comme l'âge des répondant.e.s, leur niveau d'éducation, etc.), 
                              des variables qui permettent de mesurer les comportements politiques des répondant.e.s (Ont-ils voté aux dernières élections? Sont-ils intéressés par la politique? etc.),
                              des variables qui mesurent leurs attitudes (confiance envers la police, préférence quant au type de mode de scrutin, etc.) et plusieurs autres variables pertinentes.", style = "font-size:16px"),
                            p("L'échantillon est de 789 répondant.e.s, mais certaines personnes n'ont pas répondu à toutes les questions du sondage.
                              Le sondage a été mené entre le 21 et le 31 octobre 2020 via un recrutement non-probabiliste.", style = "font-size:16px")),
                          fluidPage(includeHTML("codebook.html"))
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
                                      p("Ce tableau indique combien de répondants ont sélectionné chaque catégorie de la variable.", 
                                        em("<NA>"), "dénote le nombre d'observations manquantes (personnes n'ayant pas répondu à la question)."),
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
                                          choice = c(Choisissez = '', cat_dicho_variables)),
                            selectInput("var2",
                                        label = "Sélectionnez une variable pour les colonnes...",
                                        choice = c(Choisissez = '', cat_dicho_variables))),
                            mainPanel(h3("Votre tableau croisé"),
                                      p("Seules les variables catégorielles et dichotomiques peuvent être utilisées pour créer un tableau croisé."), 
                                      p("Consultez le codebook dans l'onglet", em("Description des variables"), "pour connaître la signification des catégories de réponse pour les variables dichotomiques."),
                                      #tableOutput("crosstab"),
                                      tableOutput("crosstab2"))
                          )
                          ),
                 #### regressions panel ####
                 tabPanel("Analyses multivariées",
                          sidebarLayout(
                            sidebarPanel(
                              helpText("Sélectionez une variable dépendante, une variable indépendante et (si nécessaire) des variables de contrôle pour l'analyse de régression."),
                              selectInput("dv",
                                          label = "Sélectionnez une variable dépendante (Y)...",
                                          choice = c(Choisissez='', dependent_variables)),
                              selectInput("iv",
                                          label = "Sélectionnez une variable indépendante (X)...",
                                          choice = c(Choisissez='', variables)),
                              selectInput("controls",
                                          label = "Sélectionnez une ou des variables de contrôle...",
                                          multiple = T,
                                          choices = c(Choisissez='', variables))),
                              # radioButtons("vary", 
                              #              label = "Pour faire l'analyse sur certains sous-groupes de l'échantillon seulement, sélectionnez d'abord le facteur qui vous intéresse...", 
                              #              choices = c("Tous les répondants" = "none", "Français" = "french", "Canadiens" = "canadians"), 
                              #              selected = "none"),
                              # checkboxGroupInput("country",
                              #                    label = "Si vous avez décidé de faire l'analyse sur les répondants d'une même nationalité, sélectionnez-la ici...",
                              #                    choices = c("Canadienne","Autre"),
                              #                    selected = c("Canadienne","Autre"))),
                            mainPanel(h3("Votre analyse de régression"),
                                      h4("À garder en tête"),
                                      p("Seules les variables continues et dichotomiques peuvent être utlisées comme variables dépendantes (y)."),
                                      p("Certaines questions de sondage ont été répondues par peu de personnes. Si vous choisissez une telle variable comme variable dépendante, il se peut qu'aucun coefficient ne puisse être estimé. De plus, si deux variables (indépendante et/ou de contrôle) sont parfaitement corrélées entre elles, le modèle retournera des valeurs manquantes pour les estimés (NA). C'est un élément important à considérer quand viendra le temps de choisir les variables à inclure dans votre modèle. Il est aussi important de choisir des variables qui proviennent du même "),
                                      p("Évidemment, il est aussi important de choisir des variables qui proviennent du même 'sous-échantillon' de personnes. Par exemple, si vous voulez connaître l'effet de la variable economieFRANCE_confiance (à quel parti faites-vous confiance pour la gestion de l'économie, en France) sur les intentions de vote, votre variable dépendante doit aussi se rapporter aux partis français."),
                                      h4("Résultats"),
                                      tableOutput("regression"),
                                      h4("Informations additionnelles sur votre modèle"),
                                      verbatimTextOutput("regression_stats"),
                                      h4("Interprétation"),
                                      p("Interprétez le coefficient de régression pour connaître l'influence de la variable indépendante sur la variable dépendante."),
                                      p("Lorsque la variable dépendante est une variable continue, on interprète l'effet d'une augmentation dans la variable indépendante sur le niveau de la variable dépendante. Par exemple, si la variable dépendante est l'idéologie (codée de 0 à 10), un coefficient positif signifie qu'une augmentation dans la variable indépendante entraîne une augmentation dans l'échelle de l'idéologie"),
                                      p("Lorsque la variable dépendante est une variable dichotomique (codée 0/1 ou 1/2), on interprète l'effet d'une augmentation dans la variable indépendante sur la probabilité que la variable dépendante prenne la valeur supérieure. Par exemple, si la variable dépendante est le vote pour le Parti Québécois en 2018 (codée 0 ou 1), un coefficient positif signifie qu'une augmentation dans la variable indépendante augmente la probabilité que le répondant ait voté pour le Parti Québécois en 2018."),
                                      h4("Notes"),
                                      p("L'erreur-type mesure l'incertitude du coefficient. Plus l'erreur-type est grande par rapport au coefficient, plus ce dernier est incertain."),
                                      p("La statistique t permet de déterminer le niveau de signification statistique du coefficient. Normalement, lorsque la statistique t est supérieure à 2, on estime que le coefficient est statistiquement significatif."),
                                      p("La valeur p est une autre mesure de signification statistique. Elle exprime la probabilité d'obtenir un tel coefficient s'il n'existe en réalité pas de relation entre x et y dans la population. Nous voulons que la probabilité soit faible, soit moins de .05 (ou 5 %)."),
                                      p("Les modèles estimés sont des modèles de régression linéaire par les moindres carrés (OLS)."))
                          ))
  
)

# checkboxGroupInput(inputId="provs", "Regions", 
#                    choices=c("Atlantic", "Quebec", "Ontario", "West"), 
#                    selected=c("Atlantic", "Quebec", "Ontario", "West")),
# checkboxGroupInput(inputId="years", "Years", 
#                    choices=c(2004, 2006, 2008, 2011, 2015, 2019), 
#                    selected=c(2004, 2006, 2008, 2011, 2015, 2019))), 

#### Define server logic ####
server <- function(input, output) {

  #### outputs, descriptives statistics (tables) ####
  output$sum_cont <- renderPrint({
    
    validate(need(input$var_cont, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    summary(d[, as.numeric(input$var_cont)])
  })
  
  output$sum_cat <- renderPrint({

    validate(need(input$var_cat, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    table(d[, as.numeric(input$var_cat)], useNA = "always")
  })
  
  output$sum_dicho <- renderPrint({
    
    validate(need(input$var_dicho, 'Les statistiques descriptives apparaîtront lorsque vous aurez sélectionné une variable.'))
    table(d[, as.numeric(input$var_dicho)], useNA = "always")
  })
  
  #### outputs, descriptive statistics (histograms) ####
  output$hist_cont <- renderPlot({
    
    validate(need(input$var_cont, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- d[, as.numeric(input$var_cont)]
    
    ggplot(d, aes(x = x)) + 
      geom_histogram(fill = "navyblue",  binwidth = .3) + 
      labs(x = names(d[as.numeric(input$var_cont)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_cat <- renderPlot({
    
    validate(need(input$var_cat, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- d[, as.numeric(input$var_cat)]
    
    ggplot(d, aes(x = x)) + 
      geom_histogram(stat = "count",fill = "navyblue") + 
      labs(x = names(d[as.numeric(input$var_cat)]),
           y = "Nombre d'observations") +
      theme_minimal()
  })
  
  output$hist_dicho <- renderPlot({
    
    validate(need(input$var_dicho, 'Un histogramme apparaîtra lorsque vous aurez sélectionné une variable.'))
    
    x <- d[, as.numeric(input$var_dicho)] 
    
    ggplot(d, aes(x = x)) + 
      geom_histogram(fill = "navyblue", stat = "count") + 
      labs(x = names(d[as.numeric(input$var_dicho)]),
           y = "Nombre d'observations") +
      #scale_x_continuous(breaks = c(0,1)) +
      theme_minimal()
  })
  
  #### outputs, crosstabs ####
  #output$crosstab <- renderTable(as.data.frame.matrix(table(d[, as.numeric(input$var1)], d[, as.numeric(input$var2)], useNA = "always")), rownames = T)
  
  #### outputs, crosstabs ####
  output$crosstab2 <- renderTable({
    
    validate(need(input$var1, 'Un tableau apparaîtra lorsque vous aurez sélectionné deux variables.'))
    validate(need(input$var2, 'Un tableau apparaîtra lorsque vous aurez sélectionné deux variables.'))
    
    x <- d[, as.numeric(input$var1)]
    y <- d[, as.numeric(input$var2)]
    datatable <- data.frame(x, y)

    # datasummary((`Variable 1`=x) * (`Variable 2`=y) + 1 ~ (`Nombre d'observations` = 1) + (`Pourcentage` = Percent()),
    #             data = datatable)
    datasummary((` ` = x) ~ y + (`Total` = 1) + (`Pourcentage` = Percent()),
                data = datatable)
    
  })
  
  #### outputs, regressions ####
  # set-up for reactive output --- we specify that the regression should include only y and x if there are no controls,
  # if there is one control, the regression shoud include y, x and the control
  modelfits <- reactive({
    if(length(input$controls) == 0){
      y <- d[, as.numeric(input$dv)]
      x <- d[, as.numeric(input$iv)]
      datatemp1 <- data.frame(y,x)
      
      model <- lm(y ~ x, data = datatemp1) %>% 
        broom::tidy() %>% 
        mutate(term = ifelse(term == "(Intercept)", "constante", 
                             ifelse(str_detect(term, "x"), str_replace(term, "x", names(d[as.numeric(input$iv)])), term))) %>% # ifelse(str_detect(term, "x"), str_remove(term, "x"),
        rename(` ` = term,
               Coefficient = estimate,
               `Erreur-type` = std.error,
               `Statistique t` = statistic,
               `Valeur p` = p.value)
    }
    if(length(input$controls) >= 1){
      y <- d[, as.numeric(input$dv)]
      x <- d[, as.numeric(input$iv)]
      control <- d[, as.numeric(input$controls)]
      datatemp2 <- data.frame(y,x,control)
      
      model <- lm(y ~ ., data = datatemp2) %>% 
        broom::tidy() %>% 
        mutate(term = ifelse(term == "(Intercept)", "constante", 
                             ifelse(str_detect(term, "x"), str_replace(term, "x", names(d[as.numeric(input$iv)])),  
                                           ifelse(str_detect(term, "control"), str_replace(term, "control", names(d[as.numeric(input$controls)])), term)))) %>% # ifelse(str_detect(term, "control"), str_remove(term, "control") # names(d[as.numeric(input$controls)])
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
     need(input$dv, 'Les résultats apparaîtront lorsque vous aurez sélectionné une variable dépendante et une variable indépendante.'),
     need(input$iv, ' ')
     )
   
   modelfits()
   
  })
  
  ##### outputs, regressions (raw) ####
  output$regression_stats <- renderPrint({
    
    validate(
      need(input$dv, 'Les résultats apparaîtront lorsque vous aurez sélectionné une variable dépendante et une variable indépendante.'),
      need(input$iv, ' ')
    )
    
    y <- d[, as.numeric(input$dv)] 
    x <- d[, as.numeric(input$iv)]
    control <- d[, as.numeric(input$controls)]
    datatemp <- data.frame(y,x,control)
    
    fit <- lm(y ~ ., data = datatemp)
    print("Nombre d'observations:")
    nobs(fit) 
    # si j'ajoute d'autres infos == faire une liste avec tout et imprimer la liste
  })
  
}


##### Run the app ####
shinyApp(ui = ui, server = server)
# runApp("appli-cours")
# library(rsconnect)
# rsconnect::deployApp('appli-cours')
