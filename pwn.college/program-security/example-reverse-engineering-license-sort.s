Disassembly of section .text:

0000000000001200 <.text>:
main:
    1412:	f3 0f 1e fa          	endbr64 # indirect jumps allowed
    1416:	55                   	push   rbp # save previous stack frame base
    1417:	48 89 e5             	mov    rbp,rsp # create new stack frame
    141a:	48 83 ec 40          	sub    rsp,0x40 # allocate local var space
    141e:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi # argc
    1421:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi # argv ptr
    1425:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx # env ptr
    1429:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # sentinal stack guard value
    1430:	00 00 
    1432:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax # sentinal stack guard value below rbp
    1436:	31 c0                	xor    eax,eax # zero eax => rax zero
    1438:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0 # argc zero?
    143c:	7f 1f                	jg     145d <strerror@plt+0x26d> > jump welcome msg
    143e:	48 8d 0d ff 0e 00 00 	lea    rcx,[rip+0xeff]        # 2344 <strerror@plt+0x1154>
    1445:	ba 32 00 00 00       	mov    edx,0x32
    144a:	48 8d 35 bb 0c 00 00 	lea    rsi,[rip+0xcbb]        # 210c <strerror@plt+0xf1c>
    1451:	48 8d 3d bc 0c 00 00 	lea    rdi,[rip+0xcbc]        # 2114 <strerror@plt+0xf24>
    1458:	e8 23 fd ff ff       	call   1180 <__assert_fail@plt>
    145d:	48 8d 3d b9 0c 00 00 	lea    rdi,[rip+0xcb9] # string addr "###"
    1464:	e8 d7 fc ff ff       	call   1140 <puts@plt> # print "###"
    1469:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30] # argv ptr
    146d:	48 8b 00             	mov    rax,QWORD PTR [rax] # dereferenced argv addr
    1470:	48 89 c6             	mov    rsi,rax # argv addr as arg2
    1473:	48 8d 3d a7 0c 00 00 	lea    rdi,[rip+0xca7] # format string addr "### Welcome to %s!\n"
    147a:	b8 00 00 00 00       	mov    eax,0x0 # zero eax => rax zero
    147f:	e8 ec fc ff ff       	call   1170 <printf@plt> # print "### Welcome to %s!\n"
    1484:	48 8d 3d 92 0c 00 00 	lea    rdi,[rip+0xc92] # string addr "###"
    148b:	e8 b0 fc ff ff       	call   1140 <puts@plt> # print "###"
    1490:	bf 0a 00 00 00       	mov    edi,0xa # ascii new line
    1495:	e8 86 fc ff ff       	call   1120 <putchar@plt> # print new line
    149a:	48 8b 05 8f 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b8f] # open file addr stdin
    14a1:	b9 00 00 00 00       	mov    ecx,0x0 # buf size
    14a6:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered => buf addr and size ignored
    14ab:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14b0:	48 89 c7             	mov    rdi,rax # open file addr stdin as arg1
    14b3:	e8 08 fd ff ff       	call   11c0 <setvbuf@plt> # set stdin unbuffered
    14b8:	48 8b 05 61 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b61] # open file addr stdout
    14bf:	b9 01 00 00 00       	mov    ecx,0x1 # buf size
    14c4:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered => buf addr and size ignored
    14c9:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14ce:	48 89 c7             	mov    rdi,rax # open file addr stdout as arg1
    14d1:	e8 ea fc ff ff       	call   11c0 <setvbuf@plt># set stdout unbuffered
    14d6:	48 8d 3d 5b 0c 00 00 	lea    rdi,[rip+0xc5b] # string addr "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
    14dd:	e8 5e fc ff ff       	call   1140 <puts@plt> # print "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
    14e2:	48 8d 3d c7 0c 00 00 	lea    rdi,[rip+0xcc7] # string addr "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
    14e9:	e8 52 fc ff ff       	call   1140 <puts@plt> # print "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
    14ee:	48 8d 3d 33 0d 00 00 	lea    rdi,[rip+0xd33] # string addr "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
    14f5:	e8 46 fc ff ff       	call   1140 <puts@plt> # print "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
    14fa:	48 8d 3d 9f 0d 00 00 	lea    rdi,[rip+0xd9f] # string addr "Providing the correct license key will net you the flag!\n"
    1501:	e8 3a fc ff ff       	call   1140 <puts@plt> # print "Providing the correct license key will net you the flag!\n"
    1506:	c7 45 f2 00 00 00 00 	mov    DWORD PTR [rbp-0xe],0x0 # allocate input buf
    150d:	66 c7 45 f6 00 00    	mov    WORD PTR [rbp-0xa],0x0 # allocate input buf
    1513:	48 8d 3d c6 0d 00 00 	lea    rdi,[rip+0xdc6] # string addr "Ready to receive your license key!\n"
    151a:	e8 21 fc ff ff       	call   1140 <puts@plt> # print "Ready to receive your license key!\n"
    151f:	48 8d 45 f2          	lea    rax,[rbp-0xe] # input buf addr
    1523:	ba 05 00 00 00       	mov    edx,0x5 # num bytes to read
    1528:	48 89 c6             	mov    rsi,rax # input buf addr as arg2
    152b:	bf 00 00 00 00       	mov    edi,0x0 # stdin fd
    1530:	e8 6b fc ff ff       	call   11a0 <read@plt> # read 5 bytes from stdin to input buf
    1535:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0 # allocate counter1 var value 0
    153c:	eb 73                	jmp    15b1 <strerror@plt+0x3c1> # jump outer loop condition
outer_loop:
    153e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0 # allocate counter2 value 0
    1545:	eb 59                	jmp    15a0 <strerror@plt+0x3b0> # jump inner loop condition
inner_loop:
    1547:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    154a:	48 98                	cdqe # zero extend eax to rax
    154c:	0f b6 54 05 f2       	movzx  edx,BYTE PTR [rbp+rax*1-0xe] # input buf byte at pos counter2
    1551:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    1554:	83 c0 01             	add    eax,0x1 # inc
    1557:	48 98                	cdqe # zero extend eax to rax
    1559:	0f b6 44 05 f2       	movzx  eax,BYTE PTR [rbp+rax*1-0xe] # input buf byte at pos counter2 plus 1
    155e:	38 c2                	cmp    dl,al # compare input buf byte pos counter2 with pos counter2 plus 1
    1560:	76 3a                	jbe    159c <strerror@plt+0x3ac> # <= jump sort end
    1562:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    1565:	48 98                	cdqe # zero extend eax to rax
    1567:	0f b6 44 05 f2       	movzx  eax,BYTE PTR [rbp+rax*1-0xe] # input buf byte at pos counter2
    156c:	88 45 e6             	mov    BYTE PTR [rbp-0x1a],al # tmp store on stack
    156f:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    1572:	83 c0 01             	add    eax,0x1 # inc
    1575:	48 98                	cdqe # zero extend eax to rax
    1577:	0f b6 44 05 f2       	movzx  eax,BYTE PTR [rbp+rax*1-0xe] # next input buf byte
    157c:	88 45 e7             	mov    BYTE PTR [rbp-0x19],al # tmp store on stack
    157f:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    1582:	48 98                	cdqe # zero extend eax to rax
    1584:	0f b6 55 e7          	movzx  edx,BYTE PTR [rbp-0x19] # next input buf byte
    1588:	88 54 05 f2          	mov    BYTE PTR [rbp+rax*1-0xe],dl # next input buf byte to current pos
    158c:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14] # counter2
    158f:	83 c0 01             	add    eax,0x1 # inc
    1592:	48 98                	cdqe # zero extend eax to rax
    1594:	0f b6 55 e6          	movzx  edx,BYTE PTR [rbp-0x1a] # current input buf byte
    1598:	88 54 05 f2          	mov    BYTE PTR [rbp+rax*1-0xe],dl # current input buf byte to next position
sort_end:
    159c:	83 45 ec 01          	add    DWORD PTR [rbp-0x14],0x1 # inc counter2
inner_loop_cond:
    15a0:	b8 04 00 00 00       	mov    eax,0x4
    15a5:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18] # 4 - counter1
    15a8:	39 45 ec             	cmp    DWORD PTR [rbp-0x14],eax # compare counter2 and 4 - counter1
    15ab:	7c 9a                	jl     1547 <strerror@plt+0x357> < jump inner loop start
    15ad:	83 45 e8 01          	add    DWORD PTR [rbp-0x18],0x1 # inc counter1
outer_loop_cond:
    15b1:	83 7d e8 03          	cmp    DWORD PTR [rbp-0x18],0x3 # counter1 three?
    15b5:	7e 87                	jle    153e <strerror@plt+0x34e> # <= jump outer loop start
    15b7:	48 8d 3d 4a 0d 00 00 	lea    rdi,[rip+0xd4a] # string addr "Checking the received license key!\n"
    15be:	e8 7d fb ff ff       	call   1140 <puts@plt> # print "Checking the received license key!\n"
    15c3:	48 8d 45 f2          	lea    rax,[rbp-0xe] # input buf addr
    15c7:	ba 05 00 00 00       	mov    edx,0x5 # num bytes to compare
    15cc:	48 8d 35 3d 2a 00 00 	lea    rsi,[rip+0x2a3d] # expected string addr "llqsu"
    15d3:	48 89 c7             	mov    rdi,rax # input buf addr as arg1
    15d6:	e8 d5 fb ff ff       	call   11b0 <memcmp@plt> # compare first 5 bytes of sorted input buf with expected
    15db:	85 c0                	test   eax,eax # equal?
    15dd:	75 14                	jne    15f3 <strerror@plt+0x403> # no => jump fail
    15df:	b8 00 00 00 00       	mov    eax,0x0 # zero eax => rax zero
    15e4:	e8 00 fd ff ff       	call   12e9 <strerror@plt+0xf9> # win
    15e9:	bf 00 00 00 00       	mov    edi,0x0 # exit code
    15ee:	e8 ed fb ff ff       	call   11e0 <exit@plt>
    15f3:	48 8d 3d 32 0d 00 00 	lea    rdi,[rip+0xd32] # string addr "Wrong! No flag for you!"
    15fa:	e8 41 fb ff ff       	call   1140 <puts@plt> # print "Wrong! No flag for you!"
    15ff:	bf 01 00 00 00       	mov    edi,0x1 # exit code
    1604:	e8 d7 fb ff ff       	call   11e0 <exit@plt>
