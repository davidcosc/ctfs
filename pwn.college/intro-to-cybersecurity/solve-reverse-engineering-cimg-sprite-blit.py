# Open the file containing the desired output
with open('/challenge/cimg', 'rb') as f:
    data = f.read()

# Only keep disred output data 0xED60
data = data[0x4020:0xEB21]
# print(data)

# Define the block size and the byte position you want to extract
block_size = 0x18
byte_position = 0x13
color_position1 = 0x7
color_position2 = 0xb
color_position3 = 0xf
row_len = 76

# Extract the char to render and color bytes from each block unless its a new line block since they are placed additionally to input blocks
extracted_rows = []
current_row = []

# Debug print pixel bytes
# for i in range(0, len(data), block_size):
#     if i + block_size <= len(data):
#         for y in range(i,i+block_size):
#             print(data[y], end=",")
#         print("")

for i in range(0, len(data), block_size):
    if i + block_size <= len(data):
        print(chr(data[i + byte_position]), end="")
        pixel = [f"0x{int(data[i+color_position1:i+color_position1+3].decode(), 10):02x}"]
        pixel += [f"0x{int(data[i+color_position2:i+color_position2+3].decode(), 10):02x}"]
        pixel += [f"0x{int(data[i+color_position3:i+color_position3+3].decode(), 10):02x}"]
        pixel += [f"0x{data[i + byte_position]:02x}"]
        current_row.append(pixel)
        if len(current_row) == row_len:
            print("")
            extracted_rows.append(current_row)
            current_row = []


def create_cimg_bytes(extracted_rows):
    dirc = 0
    width = 76
    height = 24
    cimg_bytes = []

    # Print vertical frame
    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x00", "0x01", "0x01"]
    cimg_bytes += [extracted_rows[0][0][3]]
    dirc += 1

    # Dir 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x00", f"{extracted_rows[0][0][0]}", f"{extracted_rows[0][0][1]}", f"{extracted_rows[0][0][1]}", f"0x{width-1:02x}", "0x00", "0x02", "0x01", "0x00"]
    dirc += 1

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x02", "0x01", "0x01"]
    cimg_bytes += [extracted_rows[1][0][3]]
    dirc += 1

    # Dir 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x02", f"{extracted_rows[0][0][0]}", f"{extracted_rows[0][0][1]}", f"{extracted_rows[0][0][1]}", f"0x{width-1:02x}", "0x01", "0x02", f"0x{height-2:02x}", "0x00"]
    dirc += 1

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x04", "0x01", "0x01"]
    cimg_bytes += [extracted_rows[height-1][0][3]]
    dirc += 1

    # Dir 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x04", f"{extracted_rows[0][0][0]}", f"{extracted_rows[0][0][1]}", f"{extracted_rows[0][0][1]}", f"0x{width-1:02x}", f"0x{height-1:02x}", "0x02", "0x01", "0x00"]
    dirc += 1

    # Print horizontal frame
    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x06", "0x01", "0x01"]
    cimg_bytes += [extracted_rows[0][1][3]]
    dirc += 1

    # Dir 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x06", f"{extracted_rows[0][0][0]}", f"{extracted_rows[0][0][1]}", f"{extracted_rows[0][0][1]}", "0x01", f"0x{height-1:02x}", f"0x{width-2:02x}", "0x02", "0x00"]
    dirc += 1

    # Print slogan c
    slogan_base_x = 23
    slogan_base_y = 10
    slogan_width = 6
    slogan_height = 4
    color = None

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x08", f"0x{slogan_width:02x}", f"0x{slogan_height:02x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += [pixel[3]]
            color = pixel[:3]
    dirc += 1

    # Sprite 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x08", f"{color[0]}", f"{color[1]}", f"{color[2]}", f"0x{slogan_base_x:02x}", f"0x{slogan_base_y:02x}", "0x01", "0x01", "0x00"]
    dirc += 1

    # Print slogan I
    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 5
    slogan_height = 5
    color = None

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x08", f"0x{slogan_width:02x}", f"0x{slogan_height:02x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += [pixel[3]]
            color = pixel[:3]
    dirc += 1

    # Sprite 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x08", f"{color[0]}", f"{color[1]}", f"{color[2]}", f"0x{slogan_base_x:02x}", f"0x{slogan_base_y:02x}", "0x01", "0x01", "0x00"]
    dirc += 1

    # Print slogan M
    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 8
    slogan_height = 5
    color = None

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x08", f"0x{slogan_width:02x}", f"0x{slogan_height:02x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += [pixel[3]]
            color = pixel[:3]
    dirc += 1

    # Sprite 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x08", f"{color[0]}", f"{color[1]}", f"{color[2]}", f"0x{slogan_base_x:02x}", f"0x{slogan_base_y:02x}", "0x01", "0x01", "0x00"]
    dirc += 1

    # Print slogan G
    slogan_base_x = slogan_base_x + slogan_width + 1
    slogan_base_y = 9
    slogan_width = 7
    slogan_height = 5
    color = None

    # Dir 3
    # 2B dir code, 1B sid, 1B sprite width, 1B sprite height, sbytes
    cimg_bytes += ["0x03", "0x00", "0x08", f"0x{slogan_width:02x}", f"0x{slogan_height:02x}"]
    for i in range(0,slogan_height):
        for pixel in extracted_rows[slogan_base_y+i][slogan_base_x:slogan_base_x+slogan_width]:
            cimg_bytes += [pixel[3]]
            color = pixel[:3]
    dirc += 1

    # Sprite 4
    # 2B dir code, 1B sid, 1B r, 1B g, 1B b, x-offset, y-offset, horizontal reps, vertical reps, filter char
    cimg_bytes += ["0x04", "0x00", "0x08", f"{color[0]}", f"{color[1]}", f"{color[2]}", f"0x{slogan_base_x:02x}", f"0x{slogan_base_y:02x}", "0x01", "0x01", "0x00"]
    dirc += 1

    # Set up cimg header
    cimg_bytes = ["0x63", "0x49", "0x4d", "0x47", "0x04", "0x00", f"0x{width:02x}", f"0x{height:02x}", f"0x{dirc:02x}", "0x00", "0x00", "0x00"] + cimg_bytes
    return cimg_bytes


expected_cimg = [char[2:] for char in create_cimg_bytes(extracted_rows)]
# print(expected_cimg)
print(f"exp: 0x011d, actual: 0x{len(expected_cimg):04x}")
binary_input = bytes.fromhex(''.join(expected_cimg))

with open('input.bin', 'wb') as f:
    f.write(binary_input)
