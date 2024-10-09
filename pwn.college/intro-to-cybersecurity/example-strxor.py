import os
import re
import sys
from Crypto.Util.strxor import strxor

"""
Theory:
XOR is its own inverse. XORing a message with a key once encrypts it.
XORing it with the same key again decrypts it.

#!/opt/pwn.college/python

import random
import string
import sys

from Crypto.Util.strxor import strxor

valid_keys = "!#$%&()"
valid_chars = ''.join(
	c for c in string.ascii_letters
	if all(chr(ord(k)^ord(c)) in string.ascii_letters for k in valid_keys)
)

print(valid_keys, valid_chars)

for n in range(1, 10):
	print(f"Challenge number {n}...")

	key_str = ''.join(random.sample(valid_keys*10, 10))
	pt_str = ''.join(random.sample(valid_chars*10, 10))
	ct_str = strxor(pt_str.encode(), key_str.encode()).decode()

	print(f"- Encrypted String: {ct_str}")
	print(f"- XOR Key String: {key_str}")
	answer = input("- Decrypted String? ").strip()
	if answer != pt_str:
		print("Incorrect!")
		sys.exit(1)

	print("Correct! Moving on.")

print("You have mastered XORing ASCII! Your flag:")
print(open("/flag").read())
"""

pat0 = re.compile(r".*- Encrypted String: (.*)\n")
pat1 = re.compile(r".*- XOR Key String: (.*)\n")
cipher = None
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
		cipher = m.group(1)
		print(cipher, file=sys.stderr)

	m = pat1.match(line)
	if m:
		key = m.group(1)
		msg = strxor(cipher.encode(), key.encode())
		print(msg, file=sys.stderr)
		write_file.write(msg+b"\n")
		write_file.flush()
