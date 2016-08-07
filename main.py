from flask import *
import requests
import json

apikey = 83cf91c2eefdd485e6fd9a94970053dd
customerId = 1

app = Flask(__name__)

url = 'http://api.reimaginebanking.com/customers/{}/accounts?key={}'.format(customerId,apiKey)
payload = {
  "type": "Savings",
  "nickname": "test",
  "rewards": 10000,
  "balance": 10000,	
}

def index():
    return render_template('index.html')

@app.route('/join', methods=['POST'])
def get_restaurants():

if __name__ == '__main__':
#	app.debug = True
	app.run(host='162.243.164.108')# makes server publicly available

###################################

# Create a Savings Account
response = requests.post( 
	url, 
	data=json.dumps(payload),
	headers={'content-type':'application/json'},
	)

if response.status_code == 201:
	print('account created')
