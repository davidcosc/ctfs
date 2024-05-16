import re
import subprocess
import base64
import sys
from Crypto.Hash import SHA256
from Crypto.Random import random
from Crypto.Util.strxor import strxor
"""
def level6():
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


generator = None
modulus = None
randint = random.getrandbits(2048)
msgA = None
msgB = None
secret = None
shared_key = None
pat0 = re.compile(r"p: 0x([0-9a-f]*)")
pat1 = re.compile(r"g: 0x([0-9a-f]*)")
pat2 = re.compile(r"A: 0x([0-9a-f]*)")
pat3 = re.compile(r".*\(b64\): (.*)")
p = subprocess.Popen(["/challenge/run"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)

while True:
	line = p.stdout.readline().decode("utf-8")
	print(line, end="")
	m = pat0.match(line)
	if m:
		modulus = int.from_bytes(bytes.fromhex(m.group(1)), "big")
		print(f"Modulus: {modulus}")
	m = pat1.match(line)
	if m:
		generator = int.from_bytes(bytes.fromhex("0"+m.group(1)), "big")
	m = pat2.match(line)
	if m:
		msgA = int.from_bytes(bytes.fromhex(m.group(1)), "big")
		secret = pow(msgA, randint, modulus)
		shared_key = secret.to_bytes(256, "little")
		#print(f"Shared key: {shared_key}")
		#print(msgA)
	if generator and modulus and msgA and (not msgB):
		msgB = pow(generator, randint, modulus)
		print(f"Send msgB: {msgB}")
		p.stdin.write(f"{hex(msgB)}\n".encode("utf-8"))
		p.stdin.flush()
	m = pat3.match(line)
	if m:
		msg = base64.standard_b64decode(m.group(1).strip())
		print(strxor(msg, shared_key[:len(msg)]))
