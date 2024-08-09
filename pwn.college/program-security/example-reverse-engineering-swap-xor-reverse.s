Disassembly of section .text:
0000000000001412 <main>:
    1412:	f3 0f 1e fa          	endbr64 # indirect jumps allowed
    1416:	55                   	push   rbp # save prev stack frame base
    1417:	48 89 e5             	mov    rbp,rsp # create new stack frame
    141a:	48 83 ec 70          	sub    rsp,0x70 # allocate local var space
    141e:	89 7d ac             	mov    DWORD PTR [rbp-0x54],edi # argc
    1421:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi # argv ptr
    1425:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx # env ptr
    1429:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # sentinal stack guard value
    1430:	00 00 
    1432:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax # sentinal stack guard value below rbp
    1436:	31 c0                	xor    eax,eax # zero eax => rax zero
    1438:	83 7d ac 00          	cmp    DWORD PTR [rbp-0x54],0x0 # argc zero?
    143c:	7f 1f                	jg     145d <main+0x4b> > jump welcome
    143e:	48 8d 0d cf 10 00 00 	lea    rcx,[rip+0x10cf]        # 2514 <__PRETTY_FUNCTION__.5330>
    1445:	ba 32 00 00 00       	mov    edx,0x32
    144a:	48 8d 35 bb 0c 00 00 	lea    rsi,[rip+0xcbb]        # 210c <_IO_stdin_used+0x10c>
    1451:	48 8d 3d bc 0c 00 00 	lea    rdi,[rip+0xcbc]        # 2114 <_IO_stdin_used+0x114>
    1458:	e8 23 fd ff ff       	call   1180 <__assert_fail@plt>
    145d:	48 8d 3d b9 0c 00 00 	lea    rdi,[rip+0xcb9] # string addr "###"
    1464:	e8 d7 fc ff ff       	call   1140 <puts@plt> # print "###"
    1469:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60] # argv ptr
    146d:	48 8b 00             	mov    rax,QWORD PTR [rax] # dereferenced argv addr
    1470:	48 89 c6             	mov    rsi,rax # argv addr as arg2
    1473:	48 8d 3d a7 0c 00 00 	lea    rdi,[rip+0xca7] # format string addr "### Welcome to %s!\n"
    147a:	b8 00 00 00 00       	mov    eax,0x0 # zero eax => rax zero
    147f:	e8 ec fc ff ff       	call   1170 <printf@plt> # print "### Welcome to %s!\n", argv
    1484:	48 8d 3d 92 0c 00 00 	lea    rdi,[rip+0xc92] # string addr "###"
    148b:	e8 b0 fc ff ff       	call   1140 <puts@plt> # print "###"
    1490:	bf 0a 00 00 00       	mov    edi,0xa # ascii new line
    1495:	e8 86 fc ff ff       	call   1120 <putchar@plt> # print new line
    149a:	48 8b 05 9f 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b9f] # stdin open file addr
    14a1:	b9 00 00 00 00       	mov    ecx,0x0 # buf size
    14a6:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered
    14ab:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14b0:	48 89 c7             	mov    rdi,rax # stdin open file addr as arg1
    14b3:	e8 08 fd ff ff       	call   11c0 <setvbuf@plt> # set stdin to unbuffered
    14b8:	48 8b 05 71 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b71] # stdout open file addr
    14bf:	b9 01 00 00 00       	mov    ecx,0x1 # buf size
    14c4:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered
    14c9:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14ce:	48 89 c7             	mov    rdi,rax # stdout open file addr as arg1
    14d1:	e8 ea fc ff ff       	call   11c0 <setvbuf@plt> # set stdout to unbuffered
    14d6:	48 8d 3d 5b 0c 00 00 	lea    rdi,[rip+0xc5b] # string addr "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
    14dd:	e8 5e fc ff ff       	call   1140 <puts@plt> # print "This license verifier software will allow you to read the flag. However, before you can do so, you must verify that you"
    14e2:	48 8d 3d c7 0c 00 00 	lea    rdi,[rip+0xcc7] # string addr "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
    14e9:	e8 52 fc ff ff       	call   1140 <puts@plt> # print "are licensed to read flag files! This program consumes a license key over stdin. Each program may perform entirely"
    14ee:	48 8d 3d 33 0d 00 00 	lea    rdi,[rip+0xd33] # string addr "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
    14f5:	e8 46 fc ff ff       	call   1140 <puts@plt> # print "different operations on that input! You must figure out (by reverse engineering this program) what that license key is."
    14fa:	48 8d 3d 9f 0d 00 00 	lea    rdi,[rip+0xd9f] # string addr "Providing the correct license key will net you the flag!\n"
    1501:	e8 3a fc ff ff       	call   1140 <puts@plt> # print "Providing the correct license key will net you the flag!\n"
    1506:	48 c7 45 e0 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0 # allocate input buf
    150d:	00 
    150e:	48 c7 45 e8 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0 # allocate input buf
    1515:	00 
    1516:	66 c7 45 f0 00 00    	mov    WORD PTR [rbp-0x10],0x0 # allocate input buf
    151c:	48 8d 3d bd 0d 00 00 	lea    rdi,[rip+0xdbd] # string addr "Ready to receive your license key!\n"
    1523:	e8 18 fc ff ff       	call   1140 <puts@plt> # print "Ready to receive your license key!\n"
    1528:	48 8d 45 e0          	lea    rax,[rbp-0x20] # input buf addr
    152c:	ba 11 00 00 00       	mov    edx,0x11 # num bytes to read
    1531:	48 89 c6             	mov    rsi,rax # input buf addr to arg2
    1534:	bf 00 00 00 00       	mov    edi,0x0 # stdin fd
    1539:	e8 62 fc ff ff       	call   11a0 <read@plt> # read 17 bytes from stdin to input buf
    153e:	48 8d 3d bf 0d 00 00 	lea    rdi,[rip+0xdbf] # string addr "Initial input:\n"
    1545:	e8 f6 fb ff ff       	call   1140 <puts@plt> # print "Initial input:\n"
    154a:	bf 09 00 00 00       	mov    edi,0x9 # ascii tab
    154f:	e8 cc fb ff ff       	call   1120 <putchar@plt> # print tab
    1554:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0 # allocate counter var
    155b:	eb 24                	jmp    1581 <main+0x16f> # jump loop condition
    155d:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40] loop start: counter
    1560:	48 98                	cdqe # zero extend eax to rax
    1562:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos counter
    1567:	0f b6 c0             	movzx  eax,al # zero extend al to eax
    156a:	89 c6                	mov    esi,eax # current input buf byte as arg2
    156c:	48 8d 3d a1 0d 00 00 	lea    rdi,[rip+0xda1] # format string addr "%02x "
    1573:	b8 00 00 00 00       	mov    eax,0x0 # zearo eax => rax zero
    1578:	e8 f3 fb ff ff       	call   1170 <printf@plt> # print "%02x ", current input buf byte
    157d:	83 45 c0 01          	add    DWORD PTR [rbp-0x40],0x1 # inc counter
    1581:	83 7d c0 10          	cmp    DWORD PTR [rbp-0x40],0x10 # loop condition: counter 16?
    1585:	7e d6                	jle    155d <main+0x14b> # <= jump loop start
    1587:	48 8d 3d 7c 0b 00 00 	lea    rdi,[rip+0xb7c] # string addr "\n"
    158e:	e8 ad fb ff ff       	call   1140 <puts@plt> # print "\n"
    1593:	48 8d 3d 86 0d 00 00 	lea    rdi,[rip+0xd86] # string addr "This challenge is now mangling your input using the `swap` mangler for indexes `5` and `6`.\n"
    159a:	e8 a1 fb ff ff       	call   1140 <puts@plt> # print "This challenge is now mangling your input using the `swap` mangler for indexes `5` and `6`.\n"
    159f:	0f b6 45 e5          	movzx  eax,BYTE PTR [rbp-0x1b] # input buf byte pos 5
    15a3:	88 45 bc             	mov    BYTE PTR [rbp-0x44],al # tmp store
    15a6:	0f b6 45 e6          	movzx  eax,BYTE PTR [rbp-0x1a] # input buf byte pos 6
    15aa:	88 45 bd             	mov    BYTE PTR [rbp-0x43],al # tmp store
    15ad:	0f b6 45 bd          	movzx  eax,BYTE PTR [rbp-0x43] # input buf byte pos 6
    15b1:	88 45 e5             	mov    BYTE PTR [rbp-0x1b],al # input buf byte pos 6 to pos 5
    15b4:	0f b6 45 bc          	movzx  eax,BYTE PTR [rbp-0x44] # input buf byte pos 5
    15b8:	88 45 e6             	mov    BYTE PTR [rbp-0x1a],al # input buf byte pos 5 to pos 6
    15bb:	48 8d 3d be 0d 00 00 	lea    rdi,[rip+0xdbe] # string addr "This mangled your input, resulting in:\n"
    15c2:	e8 79 fb ff ff       	call   1140 <puts@plt> # print "This mangled your input, resulting in:\n"
    15c7:	bf 09 00 00 00       	mov    edi,0x9 # ascii tab
    15cc:	e8 4f fb ff ff       	call   1120 <putchar@plt> # print tab
    15d1:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0 # allocate counter var
    15d8:	eb 24                	jmp    15fe <main+0x1ec> # jump loop condition
    15da:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] # loop start: counter
    15dd:	48 98                	cdqe # zero extend eax to rax
    15df:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos counter
    15e4:	0f b6 c0             	movzx  eax,al # zero extend al to eax
    15e7:	89 c6                	mov    esi,eax # current input buf byte as arg2
    15e9:	48 8d 3d 24 0d 00 00 	lea    rdi,[rip+0xd24] # format string addr "%02x "
    15f0:	b8 00 00 00 00       	mov    eax,0x0 # zero eax => rax zero
    15f5:	e8 76 fb ff ff       	call   1170 <printf@plt> # print "%02x ", current input buf byte
    15fa:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1 # inc counter
    15fe:	83 7d c4 10          	cmp    DWORD PTR [rbp-0x3c],0x10 # loop condition: counter 16 ?
    1602:	7e d6                	jle    15da <main+0x1c8> <= jump loop start
    1604:	48 8d 3d ff 0a 00 00 	lea    rdi,[rip+0xaff] # string addr "\n"
    160b:	e8 30 fb ff ff       	call   1140 <puts@plt> # print "\n"
    1610:	48 8d 3d 91 0d 00 00 	lea    rdi,[rip+0xd91] # string addr "This challenge is now mangling your input using the `xor` mangler with key `0x3ef5`\n"
    1617:	e8 24 fb ff ff       	call   1140 <puts@plt> # print "This challenge is now mangling your input using the `xor` mangler with key `0x3ef5`\n"
    161c:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [rbp-0x38],0x0 # allocate counter var
    1623:	eb 50                	jmp    1675 <main+0x263> # jump loop condition
    1625:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] # loop start: counter
    1628:	99                   	cdq # sign ext eax to edx => eax positive? => edx zero else minus one (all ones)
    1629:	c1 ea 1f             	shr    edx,0x1f # edx all ones? => only least signi bit one
    162c:	01 d0                	add    eax,edx # eax negative? => add one since 2s complement turns each 1 into 0 and vice versa => odd becomes even => add one to revert
    162e:	83 e0 01             	and    eax,0x1 # num in eax odd? => eax is one else zero
    1631:	29 d0                	sub    eax,edx # positive, even num => eax zero; negative, odd num => eax zero; positive, odd num => eax one; negative, even num => eax minus one
    1633:	85 c0                	test   eax,eax # set zf for positive even and negative odd nums
    1635:	74 07                	je     163e <main+0x22c> # jump xor 0x3e for pos even and neg odd
    1637:	83 f8 01             	cmp    eax,0x1
    163a:	74 1c                	je     1658 <main+0x246> # jump xor 0xfffffff5 for pos odd
    163c:	eb 33                	jmp    1671 <main+0x25f> # jump inc counter for neg even
    163e:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] # counter
    1641:	48 98                	cdqe # zero extend eax to rax
    1643:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos counter
    1648:	83 f0 3e             	xor    eax,0x3e
    164b:	89 c2                	mov    edx,eax # current 0x3e xored input buf byte
    164d:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] # counter
    1650:	48 98                	cdqe # zero extend eax to rax
    1652:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl # current 0x3e xored input buf byte
    1656:	eb 19                	jmp    1671 <main+0x25f> # jump inc counter
    1658:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] #counter
    165b:	48 98                	cdqe # zero extend eax to rax
    165d:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos counter
    1662:	83 f0 f5             	xor    eax,0xfffffff5
    1665:	89 c2                	mov    edx,eax
    1667:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    166a:	48 98                	cdqe   
    166c:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    1670:	90                   	nop
    1671:	83 45 c8 01          	add    DWORD PTR [rbp-0x38],0x1 # inc counter
    1675:	83 7d c8 10          	cmp    DWORD PTR [rbp-0x38],0x10 # loop condition: counter 16?
    1679:	7e aa                	jle    1625 <main+0x213> <= jump loop start
    167b:	48 8d 3d fe 0c 00 00 	lea    rdi,[rip+0xcfe]        # 2380 <_IO_stdin_used+0x380>
    1682:	e8 b9 fa ff ff       	call   1140 <puts@plt>
    1687:	bf 09 00 00 00       	mov    edi,0x9
    168c:	e8 8f fa ff ff       	call   1120 <putchar@plt>
    1691:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
    1698:	eb 24                	jmp    16be <main+0x2ac>
    169a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    169d:	48 98                	cdqe   
    169f:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    16a4:	0f b6 c0             	movzx  eax,al
    16a7:	89 c6                	mov    esi,eax
    16a9:	48 8d 3d 64 0c 00 00 	lea    rdi,[rip+0xc64]        # 2314 <_IO_stdin_used+0x314>
    16b0:	b8 00 00 00 00       	mov    eax,0x0
    16b5:	e8 b6 fa ff ff       	call   1170 <printf@plt>
    16ba:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
    16be:	83 7d cc 10          	cmp    DWORD PTR [rbp-0x34],0x10
    16c2:	7e d6                	jle    169a <main+0x288>
    16c4:	48 8d 3d 3f 0a 00 00 	lea    rdi,[rip+0xa3f]        # 210a <_IO_stdin_used+0x10a>
    16cb:	e8 70 fa ff ff       	call   1140 <puts@plt>
    16d0:	48 8d 3d 29 0d 00 00 	lea    rdi,[rip+0xd29]        # 2400 <_IO_stdin_used+0x400>
    16d7:	e8 64 fa ff ff       	call   1140 <puts@plt>
    16dc:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0
    16e3:	eb 42                	jmp    1727 <main+0x315>
    16e5:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    16e8:	48 98                	cdqe   
    16ea:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    16ef:	88 45 be             	mov    BYTE PTR [rbp-0x42],al
    16f2:	b8 10 00 00 00       	mov    eax,0x10
    16f7:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
    16fa:	48 98                	cdqe   
    16fc:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    1701:	88 45 bf             	mov    BYTE PTR [rbp-0x41],al
    1704:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1707:	48 98                	cdqe   
    1709:	0f b6 55 bf          	movzx  edx,BYTE PTR [rbp-0x41]
    170d:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    1711:	b8 10 00 00 00       	mov    eax,0x10
    1716:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
    1719:	48 98                	cdqe   
    171b:	0f b6 55 be          	movzx  edx,BYTE PTR [rbp-0x42]
    171f:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    1723:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1
    1727:	83 7d d0 07          	cmp    DWORD PTR [rbp-0x30],0x7
    172b:	7e b8                	jle    16e5 <main+0x2d3>
    172d:	48 8d 3d 4c 0c 00 00 	lea    rdi,[rip+0xc4c]        # 2380 <_IO_stdin_used+0x380>
    1734:	e8 07 fa ff ff       	call   1140 <puts@plt>
    1739:	bf 09 00 00 00       	mov    edi,0x9
    173e:	e8 dd f9 ff ff       	call   1120 <putchar@plt>
    1743:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0
    174a:	eb 24                	jmp    1770 <main+0x35e>
    174c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    174f:	48 98                	cdqe   
    1751:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    1756:	0f b6 c0             	movzx  eax,al
    1759:	89 c6                	mov    esi,eax
    175b:	48 8d 3d b2 0b 00 00 	lea    rdi,[rip+0xbb2]        # 2314 <_IO_stdin_used+0x314>
    1762:	b8 00 00 00 00       	mov    eax,0x0
    1767:	e8 04 fa ff ff       	call   1170 <printf@plt>
    176c:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
    1770:	83 7d d4 10          	cmp    DWORD PTR [rbp-0x2c],0x10
    1774:	7e d6                	jle    174c <main+0x33a>
    1776:	48 8d 3d 8d 09 00 00 	lea    rdi,[rip+0x98d]        # 210a <_IO_stdin_used+0x10a>
    177d:	e8 be f9 ff ff       	call   1140 <puts@plt>
    1782:	48 8d 3d bf 0c 00 00 	lea    rdi,[rip+0xcbf]        # 2448 <_IO_stdin_used+0x448>
    1789:	e8 b2 f9 ff ff       	call   1140 <puts@plt>
    178e:	48 8d 3d 0b 0d 00 00 	lea    rdi,[rip+0xd0b]        # 24a0 <_IO_stdin_used+0x4a0>
    1795:	e8 a6 f9 ff ff       	call   1140 <puts@plt>
    179a:	bf 09 00 00 00       	mov    edi,0x9
    179f:	e8 7c f9 ff ff       	call   1120 <putchar@plt>
    17a4:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [rbp-0x28],0x0
    17ab:	eb 24                	jmp    17d1 <main+0x3bf>
    17ad:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    17b0:	48 98                	cdqe   
    17b2:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    17b7:	0f b6 c0             	movzx  eax,al
    17ba:	89 c6                	mov    esi,eax
    17bc:	48 8d 3d 51 0b 00 00 	lea    rdi,[rip+0xb51]        # 2314 <_IO_stdin_used+0x314>
    17c3:	b8 00 00 00 00       	mov    eax,0x0
    17c8:	e8 a3 f9 ff ff       	call   1170 <printf@plt>
    17cd:	83 45 d8 01          	add    DWORD PTR [rbp-0x28],0x1
    17d1:	83 7d d8 10          	cmp    DWORD PTR [rbp-0x28],0x10
    17d5:	7e d6                	jle    17ad <main+0x39b>
    17d7:	48 8d 3d 2c 09 00 00 	lea    rdi,[rip+0x92c]        # 210a <_IO_stdin_used+0x10a>
    17de:	e8 5d f9 ff ff       	call   1140 <puts@plt>
    17e3:	48 8d 3d d7 0c 00 00 	lea    rdi,[rip+0xcd7]        # 24c1 <_IO_stdin_used+0x4c1>
    17ea:	e8 51 f9 ff ff       	call   1140 <puts@plt>
    17ef:	bf 09 00 00 00       	mov    edi,0x9
    17f4:	e8 27 f9 ff ff       	call   1120 <putchar@plt>
    17f9:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
    1800:	eb 2a                	jmp    182c <main+0x41a>
    1802:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1805:	48 98                	cdqe   
    1807:	48 8d 15 02 28 00 00 	lea    rdx,[rip+0x2802]        # 4010 <EXPECTED_RESULT>
    180e:	0f b6 04 10          	movzx  eax,BYTE PTR [rax+rdx*1]
    1812:	0f b6 c0             	movzx  eax,al
    1815:	89 c6                	mov    esi,eax
    1817:	48 8d 3d f6 0a 00 00 	lea    rdi,[rip+0xaf6]        # 2314 <_IO_stdin_used+0x314>
    181e:	b8 00 00 00 00       	mov    eax,0x0
    1823:	e8 48 f9 ff ff       	call   1170 <printf@plt>
    1828:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
    182c:	83 7d dc 10          	cmp    DWORD PTR [rbp-0x24],0x10
    1830:	7e d0                	jle    1802 <main+0x3f0>
    1832:	48 8d 3d d1 08 00 00 	lea    rdi,[rip+0x8d1]        # 210a <_IO_stdin_used+0x10a>
    1839:	e8 02 f9 ff ff       	call   1140 <puts@plt>
    183e:	48 8d 3d 93 0c 00 00 	lea    rdi,[rip+0xc93]        # 24d8 <_IO_stdin_used+0x4d8>
    1845:	e8 f6 f8 ff ff       	call   1140 <puts@plt>
    184a:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    184e:	ba 11 00 00 00       	mov    edx,0x11
    1853:	48 8d 35 b6 27 00 00 	lea    rsi,[rip+0x27b6]        # 4010 <EXPECTED_RESULT>
    185a:	48 89 c7             	mov    rdi,rax
    185d:	e8 4e f9 ff ff       	call   11b0 <memcmp@plt>
    1862:	85 c0                	test   eax,eax
    1864:	75 14                	jne    187a <main+0x468>
    1866:	b8 00 00 00 00       	mov    eax,0x0
    186b:	e8 79 fa ff ff       	call   12e9 <win>
    1870:	bf 00 00 00 00       	mov    edi,0x0
    1875:	e8 66 f9 ff ff       	call   11e0 <exit@plt>
    187a:	48 8d 3d 7b 0c 00 00 	lea    rdi,[rip+0xc7b]        # 24fc <_IO_stdin_used+0x4fc>
    1881:	e8 ba f8 ff ff       	call   1140 <puts@plt>
    1886:	bf 01 00 00 00       	mov    edi,0x1
    188b:	e8 50 f9 ff ff       	call   11e0 <exit@plt>
