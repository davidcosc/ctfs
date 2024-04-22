/challenge/embryoio_level128 >pipe1 &
pid=$!

python signalh.py

wait "${pid}"

