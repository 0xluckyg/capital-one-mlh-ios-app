#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template
import simplejson as json
import requests
from creds import load_credentials
from yelp.client import Client
from yelp.oauth1_authenticator import Oauth1Authenticator
from lxml import html

app = Flask(__name__)

creds = load_credentials()

auth = Oauth1Authenticator(
    consumer_key=creds[1],
    consumer_secret=creds[2],
    token=creds[3],
    token_secret=creds[4])
client = Client(auth)

merchants = 'http://api.reimaginebanking.com/merchants/'
purchases = 'http://api.reimaginebanking.com/accounts/57a6bd19bc727e4b519f20a6/purchases?key='


def is_restaurant(street, city):
    params = {
        'term': 'food',
        'location.address':street
    }
    data = client.search(city, **params)
    for x in data.businesses:
        if street == x.location.address[0]:
            return True
    return False

def get_restaurants(lat, lng, price):
    ret = {}
    params = {
        'term': 'restaurant',
        }
    data = client.search_by_coordinates(lat , lng, **params)#Hardcoding toh# the northern hemisphere
    #Testing here.
    for x in data.businesses:
        #if get_price(x.url) == price:
        print x.categories
        print "id: " + x.id.encode('utf-8')
        id = x.id.encode('utf-8')
        ret[id] = {}
        ret[id]['m_image_url'] = x.image_url
        ret[id]['m_name'] = x.name
        ret[id]['m_rating'] = str(x.rating)
        ret[id]['m_snippet_text'] = x.snippet_text
        ret[id]['m_url'] = x.url
    
    return ret

def get_price(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    price = tree.xpath('//span[@class="bullet-after"]/span/text()')
    if price:
        return len(price[0])
    else:
        return 0

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api')
def api():
    lat = request.args.get('lat')
    lng = request.args.get('lng')
    print lat
    print lng
    valid_merchant_ids = {}
    average = 0.0
    cone_key = creds[0]
    responses = requests.get(purchases+cone_key).json()
    for x in responses:
        merchant_id = x['merchant_id']
        data = requests.get(merchants+merchant_id+'/?key='+cone_key).json()
        print "data" + str(data)
        street = data['address']['street_number'] + " " + data['address']['street_name']
        city = data['address']['city']
        if is_restaurant(street, city):
            valid_merchant_ids[merchant_id] = x['amount']

    for x in valid_merchant_ids:
        average += valid_merchant_ids[x]
    average /= len(valid_merchant_ids)
    price = 0

    print "average"+str(average)

    if average < 10:
        price = 1
    elif average < 30:
        price = 2
    elif average < 50:
        price = 3
    else:
        price = 4

    nearby_food = get_restaurants(lat,lng, price)
    
    return json.dumps(nearby_food)

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=80)# makes server publicly available

