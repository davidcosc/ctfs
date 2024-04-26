import os
import time
import re

p0 = re.compile(r".*solution for: (.*)")
p1 = re.compile(r".*pwn\.college.*")

with open("blubb", "w") as f:
	time.sleep(3)
	inf = os.fdopen(0, "r")
	outf = os.fdopen(1, "w")
	line = "init"
	while (line):
		line = inf.readline()
		f.write(line)
		f.flush()
		m = p0.match(line)
		if(m):
			expr = m.group(1)
			res = eval(expr)
			outf.write(f"{res}\n")
			outf.flush()
		m = p1.match(line)
		if(m):
			break
	inf.close()
	outf.close()
