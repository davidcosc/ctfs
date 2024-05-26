import base64
import re
import subprocess
from Crypto.Hash.SHA256 import SHA256Hash

"""
difficulty = 2

    challenge = get_random_bytes(32)
    show_b64("challenge", challenge)

    response = input_b64("response")
    if SHA256Hash(challenge + response).digest()[:difficulty] == (b'\0' * difficulty):
        show("flag", flag.decode())

"""

pat0 = re.compile(r".*challenge \(b64\): (.*)\n")
proc = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
i = 0
challenge = None

while True:
	line = proc.stdout.readline().decode("utf-8")
	print(line, end="")
	m = pat0.match(line)
	if m:
		prefix = b"\0\0"
		challenge = base64.standard_b64decode(m.group(1))
		while True:
			response = challenge + str(i).encode("utf-8")
			resp_sha = SHA256Hash(response).digest()[:2]
			print(f"Response {response} sha digest[:2] {resp_sha} should equal {prefix}.")
			if resp_sha == prefix:
				response = base64.standard_b64encode(str(i).encode("utf-8"))
				proc.stdin.write(response + b"\n")
				proc.stdin.flush()
				break
			i = i + 1
