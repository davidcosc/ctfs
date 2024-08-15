expected_hex = ["0x00", "0x2a", "0xd7", "0x7c", "0xe7", "0x56", "0x22", "0x39", "0xf5", "0x6d", "0xc9", "0x49", "0x0f", "0x25", "0xd9", "0x76", "0xec", "0x5d", "0x2a", "0x2f", "0xe3", "0x78", "0xd2", "0x54", "0x13", "0x39", "0xc4", "0x6c", "0xf9", "0x48", "0x3c", "0x26", "0xe9", "0x70", "0xdb", "0x5b", "0x1b"]
#expected_hex = ["0x00"] * 37
expected_hex = list(map(lambda x: x.replace("0x",""), expected_hex))
print(expected_hex)

# reverse reverse
expected_hex = expected_hex[::-1]
print(expected_hex)

# reverse xor 0xa5270b64aa40f
current_hex = []
for index, val in enumerate(expected_hex):
	if (index % 6) == 0:
		current_hex.append(int(val, 16) ^ int("52", 16))
	elif (index % 6) == 1:
		current_hex.append(int(val, 16) ^ int("70", 16))
	elif (index % 6) == 2:
		current_hex.append(int(val, 16) ^ int("b6", 16))
	elif (index % 6) == 3:
		current_hex.append(int(val, 16) ^ int("4a", 16))
	elif (index % 6) == 4:
		current_hex.append(int(val, 16) ^ int("a4", 16))
	else:
		current_hex.append(int(val, 16) ^ int("0f", 16))

current_hex = list(map(hex, current_hex))
current_hex = list(map(lambda x: x.replace("0x",""), current_hex))
current_hex = list(map(lambda x: x if len(x) == 2 else "0" + x, current_hex))
expected_hex = current_hex
print(expected_hex)

# reverse xor 0x18
current_hex = []
for index, val in enumerate(expected_hex):
	current_hex.append(int(val, 16) ^ int("18", 16))

current_hex = list(map(hex, current_hex))
current_hex = list(map(lambda x: x.replace("0x",""), current_hex))
current_hex = list(map(lambda x: x if len(x) == 2 else "0" + x, current_hex))
expected_hex = current_hex
print(expected_hex)

# reverse xor 0x30571147
current_hex = []
for index, val in enumerate(expected_hex):
        if (index % 4) == 0:
                current_hex.append(int(val, 16) ^ int("30", 16))
        elif (index % 4) == 1:
                current_hex.append(int(val, 16) ^ int("57", 16))
        elif (index % 4) == 2:
                current_hex.append(int(val, 16) ^ int("11", 16))
        else:
                current_hex.append(int(val, 16) ^ int("47", 16))

current_hex = list(map(hex, current_hex))
current_hex = list(map(lambda x: x.replace("0x",""), current_hex))
current_hex = list(map(lambda x: x if len(x) == 2 else "0" + x, current_hex))
expected_hex = current_hex
print(expected_hex)


binary_input = bytes.fromhex(''.join(expected_hex))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
