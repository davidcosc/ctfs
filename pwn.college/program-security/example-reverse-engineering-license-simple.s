Dump of assembler code for function main:
   0x0000000000001412 <+0>:	endbr64 
   0x0000000000001416 <+4>:	push   rbp
   0x0000000000001417 <+5>:	mov    rbp,rsp
   0x000000000000141a <+8>:	sub    rsp,0x40
   0x000000000000141e <+12>:	mov    DWORD PTR [rbp-0x24],edi # argc
   0x0000000000001421 <+15>:	mov    QWORD PTR [rbp-0x30],rsi # pointer to argv "/challenge/babyrev_level1.0"
   0x0000000000001425 <+19>:	mov    QWORD PTR [rbp-0x38],rdx # pointer to envp "LESSOPEN=| /usr/bin/lesspipe %s"
   0x0000000000001429 <+23>:	mov    rax,QWORD PTR fs:0x28 # sentinel stack guard value
   0x0000000000001432 <+32>:	mov    QWORD PTR [rbp-0x8],rax # store sentinal stack guard value below rbp
   0x0000000000001436 <+36>:	xor    eax,eax
   0x0000000000001438 <+38>:	cmp    DWORD PTR [rbp-0x24],0x0 # is argc zero? => No its one
   0x000000000000143c <+42>:	jg     0x145d <main+75> # => jump first print
   0x000000000000143e <+44>:	lea    rcx,[rip+0xfa7]        # 0x23ec <__PRETTY_FUNCTION__.5330>
   0x0000000000001445 <+51>:	mov    edx,0x32
   0x000000000000144a <+56>:	lea    rsi,[rip+0xcbb]        # 0x210c
   0x0000000000001451 <+63>:	lea    rdi,[rip+0xcbc]        # 0x2114
   0x0000000000001458 <+70>:	call   0x1180 <__assert_fail@plt>
   0x000000000000145d <+75>:	lea    rdi,[rip+0xcb9]        # 0x211d # contains string ###
   0x0000000000001464 <+82>:	call   0x1140 <puts@plt> # print string ###
   0x0000000000001469 <+87>:	mov    rax,QWORD PTR [rbp-0x30] # argv pointer
   0x000000000000146d <+91>:	mov    rax,QWORD PTR [rax] # string starting address argvp points to
   0x0000000000001470 <+94>:	mov    rsi,rax # string starting address as second arg for printf
   0x0000000000001473 <+97>:	lea    rdi,[rip+0xca7]        # 0x2121 # format string "### Welcome to %s!\n"
   0x000000000000147a <+104>:	mov    eax,0x0 # zero out eax
   0x000000000000147f <+109>:	call   0x1170 <printf@plt> # print welcome message
   0x0000000000001484 <+114>:	lea    rdi,[rip+0xc92]        # 0x211d # containes string ###
   0x000000000000148b <+121>:	call   0x1140 <puts@plt> # print string ###
   0x0000000000001490 <+126>:	mov    edi,0xa # line feed
   0x0000000000001495 <+131>:	call   0x1120 <putchar@plt> # print line feed
   0x000000000000149a <+136>:	mov    rax,QWORD PTR [rip+0x2b8f] # address of open FILE obj to stdin # 0x4030 <stdin@@GLIBC_2.2.5>
   0x00000000000014a1 <+143>:	mov    ecx,0x0 # size is ignored since no buffering
   0x00000000000014a6 <+148>:	mov    edx,0x2 # mode no buffering
   0x00000000000014ab <+153>:	mov    esi,0x0 # NULL buffer => let C library manage its own buffer
   0x00000000000014b0 <+158>:	mov    rdi,rax # open FILE obj
   0x00000000000014b3 <+161>:	call   0x11c0 <setvbuf@plt> # set input buffering
   0x00000000000014b8 <+166>:	mov    rax,QWORD PTR [rip+0x2b61] # address of open FILE obj to stdout # 0x4020 <stdout@@GLIBC_2.2.5>
   0x00000000000014bf <+173>:	mov    ecx,0x1 # size is ignored since no buffering
   0x00000000000014c4 <+178>:	mov    edx,0x2 # mode no buffering
   0x00000000000014c9 <+183>:	mov    esi,0x0 # NULL buffer => let C library manage its own buffer
   0x00000000000014ce <+188>:	mov    rdi,rax # open FILE obj
   0x00000000000014d1 <+191>:	call   0x11c0 <setvbuf@plt> # set output buffering
   0x00000000000014d6 <+196>:	lea    rdi,[rip+0xc5b]        # 0x2138 # starting address of string "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
   0x00000000000014dd <+203>:	call   0x1140 <puts@plt> # print "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
   0x00000000000014e2 <+208>:	lea    rdi,[rip+0xcc7]        # 0x21b0 # starting address of string "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
   0x00000000000014e9 <+215>:	call   0x1140 <puts@plt> # print "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
   0x00000000000014ee <+220>:	lea    rdi,[rip+0xd33]        # 0x2228 # starting address of string "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
   0x00000000000014f5 <+227>:	call   0x1140 <puts@plt> # print "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
   0x00000000000014fa <+232>:	lea    rdi,[rip+0xd9f]        # 0x22a0 # starting address of string "Providing the correct license key will net you the flag!\n"
   0x0000000000001501 <+239>:	call   0x1140 <puts@plt> # print "Providing the correct license key will net you the flag!\n"
   0x0000000000001506 <+244>:	mov    DWORD PTR [rbp-0xe],0x0 # zero out buffer space on stack for read
   0x000000000000150d <+251>:	mov    WORD PTR [rbp-0xa],0x0 # zero out moer buffer space
   0x0000000000001513 <+257>:	lea    rdi,[rip+0xdc6]        # 0x22e0 # starting address of string "Ready to receive your license key!\n"
   0x000000000000151a <+264>:	call   0x1140 <puts@plt> # print "Ready to receive your license key!\n"
   0x000000000000151f <+269>:	lea    rax,[rbp-0xe] # read buffer stack starting address
   0x0000000000001523 <+273>:	mov    edx,0x5 # read size arg
   0x0000000000001528 <+278>:	mov    rsi,rax # buffer starting address arg
   0x000000000000152b <+281>:	mov    edi,0x0 # fd arg stdin
   0x0000000000001530 <+286>:	call   0x11a0 <read@plt> # read user input
   0x0000000000001535 <+291>:	lea    rdi,[rip+0xdc8]        # 0x2304 # starting address of string "Initial input:\n"
   0x000000000000153c <+298>:	call   0x1140 <puts@plt> print "Initial input:\n"
   0x0000000000001541 <+303>:	mov    edi,0x9 # tab in ascii
   0x0000000000001546 <+308>:	call   0x1120 <putchar@plt> # print tab
   0x000000000000154b <+313>:	mov    DWORD PTR [rbp-0x1c],0x0 # set up counter variable on stack to zero
   0x0000000000001552 <+320>:	jmp    0x1578 <main+358>n # jmp loop condition
   0x0000000000001554 <+322>:	mov    eax,DWORD PTR [rbp-0x1c] # counter to eax
   0x0000000000001557 <+325>:	cdqe # extend counter to qword by copying the sign bit 31 to the upper rax bits
   0x0000000000001559 <+327>:	movzx  eax,BYTE PTR [rbp+rax*1-0xe] # set eax to byte of input at position counter => takes on all the input bytes in order i.e. abcde => a then b then c ...
   0x000000000000155e <+332>:	movzx  eax,al # zero extend al to eax
   0x0000000000001561 <+335>:	mov    esi,eax # current byte as printf arg2
   0x0000000000001563 <+337>:	lea    rdi,[rip+0xdaa]        # 0x2314 # format string starting addr of "%02x "
   0x000000000000156a <+344>:	mov    eax,0x0 # reset rax to zero
   0x000000000000156f <+349>:	call   0x1170 <printf@plt> # print "%02x ", current_byte
   0x0000000000001574 <+354>:	add    DWORD PTR [rbp-0x1c],0x1 # increment counter
   0x0000000000001578 <+358>:	cmp    DWORD PTR [rbp-0x1c],0x4 # if counter
   0x000000000000157c <+362>:	jle    0x1554 <main+322> # <= 4
   0x000000000000157e <+364>:	lea    rdi,[rip+0xb85]        # 0x210a # string starting addr "\n"
   0x0000000000001585 <+371>:	call   0x1140 <puts@plt> #  print "\n"
   0x000000000000158a <+376>:	lea    rdi,[rip+0xd8f]        # 0x2320 # string starting addr "The mangling is done! The resulting bytes will be used for the final comparison.\n"
   0x0000000000001591 <+383>:	call   0x1140 <puts@plt> # print "The mangling is done! The resulting bytes will be used for the final comparison.\n"
   0x0000000000001596 <+388>:	lea    rdi,[rip+0xddb]        # 0x2378 # string starting addr "Final result of mangling input:\n"
   0x000000000000159d <+395>:	call   0x1140 <puts@plt> print "Final result of mangling input:\n"
   0x00000000000015a2 <+400>:	mov    edi,0x9 # ascii tab
   0x00000000000015a7 <+405>:	call   0x1120 <putchar@plt> # print tab
   0x00000000000015ac <+410>:	mov    DWORD PTR [rbp-0x18],0x0 # set up zeroed 32 bit counter var on stack
   0x00000000000015b3 <+417>:	jmp    0x15d9 <main+455> # jump to loop condition
   0x00000000000015b5 <+419>:	mov    eax,DWORD PTR [rbp-0x18] # counter to eax
   0x00000000000015b8 <+422>:	cdqe # zero extend eax to rax
   0x00000000000015ba <+424>:	movzx  eax,BYTE PTR [rbp+rax*1-0xe] # current input byte
   0x00000000000015bf <+429>:	movzx  eax,al # zero extend al to eax
   0x00000000000015c2 <+432>:	mov    esi,eax # current byte as arg2 printf
   0x00000000000015c4 <+434>:	lea    rdi,[rip+0xd49]        # 0x2314 # format string starting addr "%02x "
   0x00000000000015cb <+441>:	mov    eax,0x0 # reset rax to zero
   0x00000000000015d0 <+446>:	call   0x1170 <printf@plt> # print "%02x ", current_byte
   0x00000000000015d5 <+451>:	add    DWORD PTR [rbp-0x18],0x1 # increment counter
   0x00000000000015d9 <+455>:	cmp    DWORD PTR [rbp-0x18],0x4 # if counter
   0x00000000000015dd <+459>:	jle    0x15b5 <main+419> # <= 4
   0x00000000000015df <+461>:	lea    rdi,[rip+0xb24]        # 0x210a # string starting addr "\n"
   0x00000000000015e6 <+468>:	call   0x1140 <puts@plt> # print "\n"
   0x00000000000015eb <+473>:	lea    rdi,[rip+0xda7]        # 0x2399 # string starting addr "Expected result:\n"
   0x00000000000015f2 <+480>:	call   0x1140 <puts@plt> # print "Expected result:\n"
   0x00000000000015f7 <+485>:	mov    edi,0x9 # ascii tab
   0x00000000000015fc <+490>:	call   0x1120 <putchar@plt> # print tab
   0x0000000000001601 <+495>:	mov    DWORD PTR [rbp-0x14],0x0 # set up counter var on stack zeroed
   0x0000000000001608 <+502>:	jmp    0x1634 <main+546> # jumpt to loop condition
   0x000000000000160a <+504>:	mov    eax,DWORD PTR [rbp-0x14] # counter to eax
   0x000000000000160d <+507>:	cdqe # zero extend eax to rax
   0x000000000000160f <+509>:	lea    rdx,[rip+0x29fa]        # 0x4010 <EXPECTED_RESULT> # string starting addr "mecbe"
   0x0000000000001616 <+516>:	movzx  eax,BYTE PTR [rax+rdx*1] # current expected result byte
   0x000000000000161a <+520>:	movzx  eax,al # zero extend al to eax
   0x000000000000161d <+523>:	mov    esi,eax # current expected result byte as arg2
   0x000000000000161f <+525>:	lea    rdi,[rip+0xcee]        # 0x2314 # string starting addr "%02x "
   0x0000000000001626 <+532>:	mov    eax,0x0 # reset rax to zero
   0x000000000000162b <+537>:	call   0x1170 <printf@plt> # print "%02x ", current_expected_result_byte
   0x0000000000001630 <+542>:	add    DWORD PTR [rbp-0x14],0x1 # increment counter
   0x0000000000001634 <+546>:	cmp    DWORD PTR [rbp-0x14],0x4 # if counter
   0x0000000000001638 <+550>:	jle    0x160a <main+504> # <= 4
   0x000000000000163a <+552>:	lea    rdi,[rip+0xac9]        # 0x210a # string starting addr "\n"
   0x0000000000001641 <+559>:	call   0x1140 <puts@plt> # print "\n"
   0x0000000000001646 <+564>:	lea    rdi,[rip+0xd63]        # 0x23b0 # string starting addr "Checking the received license key!\n"
   0x000000000000164d <+571>:	call   0x1140 <puts@plt> print "Checking the received license key!\n"
   0x0000000000001652 <+576>:	lea    rax,[rbp-0xe] # input string starting addr
   0x0000000000001656 <+580>:	mov    edx,0x5 # size arg3
   0x000000000000165b <+585>:	lea    rsi,[rip+0x29ae]        # 0x4010 <EXPECTED_RESULT> # expected result starting addr arg2
   0x0000000000001662 <+592>:	mov    rdi,rax # input string starting addr arg1
   0x0000000000001665 <+595>:	call   0x11b0 <memcmp@plt> # compare input and expected first 5 bytes
   0x000000000000166a <+600>:	test   eax,eax # if not equal
   0x000000000000166c <+602>:	jne    0x1682 <main+624> skip win
   0x000000000000166e <+604>:	mov    eax,0x0 # zero rax
   0x0000000000001673 <+609>:	call   0x12e9 <win> # show flag
   0x0000000000001678 <+614>:	mov    edi,0x0 # exit code zero
   0x000000000000167d <+619>:	call   0x11e0 <exit@plt> # exit
   0x0000000000001682 <+624>:	lea    rdi,[rip+0xd4b]        # 0x23d4 # failure string starting addr "Wrong! No flag for you!"
   0x0000000000001689 <+631>:	call   0x1140 <puts@plt> print "Wrong! No flag for you!"
   0x000000000000168e <+636>:	mov    edi,0x1 # exit code one
   0x0000000000001693 <+641>:	call   0x11e0 <exit@plt> # exit
End of assembler dump.

