from flask import Flask, request, render_template
import simplejson as json
import requests
from creds import load_credentials
from yelp.client import Client
from yelp.oauth1_authenticator import Oauth1Authenticator

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

def get_restaurants(lat, lng):
    params = {
        'term': 'food',
        }
    data = client.search_by_coordinates(lat, lng, **params)
    #Testing here.
    for x in data.businesses:
        print x.id
    return True

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api')
def api():
    lat = request.args.get('lat')
    lng = request.args.get('lng')
    valid_merchant_ids = {}
    average = 0.0
    cone_key = creds[0]
    responses = requests.get(purchases+cone_key).json()
    for x in responses:
        merchant_id = x['merchant_id']
        data = requests.get(merchants+merchant_id+'/?key='+cone_key).json()
        print data
        street = data['address']['street_number'] + " " + data['address']['street_name']
        city = data['address']['city']
        if is_restaurant(street, city):
            valid_merchant_ids[merchant_id] = x['amount']

    for x in valid_merchant_ids:
        average += valid_merchant_ids[x]
    average /= len(valid_merchant_ids)

    nearby_food = get_restaurants(lat,lng)
    
    return json.dumps(valid_merchant_ids)

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=5000)# makes server publicly available
