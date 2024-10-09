import os
import re
import sys
from base64 import b64decode

"""
#!/opt/pwn.college/python

from base64 import b64encode

flag = open("/flag", "rb").read()

print(f"Base64-Encoded Flag: {b64encode(flag).decode()}")
"""

pat0 = re.compile(r".*Base64-Encoded Flag: (.*)\n")
r0, w0 = os.pipe()
r1, w1 = os.pipe()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(w0)
	os.close(r1)

	os.dup2(r0, 0)
	os.close(r0)

	os.dup2(w1, 1)
	os.close(w1)

	# stdout as stderr
	os.dup2(1, 2)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(r0)
os.close(w1)

read_file = os.fdopen(r1, "r")
write_file = os.fdopen(w0, "wb")

while True:
	line = read_file.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		flag = b64decode(m.group(1).encode()).decode()
		print(flag, file=sys.stderr)
