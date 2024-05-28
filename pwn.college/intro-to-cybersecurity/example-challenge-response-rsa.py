import base64
import time
import re
import subprocess
from Crypto.PublicKey import RSA

"""
e = input_hex("e")
    n = input_hex("n")

    if not (e > 2):
        print("Invalid e value (e > 2)", file=sys.stderr)
        exit(1)

    if not (2**512 < n < 2**1024):
        print("Invalid n value (2**512 < n < 2**1024)", file=sys.stderr)
        exit(1)

    challenge = int.from_bytes(get_random_bytes(64), "little")
    show_hex("challenge", challenge)

    response = input_hex("response")
    if pow(response, e, n) == challenge:
        ciphertext = pow(int.from_bytes(flag, "little"), e, n).to_bytes(256, "little")
        show_b64("secret ciphertext", ciphertext)
"""
key = RSA.generate(1024)
pat0 = re.compile(r".*You will provide the public key.*")
pat1 = re.compile(r".*e: n: challenge: 0x(.*)\n")
pat2 = re.compile(r".*response: secret ciphertext \(b64\): (.*)\n")
proc = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)

while True:
	line = proc.stdout.readline().decode("utf-8")
	print(line, end=" ")
	m = pat0.match(line)
	if m:
		time.sleep(1)
		proc.stdin.write(hex(key.e).encode("utf-8") + b"\n")
		proc.stdin.flush()
		time.sleep(1)
		proc.stdin.write(hex(key.n).encode("utf-8") + b"\n")
		proc.stdin.flush()
	m = pat1.match(line)
	if m:
		challenge = int(m.group(1), 16)
		response = pow(challenge, key.d, key.n)
		proc.stdin.write(hex(response).encode("utf-8") + b"\n")
		proc.stdin.flush()
	m = pat2.match(line)
	if m:
		c = base64.standard_b64decode(m.group(1))
		m = pow(int.from_bytes(c, 'little'), key.d, key.n)
		print(f"m: {m.to_bytes((m.bit_length() + 7) // 8, 'little')}")
		break
