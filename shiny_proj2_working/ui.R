
shinyUI(dashboardPage(
  skin='green',

dashboardHeader(title='U.S. Foreign Aid' 
                #titleWidth = 450
                ),

dashboardSidebar(
  
  sidebarMenu(
    menuItem(
      'Start',
      tabName = 'start',
      icon = icon('comment-o')
    ),
    
    
    menuItem(
      'By Region',
      tabName = 'country',
      icon = icon('globe')
    ),
    
    menuItem(
      'By Sector',
      tabName = 'sector',
      icon = icon('usd')
    ),
    
    menuItem(
      'About',
      tabName = 'about',
      icon = icon('question')
    )
  )
),


dashboardBody(
  tabItems(
    tabItem(tabName = "start",
            h2('U.S. Foreign Aid Dashboard'),
            
            fluidRow(
              box(
                p('Welcome!', br(),
                  'Explore  U.S. Foreign Assistance across various sectors, implementing agencies 
                  to other regions from 2001 to 2017.'),
                width=12
              )
            ),
            
            
            fluidRow(
              box(
                img(src='https://www.usaid.gov/sites/default/files/styles/home_carousel/public/carousel/CAR_March2015.jpg?itok=wLudXER-',
                    width='100%')
                
                #align='center'
              ),
              
              box(
                img(src='https://www.usaid.gov/sites/default/files/styles/732_width/public/nodeimage/External_Website_1_0.JPG?itok=p-mmV9Rk',
                    width='100%')
                
                #align='center'
              ),
              box(
                img(src='https://www.usaid.gov/sites/default/files/styles/home_carousel/public/carousel/Bangladesh-Monjuaras_dream.jpg?itok=zKQvlVSb',
                    width='100%')
                
                #align='center'
              ),
              box(
                img(src='https://www.usaid.gov/sites/default/files/styles/home_carousel/public/carousel/iraq_humassist2014.jpg?itok=dJPnrVKZ',
                    width='100%')
                
                #align='center'
              )
              
            )  #fluid row end
              
              
    ),#end of start tab 
    
    
    
     #########################AID by Country###################################   
    
     tabItem(tabName = "country",
             h2('AID BY REGION'),
             
             fluidRow(
               box(
                 p('Welcome! This page displays information about  
top agencies, contributing to each region in top sectors.'),
                 width=12
               )
             ),
             fluidRow(
               box(
                 selectInput(
                   'country',
                   label=h4('Select Region'),
                   choices = sort(country.names)
                 ),
                 width=3,
                 height=110
               ),
               
               box(
                 selectInput(
                   'year',
                   label=h4('Select Year'),
                   choices = years
                 ),
                 width=3,
                 height=110
               ),
               
               box(
                 checkboxGroupInput(
                   'obli',
                   label=h4('Transaction Type'),
                   choices = transactions,
                   selected= 'Disbursements'
                 ),
                 width=3.5,
                 height=110 )
               
               
             ),#fluid row2 end
             
             fluidRow(
               box(
                 plotlyOutput('line', width='100%', height='100%'),
                 width=27,
                 height=500
               )       
             ),
             
             fluidRow(
               box(
                 plotlyOutput('rchartsector', width='100%'),
                 width=27
               )),
               
               
              fluidRow(
               box(
                 plotlyOutput('rchartimpl', width='100%'),
                 width=27
               )
             )
             
             
             
             
     ),  #country tab item end
############################Sector##############################
    
    tabItem(
      tabName = 'sector',
      h2('AID BY SECTOR'),
      fluidRow(
        box(
          p('Welcome! This page displays information about top regions (receiving) and top agencies (contributing) in each sector.'),
          width=12
        )
      ),
      
      
      fluidRow(
        box(
          selectInput(
            'sect',
            label=h4('Select Sector'),
            choices = sort(sector.names)
          ),
          width=3,
          height=110
        ),
        
        box(
          selectInput(
            'secyear',
            label=h4('Select Year'),
            choices = years
          ),
          width=3,
          height=110
        ),
        box(
          checkboxGroupInput(
            'oblisec',
            label=h4('Transaction Type'),
            choices = transactions,
            selected= 'Disbursements'
          ),
          width=3.5,
          height=110)
        
        
      ),#fluid row2 end
      
      
      fluidRow(
        box(
          plotlyOutput('linesec', width='100%', height='100%'),
          width=27,
          height=500
        )       
      ),
      
      fluidRow(
        box(
          plotlyOutput('rchartcountry', width='100%'),
          width=27
        )),
      
      
      fluidRow(
        box(
          plotlyOutput('rsecchartimpl', width='100%'),
          width=27
        )
      )
      
      
      
      
    ),  #sec tab item end
    
###########################################################################
    tabItem(tabName = "about",
            h2('About'),
            fluidRow(
              
              box(
                'Code: ', a(href='mailto:jaislp3@gmail.com', 'Lakshmi Prabha Sudharsanom'), br(),
                'Data: ', a(href='https://www.usaid.gov/', 'USAID'), br(),
                br(),
                'This project has no affiliation with USAID.',
                'It\'s build on top of their freely',
                a(href='https://explorer.usaid.gov/query', 'available data'),
                'as part of the', a(href='https://nycdatascience.com/data-science-bootcamp/', 'NYC Data Science Academy Data Science Bootcamp.')
                )
              )
          ) #tab item 'about' end 

    )# all tab items end
)#body end

))  #shinyUI & dashboard (first line code end)