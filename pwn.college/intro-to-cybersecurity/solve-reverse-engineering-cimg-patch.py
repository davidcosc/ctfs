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
extracted_rows = []
current_row = []

for i in range(0, len(data), block_size):
    if i + byte_position < len(data):
        # Skip line feeds, since they are added during frame buffer initialisation and not part of the cimg data
        if hex(data[i + byte_position]) == "0xa":
            extracted_rows.append(current_row)
            current_row = []
            continue
        pixel = [hex(int(data[i+color_position1:i+color_position1+3].decode(), 10))]
        pixel += [hex(int(data[i+color_position2:i+color_position2+3].decode(), 10))]
        pixel += [hex(int(data[i+color_position3:i+color_position3+3].decode(), 10))]
        pixel += [hex(data[i + byte_position])]
        current_row.append(pixel)

def handle_2(extracted_rows):
    dirc = 0
    width = 76
    height = 24
    cimg_bytes = []

    print(len(extracted_rows[0][1:width-1]))
    print(len(extracted_rows[height-1][1:width-1]))

    # Print first and last column with a single directive using overflow exploit base_x + x_counter / x
    cimg_bytes += ["0x02", "0x00", f"{width-1:04x}", f"{0:04x}", f"{2:04x}", f"{height:04x}"]
    for row in extracted_rows:
        cimg_bytes += row[width-1]
        cimg_bytes += row[0]
    dirc += 1

    # Print first and last row with a single directive using overflow exploit current pixel offset / fb dimensions
    cimg_bytes += ["0x02", "0x00", f"{1:04x}", f"{height-1:04x}", f"{width-2:04x}", f"{2:04x}"]
    for pixel in extracted_rows[height-1][1:width-1]:
        cimg_bytes += pixel
    for pixel in extracted_rows[0][1:width-1]:
        cimg_bytes += pixel
    dirc += 1

    slogan_base_x = 23
    slogan_base_y = 10
    slogan_width = 6
    slogan_height = 4
    cimg_bytes += ["0x02", "0x00", f"{slogan_base_x:04x}", f"{slogan_base_y:04x}", f"{slogan_width:04x}", f"{slogan_height:04x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += pixel
    dirc += 1

    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 5
    slogan_height = 5
    cimg_bytes += ["0x02", "0x00", f"{slogan_base_x:04x}", f"{slogan_base_y:04x}", f"{slogan_width:04x}", f"{slogan_height:04x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += pixel
    dirc += 1

    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 8
    slogan_height = 5
    cimg_bytes += ["0x02", "0x00", f"{slogan_base_x:04x}", f"{slogan_base_y:04x}", f"{slogan_width:04x}", f"{slogan_height:04x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += pixel
    dirc += 1

    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 7
    slogan_height = 5
    cimg_bytes += ["0x02", "0x00", f"{slogan_base_x:04x}", f"{slogan_base_y:04x}", f"{slogan_width:04x}", f"{slogan_height:04x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += pixel
    dirc += 1

    # Set up cimg header
    cimg_bytes = ["0x63", "0x49", "0x4d", "0x47", "0x03", "0x00", f"{width:04x}", f"{height:04x}", f"{dirc:04x}", "0x00", "0x00", "0x00"] + cimg_bytes
    return cimg_bytes

# Remove 0x prefix and normalise to len 2
expected_cimg = [i[2:] if len(i) % 2 == 0 else "0" + i[2:] for i in handle_2(extracted_rows)]

# print(expected_cimg)
print(len(expected_cimg))
binary_input = bytes.fromhex(''.join(expected_cimg))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
