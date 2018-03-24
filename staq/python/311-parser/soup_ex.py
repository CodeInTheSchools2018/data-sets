from bs4 import BeautifulSoup
import requests

request_url = "http://www.columbiaacademy.com/"

html = requests.get(request_url)
soup = BeautifulSoup(html.text, 'html.parser')

for link in soup.find_all('a'):
  print(link.get('href'))

#print(soup.prettify())
