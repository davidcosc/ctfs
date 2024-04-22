import multiprocessing as mp
import os
import pathlib
import socket
import subprocess


def create_fifo(pipe_path):
  if(pathlib.Path(pipe_path).exists()):
    print(f"Named pipe {pipe_path} already exists.")
    return
  try:
    os.mkfifo(pipe_path)
    print(f"Named pipe created at {pipe_path}.")
  except OSError as e:
    print(f"Error: {e}.")


def child0(s, line):
  print("Child0.")
  with open("pipe2", "w") as outf:
    f = s.makefile()

    while(line):
      line = f.readline()
      #print(f"Write line: {line}", end="")
      outf.write(line)
      outf.flush()


def child1(s, line):
  print("Child1.")
  with open("pipe1", "r") as inf:
    f = s.makefile("w")

    while(line):
      line = inf.readline()
      #print(f"Read line: {line}")
      f.write(line)
      f.flush()


sp = subprocess.Popen(["/challenge/embryoio_level141"], stderr=subprocess.STDOUT, stdout=subprocess.DEVNULL)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 1892))

create_fifo("pipe1")
create_fifo("pipe2")

p0 = mp.Process(target=child0, args=(s, "line"))
p0.start()

p1 = mp.Process(target=child1, args=(s, "line"))
p1.start()

subprocess.run(["python", "arithmetich.py", "\033[0;32m"])

s.close()
print("\033[0;0m", end="")
p0.join()
p1.join()
sp.kill()
