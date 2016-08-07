import os
import ConfigParser

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
