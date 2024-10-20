import os
import re
import sys
from base64 import b64decode, b64encode


"""
Theory:
CBC mode encrypts blocks sequentially, and before encrypting plaintext block number N, it XORs it
with the previous ciphertext block (number N-1). When decrypting, after decrypting ciphertext
block N, it XORs the decrypted (but still XORed) result with the previous ciphertext block
(number N-1) to recover the original plaintext block N. For the very first block, since there is
no "previous" block to use, CBC cryptosystems generate a random initial block called an
Initialization Vector (IV). The IV is used to XOR the first block of plaintext, and is transmitted
along with the message (often prepended to it). This means that if you encrypt one block of
plaintext in CBC mode, you might get two blocks of "ciphertext": the IV, and your single block of
actual ciphertext.

Since the IV is send along unencrypted, we can tamper with it in order to affect the plaintext of the
first ciphertext block that will be decrypted on the receiver side.

C = E(P1 ^ IV1)
C = E(P2 ^ IV2)
P1 ^ IV1 = P2 ^ IV2
P1 ^ IV1 ^ P2 = IV2

Inspecting the challenge we can tell, that the worker will net us the flag if it decryptes a plaintext
of 'flag!'. The initial plaintext is 'sleep'.
P1 = 'sleep'
P2 = 'flag!'

We have to craft IV2 as deduced above.
"""

'''
Dispatcher:
#!/opt/pwn.college/python

import os

from base64 import b64encode
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Random import get_random_bytes

key = open("/challenge/.key", "rb").read()
cipher = AES.new(key=key, mode=AES.MODE_CBC)
ciphertext = cipher.iv + cipher.encrypt(pad(b"sleep", cipher.block_size))

print(f"TASK: {b64encode(ciphertext).decode()}")

Worker:
#!/opt/pwn.college/python

from base64 import b64decode
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from Crypto.Random import get_random_bytes

import time
import sys

key = open("/challenge/.key", "rb").read()

while line := sys.stdin.readline():
    if not line.startswith("TASK: "):
        continue
    data = b64decode(line.split()[1])
    iv, ciphertext = data[:16], data[16:]

    cipher = AES.new(key=key, mode=AES.MODE_CBC, iv=iv)
    plaintext = unpad(cipher.decrypt(ciphertext), cipher.block_size).decode('latin1')

    print(f"Received command: {plaintext}")
    if plaintext == "sleep":
        print("Sleeping!")
        time.sleep(1)
    elif plaintext == "flag":
        print("Victory! Your flag:")
        print(open("/flag").read())
    else:
        print("Unknown command!")
'''

# handle dispatcher
ct_b64 = None
r0, w0 = os.pipe()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(r0)

	os.dup2(w0, 1)
	os.close(w0)

	os.execv("/challenge/dispatcher", ["/challenge/dispatcher"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(w0)

read_file = os.fdopen(r0, "r")
ct_b64 = read_file.readline().split()[1]
read_file.close()
print(f"Untampered ciphertext (b64): {ct_b64}")

# handle worker
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

	os.execv("/challenge/worker", ["/challenge/worker"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(sfd)

read_file = os.fdopen(mfd, "r")
write_file = os.fdopen(mfd, "w")

ct = b64decode(ct_b64.encode())
iv1, ct = ct[:16], ct[16:]
pt1 = b"sleep" + bytes([11]*11)
pt2 = b"flag" + bytes([12]*12)
iv2 = (int.from_bytes(iv1, sys.byteorder) ^ int.from_bytes(pt1, sys.byteorder) ^ int.from_bytes(pt2, sys.byteorder)).to_bytes(16, sys.byteorder)
write_file.write("TASK: "+b64encode(iv2+ct).decode()+"\n")
print(read_file.readline(), end="")
print(read_file.readline(), end="")
print(read_file.readline(), end="")
print(read_file.readline(), end="")
