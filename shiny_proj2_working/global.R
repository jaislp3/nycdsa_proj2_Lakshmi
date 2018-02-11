library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
#library(tidyquant)
library(plotly)
#library(leaflet)
#library(scales)

source('helpers.R')

#########################################################

###################################Fresh start#############################
us_aidd = read.csv('./data/us_aiddrhuge.csv', stringsAsFactors=FALSE)
#reading from current directory



#years = min(us_aidd$Fiscal_year):max(us_aidd$Fiscal_year)
years=2001:2017

#us_aid = us_aidd %>% filter(Current_amount>=0)
us_aid = us_aidd %>% arrange(desc(us_aidd$Fiscal_year)) 
#%>% arrange(desc(fiscal_year))

country.names = unique(us_aid$Country)
sector.names = unique(us_aid$Sector)
transactions = unique(us_aid$Transaction_type)

colnames(us_aid)[2]="Region"
###########################################################################
