################### Devoir informatique pour sciences sociales ##########################

############################# telechargement des packages ###############################
library(rvest)
library(dplyr)
library(ggplot2)

############################### Importation des donnees #################################
url<-"https://www.skysports.com/world-cup-table"
dataread<-rvest::read_html(url)
dataread 
NbreTableau<-rvest::html_table(dataread)# Importer les tableaux de la page web
length(NbreTableau) # calculons le nombre de tableau de la page web

############################# Creation de la fonction ###################################
Fresult_foot<-function(){
  url<-"https://www.skysports.com/world-cup-table"
  dataread<-rvest::read_html(url)
  NbreTableau<-rvest::html_table(dataread)
  Compilation<-do.call(rbind, list(NbreTableau[[1]],NbreTableau[[2]],NbreTableau[[3]],NbreTableau[[4]],NbreTableau[[5]],NbreTableau[[6]],NbreTableau[[7]],NbreTableau[[8]]))
  Compilation<-Compilation[,-1]
  Compilation<-Compilation[,-10]
  return(Compilation)
}
df_Compilation<-Fresult_foot()
str(df_Compilation)

##################################### diagramme ########################################
df_Compilation%>%group_by(Pts)%>%arrange(desc(Pts))%>%head(10)%>%
  ggplot(aes(y=Team,x=Pts))+geom_bar(stat='identity',fill='blue')+theme_classic()

