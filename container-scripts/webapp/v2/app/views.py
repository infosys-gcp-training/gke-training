from flask import render_template
from flask import request
import socket
from app import app
import os

@app.route('/welcome')
def home():
   return "Welcome everyone!"

@app.route('/')
def template():
	hostname=socket.gethostname()
	ip_address=socket.gethostbyname(hostname)
	print ("IP address:", ip_address)
	return render_template('home.html', pod_address=ip_address)
