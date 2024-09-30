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

## Indirect Branch Protection
The ENDBR32 and ENDBR64 (collectively ENDBRANCH) are two new instructions that are used to mark valid indirect CALL/JMP target locations in the program. This instruction is a NOP on legacy processors for backward compatibility.

The processor implements a state machine that tracks indirect JMP and CALL instructions. When one of these instructions is seen, the state machine moves from IDLE to WAIT_​FOR_​ENDBRANCH state. In WAIT_​FOR_​ENDBRANCH state the next instruction in the program stream must be an ENDBRANCH. If an ENDBRANCH is not seen the processor causes a control protection fault (#CP), otherwise the state machine moves back to IDLE state.

An indirect branch (also known as a computed jump, indirect jump and register-indirect jump) is a type of program control instruction present in some machine language instruction sets. Rather than specifying the address of the next instruction to execute, as in a direct branch, the argument specifies where the address is located. An example is 'jump indirect on the r1 register', which means that the next instruction to be executed is at the address in register r1. The address to be jumped to is not known until the instruction is executed. Indirect branches can also depend on the value of a memory location.

An indirect branch can be useful to make a conditional branch, especially a multiway branch. For instance, based on program input, a value could be looked up in a jump table of pointers to code for handling the various cases implied by the data value. The data value could be added to the address of the table, with the result stored in a register. An indirect jump could then be made based on the value of that register, efficiently dispatching program control to the code appropriate to the input.

In a similar manner, subroutine call instructions can be indirect, with the address of the subroutine to be called specified in memory. Function Pointers are typically implemented with indirect subroutine calls.