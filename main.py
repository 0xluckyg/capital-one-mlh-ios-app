from flask import Flask, request, render_template
import simplejson as json
import os
import ConfigParser
import requests
from yelp.client import Client
from yelp.oauth1_authenticator import Oauth1Authenticator

app = Flask(__name__)

merchants = 'http://api.reimaginebanking.com/merchants/'
purchases = 'http://api.reimaginebanking.com/accounts/57a6cea4bc727e4b519f21b9/purchases?key='
 
def load_credentials():
    Config = ConfigParser.ConfigParser()
    Config.read(os.path.join(os.path.dirname(__file__), './config/config.ini'))
    creds = []
    creds.append(Config.get('API_Keys', 'capital_one_key'))
    creds.append(Config.get('API_Keys', 'Consumer_Key'))
    creds.append(Config.get('API_Keys', 'Consumer_Secret'))
    creds.append(Config.get('API_Keys', 'Token'))
    creds.append(Config.get('API_Keys', 'Token_Secret'))
    return creds

def is_restaurant(city, address, key,skey,tok, stok):
    auth = Oauth1Authenticator(
    consumer_key=key,
    consumer_secret=skey,
    token=tok,
    token_secret=stok
    )
    client = Client(auth)
    params = {
        'location.address':address,
        'term': 'food'
    }
    print client.search(city, **params)
    if len(client.search(city, **params)) != 0:
    	return True
    return False

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/api')
def get_restaurants():
    valid_merchant_ids = []
    creds = load_credentials()
    cone_key = creds[0]
    cons_key = creds[1]
    cons_secret = creds[2]
    token = creds[3]
    sec_token = creds[4]
    responses = requests.get(purchases+cone_key).json()
    for x in range(len(responses)):
        merchant_id = responses[x]['merchant_id']
        print merchants+merchant_id+'/?key='+cone_key
        address = requests.get(merchants+merchant_id+'/?key='+cone_key).json()['address']
        print address
	city = address['city']
	print city
        if is_restaurant(city, address, cons_key, cons_secret, token, sec_token):
            valid_merchant_ids.append(merchant_id)
    print valid_merchant_ids
    return "test"

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=5000)# makes server publicly available
