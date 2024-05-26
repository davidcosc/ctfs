import base64
import re
import subprocess
from Crypto.Hash.SHA256 import SHA256Hash

"""
prefix_length = 2
    sha256 = SHA256Hash(flag).digest()
    show_b64(f"secret sha256[:{prefix_length}]", sha256[:prefix_length])

    collision = input_b64("collision")
    if SHA256Hash(collision).digest()[:prefix_length] == sha256[:prefix_length]:
        show("flag", flag.decode())
"""

pat0 = re.compile(r".*secret sha256\[:2\] \(b64\): (.*)\n")
proc = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)

while True:
	line = proc.stdout.readline().decode("utf-8")
	print(line, end="")
	m = pat0.match(line)
	if m:
		secret = base64.standard_b64decode(m.group(1))
		i = 0
		while True:
				msg  = str(i).encode("utf-8")
				current = SHA256Hash(msg).digest()[:2]
				print(f"{msg} {current} should be {secret}")
				if current == secret:
					print(f"\n\n\n{msg} {current} matches {secret}\n\n\n")
					msg = base64.standard_b64encode(msg)
					proc.stdin.write(msg + b'\n')
					proc.stdin.flush()
					break
				i = i + 1
