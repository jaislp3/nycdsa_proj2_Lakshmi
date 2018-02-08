
# coding: utf-8

# In[ ]:


from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import re
from bs4 import BeautifulSoup

col1_list = []
col2_list = []
col3_list = []
col4_list = []
col5_list = []
col6_list = []
col7_list = []

current_button=None
next_button=None

driver = webdriver.Chrome('C:/Users/My/chromedriver.exe')

#driver = webdriver.Firefox()
#assert "U.S. Agency for International Develpoment" in driver.title
# Go to the page that we want to scrape
driver.get("https://explorer.usaid.gov/query")
time.sleep(90)   #during this time, apply filters: Set transaction type: Disbursements, 100 per page 


index=1
while True:
    try:
        time.sleep(90)
            #if current_button is not None:
            #    WebDriverWait(driver, 10).until(EC.staleness_of(prev_button))
        print("Scraping Page number " + str(index))
        index = index + 1

        pagesource = driver.page_source
        soup = BeautifulSoup(pagesource, 'html.parser')
        table = soup.find(class_='table-content')
        tr = table.find_all('tr')

        for row in tr:
            cells = row.find_all('td')

            if len(cells) ==7:
                col1_list.append(cells[0].find(text=True))
                col2_list.append(cells[1].find(text=True))
                col3_list.append(cells[2].find(text=True))
                col4_list.append(cells[3].find(text=True))
                col5_list.append(cells[4].find(text=True))
                col6_list.append(cells[5].find(text=True))
                col7_list.append(cells[6].find(text=True))

        page = soup.find(class_="page-navigator")
        current_page = page.find('span', {'data-reactid':".0.2.3.1.4.0.1"}).text
        tot_page = page.find('span', {'data-reactid':".0.2.3.1.4.0.3"}).text

        if current_page!=tot_page:
            wait_button = WebDriverWait(driver, 10)
            next_button = wait_button.until(EC.element_to_be_clickable((By.CLASS_NAME, 'nextButton')))
            current_button = next_button
            next_button.click()
        else:
            driver.close()

    
    except Exception as e:
        print(e)        
        break
        

        


# In[ ]:


import pandas as pd
us_aid = pd.DataFrame(col1_list, columns=['Activity'])
                       


us_aid['Country'] = col2_list

us_aid['Implementing_agency'] = col3_list

us_aid['Sector'] = col4_list
us_aid['Funding_ac'] = col5_list
us_aid['Fiscal_year'] = col6_list
us_aid['Current_amount'] = col7_list

                       
                       
#print(us_aid.head().T)
us_aid.info()


# #cleaning

# In[68]:


new = us_aid.Current_amount.apply(lambda x: x.replace(',', ''))
new=new.apply(lambda x:x.replace('$',''))


# In[69]:



#dont run more than once
new = new.astype('float')
new
us_aid.Current_amount= new


# In[70]:


us_aid.Fiscal_year = us_aid.Fiscal_year.astype('str')
us_aid.Country = us_aid.Country.astype('str')
us_aid.Implementing_agency = us_aid.Implementing_agency.astype('str')
us_aid.Sector = us_aid.Sector.astype('str')
us_aid.Funding_ac = us_aid.Funding_ac.astype('str')


# In[98]:


us_aid = us_aid.loc[us_aid.Country!='None', ]  # do this after converting to character

#us_aid.info()


# In[72]:


us_aid = us_aid.loc[us_aid.Current_amount>=0, ]         #filtering positive amounts
#us_aid.info()


# In[80]:


us_aid.Current_amount= us_aid.Current_amount.astype(np.int64)
us_aid.Fiscal_year = us_aid.Fiscal_year.astype(np.int64)
#us_aid.info()


# In[97]:


#us_aid.info()


# In[96]:


#Dont run more than once
us_aid.to_csv('C:/Users/My/us_aidd.csv', encoding='utf-8')


# #Manipualtion

# In[94]:



group_country = us_aid.groupby(['Country'])['Current_amount'].agg(['count', 'sum', 'max','min'])
#.sort_values(by='sum')
print(group_country.size)
#.sort_values(by='total'))


# In[95]:


group_sector = us_aid.groupby(['Sector'])[['Current_amount']].agg(['count', 'sum', 'max','min'])
#.sort_values(by='sum')
print(group_sector.size)
#.sort_values(by='total'))


# In[64]:


group_country_yr = us_aid.groupby(['Country','Fiscal_year'])['Current_amount'].sum().sort_values(ascending=False)
print(group_country_yr.size)
      #


# In[84]:


group_sector_yr = us_aid.groupby(['Sector', 'Fiscal_year'])['Current_amount'].sum().sort_values(ascending=False)
print(group_sector_yr.size)


# In[87]:


group_csecyr = us_aid.groupby(['Country', 'Sector','Fiscal_year'])['Current_amount'].sum().sort_values(ascending=False)
group_csecyr.size
#.sort_values(by='current_amount')

