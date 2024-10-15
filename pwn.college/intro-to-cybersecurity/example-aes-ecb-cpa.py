import os
import re
import requests
import string
import sys
from base64 import b64decode, b64encode


"""
Theory:
One time pads can only be used once. Advanced encryption standard (AES) on the other hand maintains
security for multiple messages encrypted with the same key. AES is a block cipher, encrypting one
plaintext block of a specific block size i.e. 16 bytes/128bits at a time.

AES must operate on complete blocks. If a plaintext is shorter than a block, it will be padded to
the block size. The padded block will then be encrypted. If the plaintext size is perfectly divisible
by the block size, a full block of padding is added.

Different AES modes define what to do when the plaintext is longer than one block. The simplest mode
is electronic code book (ECB). n ECB, each block is encrypted separately with the same key and simply
concatenated together. This mode is prone to a type of attack called chosen plain text attack (CPA).

CPA presumes, that the attacker can obtain ciphertexts for arbitrary plain texts. The ability to
prepend some chosen plaintext to a secret before it is encrypted, is one of the more common scenarios
where a CPA could occur.

We can first determine the AES block_size by requesting the AES ciphertext without adding a prefix.
We than add single prefix bytes and request respective the ciphertext again, until the length of
the ciphertext differs from the first ciphertext. At this point we know, that an entire padding block
has been added at the end of the ciphertext. The difference in length between both ciphertexts is the
block size. If we take the prefix length into account we can also calculate the length of the secret
we want to decipher.

Adding one more byte of prefix will result in the returned ciphertexts last block containing the
last secret byte only. The reamining bytes of the block will be padding. We can save this blocks
ciphertext for later.

We then create our own plaintext blocks containing a single byte of the alphabet and padding. We
prepend the block to our next request for a ciphertext. We do so for all bytes contained in our
alphabet until the first block of the returned ciphertext matches the previously saved ciphertext.
We have leaked the last byte of the secret. We can not repeat the process for the next byte. The
newly constructed plaintext will contain a single byte of the alphabet followed by the previously
leaked secret byte followed by padding. Doing this over and over again, will eventually leak the
entire secret.
"""

'''
#!/opt/pwn.college/python

from base64 import b64encode
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Random import get_random_bytes

import tempfile
import sqlite3
import flask
import os

app = flask.Flask(__name__)

class TemporaryDB:
    def __init__(self):
        self.db_file = tempfile.NamedTemporaryFile("x", suffix=".db")

    def execute(self, sql, parameters=()):
        connection = sqlite3.connect(self.db_file.name)
        connection.row_factory = sqlite3.Row
        cursor = connection.cursor()
        result = cursor.execute(sql, parameters)
        connection.commit()
        return result

key = get_random_bytes(16)
cipher = AES.new(key=key, mode=AES.MODE_ECB)

db = TemporaryDB()
# https://www.sqlite.org/lang_createtable.html
db.execute("""CREATE TABLE posts AS SELECT ? AS content""", [open("/flag", "rb").read().strip()])

@app.route("/", methods=["POST"])
def challenge_post():
    content = flask.request.form.get("content").encode('latin1')
    db.execute("INSERT INTO posts VALUES (?)", [content])
    return flask.redirect(flask.request.path)

@app.route("/reset", methods=["POST"])
def challenge_reset():
    db.execute("DELETE FROM posts WHERE ROWID > 1")
    return flask.redirect("/")

@app.route("/", methods=["GET"])
def challenge_get():
    pt = b"|".join(post["content"] for post in db.execute("SELECT content FROM posts ORDER BY ROWID DESC").fetchall())
    ct = cipher.encrypt(pad(pt, cipher.block_size))

    return f"""
        <html><body>Welcome to pwn.secret!
        <form method=post>Post a secret:<input type=text name=content><input type=submit value=Submit></form>
        <form method=post action=reset><input type=submit value="Reset Database"></form>
        <hr>
        <b>Encrypted backup:</b><pre>{b64encode(ct).decode()}</pre>
        </body></html>
    """

app.secret_key = os.urandom(8)
app.config['SERVER_NAME'] = "challenge.localhost:80"
app.run("challenge.localhost", 80)
'''

pat0 = re.compile(r".*Press CTRL.*\n")
pat1 = re.compile(r".*Encrypted backup:.*pre>(.*)<.*")
url = "http://challenge.localhost:80/"
i = 0
prefix = None
init_ct_len = None
block_size = None
block_num = None
flag_len = None
flag = ""
force = False
exp_ct = None
ct = None
alphabet = string.ascii_letters + string.digits + "-_.{}"
j = 0
r1, w1 = os.pipe()
pid = os.fork()

if pid == -1:
	print("Error fork.", file=sys.stderr)
	exit(1)

if pid == 0:
	os.close(r1)

	os.dup2(w1, 1)
	os.close(w1)

	# stdout as stderr
	os.dup2(1, 2)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.", file=sys.stderr)
	exit(1)

os.close(w1)

read_file = os.fdopen(r1, "r")

# ensure server ready
while True:
	line = read_file.readline()
	print(line, end="")

	if pat0.match(line):
		break

# calculate block size, block num and flag len
while True:
	requests.post(url+"reset")
	# clear pipe to prevent clogging
	read_file.readline()
	read_file.readline()

	prefix = "a"*i
	data = {"content": prefix}
	resp = requests.post(url, data=data)
	# clear pipe to prevent clogging
	read_file.readline()
	read_file.readline()

	ciphertext = None
	for line in resp.text.split("\n"):
		m = pat1.match(line)
		if m:
			ciphertext = b64decode(m.group(1).encode())

	if init_ct_len:
		cur_ct_len = len(ciphertext)
		if cur_ct_len != init_ct_len:
			block_size = cur_ct_len - init_ct_len
			flag_len = cur_ct_len - len(prefix) - block_size # last block is all padding
			block_num = int(cur_ct_len / block_size)
			break

	if not init_ct_len:
		init_ct_len = len(ciphertext)

	i += 1

print(f"Block size: {block_size}, Block num: {block_num}, Flag length: {flag_len}")

# execute cpa
while True:
	content = None
	if exp_ct:
		if len(flag) < block_size:
			content = (alphabet[j] + flag).encode()
			num_padding = block_size-len(content)
			padding = bytes([num_padding]) * num_padding
			content += padding
		else:
			content = (alphabet[j] + flag[:block_size-1]).encode()
		j += 1
	else:
		prefix += "a" # isolates last flag byte in padding block initially
		content = prefix

	requests.post(url+"reset")
	# clear pipe to prevent clogging
	read_file.readline()
	read_file.readline()
	data = {"content": content}
	resp = requests.post(url, data=data)
	# clear pipe to prevent clogging
	read_file.readline()
	read_file.readline()
	ciphertext = None
	for line in resp.text.split("\n"):
		m = pat1.match(line)
		if m:
			ciphertext = b64decode(m.group(1).encode())

	if exp_ct:
		ct = b64encode(ciphertext[:block_size]).decode()
		print(f"Ct: {ct}")
	else:
		block_offset = (block_num-1) * block_size
		exp_ct = b64encode(ciphertext[block_offset:block_offset+block_size]).decode()
		print(f"Expected ct: {exp_ct}")

	if (exp_ct and ct) and exp_ct == ct:
		flag = alphabet[j-1] + flag
		exp_ct = None
		ct = None
		j = 0
		print(f"Current flag: {flag}")

	if j >= len(alphabet) or (flag and flag[0] == "{"):
		print(f"Your flag: pwn.college{flag}")
		break

