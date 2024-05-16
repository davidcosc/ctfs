import ast
import base64
import re
import subprocess

"""
key = RSA.generate(2048)
    assert len(flag) <= 256
    ciphertext = pow(int.from_bytes(flag, "little"), key.e, key.n).to_bytes(256, "little")
    show_hex("e", key.e)
    show_hex("d", key.d)
    show_hex("n", key.n)
    show_b64("secret ciphertext", ciphertext)

"""

e = 0x10001
d = None
n = None
c = None

pat0 = re.compile(r"d: 0x([0-9a-f]*)")
pat1 = re.compile(r"n: 0x([0-9a-f]*)")
pat2 = re.compile(r"secret ciphertext \(b64\): (.*)\n")
p = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)

while True:
	line = p.stdout.readline().decode("utf-8")
	print(line, end="")
	m = pat0.match(line)
	if m:
		d = int.from_bytes(bytes.fromhex(m.group(1)), "big")
	m = pat1.match(line)
	if m:
		n = int.from_bytes(bytes.fromhex(m.group(1)), "big")
	m = pat2.match(line)
	if m:
		c = int.from_bytes(base64.standard_b64decode(m.group(1)), "little")
		m = pow(c, d, n)
		print(m.to_bytes((m.bit_length() + 7) // 8, "little"))
