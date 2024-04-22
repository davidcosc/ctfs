if ! test -e "pipe1"; then mkfifo "pipe1"; fi
if ! test -e "pipe2"; then mkfifo "pipe2"; fi

netstat -tulpn | grep "127.0.0.1:1769"
res=$?
echo "$res"
if test $res -ne 0; then
  echo "Start server."
  /challenge/embryoio_level140 &
  sleep 1
fi

exec 5<> "/dev/tcp/127.0.0.1/1769"

python arithmetich.py &

while IFS= read -r line; do echo "${line}"; done <&5 >pipe2 &
while IFS= read -r line; do echo "${line}"; done <pipe1 >&5

#while IFS= read -r line <&5; do echo "${line}" >pipe2; done
#cat <pipe3 >&5 &
#cat <&5 >pipe4 &
#python arithmetich.py &

#while IFS= read -r line <pipe4; do echo "${line}" echo "${line}" >pipe2; done &
#while IFS= read -r line <pipe1; do echo "${line}" echo "${line}" >pipe3; done &


