import multiprocessing as mp
import os
import pathlib
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


def child():
  with open("pipe1", "r") as inf:
    with open("pipe2", "w") as outf:
      sp0 = subprocess.Popen(["cat"], stdin=inf, stdout=subprocess.PIPE)
      sp1 = subprocess.Popen(["/challenge/embryoio_level134"], stdin=sp0.stdout, stdout=subprocess.PIPE)
      sp2 = subprocess.Popen(["cat"], stdin=sp1.stdout, stdout=outf)
      sp0.wait()
      sp1.wait()
      sp2.wait()


create_fifo("pipe1")
create_fifo("pipe1")

p = mp.Process(target=child)
p.start()

subprocess.run(["python", "arithmetich.py", "\033[0;32m"])
print("\033[0;0m", end="")
p.join()
