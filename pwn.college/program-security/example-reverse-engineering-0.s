main:
    1412:	f3 0f 1e fa          	endbr64 indirect jumps allowed
    1416:	55                   	push   rbp save current stack frame base
    1417:	48 89 e5             	mov    rbp,rsp create new stack frame
    141a:	48 83 ec 70          	sub    rsp,0x70 alloc local vars
    141e:	89 7d ac             	mov    DWORD PTR [rbp-0x54],edi argc
    1421:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi argv ptr
    1425:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx env ptr
    1429:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 sentinal stack guard val
    1430:	00 00 
    1432:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax sentinal stack guard val to stack
    1436:	31 c0                	xor    eax,eax
    1438:	83 7d ac 00          	cmp    DWORD PTR [rbp-0x54],0x0 argc 0?
    143c:	7f 1f                	jg     145d <strerror@plt+0x26d> > jump success
    143e:	48 8d 0d ff 0e 00 00 	lea    rcx,[rip+0xeff] function name addr
    1445:	ba 32 00 00 00       	mov    edx,0x32 line num
    144a:	48 8d 35 bb 0c 00 00 	lea    rsi,[rip+0xcbb] file addr
    1451:	48 8d 3d bc 0c 00 00 	lea    rdi,[rip+0xcbc] assert str addr
    1458:	e8 23 fd ff ff       	call   1180 <__assert_fail@plt>
    145d:	48 8d 3d b9 0c 00 00 	lea    rdi,[rip+0xcb9] success: str addr
    1464:	e8 d7 fc ff ff       	call   1140 <puts@plt> print str
    1469:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60] argv ptr addr
    146d:	48 8b 00             	mov    rax,QWORD PTR [rax] dereference to argv addr
    1470:	48 89 c6             	mov    rsi,rax argv addr
    1473:	48 8d 3d a7 0c 00 00 	lea    rdi,[rip+0xca7] format str addr
    147a:	b8 00 00 00 00       	mov    eax,0x0
    147f:	e8 ec fc ff ff       	call   1170 <printf@plt> print format, argv
    1484:	48 8d 3d 92 0c 00 00 	lea    rdi,[rip+0xc92] str addr
    148b:	e8 b0 fc ff ff       	call   1140 <puts@plt> print str
    1490:	bf 0a 00 00 00       	mov    edi,0xa new line
    1495:	e8 86 fc ff ff       	call   1120 <putchar@plt> print new line
    149a:	48 8b 05 9f 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b9f] stdin file addr
    14a1:	b9 00 00 00 00       	mov    ecx,0x0 buf size
    14a6:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    14ab:	be 00 00 00 00       	mov    esi,0x0 buf addr
    14b0:	48 89 c7             	mov    rdi,rax stdin file addr
    14b3:	e8 08 fd ff ff       	call   11c0 <setvbuf@plt> set stdin unbuffered
    14b8:	48 8b 05 71 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b71] stdout file addr
    14bf:	b9 01 00 00 00       	mov    ecx,0x1 buf size
    14c4:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    14c9:	be 00 00 00 00       	mov    esi,0x0 buf addr
    14ce:	48 89 c7             	mov    rdi,rax stdout file addr
    14d1:	e8 ea fc ff ff       	call   11c0 <setvbuf@plt> set stdout unbuffered
    14d6:	48 8d 3d 5b 0c 00 00 	lea    rdi,[rip+0xc5b] str addr
    14dd:	e8 5e fc ff ff       	call   1140 <puts@plt> print str
    14e2:	48 8d 3d c7 0c 00 00 	lea    rdi,[rip+0xcc7] str addr
    14e9:	e8 52 fc ff ff       	call   1140 <puts@plt> print str
    14ee:	48 8d 3d 33 0d 00 00 	lea    rdi,[rip+0xd33] str addr
    14f5:	e8 46 fc ff ff       	call   1140 <puts@plt> print str
    14fa:	48 8d 3d 9f 0d 00 00 	lea    rdi,[rip+0xd9f] str addr
    1501:	e8 3a fc ff ff       	call   1140 <puts@plt> print str
    1506:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0 alloc inbuf
    150d:	00 
    150e:	48 c7 45 d8 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0 alloc inbuf
    1515:	00 
    1516:	48 c7 45 e0 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0 alloc inbuf
    151d:	00 
    151e:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0 alloc inbuf
    1525:	c6 45 ec 00          	mov    BYTE PTR [rbp-0x14],0x0 alloc inbuf
    1529:	48 8d 3d b0 0d 00 00 	lea    rdi,[rip+0xdb0] str addr
    1530:	e8 0b fc ff ff       	call   1140 <puts@plt> print str
    1535:	48 8d 45 d0          	lea    rax,[rbp-0x30] inbuf addr
    1539:	ba 1c 00 00 00       	mov    edx,0x1c num bytes read 28
    153e:	48 89 c6             	mov    rsi,rax inbuf addr
    1541:	bf 00 00 00 00       	mov    edi,0x0 stdin fd
    1546:	e8 55 fc ff ff       	call   11a0 <read@plt> read 28 bytes from stdin
sort_mangler:
    154b:	c7 45 b8 00 00 00 00 	mov    DWORD PTR [rbp-0x48],0x0 alloc count0
    1552:	eb 73                	jmp    15c7 <strerror@plt+0x3d7> jump loop cond0
    1554:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [rbp-0x44],0x0 loop start0: alloc count1
    155b:	eb 59                	jmp    15b6 <strerror@plt+0x3c6> jump loop cond1
    155d:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] loop start1: count1
    1560:	48 98                	cdqe
    1562:	0f b6 54 05 d0       	movzx  edx,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1
    1567:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count1
    156a:	83 c0 01             	add    eax,0x1 count1+1
    156d:	48 98                	cdqe
    156f:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1+1
    1574:	38 c2                	cmp    dl,al compare selected inbuf bytes
    1576:	76 3a                	jbe    15b2 <strerror@plt+0x3c2> <= jump inc count1
    1578:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count1
    157b:	48 98                	cdqe
    157d:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1
    1582:	88 45 b6             	mov    BYTE PTR [rbp-0x4a],al tmp save inbuf byte pos count1
    1585:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count1
    1588:	83 c0 01             	add    eax,0x1 count1+1
    158b:	48 98                	cdqe
    158d:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1+1
    1592:	88 45 b7             	mov    BYTE PTR [rbp-0x49],al tmp save inbuf byte pos count1+1
    1595:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count1
    1598:	48 98                	cdqe
    159a:	0f b6 55 b7          	movzx  edx,BYTE PTR [rbp-0x49] inbuf byte pos count1+1
    159e:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos count1
    15a2:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count1
    15a5:	83 c0 01             	add    eax,0x1 count1+1
    15a8:	48 98                	cdqe
    15aa:	0f b6 55 b6          	movzx  edx,BYTE PTR [rbp-0x4a] inbuf byte pos count1
    15ae:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos count1+1
    15b2:	83 45 bc 01          	add    DWORD PTR [rbp-0x44],0x1 inc count1
    15b6:	b8 1b 00 00 00       	mov    eax,0x1b loop cond1: 27
    15bb:	2b 45 b8             	sub    eax,DWORD PTR [rbp-0x48] 27-count0
    15be:	39 45 bc             	cmp    DWORD PTR [rbp-0x44],eax count1 is 27-count0?
    15c1:	7c 9a                	jl     155d <strerror@plt+0x36d> < jump loop start1
    15c3:	83 45 b8 01          	add    DWORD PTR [rbp-0x48],0x1 inc count0
    15c7:	83 7d b8 1a          	cmp    DWORD PTR [rbp-0x48],0x1a loop cond0: count0 26?
    15cb:	7e 87                	jle    1554 <strerror@plt+0x364> <= jump loop start0
reverse_mangler_a:
    15cd:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0 alloc count
    15d4:	eb 42                	jmp    1618 <strerror@plt+0x428> jump loop cond
    15d6:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40] loop start: count
    15d9:	48 98                	cdqe
    15db:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    15e0:	88 45 b4             	mov    BYTE PTR [rbp-0x4c],al tmp save inbuf byte pos count
    15e3:	b8 1b 00 00 00       	mov    eax,0x1b 27
    15e8:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40] 27-count
    15eb:	48 98                	cdqe
    15ed:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos 27-count
    15f2:	88 45 b5             	mov    BYTE PTR [rbp-0x4b],al tmp save inbuf byte pos 27-count
    15f5:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40] count
    15f8:	48 98                	cdqe
    15fa:	0f b6 55 b5          	movzx  edx,BYTE PTR [rbp-0x4b] inbuf byte pos 27-count
    15fe:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos count
    1602:	b8 1b 00 00 00       	mov    eax,0x1b 27
    1607:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40] 27-count
    160a:	48 98                	cdqe
    160c:	0f b6 55 b4          	movzx  edx,BYTE PTR [rbp-0x4c] inbuf byte pos count
    1610:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos 27-count
    1614:	83 45 c0 01          	add    DWORD PTR [rbp-0x40],0x1 inc count
    1618:	83 7d c0 0d          	cmp    DWORD PTR [rbp-0x40],0xd loop cond: count 13?
    161c:	7e b8                	jle    15d6 <strerror@plt+0x3e6> <= jump loop start
pos_based_xor_mangler_a:
    161e:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0 alloc count
    1625:	e9 8f 00 00 00       	jmp    16b9 <strerror@plt+0x4c9> jump loop cond
    162a:	8b 4d c4             	mov    ecx,DWORD PTR [rbp-0x3c] loop start: count
    162d:	48 63 c1             	movsxd rax,ecx count
    1630:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556 magic number for div 3 bit hack see https://stackoverflow.com/questions/36039509/why-does-the-0x55555556-divide-by-3-hack-work, https://web.archive.org/web/20190703172151/http://www.hackersdelight.org/magic.htm
    1637:	48 c1 e8 20          	shr    rax,0x20 truncate 32 least sig bits from result
    163b:	48 89 c2             	mov    rdx,rax => rounded div 3 result with no remainder
    163e:	89 c8                	mov    eax,ecx count
    1640:	c1 f8 1f             	sar    eax,0x1f isolate sign bit => obsolete, count not negative 
    1643:	89 d6                	mov    esi,edx div 3 result
    1645:	29 c6                	sub    esi,eax sub sign bit => sign bit always zero => unchanged
    1647:	89 f0                	mov    eax,esi div 3 result
    1649:	89 c2                	mov    edx,eax div 3 result
    164b:	01 d2                	add    edx,edx 2 * div 3 result
    164d:	01 c2                	add    edx,eax 3 * div 3 result
    164f:	89 c8                	mov    eax,ecx count
    1651:	29 d0                	sub    eax,edx count-3*div3result calculates remainder => modulus
    1653:	83 f8 02             	cmp    eax,0x2 remainder 2?
    1656:	74 44                	je     169c <strerror@plt+0x4ac> ==2 jump xor mangler 0x35
    1658:	83 f8 02             	cmp    eax,0x2 remainder 2?
    165b:	7f 58                	jg     16b5 <strerror@plt+0x4c5> >2 inc count
    165d:	85 c0                	test   eax,eax reamainder 0?
    165f:	74 07                	je     1668 <strerror@plt+0x478> ==0 jump xor mangler 0xe4
    1661:	83 f8 01             	cmp    eax,0x1 remainder 1?
    1664:	74 1c                	je     1682 <strerror@plt+0x492> ==1 jump xor mangler 0x2b
    1666:	eb 4d                	jmp    16b5 <strerror@plt+0x4c5> <0 jump inc count
    1668:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    166b:	48 98                	cdqe
    166d:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    1672:	83 f0 e4             	xor    eax,0xffffffe4 xor 0xe4
    1675:	89 c2                	mov    edx,eax 0xe4 xored byte
    1677:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    167a:	48 98                	cdqe
    167c:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0xe4 xored byte to inbuf pos count
    1680:	eb 33                	jmp    16b5 <strerror@plt+0x4c5> jump inc count
    1682:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    1685:	48 98                	cdqe
    1687:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    168c:	83 f0 2b             	xor    eax,0x2b
    168f:	89 c2                	mov    edx,eax 0x2b xored byte
    1691:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    1694:	48 98                	cdqe
    1696:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0x2b xored byte to inbuf pos count
    169a:	eb 19                	jmp    16b5 <strerror@plt+0x4c5> jump inc count
    169c:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    169f:	48 98                	cdqe
    16a1:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    16a6:	83 f0 35             	xor    eax,0x35
    16a9:	89 c2                	mov    edx,eax 0x35 xored byte
    16ab:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] count
    16ae:	48 98                	cdqe
    16b0:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0x35 xored byte to inbuf pos count
    16b4:	90                   	nop
    16b5:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1 inc count
    16b9:	83 7d c4 1b          	cmp    DWORD PTR [rbp-0x3c],0x1b loop cond: count 27?
    16bd:	0f 8e 67 ff ff ff    	jle    162a <strerror@plt+0x43a> <= jump loop start
reverse_mangler_b:
    16c3:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [rbp-0x38],0x0 alloc count
    16ca:	eb 42                	jmp    170e <strerror@plt+0x51e> jump loop cond
    16cc:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] count
    16cf:	48 98                	cdqe
    16d1:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    16d6:	88 45 b2             	mov    BYTE PTR [rbp-0x4e],al tmp save inbuf byte pos count
    16d9:	b8 1b 00 00 00       	mov    eax,0x1b 27
    16de:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38] 27-count
    16e1:	48 98                	cdqe
    16e3:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos 27-count
    16e8:	88 45 b3             	mov    BYTE PTR [rbp-0x4d],al tmp save inbuf byte pos 27-count
    16eb:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] count
    16ee:	48 98                	cdqe
    16f0:	0f b6 55 b3          	movzx  edx,BYTE PTR [rbp-0x4d] inbuf byte pos 27-count
    16f4:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos count
    16f8:	b8 1b 00 00 00       	mov    eax,0x1b 27
    16fd:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38] 27-count
    1700:	48 98                	cdqe
    1702:	0f b6 55 b2          	movzx  edx,BYTE PTR [rbp-0x4e] inbuf byte pos count
    1706:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos 27-count
    170a:	83 45 c8 01          	add    DWORD PTR [rbp-0x38],0x1 inc count
    170e:	83 7d c8 0d          	cmp    DWORD PTR [rbp-0x38],0xd loop cond: count 13?
    1712:	7e b8                	jle    16cc <strerror@plt+0x4dc> <= jump loop start
pos_based_xor_mangler_b:
    1714:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0 alloc count
    171b:	e9 8f 00 00 00       	jmp    17af <strerror@plt+0x5bf> jump loop cond
    1720:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34] loop start: count
    1723:	48 63 c1             	movsxd rax,ecx count
    1726:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556 magic number for div 3 bit hack see https://stackoverflow.com/questions/36039509/why-does-the-0x55555556-divide-by-3-hack-work, https://web.archive.org/web/20190703172151/http://www.hackersdelight.org/magic.htm
    172d:	48 c1 e8 20          	shr    rax,0x20 truncate 32 least sig bits from result
    1731:	48 89 c2             	mov    rdx,rax => rounded div 3 result with no remainder
    1734:	89 c8                	mov    eax,ecx count
    1736:	c1 f8 1f             	sar    eax,0x1f isolate sign bit => obsolete, count not negative
    1739:	89 d6                	mov    esi,edx div 3 result
    173b:	29 c6                	sub    esi,eax sub sign bit => sign bit always zero => unchanged
    173d:	89 f0                	mov    eax,esi div 3 result
    173f:	89 c2                	mov    edx,eax div 3 result
    1741:	01 d2                	add    edx,edx 2 * div 3 result
    1743:	01 c2                	add    edx,eax 3 * div 3 result
    1745:	89 c8                	mov    eax,ecx count
    1747:	29 d0                	sub    eax,edx count-3*div3result => calculates remainder => modulus
    1749:	83 f8 02             	cmp    eax,0x2 remainder 2?
    174c:	74 44                	je     1792 <strerror@plt+0x5a2> ==2 jump xor mangler 0x93
    174e:	83 f8 02             	cmp    eax,0x2 remainder 2?
    1751:	7f 58                	jg     17ab <strerror@plt+0x5bb> >2 jump inc count
    1753:	85 c0                	test   eax,eax remainder 0?
    1755:	74 07                	je     175e <strerror@plt+0x56e> ==0 jump xor mangler 0x90
    1757:	83 f8 01             	cmp    eax,0x1 remainder 1?
    175a:	74 1c                	je     1778 <strerror@plt+0x588> ==1 jump xor mangler 0x78
    175c:	eb 4d                	jmp    17ab <strerror@plt+0x5bb> <0 jump inc count
    175e:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    1761:	48 98                	cdqe
    1763:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    1768:	83 f0 90             	xor    eax,0xffffff90 xor 0x90
    176b:	89 c2                	mov    edx,eax 0x90 xored byte
    176d:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    1770:	48 98                	cdqe
    1772:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0x90 xored byte to inbuf pos count
    1776:	eb 33                	jmp    17ab <strerror@plt+0x5bb> jump inc count
    1778:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    177b:	48 98                	cdqe
    177d:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    1782:	83 f0 78             	xor    eax,0x78
    1785:	89 c2                	mov    edx,eax 0x78 xored byte
    1787:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    178a:	48 98                	cdqe
    178c:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0x78 xored byte to inbuf pos count
    1790:	eb 19                	jmp    17ab <strerror@plt+0x5bb> jump inc count
    1792:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    1795:	48 98                	cdqe
    1797:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    179c:	83 f0 93             	xor    eax,0xffffff93 xor 0x93
    179f:	89 c2                	mov    edx,eax 0x93 xored byte
    17a1:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34] count
    17a4:	48 98                	cdqe
    17a6:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl 0x93 xored byte to inbuf pos count
    17aa:	90                   	nop
    17ab:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1 inc count
    17af:	83 7d cc 1b          	cmp    DWORD PTR [rbp-0x34],0x1b loop cond: count 27?
    17b3:	0f 8e 67 ff ff ff    	jle    1720 <strerror@plt+0x530> <= jump loop start
compare_result:
    17b9:	48 8d 3d 48 0b 00 00 	lea    rdi,[rip+0xb48] str addr
    17c0:	e8 7b f9 ff ff       	call   1140 <puts@plt> print str
    17c5:	48 8d 45 d0          	lea    rax,[rbp-0x30] inbuf addr
    17c9:	ba 1c 00 00 00       	mov    edx,0x1c num bytes to cmp 28
    17ce:	48 8d 35 3b 28 00 00 	lea    rsi,[rip+0x283b] expected result addr
    17d5:	48 89 c7             	mov    rdi,rax inbuf addr
    17d8:	e8 d3 f9 ff ff       	call   11b0 <memcmp@plt>
    17dd:	85 c0                	test   eax,eax equal?
    17df:	75 14                	jne    17f5 <strerror@plt+0x605> unequeal jump fail
    17e1:	b8 00 00 00 00       	mov    eax,0x0
    17e6:	e8 fe fa ff ff       	call   12e9 <strerror@plt+0xf9> win
    17eb:	bf 00 00 00 00       	mov    edi,0x0 exit code
    17f0:	e8 eb f9 ff ff       	call   11e0 <exit@plt>
    17f5:	48 8d 3d 30 0b 00 00 	lea    rdi,[rip+0xb30] fail: str addr
    17fc:	e8 3f f9 ff ff       	call   1140 <puts@plt> print str
    1801:	bf 01 00 00 00       	mov    edi,0x1 exit code
    1806:	e8 d5 f9 ff ff       	call   11e0 <exit@plt>
