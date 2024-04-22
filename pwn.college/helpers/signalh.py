import os
import re
import subprocess
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
p0 = re.compile(r'.*PID (.*)\).* order: (.*)')
p1 = re.compile(r'.*Correct!.*')
line = "init"
pid = ""
signals = []

create_fifo("pipe1")

with open("pipe1", "r") as f:
  while(line):
    line = f.readline()
    print(f"{color}{line}", end="")
    m0 = p0.match(line)
    if(m0):
      pid = m0.group(1)
      print(f"{color}{pid}")
      signals = eval(m0.group(2))
      print(f"{color}{signals}")
    m1 = p1.match(line)
    if(signals and (m0 or m1)):
      subprocess.run(["kill", "-s", signals[0], pid])
      signals = signals[1:]
