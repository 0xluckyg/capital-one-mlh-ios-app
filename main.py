from flask import Flask, request, render_template
import simplejson as json
import os
import ConfigParser
import requests
from yelp.client import Client
from yelp.oauth1_authenticator import Oauth1Authenticator

app = Flask(__name__)

merchants = 'http://api.reimaginebanking.com/merchants/'
purchases = 'http://api.reimaginebanking.com/accounts/57a6bd19bc727e4b519f20a6/purchases?key='
 
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

def is_restaurant(street, city, key, skey, tok, stok):
    auth = Oauth1Authenticator(
    consumer_key=key,
    consumer_secret=skey,
    token=tok,
    token_secret=stok
    )
    client = Client(auth)
    params = {
        'location.address':street,
        'term': 'food'
    }
    data = client.search(city, **params)
    for x in data.businesses:
        if street == x.location.address[0]:
            return True
    return False

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api')
def get_restaurants():
    lat = request.args.get('lat')
    lng = request.args.get('lng')
    valid_merchant_ids = {}
    creds = load_credentials()
    cone_key = creds[0]
    responses = requests.get(purchases+cone_key).json()
    for x in responses:
        merchant_id = x['merchant_id']
        data = requests.get(merchants+merchant_id+'/?key='+cone_key).json()
        print data
        street = data['address']['street_number'] + " " + data['address']['street_name']
        city = data['address']['city']
        if is_restaurant(street, city, creds[1], creds[2], creds[3], creds[4]):
            valid_merchant_ids[merchant_id] = x['amount']
    print valid_merchant_ids
    return json.dumps(valid_merchant_ids)

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=5000)# makes server publicly available
