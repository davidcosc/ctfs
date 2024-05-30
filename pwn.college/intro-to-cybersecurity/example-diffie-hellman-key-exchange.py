import base64
import re
import os
from Crypto.Random.random import getrandbits
from Crypto.Util.strxor import strxor

"""
Therory:
	Alice and Bob publicly agree to use a modulus p and base g,
	where p is a prime and g is primitive root modulo p.
	Alice chooses a secret integer a, then send Bob A = g^a % p.
	Bob chooses a secret integer b, then sends Alice B = g^b % p.
	(g^a % p)^b % p = g^ab % p = g^ba % p = (g^b % p )^a % p

    # 2048-bit MODP Group from RFC3526
    p = int.from_bytes(bytes.fromhex(
        "FFFFFFFF FFFFFFFF C90FDAA2 2168C234 C4C6628B 80DC1CD1 "
        "29024E08 8A67CC74 020BBEA6 3B139B22 514A0879 8E3404DD "
        "EF9519B3 CD3A431B 302B0A6D F25F1437 4FE1356D 6D51C245 "
        "E485B576 625E7EC6 F44C42E9 A637ED6B 0BFF5CB6 F406B7ED "
        "EE386BFB 5A899FA5 AE9F2411 7C4B1FE6 49286651 ECE45B3D "
        "C2007CB8 A163BF05 98DA4836 1C55D39A 69163FA8 FD24CF5F "
        "83655D23 DCA3AD96 1C62F356 208552BB 9ED52907 7096966D "
        "670C354E 4ABC9804 F1746C08 CA18217C 32905E46 2E36CE3B "
        "E39E772C 180E8603 9B2783A2 EC07A28F B5C55DF0 6F4C52C9 "
        "DE2BCBF6 95581718 3995497C EA956AE5 15D22618 98FA0510 "
        "15728E5A 8AACAA68 FFFFFFFF FFFFFFFF"
    ), "big")
    g = 2

    show_hex("p", p)
    show_hex("g", g)

    a = getrandbits(2048)
    A = pow(g, a, p)
    show_hex("A", A)

    B = input_hex("B")
    if not (B > 2**1024):
        print("Invalid B value (B <= 2**1024)", file=sys.stderr)
        exit(1)

    s = pow(B, a, p)

    key = s.to_bytes(256, "little")
    assert len(flag) <= len(key)
    ciphertext = strxor(flag, key[:len(flag)])
    show_b64("secret ciphertext", ciphertext)
"""


p = None
g = None
A = None
b = getrandbits(2048)
shared_key = None
pat0 = re.compile(r".*p: (.*)\n")
pat1 = re.compile(r".*g: (.*)\n")
pat2 = re.compile(r".*A: (.*)\n")
pat3 = re.compile(r".*secret ciphertext \(b64\): (.*)\n")
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
		p = int(m.group(1).encode("utf-8"), 16)
	m = pat1.match(line)
	if m:
		g = int(m.group(1).encode("utf-8"), 16)
	m = pat2.match(line)
	if m:
		A = int(m.group(1).encode("utf-8"), 16)
		B = pow(g, b, p)
		shared_key = pow(A, b, p)
		shared_key = shared_key.to_bytes(256, "little")
		input.write(hex(B).encode("utf-8") + b"\n")
		input.flush()
	m = pat3.match(line)
	if m:
		cipher = base64.standard_b64decode(m.group(1).encode("utf-8"))
		result = strxor(cipher, shared_key[:len(cipher)])
		print(f"Flag {result}")
		break
