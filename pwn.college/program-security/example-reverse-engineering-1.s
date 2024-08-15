main:
    1412:	f3 0f 1e fa          	endbr64
    1416:	55                   	push   rbp
    1417:	48 89 e5             	mov    rbp,rsp
    141a:	48 83 c4 80          	add    rsp,0xffffffffffffff80
    141e:	89 7d 9c             	mov    DWORD PTR [rbp-0x64],edi
    1421:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    1425:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    1429:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    1430:	00 00 
    1432:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1436:	31 c0                	xor    eax,eax
    1438:	83 7d 9c 00          	cmp    DWORD PTR [rbp-0x64],0x0
    143c:	7f 1f                	jg     145d <strerror@plt+0x26d>
    143e:	48 8d 0d 17 0f 00 00 	lea    rcx,[rip+0xf17]        # 235c <strerror@plt+0x116c>
    1445:	ba 32 00 00 00       	mov    edx,0x32
    144a:	48 8d 35 bb 0c 00 00 	lea    rsi,[rip+0xcbb]        # 210c <strerror@plt+0xf1c>
    1451:	48 8d 3d bc 0c 00 00 	lea    rdi,[rip+0xcbc]        # 2114 <strerror@plt+0xf24>
    1458:	e8 23 fd ff ff       	call   1180 <__assert_fail@plt>
    145d:	48 8d 3d b9 0c 00 00 	lea    rdi,[rip+0xcb9]        # 211d <strerror@plt+0xf2d>
    1464:	e8 d7 fc ff ff       	call   1140 <puts@plt>
    1469:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    146d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1470:	48 89 c6             	mov    rsi,rax
    1473:	48 8d 3d a7 0c 00 00 	lea    rdi,[rip+0xca7]        # 2121 <strerror@plt+0xf31>
    147a:	b8 00 00 00 00       	mov    eax,0x0
    147f:	e8 ec fc ff ff       	call   1170 <printf@plt>
    1484:	48 8d 3d 92 0c 00 00 	lea    rdi,[rip+0xc92]        # 211d <strerror@plt+0xf2d>
    148b:	e8 b0 fc ff ff       	call   1140 <puts@plt>
    1490:	bf 0a 00 00 00       	mov    edi,0xa
    1495:	e8 86 fc ff ff       	call   1120 <putchar@plt>
    149a:	48 8b 05 bf 2b 00 00 	mov    rax,QWORD PTR [rip+0x2bbf]        # 4060 <stdin@GLIBC_2.2.5>
    14a1:	b9 00 00 00 00       	mov    ecx,0x0
    14a6:	ba 02 00 00 00       	mov    edx,0x2
    14ab:	be 00 00 00 00       	mov    esi,0x0
    14b0:	48 89 c7             	mov    rdi,rax
    14b3:	e8 08 fd ff ff       	call   11c0 <setvbuf@plt>
    14b8:	48 8b 05 91 2b 00 00 	mov    rax,QWORD PTR [rip+0x2b91]        # 4050 <stdout@GLIBC_2.2.5>
    14bf:	b9 01 00 00 00       	mov    ecx,0x1
    14c4:	ba 02 00 00 00       	mov    edx,0x2
    14c9:	be 00 00 00 00       	mov    esi,0x0
    14ce:	48 89 c7             	mov    rdi,rax
    14d1:	e8 ea fc ff ff       	call   11c0 <setvbuf@plt>
    14d6:	48 8d 3d 5b 0c 00 00 	lea    rdi,[rip+0xc5b]        # 2138 <strerror@plt+0xf48>
    14dd:	e8 5e fc ff ff       	call   1140 <puts@plt>
    14e2:	48 8d 3d c7 0c 00 00 	lea    rdi,[rip+0xcc7]        # 21b0 <strerror@plt+0xfc0>
    14e9:	e8 52 fc ff ff       	call   1140 <puts@plt>
    14ee:	48 8d 3d 33 0d 00 00 	lea    rdi,[rip+0xd33]        # 2228 <strerror@plt+0x1038>
    14f5:	e8 46 fc ff ff       	call   1140 <puts@plt>
    14fa:	48 8d 3d 9f 0d 00 00 	lea    rdi,[rip+0xd9f]        # 22a0 <strerror@plt+0x10b0>
    1501:	e8 3a fc ff ff       	call   1140 <puts@plt>
    1506:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    150d:	00 
    150e:	48 c7 45 d8 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    1515:	00 
    1516:	48 c7 45 e0 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    151d:	00 
    151e:	48 c7 45 e8 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    1525:	00 
    1526:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
    152d:	66 c7 45 f4 00 00    	mov    WORD PTR [rbp-0xc],0x0
    1533:	48 8d 3d a6 0d 00 00 	lea    rdi,[rip+0xda6]        # 22e0 <strerror@plt+0x10f0>
    153a:	e8 01 fc ff ff       	call   1140 <puts@plt>
    153f:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    1543:	ba 25 00 00 00       	mov    edx,0x25 num bytes read 37
    1548:	48 89 c6             	mov    rsi,rax
    154b:	bf 00 00 00 00       	mov    edi,0x0
    1550:	e8 4b fc ff ff       	call   11a0 <read@plt>
sort_mangler:
    1555:	c7 45 b0 00 00 00 00 	mov    DWORD PTR [rbp-0x50],0x0 alloc count0
    155c:	eb 73                	jmp    15d1 <strerror@plt+0x3e1> jump loop cond0
    155e:	c7 45 b4 00 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x0 loop start0: alloc count1
    1565:	eb 59                	jmp    15c0 <strerror@plt+0x3d0> jump loop cond1
    1567:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c] loop start1: count1
    156a:	48 98                	cdqe
    156c:	0f b6 54 05 d0       	movzx  edx,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1
    1571:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c] count1
    1574:	83 c0 01             	add    eax,0x1 count1+1
    1577:	48 98                	cdqe
    1579:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count1+1
    157e:	38 c2                	cmp    dl,al byte1 is byte1+1?
    1580:	76 3a                	jbe    15bc <strerror@plt+0x3cc> <= jump inc count1
    1582:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1585:	48 98                	cdqe
    1587:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    158c:	88 45 ae             	mov    BYTE PTR [rbp-0x52],al
    158f:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    1592:	83 c0 01             	add    eax,0x1
    1595:	48 98                	cdqe
    1597:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    159c:	88 45 af             	mov    BYTE PTR [rbp-0x51],al
    159f:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    15a2:	48 98                	cdqe
    15a4:	0f b6 55 af          	movzx  edx,BYTE PTR [rbp-0x51]
    15a8:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    15ac:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    15af:	83 c0 01             	add    eax,0x1
    15b2:	48 98                	cdqe
    15b4:	0f b6 55 ae          	movzx  edx,BYTE PTR [rbp-0x52]
    15b8:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    15bc:	83 45 b4 01          	add    DWORD PTR [rbp-0x4c],0x1 inc count1
    15c0:	b8 24 00 00 00       	mov    eax,0x24 loop cond1: 36
    15c5:	2b 45 b0             	sub    eax,DWORD PTR [rbp-0x50] 36-count0
    15c8:	39 45 b4             	cmp    DWORD PTR [rbp-0x4c],eax count1 is 36-count0?
    15cb:	7c 9a                	jl     1567 <strerror@plt+0x377> < jump loop start1
    15cd:	83 45 b0 01          	add    DWORD PTR [rbp-0x50],0x1 inc count0
    15d1:	83 7d b0 23          	cmp    DWORD PTR [rbp-0x50],0x23 loop cond0: count0 35?
    15d5:	7e 87                	jle    155e <strerror@plt+0x36e> <= jump loop start0
pos_based_xor_mangler:
    15d7:	c7 45 b8 00 00 00 00 	mov    DWORD PTR [rbp-0x48],0x0 alloc count
    15de:	e9 98 00 00 00       	jmp    167b <strerror@plt+0x48b> jump loop cond
    15e3:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48] loop start: count
    15e6:	99                   	cdq
    15e7:	c1 ea 1e             	shr    edx,0x1e isolate sign byte => always zero, no negative
    15ea:	01 d0                	add    eax,edx unchanged
    15ec:	83 e0 03             	and    eax,0x3 and count with 0b11 => calc remainder div 4
    15ef:	29 d0                	sub    eax,edx unchanged
    15f1:	83 f8 03             	cmp    eax,0x3 remainder 3?
    15f4:	74 68                	je     165e <strerror@plt+0x46e> ==3 jump xor 0x47
    15f6:	83 f8 03             	cmp    eax,0x3 remainder 3?
    15f9:	7f 7c                	jg     1677 <strerror@plt+0x487> >3 jump inc count
    15fb:	83 f8 02             	cmp    eax,0x2 remainder 2?
    15fe:	74 44                	je     1644 <strerror@plt+0x454> ==2 jump xor 0x11
    1600:	83 f8 02             	cmp    eax,0x2 remainder 2?
    1603:	7f 72                	jg     1677 <strerror@plt+0x487> >2 jump inc count
    1605:	85 c0                	test   eax,eax remainder 0?
    1607:	74 07                	je     1610 <strerror@plt+0x420> ==0 jump xor 0x30
    1609:	83 f8 01             	cmp    eax,0x1 remainder 1?
    160c:	74 1c                	je     162a <strerror@plt+0x43a> ==1 jump xor 0x57
    160e:	eb 67                	jmp    1677 <strerror@plt+0x487> <0 jump inc count
    1610:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1613:	48 98                	cdqe
    1615:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    161a:	83 f0 30             	xor    eax,0x30
    161d:	89 c2                	mov    edx,eax
    161f:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1622:	48 98                	cdqe
    1624:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1628:	eb 4d                	jmp    1677 <strerror@plt+0x487>
    162a:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    162d:	48 98                	cdqe
    162f:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1634:	83 f0 57             	xor    eax,0x57
    1637:	89 c2                	mov    edx,eax
    1639:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    163c:	48 98                	cdqe
    163e:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1642:	eb 33                	jmp    1677 <strerror@plt+0x487>
    1644:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1647:	48 98                	cdqe
    1649:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    164e:	83 f0 11             	xor    eax,0x11
    1651:	89 c2                	mov    edx,eax
    1653:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1656:	48 98                	cdqe
    1658:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    165c:	eb 19                	jmp    1677 <strerror@plt+0x487>
    165e:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1661:	48 98                	cdqe
    1663:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1668:	83 f0 47             	xor    eax,0x47
    166b:	89 c2                	mov    edx,eax
    166d:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
    1670:	48 98                	cdqe
    1672:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1676:	90                   	nop
    1677:	83 45 b8 01          	add    DWORD PTR [rbp-0x48],0x1 inc count
    167b:	83 7d b8 24          	cmp    DWORD PTR [rbp-0x48],0x24 loop cond: count 36?
    167f:	0f 8e 5e ff ff ff    	jle    15e3 <strerror@plt+0x3f3> <= jump loop start
reverse_mangler:
    1685:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [rbp-0x44],0x0 alloc count
    168c:	eb 42                	jmp    16d0 <strerror@plt+0x4e0> jump loop cond
    168e:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count
    1691:	48 98                	cdqe
    1693:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    1698:	88 45 ac             	mov    BYTE PTR [rbp-0x54],al tmp save inbuf byte pos count
    169b:	b8 24 00 00 00       	mov    eax,0x24 36
    16a0:	2b 45 bc             	sub    eax,DWORD PTR [rbp-0x44] 36-count
    16a3:	48 98                	cdqe
    16a5:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos 36-count
    16aa:	88 45 ad             	mov    BYTE PTR [rbp-0x53],al tmp save inbuf byte pos 36-count
    16ad:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44] count
    16b0:	48 98                	cdqe
    16b2:	0f b6 55 ad          	movzx  edx,BYTE PTR [rbp-0x53] inbuf byte pos 36-count
    16b6:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf byte pos count
    16ba:	b8 24 00 00 00       	mov    eax,0x24 36
    16bf:	2b 45 bc             	sub    eax,DWORD PTR [rbp-0x44] 36-count
    16c2:	48 98                	cdqe
    16c4:	0f b6 55 ac          	movzx  edx,BYTE PTR [rbp-0x54] inbuf byte pos count
    16c8:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl to inbuf pos 36-count
    16cc:	83 45 bc 01          	add    DWORD PTR [rbp-0x44],0x1 inc count
    16d0:	83 7d bc 11          	cmp    DWORD PTR [rbp-0x44],0x11 loop cond: count 17?
    16d4:	7e b8                	jle    168e <strerror@plt+0x49e> <= jump loop start
reverse_mangler:
    16d6:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [rbp-0x40],0x0
    16dd:	eb 42                	jmp    1721 <strerror@plt+0x531>
    16df:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    16e2:	48 98                	cdqe
    16e4:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    16e9:	88 45 aa             	mov    BYTE PTR [rbp-0x56],al
    16ec:	b8 24 00 00 00       	mov    eax,0x24
    16f1:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40]
    16f4:	48 98                	cdqe
    16f6:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    16fb:	88 45 ab             	mov    BYTE PTR [rbp-0x55],al
    16fe:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    1701:	48 98                	cdqe
    1703:	0f b6 55 ab          	movzx  edx,BYTE PTR [rbp-0x55]
    1707:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    170b:	b8 24 00 00 00       	mov    eax,0x24
    1710:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40]
    1713:	48 98                	cdqe
    1715:	0f b6 55 aa          	movzx  edx,BYTE PTR [rbp-0x56]
    1719:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    171d:	83 45 c0 01          	add    DWORD PTR [rbp-0x40],0x1
    1721:	83 7d c0 11          	cmp    DWORD PTR [rbp-0x40],0x11
    1725:	7e b8                	jle    16df <strerror@plt+0x4ef>
xor_0x18_mangler:
    1727:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0 alloc count
    172e:	eb 1d                	jmp    174d <strerror@plt+0x55d> jump loop cond
    1730:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c] loop start: count
    1733:	48 98                	cdqe
    1735:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30] inbuf byte pos count
    173a:	83 f0 18             	xor    eax,0x18 
    173d:	89 c2                	mov    edx,eax
    173f:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1742:	48 98                	cdqe
    1744:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1748:	90                   	nop
    1749:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1
    174d:	83 7d c4 24          	cmp    DWORD PTR [rbp-0x3c],0x24 loop cond: count 36?
    1751:	7e dd                	jle    1730 <strerror@plt+0x540> <= jump loop start
pos_based_xor_mangler:
    1753:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [rbp-0x38],0x0 alloc count
    175a:	e9 f5 00 00 00       	jmp    1854 <strerror@plt+0x664> jump loop cond
    175f:	8b 4d c8             	mov    ecx,DWORD PTR [rbp-0x38] loop start: count
    1762:	48 63 c1             	movsxd rax,ecx
    1765:	48 69 c0 ab aa aa 2a 	imul   rax,rax,0x2aaaaaab
    176c:	48 c1 e8 20          	shr    rax,0x20 rounded div 6 result no remainder
    1770:	48 89 c2             	mov    rdx,rax div 6 result
    1773:	89 c8                	mov    eax,ecx count
    1775:	c1 f8 1f             	sar    eax,0x1f isolate sign bit => zero, count never negative
    1778:	29 c2                	sub    edx,eax unchanged
    177a:	89 d0                	mov    eax,edx div 6 result
    177c:	01 c0                	add    eax,eax 2 * div6res
    177e:	01 d0                	add    eax,edx 3 * div6res
    1780:	01 c0                	add    eax,eax 6 * div6res
    1782:	29 c1                	sub    ecx,eax => calc remainder div 6
    1784:	89 ca                	mov    edx,ecx remainder
    1786:	83 fa 05             	cmp    edx,0x5 remainder 5?
    1789:	0f 87 c1 00 00 00    	ja     1850 <strerror@plt+0x660> > jump inc count
    178f:	89 d0                	mov    eax,edx remainder
    1791:	48 8d 14 85 00 00 00 	lea    rdx,[rax*4+0x0] which xor case offset
    1798:	00 
    1799:	48 8d 05 a4 0b 00 00 	lea    rax,[rip+0xba4] case base addr
    17a0:	8b 04 02             	mov    eax,DWORD PTR [rdx+rax*1] get rel jump offset for case as stored at base addr + offset
    17a3:	48 98                	cdqe
    17a5:	48 8d 15 98 0b 00 00 	lea    rdx,[rip+0xb98] case base addr
    17ac:	48 01 d0             	add    rax,rdx calc final case addr to jump to
    17af:	3e ff e0             	notrack jmp rax
    17b2:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 0: xor 0x52
    17b5:	48 98                	cdqe
    17b7:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    17bc:	83 f0 52             	xor    eax,0x52
    17bf:	89 c2                	mov    edx,eax
    17c1:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    17c4:	48 98                	cdqe
    17c6:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    17ca:	e9 81 00 00 00       	jmp    1850 <strerror@plt+0x660>
    17cf:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 1: xor 0x70
    17d2:	48 98                	cdqe
    17d4:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    17d9:	83 f0 70             	xor    eax,0x70
    17dc:	89 c2                	mov    edx,eax
    17de:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    17e1:	48 98                	cdqe
    17e3:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    17e7:	eb 67                	jmp    1850 <strerror@plt+0x660>
    17e9:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 2: xor 0xb6
    17ec:	48 98                	cdqe
    17ee:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    17f3:	83 f0 b6             	xor    eax,0xffffffb6
    17f6:	89 c2                	mov    edx,eax
    17f8:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    17fb:	48 98                	cdqe
    17fd:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1801:	eb 4d                	jmp    1850 <strerror@plt+0x660>
    1803:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 3: xor 0x4a
    1806:	48 98                	cdqe
    1808:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    180d:	83 f0 4a             	xor    eax,0x4a
    1810:	89 c2                	mov    edx,eax
    1812:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    1815:	48 98                	cdqe
    1817:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    181b:	eb 33                	jmp    1850 <strerror@plt+0x660>
    181d:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 4: xor 0xa4
    1820:	48 98                	cdqe
    1822:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1827:	83 f0 a4             	xor    eax,0xffffffa4
    182a:	89 c2                	mov    edx,eax
    182c:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    182f:	48 98                	cdqe
    1831:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1835:	eb 19                	jmp    1850 <strerror@plt+0x660>
    1837:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38] remainder 5: xor 0x0f
    183a:	48 98                	cdqe
    183c:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1841:	83 f0 0f             	xor    eax,0xf
    1844:	89 c2                	mov    edx,eax
    1846:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    1849:	48 98                	cdqe
    184b:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    184f:	90                   	nop
    1850:	83 45 c8 01          	add    DWORD PTR [rbp-0x38],0x1 inc count
    1854:	83 7d c8 24          	cmp    DWORD PTR [rbp-0x38],0x24 loop cond: count 36?
    1858:	0f 8e 01 ff ff ff    	jle    175f <strerror@plt+0x56f> <= jump loop start
reverse_mangler:
    185e:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
    1865:	eb 42                	jmp    18a9 <strerror@plt+0x6b9>
    1867:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    186a:	48 98                	cdqe
    186c:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1871:	88 45 a8             	mov    BYTE PTR [rbp-0x58],al
    1874:	b8 24 00 00 00       	mov    eax,0x24
    1879:	2b 45 cc             	sub    eax,DWORD PTR [rbp-0x34]
    187c:	48 98                	cdqe
    187e:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    1883:	88 45 a9             	mov    BYTE PTR [rbp-0x57],al
    1886:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    1889:	48 98                	cdqe
    188b:	0f b6 55 a9          	movzx  edx,BYTE PTR [rbp-0x57]
    188f:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    1893:	b8 24 00 00 00       	mov    eax,0x24
    1898:	2b 45 cc             	sub    eax,DWORD PTR [rbp-0x34]
    189b:	48 98                	cdqe
    189d:	0f b6 55 a8          	movzx  edx,BYTE PTR [rbp-0x58]
    18a1:	88 54 05 d0          	mov    BYTE PTR [rbp+rax*1-0x30],dl
    18a5:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
    18a9:	83 7d cc 11          	cmp    DWORD PTR [rbp-0x34],0x11
check:
    18ad:	7e b8                	jle    1867 <strerror@plt+0x677>
    18af:	48 8d 3d 52 0a 00 00 	lea    rdi,[rip+0xa52]        # 2308 <strerror@plt+0x1118>
    18b6:	e8 85 f8 ff ff       	call   1140 <puts@plt>
    18bb:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    18bf:	ba 25 00 00 00       	mov    edx,0x25
    18c4:	48 8d 35 55 27 00 00 	lea    rsi,[rip+0x2755]        # 4020 <strerror@plt+0x2e30>
    18cb:	48 89 c7             	mov    rdi,rax
    18ce:	e8 dd f8 ff ff       	call   11b0 <memcmp@plt>
    18d3:	85 c0                	test   eax,eax
    18d5:	75 14                	jne    18eb <strerror@plt+0x6fb>
    18d7:	b8 00 00 00 00       	mov    eax,0x0
    18dc:	e8 08 fa ff ff       	call   12e9 <strerror@plt+0xf9>
    18e1:	bf 00 00 00 00       	mov    edi,0x0
    18e6:	e8 f5 f8 ff ff       	call   11e0 <exit@plt>
    18eb:	48 8d 3d 3a 0a 00 00 	lea    rdi,[rip+0xa3a]        # 232c <strerror@plt+0x113c>
    18f2:	e8 49 f8 ff ff       	call   1140 <puts@plt>
    18f7:	bf 01 00 00 00       	mov    edi,0x1
    18fc:	e8 df f8 ff ff       	call   11e0 <exit@plt>
