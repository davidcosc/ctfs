expected_hex = ["90", "3a", "95", "35", "2a", "a9", "68", "bc"]
binary_input = bytes.fromhex(''.join(expected_hex))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
