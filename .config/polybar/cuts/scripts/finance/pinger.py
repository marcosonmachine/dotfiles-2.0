import time
import sys
import requests
from bs4 import BeautifulSoup
from selenium.webdriver.firefox.options import Options
from selenium import webdriver
import re

conversion = sys.argv[1]
googleFinUrl = "https://www.google.com/finance/quote/"

url = googleFinUrl + str(conversion)

options = Options()
options.headless = True

driver = webdriver.Firefox(options=options)
driver.get(url)

title = "" 

for x in driver.title:
    if x == '|':
        break;
    title += x;

file1 = open("conversion", "w+")
file1.truncate(0)
file1.write(title)
file1.close();

driver.close()
