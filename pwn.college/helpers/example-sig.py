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
  with open("pipe1", "w") as f:
    p = subprocess.Popen(["/challenge/embryoio_level133"], stdout=f)
    p.wait()


create_fifo("pipe1")

p = mp.Process(target=child)
p.start()

subprocess.run(["python", "signalh.py", "\033[0;32m"])
print("\033[0;0m", end="")

p.join()
