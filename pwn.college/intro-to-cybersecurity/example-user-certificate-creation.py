import base64
import json
import os
import re
from Crypto.Hash.SHA256 import SHA256Hash
from Crypto.PublicKey import RSA


"""
    root_key = RSA.generate(2048)

    show_hex("root key d", root_key.d)

    root_certificate = {
        "name": "root",
        "key": {
            "e": root_key.e,
            "n": root_key.n,
        },
        "signer": "root",
    }

    root_trusted_certificates = {
        "root": root_certificate,
    }

    root_certificate_data = json.dumps(root_certificate).encode()
    root_certificate_hash = SHA256Hash(root_certificate_data).digest()
    root_certificate_signature = pow(
        int.from_bytes(root_certificate_hash, "little"),
        root_key.d,
        root_key.n
    ).to_bytes(256, "little")

    show_b64("root certificate", root_certificate_data)
    show_b64("root certificate signature", root_certificate_signature)

    user_certificate_data = input_b64("user certificate")
    user_certificate_signature = input_b64("user certificate signature")

    try:
        user_certificate = json.loads(user_certificate_data)
    except json.JSONDecodeError:
        print("Invalid user certificate", file=sys.stderr)
        exit(1)

    user_name = user_certificate.get("name")
    if user_name in root_trusted_certificates:
        print(f"Invalid user certificate name: `{user_name}`", file=sys.stderr)
        exit(1)

    user_key = user_certificate.get("key", {})
    if not (isinstance(user_key.get("e"), int) and isinstance(user_key.get("n"), int)):
        print(f"Invalid user certificate key: `{user_key}`", file=sys.stderr)
        exit(1)

    if not (user_key["e"] > 2):
        print("Invalid user certificate key e value (e > 2)", file=sys.stderr)
        exit(1)

    if not (2**512 < user_key["n"] < 2**1024):
        print("Invalid user certificate key n value (2**512 < n < 2**1024)", file=sys.stderr)
        exit(1)

    user_signer = user_certificate.get("signer")
    if user_signer not in root_trusted_certificates:
        print(f"Untrusted user certificate signer: `{user_signer}`", file=sys.stderr)
        exit(1)

    user_signer_key = root_trusted_certificates[user_signer]["key"]
    user_certificate_hash = SHA256Hash(user_certificate_data).digest()
    user_certificate_check = pow(
        int.from_bytes(user_certificate_signature, "little"),
        user_signer_key["e"],
        user_signer_key["n"]
    ).to_bytes(256, "little")[:len(user_certificate_hash)]

    if user_certificate_check != user_certificate_hash:
        print("Untrusted user certificate: invalid signature", file=sys.stderr)
        exit(1)

    ciphertext = pow(int.from_bytes(flag, "little"), user_key["e"], user_key["n"]).to_bytes(256, "little")
    show_b64("secret ciphertext", ciphertext)
"""


d = None
root_cert = None
user_key = None
pat0 = re.compile(r".*root key d: 0x(.*)\n")
pat1 = re.compile(r".*root certificate \(b64\): (.*)\n")
pat2 = re.compile(r".*root certificate signature \(b64\): (.*)\n")
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
	print("Error excecv.")
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
		d = int(m.group(1), 16)
		print(f"Got d: {d}")
	m = pat1.match(line)
	if m:
		root_cert = json.loads(base64.standard_b64decode(m.group(1).encode("utf-8")).decode("utf-8"))
		print(f"Got root cert: {root_cert}")
	m = pat2.match(line)
	if m:
		root_cert_sig = base64.standard_b64decode(m.group(1).encode("utf-8"))
		print(f"Got root cert sig: {root_cert_sig}")
		user_key = RSA.generate(1024)
		user_certificate = {
			"name": "hacker",
			"key": {
				"e": user_key.e,
				"n": user_key.n,
			},
			"signer": "root",
		}
		user_cert_data = json.dumps(user_certificate).encode("utf-8")
		user_cert_hash = SHA256Hash(user_cert_data).digest()
		user_cert_sig = pow(int.from_bytes(user_cert_hash, "little"), d, int(root_cert["key"]["n"])).to_bytes(256, "little")
		input.write(base64.standard_b64encode(user_cert_data) + b"\n")
		input.flush()
		input.write(base64.standard_b64encode(user_cert_sig) + b"\n")
		input.flush()
	m = pat3.match(line)
	if m:
		cipher = base64.standard_b64decode(m.group(1).encode("utf-8"))
		c = int.from_bytes(cipher, "little")
		flag = pow(c, user_key.d, user_key.n)
		flag = flag.to_bytes((flag.bit_length() + 7) // 8, "little")
		print(flag)
