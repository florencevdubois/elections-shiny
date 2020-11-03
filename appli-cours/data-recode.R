library(tidyverse)

dat <- read.csv("appli-cours/data/sondage_raw.csv", sep = ";")

#### Recode ####
summary(dat)

dat <- dat %>% 
  mutate(securite_immigration = NA, # question retirée ex-post
         influence_medias = NA, # question retirée ex-post
         sophistication_etatsunis = ifelse(sophistication_etatsunis == 2, 1, 0),
         sophistication_freeland = ifelse(sophistication_freeland == 5, 1, 0),
         sophistication_legault = ifelse(sophistication_legault == 4, 1, 0),
         sophistication_macron = ifelse(sophistication_macron == 2, 1, 0),
         sophistication_pence = ifelse(sophistication_pence == 3, 1, 0),
         sophistication_singh = ifelse(sophistication_singh == 1, 1, 0),
         vote_quebec2018_CAQ = ifelse(quebec_2018 == 1, 1, 0),
         vote_quebec2018_PQ = ifelse(quebec_2018 == 2, 1, 0),
         vote_quebec2018_PLQ = ifelse(quebec_2018 == 3, 1, 0),
         vote_quebec2018_QS = ifelse(quebec_2018 == 4, 1, 0),
         vote_quebec2018_vert = ifelse(quebec_2018 == 5, 1, 0),
         vote_quebec2018_autre = ifelse(quebec_2018 == 6, 1, 0),
         vote_quebec2018_bulletinnul = ifelse(quebec_2018 == 7, 1, 0),
         vote_quebec2018_pasvote = ifelse(quebec_2018 == 8, 1, 0),
         vote_france_enmarche = ifelse(vote_france == 1, 1, 0),
         vote_france_republicains = ifelse(vote_france == 2, 1, 0),
         vote_france_verts = ifelse(vote_france == 3, 1, 0),
         vote_france_PS = ifelse(vote_france == 4, 1, 0),
         vote_france_RN = ifelse(vote_france == 5, 1, 0),
         vote_france_insoumise = ifelse(vote_france == 6, 1, 0),
         vote_canada_liberal = ifelse(vote_canada == 1, 1, 0),
         vote_canada_conservateur = ifelse(vote_canada == 2, 1, 0),
         vote_canada_npd = ifelse(vote_canada == 3, 1, 0),
         vote_canada_bloc = ifelse(vote_canada == 4, 1, 0),
         vote_canada_vert = ifelse(vote_canada == 5, 1, 0),
         vote_canada_autre = ifelse(vote_canada == 6, 1, 0),
         vote_quebec_CAQ = ifelse(vote_quebec == 1, 1, 0),
         vote_quebec_PQ = ifelse(vote_quebec == 2, 1, 0),
         vote_quebec_PLQ = ifelse(vote_quebec == 3, 1, 0),
         vote_quebec_QS = ifelse(vote_quebec == 4, 1, 0),
         vote_quebec_vert = ifelse(vote_quebec == 5, 1, 0),
         vote_quebec_autre = ifelse(vote_quebec == 6, 1, 0)) 

table(dat$securite_immigration)
table(dat$influence_medias)
table(dat$vote_nationaliste)
table(dat$vote_strategique)

table(dat$sophistication_etatsunis)
table(dat$sophistication_freeland)
table(dat$sophistication_legault)
table(dat$sophistication_macron)
table(dat$sophistication_pence)
table(dat$sophistication_singh)

table(dat$quebec_2018, dat$vote_quebec2018_CAQ)
table(dat$quebec_2018, dat$vote_quebec2018_PQ)
table(dat$quebec_2018, dat$vote_quebec2018_PLQ)
table(dat$quebec_2018, dat$vote_quebec2018_QS)
table(dat$quebec_2018, dat$vote_quebec2018_vert)
table(dat$quebec_2018, dat$vote_quebec2018_autre)
table(dat$quebec_2018, dat$vote_quebec2018_bulletinnul)
table(dat$quebec_2018, dat$vote_quebec2018_pasvote)

table(dat$vote_quebec, dat$vote_quebec_CAQ)
table(dat$vote_quebec, dat$vote_quebec_PQ)
table(dat$vote_quebec, dat$vote_quebec_PLQ)
table(dat$vote_quebec, dat$vote_quebec_QS)
table(dat$vote_quebec, dat$vote_quebec_vert)
table(dat$vote_quebec, dat$vote_quebec_autre)

table(dat$vote_canada, dat$vote_canada_liberal)
table(dat$vote_canada, dat$vote_canada_conservateur)
table(dat$vote_canada, dat$vote_canada_npd)
table(dat$vote_canada, dat$vote_canada_bloc)
table(dat$vote_canada, dat$vote_canada_vert)
table(dat$vote_canada, dat$vote_canada_autre)

table(dat$vote_france, dat$vote_france_enmarche)
table(dat$vote_france, dat$vote_france_republicains)
table(dat$vote_france, dat$vote_france_verts)
table(dat$vote_france, dat$vote_france_PS)
table(dat$vote_france, dat$vote_france_RN)
table(dat$vote_france, dat$vote_france_insoumise)

#### Reorder variables ####
dat <- dat %>% 
  dplyr::select(annee_naissance, age, emploi, revenu, genre, citoyennete, ethnie, minorite, education, religion, reseau_social, residence, naissance_pays_residence, cohabitation, droit_vote,
          province, naissance_province_residence, classe_sociale, classe_sociale_parents, langue, province_naissance_parents, pays_naissance_parents, climat_social, covid_satisfaction,
          covid_soin, covid_gestion, covid_inquietude, covid_jeune, covid_politiques, immigration_ouverture, immigration_syrie, climat_economie, transition_energetique_taxes,
          climat_impact, confiance_police, securite_quartier, securite_gouvernement, securite_immigration, securite_frontieres, immigration_quotas, minorites_partis, corruption,
          corruption_participation, corruption_evaluation_partis, mondialisation, economie_sociotropique, economie_egotropique, economie_satisfaction, economie_preoccupation, 
          economie_criteres, economieCANADA_confiance, economieFRANCE_confiance, immigrationCANADA_confiance, immigrationFRANCE_confiance, deficit, representation_minorites, enjeux_chomage,
          enjeux_environnement, enjeux_immigration, enjeux_economie, enjeux_education, enjeux_sante, importance_immigration, importance_ecologie, inquietude_attentats, ideologie,
          satisfaction_democracie, satisfaction_gouvernement, institutions_democratiques, vote_demonstration, confiance_ChefEtat, altruisme_politiques, education_civique, ecoles,
          comprehension_elites, importance_vote, importance_representation, disproportion_electorale, partis_votes, votes_objectif, votes_delais, reedition_compte, importance_chef,
          interet_politique, interet_politiqueUS, connaissances_politiqueUS, engagement_politique, proche_parti, importance_traits, trait_integrite, trait_leadership, trait_competence,
          trait_empathie, representation_partis, mode_scrutin, changement_scrutin, vote_nationaliste, integration_localite, parti_liberal, parti_conservateur, ndp, bloc_quebecois, parti_vert,
          source_information, reseausociaux_cause, medias_traditionnels, consultation_sondage1, consultation_sondageCANADA, consultation_sondageFRANCE, principale_source, engagement_reseauxsociaux,
          abonnements_personnalites, frequence_utilisation, inscription_reseauxsociaux, contact_information, plateforme, couverture_influence, medias_neutralite, influence_medias, biais_medias,
          chaines_independance, niveau_information, effet_debats, importance_debatsTV, confiance_contenuRS, confiance_TVRadio, confiance_presseecrite, site_parti, like_parti, sophistication_etatsunis,
          sophistication_freeland, sophistication_legault, sophistication_macron, sophistication_pence, sophistication_singh, participation, vote_quebec2018_CAQ, vote_quebec2018_PQ, vote_quebec2018_PLQ,
          vote_quebec2018_QS, vote_quebec2018_vert, vote_quebec2018_autre, vote_quebec2018_bulletinnul, vote_quebec2018_pasvote, vote_US, vote_habitude, vote_memeparti, vote_france_enmarche, 
          vote_france_republicains, vote_france_verts, vote_france_PS, vote_france_RN, vote_france_insoumise, vote_canada_liberal, vote_canada_conservateur, vote_canada_npd, vote_canada_bloc,
          vote_canada_vert, vote_canada_autre, vote_quebec_CAQ, vote_quebec_PQ, vote_quebec_PLQ, vote_quebec_QS, vote_quebec_vert, vote_quebec_autre, anciens_presidents, vote_strategique,
          aucune_preference, preference_parti, satisfaction_modescrutin, vote_chancesfavoris, importance_competence, motivation, premier_choix, strategie_vote2, autrechoix_frequence, 
          refus_voteCANADA, refus_voteFRANCE) %>% 
  arrange(annee_naissance, age, emploi, revenu, genre, citoyennete, ethnie, minorite, education, religion, reseau_social, residence, naissance_pays_residence, cohabitation, droit_vote,
          province, naissance_province_residence, classe_sociale, classe_sociale_parents, langue, province_naissance_parents, pays_naissance_parents, climat_social, covid_satisfaction,
          covid_soin, covid_gestion, covid_inquietude, covid_jeune, covid_politiques, immigration_ouverture, immigration_syrie, climat_economie, transition_energetique_taxes,
          climat_impact, confiance_police, securite_quartier, securite_gouvernement, securite_immigration, securite_frontieres, immigration_quotas, minorites_partis, corruption,
          corruption_participation, corruption_evaluation_partis, mondialisation, economie_sociotropique, economie_egotropique, economie_satisfaction, economie_preoccupation, 
          economie_criteres, economieCANADA_confiance, economieFRANCE_confiance, immigrationCANADA_confiance, immigrationFRANCE_confiance, deficit, representation_minorites, enjeux_chomage,
          enjeux_environnement, enjeux_immigration, enjeux_economie, enjeux_education, enjeux_sante, importance_immigration, importance_ecologie, inquietude_attentats, ideologie,
          satisfaction_democracie, satisfaction_gouvernement, institutions_democratiques, vote_demonstration, confiance_ChefEtat, altruisme_politiques, education_civique, ecoles,
          comprehension_elites, importance_vote, importance_representation, disproportion_electorale, partis_votes, votes_objectif, votes_delais, reedition_compte, importance_chef,
          interet_politique, interet_politiqueUS, connaissances_politiqueUS, engagement_politique, proche_parti, importance_traits, trait_integrite, trait_leadership, trait_competence,
          trait_empathie, representation_partis, mode_scrutin, changement_scrutin, vote_nationaliste, integration_localite, parti_liberal, parti_conservateur, ndp, bloc_quebecois, parti_vert,
          source_information, reseausociaux_cause, medias_traditionnels, consultation_sondage1, consultation_sondageCANADA, consultation_sondageFRANCE, principale_source, engagement_reseauxsociaux,
          abonnements_personnalites, frequence_utilisation, inscription_reseauxsociaux, contact_information, plateforme, couverture_influence, medias_neutralite, influence_medias, biais_medias,
          chaines_independance, niveau_information, effet_debats, importance_debatsTV, confiance_contenuRS, confiance_TVRadio, confiance_presseecrite, site_parti, like_parti, sophistication_etatsunis,
          sophistication_freeland, sophistication_legault, sophistication_macron, sophistication_pence, sophistication_singh, participation, vote_quebec2018_CAQ, vote_quebec2018_PQ, vote_quebec2018_PLQ,
          vote_quebec2018_QS, vote_quebec2018_vert, vote_quebec2018_autre, vote_quebec2018_bulletinnul, vote_quebec2018_pasvote, vote_US, vote_habitude, vote_memeparti, vote_france_enmarche, 
          vote_france_republicains, vote_france_verts, vote_france_PS, vote_france_RN, vote_france_insoumise, vote_canada_liberal, vote_canada_conservateur, vote_canada_npd, vote_canada_bloc,
          vote_canada_vert, vote_canada_autre, vote_quebec_CAQ, vote_quebec_PQ, vote_quebec_PLQ, vote_quebec_QS, vote_quebec_vert, vote_quebec_autre, anciens_presidents, vote_strategique,
          aucune_preference, preference_parti, satisfaction_modescrutin, vote_chancesfavoris, importance_competence, motivation, premier_choix, strategie_vote2, autrechoix_frequence, 
          refus_voteCANADA, refus_voteFRANCE)

custom_glimpse <- function(df) {
  data.frame(
    col_name = colnames(df),
    col_index = 1:ncol(df),
    col_class = sapply(df, class),
    row.names = NULL
  )
}
variable_nb <- custom_glimpse(dat)

#### Variables class ####
class(dat$education)
summary(dat$education)

#### Group variable types #####

# categorical variables - 102 variables
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
                           "Sécurité - immigration" = 38,
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
                           "Influence des médias sur l'élection" = 119,
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

# continuous variables - 31 variables
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

# categorical and dichotomous variables (for cross tabs)
cat_dicho_variables <- c(categorical_variables,  dichotomous_variables)

# dependent variables only (dichotomous or continuous)
dependent_variables <- c(continuous_variables, dichotomous_variables)

# all variables
variables <- c(categorical_variables, dichotomous_variables, continuous_variables)

# convert categorical and dichotomous variables to factor 
dat[cat_dicho_variables] <- sapply(dat[cat_dicho_variables], as.factor)
summary(dat$education)
summary(dat$genre)
table(dat$genre)
summary(dat$annee_naissance)
summary(dat$enjeux_chomage)
summary(dat$vote_strategique)

# paste column names to values of categorical variables
# test <- dat[categorical_variables]
# test[] <- paste(colnames(test), as.matrix(test), sep = "")
# table(test$ethnie)
# class(test)

#### Save ####

write.csv(dat, "appli-cours/data/sondage_recoded.csv")


###################


test <- read.csv("appli-cours/data/sondage_recoded.csv") %>% dplyr::select(-X)
y <- test[, as.numeric(test$age)]
y <- test %>% dplyr::select(trait_competence)
x <- test %>% dplyr::select(age)
df <- data.frame(y,x)

model <- lm(trait_competence ~ age, data = test) %>% 
  broom::tidy() %>% 
  mutate(term = ifelse(term == "(Intercept)", "constante", 
                       ifelse(term == "x", names(d[as.numeric(input$iv)]), term))) %>% # ifelse(str_detect(term, "x"), str_remove(term, "x"), 
  rename(` ` = term,
         Coefficient = estimate,
         `Erreur-type` = std.error,
         `Statistique t` = statistic,
         `Valeur p` = p.value)