import base64
import os
import re
from Crypto.Hash.SHA256 import SHA256Hash


"""
Theory:
	To brute force a collision, we repeatedly sha256 increasing byte values.
	We do so by incrementing an integer starting at zero and then sha256ing
	its byte representation. We calculate the num of bytes to represent the
	integer as by dviding the length of its hex representation. Two hex digits
	make one byte. Since all ascii symbols i.e. letters, numbers are represented
	by a hex number as a single byte, this allows us to generate all message
	combinations of arbitrary characters with the message lenght increasing
	infinitely unless we find a match.

    prefix_length = 2
    sha256 = SHA256Hash(flag).digest()
    show_b64(f"secret sha256[:{prefix_length}]", sha256[:prefix_length])

    collision = input_b64("collision")
    if SHA256Hash(collision).digest()[:prefix_length] == sha256[:prefix_length]:
        show("flag", flag.decode())
"""


pat0 = re.compile(r".*secret sha256\[:2\] \(b64\): (.*)\n")
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
		target_hash = m.group(1)
		i = 0
		while True:
			num_bytes = int((len(hex(i))-2) / 2 if len(hex(i)) % 2 == 0 else (len(hex(i))-1) / 2)
			i_str = i.to_bytes(num_bytes, "big")
			sha256 = SHA256Hash(i_str).digest()
			candidate = base64.standard_b64encode(sha256[:2]).decode("utf-8")
			print(f"Input {i} num b {num_bytes} Compare {sha256[:2]} as b64 {candidate} should equal {target_hash}")
			if candidate == target_hash:
				input.write(base64.standard_b64encode(i_str) + b"\n")
				input.flush()
				break
			i += 1
