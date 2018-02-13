
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
    group_by(Fiscal_Year, Transaction_type) %>%
    summarize(Total = sum(Current_amount))
  
  m = filter(c, Fiscal_Year==year)
  
     p= ggplot(c, aes(x = Fiscal_Year, y = Total, group=Transaction_type)) +
     geom_line(aes(color=Transaction_type)) + geom_point(aes(color=Transaction_type)) +
     annotate('point', x=m$Fiscal_Year, y=m$Total,  color='green', size=3)+
     #annotate('text', x=m$Fiscal_year,y=m$Total+m$Total/10)+
    #label = as.character(m$Total)
     labs(title =  "Line Graph for Seventeen Years", x='Fiscal Year') +
      theme(axis.text.x  = element_text(size=8, angle=45))+
       theme(axis.title.x = element_text(margin = unit(c(14, 0, 0, 0), "mm") ))
      
      #axis.ticks = element_blank()
     #print (p)
     #xtitle <- list(title = "Fiscal Year", tickangle=45, titlefont=f)
     ytitle <- list(
       title = "Total Transaction (USD)",
       tickangle=45,
       titlefont = f
     )
     
  ggplotly(p)  %>% layout(yaxis=ytitle)
} #line chart end    
      
 ####################row charts##########################       
rsecChart = function(data, country, year) {    
small=c(year, '2016', '2011')
  
  cfilter = data %>% 
    filter(Region==country, Fiscal_Year%in% small, Transaction_type=='Disbursements') %>%
    group_by(Sector, sect, Fiscal_Year) %>% 
      summarize(Total = sum(Current_amount)) %>%
      filter(Total>100000) %>%
      arrange(desc(Total))
  
 
  if (dim(cfilter)[1] >=20){
        c = cfilter[1:20,]
  }else  {
           c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Sector,levels=rev(c$Sector))
  
               
 p =ggplot(c, aes(x = sect, y =Total, fill= Fiscal_Year, label=Sector)) +
        #geom_bar(stat='identity', position=position_dodge()) + 
      geom_col() + 
      facet_wrap(~Fiscal_Year)+
        #coord_flip()+
        labs(title = 'Top Sectors-Disbursements', x='', y='') +
        theme(axis.text.x  = element_text(size=8, angle=90)) 
       # axis.ticks = element_blank())
 #xtitle <- list(
 #  title = "",
 #  tickangle=60,
  # titlefont = f
 #) 
 
 ytitle <- list(
   title = "Total Transaction (USD)",
   tickangle=45,
   titlefont = f
 )
 
 
 
   
ggplotly(p) %>% layout(yaxis=ytitle, showlegend=FALSE)
 
#} 

  
  
} #rcchart end

###rimplchart
rimplChart = function(data, country, year) { 
  small = c(year, '2016', '2011')
  cfilter = data %>% 
    filter(Region==country, Fiscal_Year%in% small, Transaction_type=='Disbursements') %>%
  
    group_by(Implementing_agency, Impl, Fiscal_Year) %>% 
    summarize(Total = sum(Current_amount)) %>%
    filter(Total>100000) %>%
    arrange(desc(Total))
  
  if (dim(cfilter)[1] >=20){
    c = cfilter[1:20,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Implementing_agency,levels=rev(c$Implementing_agency))
  
  
  p =ggplot(c, aes(x=Impl, y =Total, fill=Fiscal_Year, label =Implementing_agency)) +
    geom_col() + facet_wrap(~Fiscal_Year) +
    #coord_flip()+
    labs(title = 'Top Implementing Agencies-Disbursements', x='', y='')+
    theme(axis.text.x  = element_text(size=8, angle=90)) 
    
    #xtitle <- list(
    #  title = "",
    #  tickangle=60,
    #  titlefont = f
    #) 
    
    ytitle <- list(
      title = "Total Transaction (USD)",
      tickangle=45,
      titlefont = f
    )
    
    
    
    
    ggplotly(p) %>% layout(yaxis=ytitle, showlegend=FALSE)
    
} #rfchart end
#############################################################
##################################Sector##################

#########################line##################################  
linesecChart = function(data, sector, year, trans) {
  c = data %>% 
    filter(Sector==sector, Transaction_type %in% trans) %>%
    group_by(Fiscal_Year, Transaction_type) %>%
    summarize(Total = sum(Current_amount))
  
  m=filter(c, Fiscal_Year==year)
  #######
  
  p= ggplot(c, aes(x = Fiscal_Year, y = Total, group=Transaction_type)) +
    geom_line(aes(color=Transaction_type)) + geom_point(aes(color=Transaction_type)) +
    annotate('point', x=m$Fiscal_Year, y=m$Total,  color='green', size=3)+
    #annotate('text', x=m$Fiscal_year, y=m$Total+m$Total/10, label = )+
    labs(title =  "Line Graph for Seventeen Years", x="Fiscal Year") +
    theme(axis.text.x  = element_text(size=8, angle=45))+
    theme(axis.title.x = element_text(margin = unit(c(14, 0, 0, 0), "mm") ))
  
    
  #print (p)
  #xtitle <- list(title = "Fiscal Year", tickangle=45, titlefont=f)
  ytitle <- list(
    title = "Total Transaction (USD)",
    tickangle=45,
    titlefont = f
  )
  ggplotly(p) %>% layout(yaxis=ytitle)
} #line chart end    

###########################row charts###############################


#rcountrychart
rcountryChart = function(data, sector, year) {    
  small=c(year, '2016', '2011')
  cfilter = data %>% 
    filter(Sector==sector, Fiscal_Year%in%small, Transaction_type=='Disbursements') %>%
    group_by(Region, Fiscal_Year) %>% 
      summarize(Total = sum(Current_amount)) %>%
    filter(Total>100000) %>%
    arrange(desc(Total))
  
  if (dim(cfilter)[1] >=20){
    c = cfilter[1:20,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  #name=factor(c$Region, levels=rev(c$Region))
  
  
  p =ggplot(c, aes(x =Region , y =Total, fill=Fiscal_Year)) +
    geom_col() + facet_wrap(~Fiscal_Year) +
    #coord_flip()+
    labs(title = 'Top Regions-Disbursements', x='', y='') +
    theme(axis.text.x  = element_text(size=8, angle=90))
    
  #xtitle <- list(
  #  title = "",
  #  tickangle=60,
  #  titlefont = f
  #) 
  
  ytitle <- list(
    title = "Total Transaction (USD)",
    tickangle=45,
    titlefont = f
  )
  
  
  
  
  ggplotly(p) %>% layout(yaxis=ytitle, showlegend=FALSE)
  
  
} #rcountrychart end





###rsecimplchart
rsecimplChart = function(data, sector, year) { 
  small = c(year, '2016', '2011')
  cfilter = data %>% 
    filter(Sector==sector, Fiscal_Year%in%small, Transaction_type=='Disbursements') %>%
    group_by(Implementing_agency, Impl,  Fiscal_Year) %>% 
      summarize(Total = sum(Current_amount)) %>%
    filter(Total>100000) %>%
    arrange(desc(Total))
  
  if (dim(cfilter)[1] >=20){
    c = cfilter[1:20,]
  }else {
    c =cfilter[1:dim(cfilter)[1], ]
  }
  
  
  
  p =ggplot(c, aes(x=Impl,  y = Total, fill=Fiscal_Year, label = Implementing_agency)) +
    geom_col() + facet_wrap(~Fiscal_Year ) +
    #coord_flip()+
    #scale_x_continuous(limits=c(0, max(c$Total) ))+
    labs(title = 'Top Implementing Agencies-Disbursements', x='', y='')+
    theme(axis.text.x  = element_text(size=8, angle=90))
    
  
  #xtitle <- list(
  #  title = "",
  #  tickangle=60,
   # titlefont = f
  #) 
  
  ytitle <- list(
    title = "Total Transaction (USD)",
    tickangle=45,
    titlefont = f
  )
  
  
  
  
  ggplotly(p) %>% layout(yaxis=ytitle, showlegend=FALSE)
  
} #rfchart end

















