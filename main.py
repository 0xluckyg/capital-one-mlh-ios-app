from flask import Flask, request, render_template
import simplejson as json
import os

apiKey = "83cf91c2eefdd485e6fd9a94970053dd"
customerId = 1

app = Flask(__name__)

url = 'http://api.reimaginebanking.com/customers/{}/accounts?key={}'.format(customerId,apiKey)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api')
def get_restaurants():
	return "test"

if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=80)# makes server publicly available