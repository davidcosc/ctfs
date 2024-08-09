main:
    1412:	f3 0f 1e fa          	endbr64 # indirect jumps allowed
    1416:	55                   	push   rbp # save prev func stack frame base
    1417:	48 89 e5             	mov    rbp,rsp # create new stack frame
    141a:	48 83 ec 60          	sub    rsp,0x60 # allocate local var space
    141e:	89 7d bc             	mov    DWORD PTR [rbp-0x44],edi # argc
    1421:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi # argv ptr
    1425:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx # env ptr
    1429:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # sentinel stack guard value
    1430:	00 00 
    1432:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax # sentinel stack guard value below rbp
    1436:	31 c0                	xor    eax,eax # zero eax => rax zero
    1438:	83 7d bc 00          	cmp    DWORD PTR [rbp-0x44],0x0 # argc zero?
    143c:	7f 1f                	jg     145d <strerror@plt+0x26d> > jump welcome
    143e:	48 8d 0d ff 0e 00 00 	lea    rcx,[rip+0xeff]        # 2344 <strerror@plt+0x1154>
    1445:	ba 32 00 00 00       	mov    edx,0x32
    144a:	48 8d 35 bb 0c 00 00 	lea    rsi,[rip+0xcbb]        # 210c <strerror@plt+0xf1c>
    1451:	48 8d 3d bc 0c 00 00 	lea    rdi,[rip+0xcbc]        # 2114 <strerror@plt+0xf24>
    1458:	e8 23 fd ff ff       	call   1180 <__assert_fail@plt>
    145d:	48 8d 3d b9 0c 00 00 	lea    rdi,[rip+0xcb9] # welcome: string addr "###"
    1464:	e8 d7 fc ff ff       	call   1140 <puts@plt> # print "###"
    1469:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50] # argv ptr
    146d:	48 8b 00             	mov    rax,QWORD PTR [rax] # dereferenced argv addr
    1470:	48 89 c6             	mov    rsi,rax # argv addr as arg2
    1473:	48 8d 3d a7 0c 00 00 	lea    rdi,[rip+0xca7] # format string addr "### Welcome to %s!\n"
    147a:	b8 00 00 00 00       	mov    eax,0x0 # zero eax => rax zero
    147f:	e8 ec fc ff ff       	call   1170 <printf@plt> # print "### Welcome to %s!\n", argv
    1484:	48 8d 3d 92 0c 00 00 	lea    rdi,[rip+0xc92] # string addr "###"
    148b:	e8 b0 fc ff ff       	call   1140 <puts@plt> # print "###"
    1490:	bf 0a 00 00 00       	mov    edi,0xa # ascii new line
    1495:	e8 86 fc ff ff       	call   1120 <putchar@plt> # print new line
    149a:	48 8b 05 8f 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b8f] # stdin open file addr
    14a1:	b9 00 00 00 00       	mov    ecx,0x0 # buf size
    14a6:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered => buf ignored
    14ab:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14b0:	48 89 c7             	mov    rdi,rax # stdin open file addr as arg1
    14b3:	e8 08 fd ff ff       	call   11c0 <setvbuf@plt> # set stdin unbuffered
    14b8:	48 8b 05 61 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b61] # stdout open file addr
    14bf:	b9 01 00 00 00       	mov    ecx,0x1 # buf size
    14c4:	ba 02 00 00 00       	mov    edx,0x2 # type unbuffered => buf ignored
    14c9:	be 00 00 00 00       	mov    esi,0x0 # buf addr
    14ce:	48 89 c7             	mov    rdi,rax # stdout open file addr as arg1
    14d1:	e8 ea fc ff ff       	call   11c0 <setvbuf@plt> # set stdout unbuffered
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
    1516:	48 8d 3d c3 0d 00 00 	lea    rdi,[rip+0xdc3] # string addr "Ready to receive your license key!"
    151d:	e8 1e fc ff ff       	call   1140 <puts@plt> # print "Ready to receive your license key!"
    1522:	48 8d 45 e0          	lea    rax,[rbp-0x20] # input buf addr
    1526:	ba 0f 00 00 00       	mov    edx,0xf # num bytes to read
    152b:	48 89 c6             	mov    rsi,rax # input buf addr as arg2
    152e:	bf 00 00 00 00       	mov    edi,0x0 # stdin fd
    1533:	e8 68 fc ff ff       	call   11a0 <read@plt> #  read 15 bytes from stdin to input buf
    1538:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [rbp-0x30],0x0 # allocate counter var
    153f:	e9 8f 00 00 00       	jmp    15d3 <strerror@plt+0x3e3> # jump loop condition
    1544:	8b 4d d0             	mov    ecx,DWORD PTR [rbp-0x30] # loop start: counter
    1547:	48 63 c1             	movsxd rax,ecx # counter to rax zero extended
    154a:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556 # counter * 0x55555556 => counter < 16 => result max 5 byte long
    1551:	48 c1 e8 20          	shr    rax,0x20 # isolate 5th byte of mul result
    1555:	48 89 c2             	mov    rdx,rax # save isol byte to rdx
    1558:	89 c8                	mov    eax,ecx # counter
    155a:	c1 f8 1f             	sar    eax,0x1f # signed div 2 / shift right by 31 => always zero
    155d:	89 d6                	mov    esi,edx # isol byte
    155f:	29 c6                	sub    esi,eax # unchanged
    1561:	89 f0                	mov    eax,esi # isol byte
    1563:	89 c2                	mov    edx,eax # isol byte
    1565:	01 d2                	add    edx,edx # add isol byte
    1567:	01 c2                	add    edx,eax # add isol byte
    1569:	89 c8                	mov    eax,ecx # counter
    156b:	29 d0                	sub    eax,edx # sub 3 * isol byte => results in pattern 0,1,2 => 0 : 0, 1 : 1, 2 : 2, 3 : 0, 4 : 1, 5 : 2, 6 : 0...
    156d:	83 f8 02             	cmp    eax,0x2
    1570:	74 44                	je     15b6 <strerror@plt+0x3c6> ==2: jump xor mangle 0x33
    1572:	83 f8 02             	cmp    eax,0x2
    1575:	7f 58                	jg     15cf <strerror@plt+0x3df> >2: jump inc counter
    1577:	85 c0                	test   eax,eax
    1579:	74 07                	je     1582 <strerror@plt+0x392> ==0: jump xor mangle 0xc7
    157b:	83 f8 01             	cmp    eax,0x1
    157e:	74 1c                	je     159c <strerror@plt+0x3ac> ==1: jump xor mangle 0xffffffba
    1580:	eb 4d                	jmp    15cf <strerror@plt+0x3df> <1: jump inc counter
    1582:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] counter
    1585:	48 98                	cdqe   
    1587:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos count
    158c:	83 f0 c7             	xor    eax,0xffffffc7 # xor mangle input buf byte 0xc7
    158f:	89 c2                	mov    edx,eax # save mangled input buf byte
    1591:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] # counter
    1594:	48 98                	cdqe   
    1596:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl # move mangled input buf byte to input buf pos count
    159a:	eb 33                	jmp    15cf <strerror@plt+0x3df> # jump inc count
    159c:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] counter
    159f:	48 98                	cdqe   
    15a1:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos count
    15a6:	83 f0 ba             	xor    eax,0xffffffba # xor mangle input buf byte 0xba
    15a9:	89 c2                	mov    edx,eax # save mangled input buf byte
    15ab:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] # counter
    15ae:	48 98                	cdqe   
    15b0:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl # move mangled input buf byte to input buf pos counter
    15b4:	eb 19                	jmp    15cf <strerror@plt+0x3df> # jump inc count
    15b6:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] # counter
    15b9:	48 98                	cdqe # zero extend eax to rax
    15bb:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] # input buf byte pos counter
    15c0:	83 f0 33             	xor    eax,0x33 # xor mangle input buf byte 0x33
    15c3:	89 c2                	mov    edx,eax # save mangled input buf byte
    15c5:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30] # counter
    15c8:	48 98                	cdqe # zero extend eax to rax
    15ca:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl # mov mangled input buf byte back to input buf pos counter
    15ce:	90                   	nop
    15cf:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1 # inc counter
    15d3:	83 7d d0 0e          	cmp    DWORD PTR [rbp-0x30],0xe # loop condition: counter 14?
    15d7:	0f 8e 67 ff ff ff    	jle    1544 <strerror@plt+0x354> # <= jump loop start
    15dd:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [rbp-0x2c],0x0 # alloc counter
    15e4:	eb 73                	jmp    1659 <strerror@plt+0x469> # jump loop condition
    15e6:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [rbp-0x28],0x0 # loop start: alloc counter2
    15ed:	eb 59                	jmp    1648 <strerror@plt+0x458> # jump inner loop condition
    15ef:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] # inner loop start: counter2
    15f2:	48 98                	cdqe   
    15f4:	0f b6 54 05 e0       	movzx  edx,BYTE PTR [rbp+rax*1-0x20] input buf byte pos count2
    15f9:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] counter
    15fc:	83 c0 01             	add    eax,0x1 inc
    15ff:	48 98                	cdqe   
    1601:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] input buf byte pos count2 + 1
    1606:	38 c2                	cmp    dl,al input buf byte pos count2 cmp input buf byte pos count2 + 1
    1608:	76 3a                	jbe    1644 <strerror@plt+0x454> <= jump inc counter
    160a:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] counter
    160d:	48 98                	cdqe   
    160f:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] input buf byte pos counter
    1614:	88 45 ce             	mov    BYTE PTR [rbp-0x32],al tmp store
    1617:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] counter
    161a:	83 c0 01             	add    eax,0x1 inc
    161d:	48 98                	cdqe   
    161f:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20] input buf byte pos counter + 1
    1624:	88 45 cf             	mov    BYTE PTR [rbp-0x31],al tmp store
    1627:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] counter
    162a:	48 98                	cdqe   
    162c:	0f b6 55 cf          	movzx  edx,BYTE PTR [rbp-0x31] input buf byte pos counter + 1
    1630:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl swap to pos counter
    1634:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28] counter
    1637:	83 c0 01             	add    eax,0x1 inc
    163a:	48 98                	cdqe   
    163c:	0f b6 55 ce          	movzx  edx,BYTE PTR [rbp-0x32] input buf byte pos counter
    1640:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl swap to pos counter +1
    1644:	83 45 d8 01          	add    DWORD PTR [rbp-0x28],0x1 inc counter
    1648:	b8 0e 00 00 00       	mov    eax,0xe # inner loop condition: 15
    164d:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c] 15 - counter
    1650:	39 45 d8             	cmp    DWORD PTR [rbp-0x28],eax counter2 cmp 15 - counter ?
    1653:	7c 9a                	jl     15ef <strerror@plt+0x3ff> < inner loop start
    1655:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
    1659:	83 7d d4 0d          	cmp    DWORD PTR [rbp-0x2c],0xd # loop condition: counter 13 ?
    165d:	7e 87                	jle    15e6 <strerror@plt+0x3f6> <= jump loop start
    165f:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0 allocate counter
    1666:	e9 8f 00 00 00       	jmp    16fa <strerror@plt+0x50a> jump loop condition
    166b:	8b 4d dc             	mov    ecx,DWORD PTR [rbp-0x24] loop start: counter
    166e:	48 63 c1             	movsxd rax,ecx
    1671:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556 
    1678:	48 c1 e8 20          	shr    rax,0x20
    167c:	48 89 c2             	mov    rdx,rax
    167f:	89 c8                	mov    eax,ecx
    1681:	c1 f8 1f             	sar    eax,0x1f
    1684:	89 d6                	mov    esi,edx
    1686:	29 c6                	sub    esi,eax
    1688:	89 f0                	mov    eax,esi
    168a:	89 c2                	mov    edx,eax
    168c:	01 d2                	add    edx,edx
    168e:	01 c2                	add    edx,eax
    1690:	89 c8                	mov    eax,ecx
    1692:	29 d0                	sub    eax,edx results in pattern 0,1,2,0,1,2...
    1694:	83 f8 02             	cmp    eax,0x2
    1697:	74 44                	je     16dd <strerror@plt+0x4ed> ==2: jump xor mangle 0x57
    1699:	83 f8 02             	cmp    eax,0x2
    169c:	7f 58                	jg     16f6 <strerror@plt+0x506> >2: jump inc counter
    169e:	85 c0                	test   eax,eax
    16a0:	74 07                	je     16a9 <strerror@plt+0x4b9> ==0: jump xor mangle 0x4b
    16a2:	83 f8 01             	cmp    eax,0x1
    16a5:	74 1c                	je     16c3 <strerror@plt+0x4d3> ==1: jump xor mangle 0x6a
    16a7:	eb 4d                	jmp    16f6 <strerror@plt+0x506> <1: jump inc counter
    16a9:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16ac:	48 98                	cdqe   
    16ae:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    16b3:	83 f0 4b             	xor    eax,0x4b
    16b6:	89 c2                	mov    edx,eax
    16b8:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16bb:	48 98                	cdqe   
    16bd:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    16c1:	eb 33                	jmp    16f6 <strerror@plt+0x506>
    16c3:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16c6:	48 98                	cdqe   
    16c8:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    16cd:	83 f0 6a             	xor    eax,0x6a
    16d0:	89 c2                	mov    edx,eax
    16d2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16d5:	48 98                	cdqe   
    16d7:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    16db:	eb 19                	jmp    16f6 <strerror@plt+0x506>
    16dd:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16e0:	48 98                	cdqe   
    16e2:	0f b6 44 05 e0       	movzx  eax,BYTE PTR [rbp+rax*1-0x20]
    16e7:	83 f0 57             	xor    eax,0x57
    16ea:	89 c2                	mov    edx,eax
    16ec:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    16ef:	48 98                	cdqe   
    16f1:	88 54 05 e0          	mov    BYTE PTR [rbp+rax*1-0x20],dl
    16f5:	90                   	nop
    16f6:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1 inc counter
    16fa:	83 7d dc 0e          	cmp    DWORD PTR [rbp-0x24],0xe loop condition: counter 15?
    16fe:	0f 8e 67 ff ff ff    	jle    166b <strerror@plt+0x47b> <= 15: jump loop start
    1704:	48 8d 3d fd 0b 00 00 	lea    rdi,[rip+0xbfd]        # 2308 <strerror@plt+0x1118>
    170b:	e8 30 fa ff ff       	call   1140 <puts@plt>
    1710:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    1714:	ba 0f 00 00 00       	mov    edx,0xf
    1719:	48 8d 35 f0 28 00 00 	lea    rsi,[rip+0x28f0]        # 4010 <strerror@plt+0x2e20>
    1720:	48 89 c7             	mov    rdi,rax
    1723:	e8 88 fa ff ff       	call   11b0 <memcmp@plt>
    1728:	85 c0                	test   eax,eax
    172a:	75 14                	jne    1740 <strerror@plt+0x550>
    172c:	b8 00 00 00 00       	mov    eax,0x0
    1731:	e8 b3 fb ff ff       	call   12e9 <strerror@plt+0xf9>
    1736:	bf 00 00 00 00       	mov    edi,0x0
    173b:	e8 a0 fa ff ff       	call   11e0 <exit@plt>
    1740:	48 8d 3d e5 0b 00 00 	lea    rdi,[rip+0xbe5]        # 232c <strerror@plt+0x113c>
    1747:	e8 f4 f9 ff ff       	call   1140 <puts@plt>
    174c:	bf 01 00 00 00       	mov    edi,0x1
    1751:	e8 8a fa ff ff       	call   11e0 <exit@plt>
