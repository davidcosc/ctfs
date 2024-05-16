import base64
import string

"""
key (b64): ZKrYIvJaiQJgLJzE2X6WF9x7bcBZIFn7ay5UkEg0NYr6tuTn+I0e0SldrT4gyAwwwNBf7U0y97uZug==
secret ciphertext (b64): FN22DJE15W4FS/m/viTfXJIxJYIPTQ/JRkckpDgMRPK0j5GmvMQo/00P13BahUh88rsbojVnjezksA==
"""
def byte_xor(str0, str1):
	return bytes([a ^ b for a,b in zip(str0, str1)])

ctext0 = base64.standard_b64decode("O7b/IuGzbdYJBoyPzKMIQ0eErhF6+QWkX/10jS9jeNTQB77UNnqUDb4PS6VZiP05XQvupsyk98fD2w==")
print(len(ctext0))
ctext1 = base64.standard_b64decode("KqPyaOe6ZtIFC4KY+L8RSlSmsVVf5BG7RLZ/uzwwcIDbH5vfL3i8TbUpQJlQscwDGBjTk9WQ7PHf")
print(len(ctext1))
ptextxor = byte_xor(ctext0, ctext1)
alpha = list(string.ascii_letters)
alpha = alpha + list(string.punctuation)
alpha = alpha + list(string.whitespace)
#print(alpha)
print(byte_xor(b"abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzaaaaaa", ptextxor))

