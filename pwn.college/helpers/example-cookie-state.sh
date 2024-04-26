cook=$(echo -e "GET / HTTP/1.0\n\n" | nc 127.0.0.1 80 | grep "Set-Cookie"| sed "s/Set-Cookie: //g")
for i in {0..4}
do
  outp=$(echo -e "GET / HTTP/1.0\nCookie: $cook\n\n" | nc 127.0.0.1 80)
  cook=$(echo "$outp" | grep "Set-Cookie"| sed "s/Set-Cookie: //g")
  echo "$outp"
done

