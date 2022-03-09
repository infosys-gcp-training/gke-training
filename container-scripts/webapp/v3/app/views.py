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
	color = os.getenv('COLOR')
	#ip_address = request.remote_addr
	hostname=socket.gethostname()
	ip_address=socket.gethostbyname(hostname)
	print ("IP address:", ip_address)
	
	if color == 'red':
		bkg_color = '#8b0000'
	elif color == 'blue':
		bkg_color = '#00264D'
	elif color == 'green':
		bkg_color = '#808000'
	elif color == 'yellow':
		bkg_color = '#FFFF00'
	elif color == 'orange':
		bkg_color = '#A36A00'
	else:
		bkg_color = '#00264D'

	print ("Background color:", bkg_color)
	return render_template('home.html', bkg_color=bkg_color, pod_address=ip_address)
