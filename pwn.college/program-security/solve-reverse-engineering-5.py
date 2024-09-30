expected_hex = ["71", "e3", "e0", "8c", "12", "8d", "cf", "58", "90", "d8", "78", "7c"]

binary_input = bytes.fromhex(''.join(expected_hex))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
