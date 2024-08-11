expected_hex = ["0x16", "0x29", "0xdd", "0x11", "0x25", "0xd0", "0x1d", "0x27", "0xd2", "0x1f", "0x20", "0xd6", "0x1a", "0x23", "0xd7", "0x07", "0x3e", "0xcb", "0x01", "0x3b", "0xcf", "0x0c", "0x35", "0xc0", "0x0d", "0x34", "0xc2", "0x0e"]
expected_hex = list(map(lambda x: x.replace("0x",""), expected_hex))
print(expected_hex)

# reverse xor mangler b
xor_hex_b = []
for index, val in enumerate(expected_hex):
	if (index % 3) == 0:
		xor_hex_b.append(int(val, 16) ^ int("90", 16))
	elif (index % 3) == 1:
		xor_hex_b.append(int(val, 16) ^ int("78", 16))
	else:
		xor_hex_b.append(int(val, 16) ^ int("93", 16))

xor_hex_b = list(map(hex, xor_hex_b))
xor_hex_b = list(map(lambda x: x.replace("0x",""), xor_hex_b))
xor_hex_b = list(map(lambda x: x if len(x) == 2 else "0" + x, xor_hex_b))
print(xor_hex_b)

# reverse reverse mangler b
xor_hex_b = xor_hex_b[::-1]

# reverse xor mangler a
xor_hex_a = []
for index, val in enumerate(xor_hex_b):
        if (index % 3) == 0:
                xor_hex_a.append(int(val, 16) ^ int("e4", 16))
        elif (index % 3) == 1:
                xor_hex_a.append(int(val, 16) ^ int("2b", 16))
        else:
                xor_hex_a.append(int(val, 16) ^ int("35", 16))

xor_hex_a = list(map(hex, xor_hex_a))
xor_hex_a = list(map(lambda x: x.replace("0x",""), xor_hex_a))
xor_hex_a = list(map(lambda x: x if len(x) == 2 else "0" + x, xor_hex_a))
print(xor_hex_a)

# reverse reverse mangler a
xor_hex_a = xor_hex_a[::-1]

binary_input = bytes.fromhex(''.join(xor_hex_a))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
