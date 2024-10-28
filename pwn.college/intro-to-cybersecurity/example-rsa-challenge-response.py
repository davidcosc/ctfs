import base64
import os
import re
from Crypto.PublicKey import RSA


"""
Theory:
	(m^e)^d is congruent to m within the modulus n,
	where
		n = pq,
		p is prime,
		q is prime,
		ed is congruent to 1 within the modulus phi,
		where phi = (p-1)(q-1)

	<e, n> is public key
	<d, n> is private key
	m is plaintext
	m^e is ciphertext

	Common value for e is 0x10001 or 65537.
	The private key can be calculated by rearranging
	ed is congruent to 1 within modulus phi to
	d is congruent to e^-1 withing modulus phi.

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
pat0 = re.compile(r".*You will provide the public key.")
pat1 = re.compile(r".*e: n: challenge: 0x(.*)\n")
pat2 = re.compile(r".*response: secret ciphertext \(b64\): (.*)\n")
r_pipe0, w_pipe0 = os.pipe()
r_pipe1, w_pipe1 = os.pipe()

pid = os.fork()

if pid == -1:
	print("Error fork.")
	exit(1)

if pid == 0:
	os.close(w_pipe0)
	os.close(r_pipe1)

	os.dup2(r_pipe0, 0)
	os.close(r_pipe0)

	os.dup2(w_pipe1, 1)
	os.close(w_pipe1)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.")
	exit(1)

os.close(r_pipe0)
os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")
input = os.fdopen(w_pipe0, "wb")

while True:
	line = output.readline()
	print(line, end="")
	m = pat0.match(line)
	if m:
		input.write(hex(key.e).encode("utf-8") + b"\n")
		input.flush()
		input.write(hex(key.n).encode("utf-8") + b"\n")
		input.flush()
	m = pat1.match(line)
	if m:
		challenge = int(m.group(1), 16)
		cipher = pow(challenge, key.d, key.n)
		input.write(hex(cipher).encode("utf-8") + b"\n")
		input.flush()
	m = pat2.match(line)
	if m:
		flag_cipher = base64.standard_b64decode(m.group(1).encode("utf-8"))
		flag = pow(int.from_bytes(flag_cipher, 'little'), key.d, key.n)
		print(f"Flag: {flag.to_bytes((flag.bit_length() + 7) // 8, 'little')}")
