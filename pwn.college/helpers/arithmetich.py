import os
import re
import sys
import pathlib


def create_fifo(pipe_path):
  if(pathlib.Path(pipe_path).exists()):
    print(f"{color}Named pipe {pipe_path} already exists.")
    return
  try:
    os.mkfifo(pipe_path)
    print(f"{color}Named pipe created at {pipe_path}.")
  except OSError as e:
    print(f"{color}Error: {e}.")


color = sys.argv[1] if len(sys.argv)==2 else  ""
p0 = re.compile(r".*solution for: (.*)")
p1 = re.compile(r".*pwn\.college.*")
expr = ""
line = "init"

create_fifo("pipe1")
create_fifo("pipe2")

with open("pipe1", "w") as outf:
  with open("pipe2", "r") as inf:
    while(line):
      line = inf.readline()
      print(f"{color}{line}", end="")
      m = p0.match(line)
      if(m):
        expr = m.group(1)
        res = eval(expr)
        print(f"{color}{res}")
        outf.write(f"{res}\n")
        outf.flush()
      m = p1.match(line)
      if(m):
        break
