import requests
from lxml import html

def get_price(url): 
    page = requests.get('https://www.yelp.com/biz/andrea-salumeria-jersey-city') 
    tree = html.fromstring(page.content) 
    price = tree.xpath('//span[@class="bullet-after"]/span/text()') 
    print len(price)

get_price('edshjw')
