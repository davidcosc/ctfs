# Open the file containing the desired output
with open('/challenge/cimg', 'rb') as f:
    data = f.read()

# Only keep disred output data
data = data[0x3020:0xDD62]

# Define the block size and the byte position you want to extract
block_size = 0x18
byte_position = 0x13
color_position1 = 0x7
color_position2 = 0xb
color_position3 = 0xf

# Extract the 0x13th and color bytes from each block unless its a new line block since they are placed additionally to input blocks
extracted_bytes = []
for i in range(0, len(data), block_size):
    if i + byte_position < len(data):
        if hex(data[i + byte_position]) == "0xa":
            print(f"index: {i}, value: {hex(data[i + byte_position])}")
            continue
        pixel = [hex(int(data[i+color_position1:i+color_position1+3].decode(), 10))]
        pixel += [hex(int(data[i+color_position2:i+color_position2+3].decode(), 10))]
        pixel += [hex(int(data[i+color_position3:i+color_position3+3].decode(), 10))]
        pixel += [hex(data[i + byte_position])]
        extracted_bytes.append(pixel)

# Set up cimg header
expected_cimg_header = ["63", "49", "4d", "47", "02", "00", "4c", "18"]
expected_cimg_body = []

# Extracted bytes to cimg bytes
for eb in extracted_bytes:
    expected_cimg_body += eb

print(len(expected_cimg_body))

# Remove 0x prefix and normalise to len 2
expected_cimg_body = [i[2:] if len(i) % 2 == 0 else "0" + i[2:] for i in expected_cimg_body]

print(len(expected_cimg_body))

cimg_bytes = []
for cb in expected_cimg_header + expected_cimg_body:
  cimg_bytes.append(bytes.fromhex(cb))

binary_input = bytes.fromhex(''.join(expected_cimg_header + expected_cimg_body))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
