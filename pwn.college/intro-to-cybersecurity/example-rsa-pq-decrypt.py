import base64
import re
import subprocess

"""
key = RSA.generate(2048)
    assert len(flag) <= 256
    ciphertext = pow(int.from_bytes(flag, "little"), key.e, key.n).to_bytes(256, "little")
    show_hex("e", key.e)
    show_hex("p", key.p)
    show_hex("q", key.q)
    show_b64("secret ciphertext", ciphertext)
"""

e = 0x10001
p = None
q = None
n = None
phi = None
d = None
c = None

pat0 = re.compile(r"p: 0x([0-9a-f]*)")
pat1 = re.compile(r"q: 0x([0-9a-f]*)")
pat2 = re.compile(r"secret ciphertext \(b64\): (.*)\n")
proc = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)

while True:
	line = proc.stdout.readline().decode("utf-8")
	print(line, end="")
	m = pat0.match(line)
	if m:
		p = int.from_bytes(bytes.fromhex(m.group(1)), "big")
	m = pat1.match(line)
	if m:
		q = int.from_bytes(bytes.fromhex(m.group(1)), "big")
	m = pat2.match(line)
	if m:
		c = int.from_bytes(base64.standard_b64decode(m.group(1)), "little")
		n = p * q
		phi = (p-1) * (q-1)
		d = pow(e, -1, phi)
		m = pow(c, d, n)
		print(m.to_bytes((m.bit_length() + 7) // 8, "little"))
