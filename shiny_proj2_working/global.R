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
#years=2001:2017

#us_aid = us_aidd %>% filter(Current_amount>=0)
us_aid = us_aidd %>% arrange(us_aidd$Fiscal_year) 
#%>% arrange(desc(fiscal_year))

country.names = unique(us_aid$Country)

transactions = unique(us_aid$Transaction_type)

colnames(us_aid)[2]="Region"
###########################################################################
#Cleaning
us_aid = us_aid%>% filter(Sector!='Industry', Sector !='Program Design and Learning', Sector!='Communications')

sector.names = unique(us_aid$Sector)

#us_aid$sect = sapply(us_aid$Sector, function(x) {substr(x, 1,10)})
us_aid$sect  = us_aid$Sector

us_aid$sect = gsub(pattern = "Emergency Response", replacement = "Emergency", x = us_aid$sect, fixed=T)
us_aid$sect = gsub(pattern = "Basic Health", replacement = "Health", x = us_aid$sect)
us_aid$sect =gsub(pattern = "General Environmental Protection", replacement = "Environment", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Water Supply and Sanitation", replacement = "Water", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Energy", replacement = "Energy", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Trade Policy and Regulations", replacement = "Trade", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Maternal and Child Health, Family Planning", replacement = "Child", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Agriculture", replacement = "Agriculture", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Post-Secondary Education", replacement = "Post-Sec", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Conflict, Peace, and Security", replacement = "Peace", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Operating Expenses", replacement = "Op-Exp", x = us_aid$sect)
us_aid$sect =gsub(pattern = "HIV/AIDS", replacement = "HIV", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Developmental Food Aid/Food Security Assistance", replacement = "Food", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Government and Civil Society", replacement = "Civil", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Other Multisector", replacement = "Other-mul", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Disaster Prevention and Preparedness", replacement = "Disaster", x = us_aid$sect)
us_aid$sect =gsub(pattern = "Banking and Financial Services", replacement = "Bank", x = us_aid$sect)
us_aid$sect = gsub(pattern = "Communications", replacement = "Commu", x = us_aid$sect )
  us_aid$sect =gsub(pattern = "Health, General", replacement = "Gen-Health", x = us_aid$sect)
  
us_aid$sect =gsub(pattern = "Administration and Oversight", replacement = "Admin", x = us_aid$sect)
  us_aid$sect =gsub(pattern = "Transport and Storage", replacement = "Transport", x = us_aid$sect)
                     
  us_aid$sect =gsub(pattern = "Other Social Infrastructure and Services", replacement = "Social", x = us_aid$sect)
  us_aid$sect =gsub(pattern = "Basic Education", replacement = "Basic-Ed", x = us_aid$sect)
                     
  us_aid$sect =gsub(pattern = "Business and Other Services", replacement = "Business", x = us_aid$sect)
  us_aid$sect =gsub(pattern = "Mineral Resources and Mining", replacement = "Mineral", x = us_aid$sect )


us_aid$Region = gsub(pattern = "East Asia and Oceania Region", replacement = "East Asia and Oceania", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "Eastern Africa Region", replacement = "Eastern Africa", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "Europe Region", replacement = "Europe", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "Middle East Region", replacement = "Middle East", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "North Africa Region", replacement = "North Africa", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "South and Central Asia Region", replacement = "South and Central Asia", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "Southern Africa Region", replacement = "Southern Africa", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "West Africa Region", replacement = "West Africa", x = us_aid$Region, fixed=T)
us_aid$Region = gsub(pattern = "Western Hemisphere Region", replacement = "Western Hemisphere", x = us_aid$Region, fixed=T)

country.names = unique(us_aid$Region)
#us_aid$Implementing_agency = gsub(replacement = "U.S. Agency for International Development", pattern = "USAID", x = us_aid$Implementing_agency, fixed=T)
#######################################################################
us_aid$Impl = us_aid$Implementing_agency
us_aid$Impl = gsub(pattern = "U.S. Agency for International Development", replacement = "USAID", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Defense", replacement = "Defense", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Homeland Security", replacement = "Homeland", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of the Interior", replacement = "Interior", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of the Treasury", replacement = "Treasury", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of State", replacement = "State", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Energy", replacement = "Energy", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Commerce", replacement = "Commerce", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Justice", replacement = "Justice", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Health and Human Services", replacement = "HHS", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Environmental Protection Agency", replacement = "EPA", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Agriculture", replacement = "Agriculture", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Labor", replacement = "Labor", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Department of Transportation", replacement = "Transport", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Trade and Development Agency", replacement = "TDA", x = us_aid$Impl, fixed=T)
us_aid$Impl = gsub(pattern = "Federal Trade Commission", replacement = "FTC", x = us_aid$Impl, fixed=T)


us_aid$Date = paste(as.character(us_aid$Fiscal_year), "-01-01")
us_aid$Date = gsub(pattern=" ", replacement = "", x=us_aid$Date, fixed=T)
us_aid$Fiscal_Year = as.Date(us_aid$Date, format="%Y-%m-%d")
us_aid$Fiscal_Year = sapply(us_aid$Fiscal_Year, function(x){substr(x,1,4)})

years=unique(us_aid$Fiscal_Year)











