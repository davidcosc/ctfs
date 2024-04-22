cat <pipe1 | /challenge/embryoio_level129 | cat >pipe2 &
pid=$!

python arithmetich.py

wait "${pid}"

