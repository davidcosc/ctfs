import os
import re
import sys
from base64 import b64encode, b64decode
from Crypto.Util.strxor import strxor

"""
Theory:
A one-time pad is the only cryptosystem that has been proven to be perfectly secure.
It works by simply XORing bits of a plaintext with bits of a key one by one. As long as
we can transfer the key securly and only use the pad once, the cryptosystem can not be broken.

XOR is commutative and associative and its own inverse.
a^a^k = k
b^b^k = k
a^a^k = b^b^k | ^a^k
a = a^k^b^k^b

#!/opt/pwn.college/python

from base64 import b64encode, b64decode
from Crypto.Random import get_random_bytes
from Crypto.Util.strxor import strxor

flag = open("/flag", "rb").read()

key = get_random_bytes(256)
ciphertext = strxor(flag, key[:len(flag)])

print(f"Flag Ciphertext (b64): {b64encode(ciphertext).decode()}")

while True:
    plaintext = b64decode(input("Plaintext (b64): "))
    ciphertext = strxor(plaintext, key[:len(plaintext)])
    print(f"Ciphertext (b64): {b64encode(ciphertext).decode()}")
"""

pat0 = re.compile(r".*Flag Ciphertext \(b64\): (.*)\n")
pat1 = re.compile(r".*Plaintext \(b64\): Ciphertext \(b64\): (.*)\n")
a_xor_k = None
b = None
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
		a_xor_k = b64decode(m.group(1).encode())
		print(a_xor_k)
		b = "b"*len(a_xor_k)
		write_file.write(b64encode(b.encode()) + b"\n")
		write_file.flush()

	m = pat1.match(line)
	if m:
		b_xor_k = b64decode(m.group(1).encode())
		print(b_xor_k)
		a = strxor(strxor(a_xor_k, b_xor_k), b.encode())
		print(a.encode())
