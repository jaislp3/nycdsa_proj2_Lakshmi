
###############All Charts#################################################
f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)


##########################

########################line################################
lineChart = function(data, country, year, trans) {
  c = data %>% 
    filter(Region==country, Transaction_type %in% trans) %>%
    group_by(Fiscal_year, Transaction_type) %>%
    summarize(Total = sum(Current_amount))
  
  m = filter(c, Fiscal_year==year)
 #######
#########################line##################################  
     p= ggplot(c, aes(x = Fiscal_year, y = Total, group=Transaction_type)) +
     geom_line(aes(color=Transaction_type)) + geom_point(aes(color=Transaction_type)) +
     annotate('point', x=m$Fiscal_year, y=m$Total,  color='green', size=3)+
     #annotate('text', x=m$Fiscal_year,y=m$Total+m$Total/10)+
    #label = as.character(m$Total)
     labs(title =  "Line Graph for Seventeen Years", x='Fiscal year') +
      theme(
      axis.text.x = element_blank(),
      axis.ticks = element_blank())
     #print (p)
     #xtitle <- list(title = "Fiscal Year", titlefont=f)
     ytitle <- list(
       title = "Total Transaction (USD)",
       tickangle=45,
       titlefont = f
     )
     
  ggplotly(p)  %>% layout(yaxis=ytitle)
} #line chart end    
      
 ####################bar charts##########################       
rsecChart = function(data, country, year) {    
small=c(year, 2016, 2017, 2011)
  
  cfilter = data %>% 
    filter(Region==country, Fiscal_year %in% small, Transaction_type=='Disbursements') %>%
    group_by(Sector, Fiscal_year) %>% 
      summarize(Total = sum(Current_amount)) %>%
      arrange(desc(Total))
  
 
  if (dim(cfilter)[1] >=50){
        c = cfilter[1:50,]
  }else  {
           c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Sector,levels=rev(c$Sector))
  Fiscal_Year = as.character(c$Fiscal_year)
               
 p =ggplot(c, aes(x = Sector, y =Total, fill= Fiscal_Year)) +
        geom_col(position = 'dodge') + 
        #coord_flip()+
        labs(title = 'Top Sectors-Disbursements', x="", y="") +
      theme(
        axis.text.x = element_blank(),
        axis.ticks = element_blank())
#print (p)
 xtitle <- list(title = "Total Transaction (USD)", titlefont=f)
 #ytitle <- list( title = "" )
 
 #if (dim(cfilter)[1]!=0){
   
ggplotly(p) 
#%>% layout(xaxis = xtitle)
 
#} 

  
  
} #rcchart end

###rimplchart
rimplChart = function(data, country, year) { 
  small = c(year, 2016, 2017, 2011)
  cfilter = data %>% 
    filter(Region==country, Fiscal_year%in% small, Transaction_type=='Disbursements') %>%
  
    group_by(Implementing_agency, Fiscal_year) %>% 
    summarize(Total = sum(Current_amount)) %>%
    arrange(desc(Total))
  
  if (dim(cfilter)[1] >=50){
    c = cfilter[1:50,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Implementing_agency,levels=rev(c$Implementing_agency))
  Fiscal_Year = as.character(c$Fiscal_year)
  
  p =ggplot(c, aes(x =Implementing_agency , y =Total, fill=Fiscal_Year )) +
    geom_col(position='dodge') + 
    #coord_flip()+
    labs(title = 'Top Implementing Agencies-Disbursements', x="", y="") +
    theme(
      axis.text.x = element_blank(),
      axis.ticks = element_blank())
  
  #print (p)
  
  xtitle <- list(title = "Total Transaction (USD)", titlefont=f)
  ytitle <- list( title = "" )
  
  ggplotly(p) 
  #%>% layout(xaxis=xtitle)
  
} #rfchart end
#############################################################
##################################Sector##################

#########################line##################################  
linesecChart = function(data, sector, year, trans) {
  c = data %>% 
    filter(Sector==sector, Transaction_type %in% trans) %>%
    group_by(Fiscal_year, Transaction_type) %>%
    summarize(Total = sum(Current_amount))
  
  m=filter(c, Fiscal_year==year)
  #######
  
  p= ggplot(c, aes(x = Fiscal_year, y = Total, group=Transaction_type)) +
    geom_line(aes(color=Transaction_type)) + geom_point(aes(color=Transaction_type)) +
    annotate('point', x=m$Fiscal_year, y=m$Total,  color='green', size=3)+
    #annotate('text', x=m$Fiscal_year, y=m$Total+m$Total/10, label = )+
    labs(title =  "Line Graph for Seventeen Years", x='Fiscal Year') +
    theme(
      axis.text.x = element_blank(),
      axis.ticks = element_blank())
  #print (p)
  
  xtitle <- list(title = "Fiscal Year", titlefont=f)
  ytitle <- list(
    title = "Total Transaction (USD)",
    tickangle=45,
    titlefont = f
  )
  ggplotly(p) %>% layout(yaxis=ytitle)
} #line chart end    

###########################bar charts###############################


#rcountrychart
rcountryChart = function(data, sector, year) {    
  small=c(year, 2016, 2017, 2011)
  cfilter = data %>% 
    filter(Sector==sector, Fiscal_year%in%small, Transaction_type=='Disbursements') %>%
    group_by(Region, Fiscal_year) %>% 
      summarize(Total = sum(Current_amount)) %>%
      arrange(desc(Total))
  
  if (dim(cfilter)[1] >=50){
    c = cfilter[1:50,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Region, levels=rev(c$Region))
  Fiscal_Year = as.character(c$Fiscal_year)
  
  p =ggplot(c, aes(x =Region , y =Total, fill=Fiscal_Year)) +
    geom_col(position='dodge') + 
    #coord_flip()+
    labs(title = 'Top Regions-Disbursements', x="", y="") +
    theme(
      axis.text.x = element_blank(),
      axis.ticks = element_blank())
  #print (p)
  
  xtitle <- list(title = "Total Transaction (USD)", titlefont=f)
  ytitle <- list( title = "" )
  
ggplotly(p) 
#%>% layout(xaxis=xtitle)
  
} #rcountrychart end





###rsecimplchart
rsecimplChart = function(data, sector, year) { 
  small = c(year, 2016, 2017, 2011)
  cfilter = data %>% 
    filter(Sector==sector, Fiscal_year%in%small, Transaction_type=='Disbursements') %>%
    group_by(Implementing_agency, Fiscal_year) %>% 
      summarize(Total = sum(Current_amount)) %>%
      arrange(desc(Total))
  
  if (dim(cfilter)[1] >=50){
    c = cfilter[1:50,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  
  #name = factor(c$Implementing_agency,levels=rev(c$Implementing_agency))
  Fiscal_Year = as.character(c$Fiscal_year)
  
  p =ggplot(c, aes(x = Implementing_agency, y = Total, fill=Fiscal_Year)) +
    geom_col(position='dodge') + 
    #coord_flip()+
    #scale_x_continuous(limits=c(0, max(c$Total) ))+
<<<<<<< HEAD
    labs(title = 'Top Implementing Agencies-Disbursements', x="", y="")+
=======
    labs(title = 'Top Implementing Agencies-Disbursements', x="", y="") +
>>>>>>> 6188a4ecdda228e99aa7eacb9eb9b413cb1e56a9
    theme(
      axis.text.x = element_blank(),
      axis.ticks = element_blank())
  
  #print (p)
  
  xtitle <- list(title = "Total Transaction (USD)", titlefont=f)
  ytitle <- list( title = "" )
  
ggplotly(p) 
#%>% layout(xaxis=xtitle)
  
} #rfchart end

















