import os
import re
import signal
import sys
import time
from base64 import b64decode, b64encode


"""
Theory:
We can decrypt each block based on its previous block.
D(Cn) = X = Cn-1 ^ Pn
We consider each block pair separately. We call Cn-1 initial initialization vector IIV. We are not
interested in its ciphertext. Like the IV we only use it for xoring.
D(C) = X = IIV ^ P
Once we manipulate it, we call the IIV zeroing initialization vector ZIV. At no point are we
manipulating the ciphertext. Hence the ciphertext will always be decrypted to the same xor-text X.
X = IIV ^ Piiv
X = ZIV ^ Pziv
We are going to deduce Piiv byte by byte, starting at the last byte. Manipulating the last byte of
the IV will directly affect the last byte of P. We can ignore the remaining bytes. We call the
currently manipulated byte of the IV y. We iteratively let y be 0-255 and make a decryption request.
We know, that the value of y for which we do not receive a padding error will result in a padding of
1 for the plaintext. This allows us to deduce the last byte of X by xoring y and 1.
x,x,x,x = ziv,ziv,ziv,y ^ pziv,pziv,pziv,1
x = y ^ 1
We can deduce the last byte of the actual plaintext, by xoring x with the last byte of IIV since
x is always the same for all combinations of plaintext and iv.
For the next byte we craft ZIV such that the last byte of p should result in padding value 2. We
can do so by setting the last byte of ZIV to x and then xoring it with 2.
x,x,x,x = ziv,ziv,y,x^2 ^ pziv,pziv,2,2
x,x,x,x ^ ziv,ziv,y,x^2 = pziv,pziv,2,2
"""

# handle dispatcher
BLOCK_SIZE = 16
blocks = None
r, w = os.pipe()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(r)

	os.dup2(w, 1)
	os.close(w)

	os.execv("/challenge/dispatcher", ["/challenge/disptacher", "flag"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(w)

read_file = os.fdopen(r, "r")
ct = b64decode(read_file.readline().split()[1])
read_file.close()
os.waitpid(pid,0)
assert len(ct) % BLOCK_SIZE == 0, "ensure the cts block size is 16 or adjust the block size"
blocks = [ct[i:i+BLOCK_SIZE] for i in range(0, len(ct), BLOCK_SIZE)]
print(f"Intercepted dispatched ciphertext blocks: {blocks}")

# handle worker
def do_oracle(msg):
	value_error = False
	pat0 = re.compile("ValueError.*\n")
	pat1 = re.compile("Sleeping!\n")
	pat2 = re.compile("Unknown command!\n")
	pat3 = re.compile("Not so easy.*\n")
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

	write_file.write("TASK: "+b64encode(msg).decode()+"\n")

	while True:
		line = read_file.readline()

		if pat0.match(line):
			value_error = True
			break

		if pat1.match(line) or pat2.match(line) or pat3.match(line):
			value_error = False
			os.kill(pid, signal.SIGTERM)
			break

	os.waitpid(pid, 0)
	return value_error

flag = b""
initial_iv = blocks[0]

for ct in blocks[1:]:
	# single block attack
	zeroing_iv = [0]*BLOCK_SIZE
	print(f"IIV: {initial_iv}, CT: {ct}")
	for pad_val in range(1, BLOCK_SIZE+1):
		padding_iv = [pad_val ^ cur_byte for cur_byte in zeroing_iv]

		for y in range(256):
			padding_iv[-pad_val] = y
			iv = bytes(padding_iv)
			print(f"Checking iv {iv}")
			if not do_oracle(iv+ct):
				if pad_val == 1:
					# make sure the padding really is of length 1 by changing
					# the penultimate block and querying the oracle again
					padding_iv[-2] ^= 1
					iv = bytes(padding_iv)
					print(f"Checking false positive with iv: {iv}")
					if do_oracle(iv+ct):
						print("False positive.")
						continue # false positive
				break

		# set respective zeroing_iv byte to x
		# this in turn will be xored with the expected padding byte for the next iteration
		# and always result in the correct padding value x ^ x ^ pad_val = pad_val
		zeroing_iv[-pad_val] = y ^ pad_val
		print(f"Current zeroing_iv: {bytes(zeroing_iv)}")
		print(f"Current palintext byte: {bytes([(zeroing_iv[-pad_val] ^ initial_iv[-pad_val])])}")

	flag += bytes([ziv_byte ^ iv_byte for ziv_byte, iv_byte in zip(zeroing_iv, initial_iv)])
	print(flag)
	initial_iv = ct
