expected_hex = ["08", "f1", "63", "f6", "cd", "66"]
binary_input = bytes.fromhex(''.join(expected_hex))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
