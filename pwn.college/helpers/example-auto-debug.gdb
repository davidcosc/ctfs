run
break *main+577
commands
  silent
  set $cur_val = *(long*)($rbp-0x18)
  printf "cur_val: %lx\n", $cur_val
  continue
end
break *main+620
commands
  jump *main+630
end
break *main+630
commands
  set *((long*)($rbp-0x10)) = *((long*)($rbp-0x18))
  continue
end
continue
