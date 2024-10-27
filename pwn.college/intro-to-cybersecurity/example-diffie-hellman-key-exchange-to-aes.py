import os
import re
import sys
from base64 import b64decode
from Crypto.Cipher import AES
from Crypto.Random.random import getrandbits


"""
Therory:
	Alice and Bob publicly agree to use a modulus p and base g,
	where p is a prime and g is primitive root modulo p.
	Alice chooses a secret integer a, then send Bob A = g^a % p.
	Bob chooses a secret integer b, then sends Alice B = g^b % p.
	(g^a % p)^b % p = g^ab % p = g^ba % p = (g^b % p )^a % p

#!/opt/pwn.college/python

import sys
from base64 import b64encode
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Random.random import getrandbits

flag = open("/flag", "rb").read()
assert len(flag) <= 256

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
print(f"p = {p:#x}")
print(f"g = {g:#x}")

a = getrandbits(2048)
A = pow(g, a, p)
print(f"A = {A:#x}")

try:
    B = int(input("B? "), 16)
except ValueError:
    print("Invalid B value (not a hex number)", file=sys.stderr)
    sys.exit(1)
if B <= 2**1024:
    print("Invalid B value (B <= 2**1024)", file=sys.stderr)
    sys.exit(1)

s = pow(B, a, p)
key = s.to_bytes(256, "little")[:16]

# friendship ended with DHKE, AES is my new best friend
cipher = AES.new(key=key, mode=AES.MODE_CBC)
flag = open("/flag", "rb").read()
ciphertext = cipher.iv + cipher.encrypt(pad(flag, cipher.block_size))
print(f"Flag Ciphertext (b64): {b64encode(ciphertext).decode()}")
"""

pat0 = re.compile(r"p = (.*)\n")
pat1 = re.compile(r"g = (.*)\n")
pat2 = re.compile(r"A = (.*)\n")
pat3 = re.compile(r"Flag Ciphertext \(b64\): (.*)\n")
p = None
g = None
A = None
key = None
b = getrandbits(2048)
mfd, sfd = os.openpty()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(mfd)

	os.dup2(sfd, 0)
	os.dup2(sfd, 1)
	os.dup2(sfd, 2)
	os.close(sfd)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(sfd)

read_file = os.fdopen(mfd, "r")
write_file = os.fdopen(mfd, "w")

while True:
	line = read_file.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		p = int(m.group(1), 16)
		print(f"Got p: {p}")

	m = pat1.match(line)
	if m:
		g = int(m.group(1), 16)
		print(f"Got g: {g}")

	m = pat2.match(line)
	if m:
		A = int(m.group(1), 16)
		print(f"Got A: {A}")
		s = pow(A, b, p)
		key = s.to_bytes(256, "little")[:16]
		print(f"Calculated key: {key}")
		write_file.write(f"{pow(g, b, p):#x}\n")

	m = pat3.match(line)
	if m:
		cipher = AES.new(key=key, mode=AES.MODE_CBC)
		ct = b64decode(m.group(1).encode())
		print(f"Your flag: {cipher.decrypt(ct)[16:]}")
		break
