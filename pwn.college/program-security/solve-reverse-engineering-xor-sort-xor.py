expected_hex = ["0x0a",	"0x23",	"0x1e",	"0x1b",	"0x35", "0xf5",	"0xee",	"0xc6", "0xe2",	"0xf5",	"0xaa",	"0x9b",	"0x86",	"0xb1",	"0x8a"]
expected_hex = list(map(lambda x: x.replace("0x",""), expected_hex))
print(expected_hex)

rev_xor_hex = []
for index, val in enumerate(expected_hex):
	if (index % 3) == 0:
		rev_xor_hex.append(int(val, 16) ^ int("4b", 16))
	elif (index % 3) == 1:
		rev_xor_hex.append(int(val, 16) ^ int("6a", 16))
	else:
		rev_xor_hex.append(int(val, 16) ^ int("57", 16))

rev_xor_hex = list(map(hex, rev_xor_hex))
rev_xor_hex = list(map(lambda x: x.replace("0x",""), rev_xor_hex))
print(rev_xor_hex)

rev_xor_hex2 = []
for index, val in enumerate(rev_xor_hex):
        if (index % 3) == 0:
                rev_xor_hex2.append(int(val, 16) ^ int("c7", 16))
        elif (index % 3) == 1:
                rev_xor_hex2.append(int(val, 16) ^ int("ba", 16))
        else:
                rev_xor_hex2.append(int(val, 16) ^ int("33", 16))

rev_xor_hex2 = list(map(hex, rev_xor_hex2))
rev_xor_hex2 = list(map(lambda x: x.replace("0x",""), rev_xor_hex2))
rev_xor_hex2 = list(map(lambda x: x if len(x) == 2 else "0" + x, rev_xor_hex2))
print(rev_xor_hex2)

binary_input = bytes.fromhex(''.join(rev_xor_hex2))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
