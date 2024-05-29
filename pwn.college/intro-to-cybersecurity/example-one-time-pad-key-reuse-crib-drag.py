import base64
import re
import os
import time
from Crypto.Util.strxor import strxor


"""
Theory: (a xor b) xor b = a xor (b xor b) = a xor 0 = a
	=> xor is its own inverse, it is cumutative and assosiative

	If the same key is reused to encrypt two messages:
	cipher0 = msg0 xor key
	cipher1 = msg1 xor key
	cipher0 xor cipher1 = (msg0 xor key) xor (msg1 xor key)
			    = (msg0 xor msg1) xor (key xor key)
			    = msg0 xor msg1
	=> if we know parts of one of the messsages or even one entire message like msg0
	we can (msg0 xor msg1) xor msg0 to get the previously unknown msg1


    key = get_random_bytes(256)
    assert len(flag) <= len(key)

    ciphertext = strxor(flag, key[:len(flag)])
    show_b64("secret ciphertext", ciphertext)

    while True:
        plaintext = input_b64("plaintext")
        ciphertext = strxor(plaintext, key[:len(plaintext)])
        show_b64("ciphertext", ciphertext)
"""



ciphertext0 = None
ciphertext1 = None
plaintext = None
pat0 = re.compile(r"secret ciphertext \(b64\): (.*)\n")
pat1 = re.compile(r"plaintext \(b64\): ciphertext \(b64\): (.*)\n")
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
	print("Error execvp.")
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
		ciphertext0 = base64.standard_b64decode(m.group(1))
		print(f"Got ciphertext0 {ciphertext0} with len {len(ciphertext0)}")
		plaintext = "A" * len(ciphertext0)
		plaintext = plaintext.encode("utf-8")
		plaintext_b64 = base64.standard_b64encode(plaintext)
		input.write(plaintext_b64 + b"\n")
		input.flush()
	m = pat1.match(line)
	if m:
		ciphertext1 = base64.standard_b64decode(m.group(1))
		print(f"Got ciphertext1 {ciphertext1} with len {len(ciphertext1)}")
		text = strxor(ciphertext0, ciphertext1)
		print(strxor(plaintext, text))
