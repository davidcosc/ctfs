# Theory

## Stack Guard
A canary value is randomly generated at program start. The canary is then placed onto the stack at the beginning of a routine call.
Before returning the canary value on the stack is compared with the initial canary value. If the values do not match, the program is terminated by the __stack_chk_fail routine.

```
# Assembly of a routine with no canary
0x0804856e leave
0x0804856f ret

# Assembly of a routine with canary
0x080485d9 mov eax, <canary>
0x080485dc xor eax, <right canary val>
0x080485e3 je 0x080485ea
0x080485e5 call <__stack_chk_fail@plt>
0x080485ea leave
0x080485eb ret
```