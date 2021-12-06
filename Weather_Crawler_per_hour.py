from selenium import webdriver
import selenium
import json 
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
from bs4 import BeautifulSoup, BeautifulStoneSoup, element
from selenium.webdriver.common.by import By 
import time 

File_Name ='Time_Weather.json'
location_number = ['6600100' , '6600200' , '6600300' , '6600400' ,'6600500' ,'6600600','6600700','6600800','6600900','6601000','66001100','6601200','6601300','6601400','6601500','6601600','6601700','6601800','6601900','6602000','6602100','6602200','6602300','6602400','6602500','6602600','6602700','6602800','6602900']
location_name =['中區','東區','南區','西區','北區','西屯區','南屯區','北屯區','豐原區','東勢區','大甲區','清水區','沙鹿區','梧棲區','后里區','神岡區','潭子區','大雅區','新社區','石岡區','外埔區','大安區','烏日區','大肚區','龍井區','霧峰區','太平區','大里區','和平區']
URL = "https://www.cwb.gov.tw/V8/C/W/County/County.html?CID=66"

options = Options()
options.add_argument("--disable-notifications")
chrome = webdriver.Chrome('./chromedriver',chrome_options=options)

total_data = []
location_weather = {}

def Write_Json_File():
    with open(File_Name ,'w')as wfp:
        json.dump(total_data,wfp,ensure_ascii=False)


# To stop the new window by opening the webdriver


# Open webdriver by URL

def crawler_func(i):

    # select location 
    time.sleep(2)
    chrome.execute_script("window.scrollTo(0, 300)")
    time.sleep(2)

    #alto Select block 
    #careful the find_element_by_* was not suppose by the newest version 
    location = chrome.find_element(By.XPATH , "//label[@for='TID']").click()


    #location.click()
    time.sleep(2)
    select = Select(chrome.find_element(By.ID , "TID"))
    select.select_by_value(location_number[i])

    #option = chrome.find_element(By.CSS_SELECTOR ,("option[value='6600100']"))
    #chrome.execute_script("arguments[0].click();",option)

    button = chrome.find_element(By.XPATH,"//button[@class='btn btn-default btn-block']")
    button.click()
    time.sleep(2)

    BeautifulSoup_func()
    #option = chrome.find_element(By.XPATH , "//option[@value='value']")
    #option.click()
    #time.sleep(2)

    # sleep , To avoid the crawler catch data when the web isn't complete finish 


def BeautifulSoup_func():
    #use beautifulsoup to get the data
    global location_weather
    location_weather['Time_and_Weather'] = []

    chrome.execute_script("window.scrollTo(0, 800)")
    time.sleep(3)
    #use html parser to get the data
    soup = BeautifulSoup(chrome.page_source , "html.parser")

    #the web data is on the item of table
    #And use id to find the table 
    table = soup.find("table",{"id":"TableId3hr"})

    #table elements => location = th =>  time => headers = "PC3_Ti PC3_D2"

    Table_row = table.find("th",{"id":"PC3_Wx"})
    #get the Weather use Weather headers
    Weather_header = 'PC3_Wx PC3_D2 PC3_D2H'
    #count the hours 
    temp = 0 
    #store the dict by weather and time  => store Timer_and_weather
    Timer_data = []

    # 8 Time period 
    for i in range(8):
        #store the weather and time 
        Timer_and_weather = {}
        #diff headers 
        new_Weather_header = ''
        if(temp < 10 ):
            new_Weather_header = Weather_header+'0'+str(temp)
            Timer_and_weather['time'] = '0'+str(temp)+':00'
        else:
            Timer_and_weather['time'] = str(temp)+':00'
            new_Weather_header = Weather_header+str(temp)
        #element means the table cell 
        element = table.find("td",{"headers":new_Weather_header})
        #Weather title in img tile so get the img attribute
        img = table.find("img")
        Timer_and_weather['weather'] = img.get('title')
        Timer_data.append(Timer_and_weather)
        temp+=3
    #store the whole weather and time 
    location_weather['Time_and_Weather'].append(Timer_data)
    #store to total_file 
    total_data.append(location_weather)


if __name__ == '__main__':
    chrome.get(URL)
    for i in range(len(location_number)):
        location_weather = {}
        crawler_func(i)
        location_weather['locatin'] = location_name[i]
        #go to the previous page
        chrome.back()
    #write the file to json file 
    Write_Json_File()
    chrome.close()