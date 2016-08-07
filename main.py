from flask import Flask, request, render_template
import simplejson as json
import os
import ConfigParser

app = Flask(__name__)

merchants = 'http://api.reimaginebanking.com/merchants/{}/accounts?key={}'.format(customerId,apiKey)

def load_credentials():
	Config = ConfigParser.ConfigParser()
    Config.read(os.path.join(os.path.dirname(__file__), './config/config.ini'))
    creds = []
    creds.append(Config.get('API_Keys', 'capital_one_key'))
    creds.append(Config.get('API_Keys', 'yelp_key'))
    return creds

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/api')
def get_restaurants():
	creds = load_credentials()
	cone_key = creds[0]
	yelp_key = creds[1]
	
	return "test"

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=80)# makes server publicly available