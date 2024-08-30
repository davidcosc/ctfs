Disassembly of section .text:

0000000000001180 <.text>:

pre_exit:
    1269:	f3 0f 1e fa          	endbr64
    126d:	55                   	push   rbp
    126e:	48 89 e5             	mov    rbp,rsp
    1271:	48 83 ec 10          	sub    rsp,0x10
    1275:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1279:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi str addr unknown register
    127d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1281:	be 01 00 00 00       	mov    esi,0x1 exit code
    1286:	48 89 c7             	mov    rdi,rax vm buf addr
    1289:	e8 99 00 00 00       	call   1327 <sleep@plt+0x1b7> exit
    128e:	90                   	nop
    128f:	c9                   	leave
    1290:	c3                   	ret

exit:
    1327:	f3 0f 1e fa          	endbr64
    132b:	55                   	push   rbp
    132c:	48 89 e5             	mov    rbp,rsp
    132f:	48 83 ec 10          	sub    rsp,0x10
    1333:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1337:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi exit code
    133a:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc] exit code
    133d:	89 c7                	mov    edi,eax exit code
    133f:	e8 1c fe ff ff       	call   1160 <exit@plt>

read_register:
    1363:	f3 0f 1e fa          	endbr64
    1367:	55                   	push   rbp
    1368:	48 89 e5             	mov    rbp,rsp
    136b:	48 83 ec 10          	sub    rsp,0x10
    136f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1373:	89 f0                	mov    eax,esi register num
    1375:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al register num
    1378:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 register num 0x20?
    137c:	75 10                	jne    138e <sleep@plt+0x21e> no jump next register check
    137e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1382:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100] value at register a addr
    1389:	e9 85 00 00 00       	jmp    1413 <sleep@plt+0x2a3>
    138e:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
    1392:	75 0d                	jne    13a1 <sleep@plt+0x231>
    1394:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1398:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101] value at register b addr
    139f:	eb 72                	jmp    1413 <sleep@plt+0x2a3>
    13a1:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8
    13a5:	75 0d                	jne    13b4 <sleep@plt+0x244>
    13a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13ab:	0f b6 80 02 01 00 00 	movzx  eax,BYTE PTR [rax+0x102] value at register c addr
    13b2:	eb 5f                	jmp    1413 <sleep@plt+0x2a3>
    13b4:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4
    13b8:	75 0d                	jne    13c7 <sleep@plt+0x257>
    13ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13be:	0f b6 80 03 01 00 00 	movzx  eax,BYTE PTR [rax+0x103] value at register d addr
    13c5:	eb 4c                	jmp    1413 <sleep@plt+0x2a3>
    13c7:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
    13cb:	75 0d                	jne    13da <sleep@plt+0x26a>
    13cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13d1:	0f b6 80 04 01 00 00 	movzx  eax,BYTE PTR [rax+0x104] value at register e addr
    13d8:	eb 39                	jmp    1413 <sleep@plt+0x2a3>
    13da:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40
    13de:	75 0d                	jne    13ed <sleep@plt+0x27d>
    13e0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13e4:	0f b6 80 05 01 00 00 	movzx  eax,BYTE PTR [rax+0x105] value at register f addr
    13eb:	eb 26                	jmp    1413 <sleep@plt+0x2a3>
    13ed:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
    13f1:	75 0d                	jne    1400 <sleep@plt+0x290>
    13f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13f7:	0f b6 80 06 01 00 00 	movzx  eax,BYTE PTR [rax+0x106] value at register g addr
    13fe:	eb 13                	jmp    1413 <sleep@plt+0x2a3>
    1400:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1404:	48 8d 35 fd 0b 00 00 	lea    rsi,[rip+0xbfd] str addr unknown register
    140b:	48 89 c7             	mov    rdi,rax vm buf addr
    140e:	e8 56 fe ff ff       	call   1269 <sleep@plt+0xf9> pre_exit
    1413:	c9                   	leave
    1414:	c3                   	ret

write_register:
    1415:	f3 0f 1e fa          	endbr64
    1419:	55                   	push   rbp
    141a:	48 89 e5             	mov    rbp,rsp
    141d:	48 83 ec 10          	sub    rsp,0x10
    1421:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1425:	89 f1                	mov    ecx,esi register num
    1427:	89 d0                	mov    eax,edx register value
    1429:	89 ca                	mov    edx,ecx register num
    142b:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register num
    142e:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al register value
    1431:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 register num 0x20?
    1435:	75 13                	jne    144a <sleep@plt+0x2da> no jump next register check
    1437:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    143b:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] register value
    143f:	88 90 00 01 00 00    	mov    BYTE PTR [rax+0x100],dl to register a addr
    1445:	e9 9a 00 00 00       	jmp    14e4 <sleep@plt+0x374>
    144a:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
    144e:	75 13                	jne    1463 <sleep@plt+0x2f3>
    1450:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1454:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    1458:	88 90 01 01 00 00    	mov    BYTE PTR [rax+0x101],dl to register b addr
    145e:	e9 81 00 00 00       	jmp    14e4 <sleep@plt+0x374>
    1463:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8
    1467:	75 10                	jne    1479 <sleep@plt+0x309>
    1469:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    146d:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    1471:	88 90 02 01 00 00    	mov    BYTE PTR [rax+0x102],dl to register c addr
    1477:	eb 6b                	jmp    14e4 <sleep@plt+0x374>
    1479:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4
    147d:	75 10                	jne    148f <sleep@plt+0x31f>
    147f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1483:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    1487:	88 90 03 01 00 00    	mov    BYTE PTR [rax+0x103],dl to register d addr
    148d:	eb 55                	jmp    14e4 <sleep@plt+0x374>
    148f:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
    1493:	75 10                	jne    14a5 <sleep@plt+0x335>
    1495:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1499:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    149d:	88 90 04 01 00 00    	mov    BYTE PTR [rax+0x104],dl to register e addr
    14a3:	eb 3f                	jmp    14e4 <sleep@plt+0x374>
    14a5:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40
    14a9:	75 10                	jne    14bb <sleep@plt+0x34b>
    14ab:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14af:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    14b3:	88 90 05 01 00 00    	mov    BYTE PTR [rax+0x105],dl to register f addr
    14b9:	eb 29                	jmp    14e4 <sleep@plt+0x374>
    14bb:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
    14bf:	75 10                	jne    14d1 <sleep@plt+0x361>
    14c1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14c5:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]
    14c9:	88 90 06 01 00 00    	mov    BYTE PTR [rax+0x106],dl to register g addr
    14cf:	eb 13                	jmp    14e4 <sleep@plt+0x374>
    14d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14d5:	48 8d 35 2c 0b 00 00 	lea    rsi,[rip+0xb2c] str addr unknown register
    14dc:	48 89 c7             	mov    rdi,rax
    14df:	e8 85 fd ff ff       	call   1269 <sleep@plt+0xf9> pre_exit
    14e4:	c9                   	leave
    14e5:	c3                   	ret

write_memory:
    1507:	f3 0f 1e fa          	endbr64
    150b:	55                   	push   rbp
    150c:	48 89 e5             	mov    rbp,rsp
    150f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1513:	89 f1                	mov    ecx,esi register value 1
    1515:	89 d0                	mov    eax,edx register value 2
    1517:	89 ca                	mov    edx,ecx register value 1
    1519:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register value 1
    151c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al register value 2
    151f:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] register value 1
    1523:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm buf addr
    1527:	48 98                	cdqe
    1529:	0f b6 4d f0          	movzx  ecx,BYTE PTR [rbp-0x10] register value 2
    152d:	88 0c 02             	mov    BYTE PTR [rdx+rax*1],cl to vm buf addr+registerv value 1
    1530:	90                   	nop
    1531:	5d                   	pop    rbp
    1532:	c3                   	ret

interpret_imm:
    1533:	f3 0f 1e fa          	endbr64
    1537:	55                   	push   rbp
    1538:	48 89 e5             	mov    rbp,rsp
    153b:	48 83 ec 10          	sub    rsp,0x10
    153f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1543:	89 f1                	mov    ecx,esi register num
    1545:	89 d0                	mov    eax,edx register value
    1547:	89 ca                	mov    edx,ecx register num
    1549:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register num
    154c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al register value
    154f:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] register value
    1553:	0f b6 4d f4          	movzx  ecx,BYTE PTR [rbp-0xc] register num
    1557:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    155b:	89 ce                	mov    esi,ecx register num
    155d:	48 89 c7             	mov    rdi,rax vm buf addr
    1560:	e8 b0 fe ff ff       	call   1415 <sleep@plt+0x2a5> write register
    1565:	90                   	nop
    1566:	c9                   	leave
    1567:	c3                   	ret

interpret_add:
    1568:	f3 0f 1e fa          	endbr64
    156c:	55                   	push   rbp
    156d:	48 89 e5             	mov    rbp,rsp
    1570:	53                   	push   rbx
    1571:	48 83 ec 18          	sub    rsp,0x18
    1575:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    1579:	89 f1                	mov    ecx,esi register num 1
    157b:	89 d0                	mov    eax,edx register num 2
    157d:	89 ca                	mov    edx,ecx register num 1
    157f:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl register num 1
    1582:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al register num 2
    1585:	0f b6 55 e4          	movzx  edx,BYTE PTR [rbp-0x1c] register num 1
    1589:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buff addr
    158d:	89 d6                	mov    esi,edx register num 1
    158f:	48 89 c7             	mov    rdi,rax code buff addr
    1592:	e8 cc fd ff ff       	call   1363 <sleep@plt+0x1f3> read register
    1597:	89 c3                	mov    ebx,eax register value 1
    1599:	0f b6 55 e0          	movzx  edx,BYTE PTR [rbp-0x20] register num 2
    159d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buff addr
    15a1:	89 d6                	mov    esi,edx register num 2
    15a3:	48 89 c7             	mov    rdi,rax vm buf addr
    15a6:	e8 b8 fd ff ff       	call   1363 <sleep@plt+0x1f3> read register
    15ab:	01 d8                	add    eax,ebx register value 2+1
    15ad:	0f b6 d0             	movzx  edx,al register value 2+1
    15b0:	0f b6 4d e4          	movzx  ecx,BYTE PTR [rbp-0x1c] register num 1
    15b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    15b8:	89 ce                	mov    esi,ecx register num 1
    15ba:	48 89 c7             	mov    rdi,rax vm buf addr
    15bd:	e8 53 fe ff ff       	call   1415 <sleep@plt+0x2a5> write register
    15c2:	90                   	nop
    15c3:	48 83 c4 18          	add    rsp,0x18
    15c7:	5b                   	pop    rbx
    15c8:	5d                   	pop    rbp
    15c9:	c3                   	ret

interpret_stmt:
    1687:	f3 0f 1e fa          	endbr64
    168b:	55                   	push   rbp
    168c:	48 89 e5             	mov    rbp,rsp
    168f:	53                   	push   rbx
    1690:	48 83 ec 18          	sub    rsp,0x18
    1694:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    1698:	89 f1                	mov    ecx,esi register num 1
    169a:	89 d0                	mov    eax,edx register num 2
    169c:	89 ca                	mov    edx,ecx register num 1
    169e:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl register num 1
    16a1:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al register num 2
    16a4:	0f b6 55 e0          	movzx  edx,BYTE PTR [rbp-0x20] register num 2
    16a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16ac:	89 d6                	mov    esi,edx register num 2
    16ae:	48 89 c7             	mov    rdi,rax vm buf addr
    16b1:	e8 ad fc ff ff       	call   1363 <sleep@plt+0x1f3> read register
    16b6:	0f b6 d8             	movzx  ebx,al register value 2
    16b9:	0f b6 55 e4          	movzx  edx,BYTE PTR [rbp-0x1c] register num 1
    16bd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16c1:	89 d6                	mov    esi,edx register num 1
    16c3:	48 89 c7             	mov    rdi,rax vm buf addr
    16c6:	e8 98 fc ff ff       	call   1363 <sleep@plt+0x1f3> read register
    16cb:	0f b6 c8             	movzx  ecx,al register value 1
    16ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16d2:	89 da                	mov    edx,ebx register value 2
    16d4:	89 ce                	mov    esi,ecx register value 1
    16d6:	48 89 c7             	mov    rdi,rax vm buf addr
    16d9:	e8 29 fe ff ff       	call   1507 <sleep@plt+0x397> write memory
    16de:	90                   	nop
    16df:	48 83 c4 18          	add    rsp,0x18
    16e3:	5b                   	pop    rbx
    16e4:	5d                   	pop    rbp
    16e5:	c3                   	ret

execute_program:
    1a97:	f3 0f 1e fa          	endbr64
    1a9b:	55                   	push   rbp
    1a9c:	48 89 e5             	mov    rbp,rsp
    1a9f:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
    1aa6:	48 89 bd 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdi vm buf addr
    1aad:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    1ab4:	00 00 
    1ab6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1aba:	31 c0                	xor    eax,eax
    1abc:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr
    1ac3:	48 83 c0 33          	add    rax,0x33 vm buf addr+0x33
    1ac7:	ba 06 00 00 00       	mov    edx,0x6 num bytes read
    1acc:	48 89 c6             	mov    rsi,rax vm buf addr+0x33
    1acf:	bf 00 00 00 00       	mov    edi,0x0 stdin fd
    1ad4:	e8 47 f6 ff ff       	call   1120 <read@plt> read 6 bytes from stdin to vm buf addr+0x33
    1ad9:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr
    1ae0:	ba 53 00 00 00       	mov    edx,0x53 imm value
    1ae5:	be 02 00 00 00       	mov    esi,0x2 register num
    1aea:	48 89 c7             	mov    rdi,rax vm buf addr
    1aed:	e8 41 fa ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm b = 0x53
    1af2:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1af9:	ba 01 00 00 00       	mov    edx,0x1
    1afe:	be 08 00 00 00       	mov    esi,0x8
    1b03:	48 89 c7             	mov    rdi,rax
    1b06:	e8 28 fa ff ff       	call   1533 <sleep@plt+0x3c3> c = 0x1
    1b0b:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1b12:	ba 08 00 00 00       	mov    edx,0x8
    1b17:	be 20 00 00 00       	mov    esi,0x20
    1b1c:	48 89 c7             	mov    rdi,rax
    1b1f:	e8 0f fa ff ff       	call   1533 <sleep@plt+0x3c3> a = 0x8
    1b24:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr
    1b2b:	ba 20 00 00 00       	mov    edx,0x20 register a num
    1b30:	be 02 00 00 00       	mov    esi,0x2 register b num
    1b35:	48 89 c7             	mov    rdi,rax vm buf addr
    1b38:	e8 4a fb ff ff       	call   1687 <sleep@plt+0x517> interpret stmt vm buf addr+b = a => 0x8
    1b3d:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1b44:	ba 08 00 00 00       	mov    edx,0x8 register c num
    1b49:	be 02 00 00 00       	mov    esi,0x2 register b num
    1b4e:	48 89 c7             	mov    rdi,rax vm buf addr
    1b51:	e8 12 fa ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c
    1b56:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1b5d:	ba f1 00 00 00       	mov    edx,0xf1
    1b62:	be 20 00 00 00       	mov    esi,0x20
    1b67:	48 89 c7             	mov    rdi,rax
    1b6a:	e8 c4 f9 ff ff       	call   1533 <sleep@plt+0x3c3> a = 0xf1
    1b6f:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1b76:	ba 20 00 00 00       	mov    edx,0x20
    1b7b:	be 02 00 00 00       	mov    esi,0x2
    1b80:	48 89 c7             	mov    rdi,rax
    1b83:	e8 ff fa ff ff       	call   1687 <sleep@plt+0x517> vm buf addr+b = a => 0xf1
    1b88:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1b8f:	ba 08 00 00 00       	mov    edx,0x8
    1b94:	be 02 00 00 00       	mov    esi,0x2
    1b99:	48 89 c7             	mov    rdi,rax
    1b9c:	e8 c7 f9 ff ff       	call   1568 <sleep@plt+0x3f8> b = b+c
    1ba1:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1ba8:	ba 63 00 00 00       	mov    edx,0x63
    1bad:	be 20 00 00 00       	mov    esi,0x20
    1bb2:	48 89 c7             	mov    rdi,rax
    1bb5:	e8 79 f9 ff ff       	call   1533 <sleep@plt+0x3c3> a = 0x63
    1bba:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1bc1:	ba 20 00 00 00       	mov    edx,0x20
    1bc6:	be 02 00 00 00       	mov    esi,0x2
    1bcb:	48 89 c7             	mov    rdi,rax
    1bce:	e8 b4 fa ff ff       	call   1687 <sleep@plt+0x517>
    1bd3:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr+b = a => 0x63
    1bda:	ba 08 00 00 00       	mov    edx,0x8
    1bdf:	be 02 00 00 00       	mov    esi,0x2
    1be4:	48 89 c7             	mov    rdi,rax
    1be7:	e8 7c f9 ff ff       	call   1568 <sleep@plt+0x3f8> b = b+c
    1bec:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1bf3:	ba f6 00 00 00       	mov    edx,0xf6
    1bf8:	be 20 00 00 00       	mov    esi,0x20
    1bfd:	48 89 c7             	mov    rdi,rax
    1c00:	e8 2e f9 ff ff       	call   1533 <sleep@plt+0x3c3> a = 0xf6
    1c05:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c0c:	ba 20 00 00 00       	mov    edx,0x20
    1c11:	be 02 00 00 00       	mov    esi,0x2
    1c16:	48 89 c7             	mov    rdi,rax
    1c19:	e8 69 fa ff ff       	call   1687 <sleep@plt+0x517> vm buf addr+b = a => 0xf6
    1c1e:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c25:	ba 08 00 00 00       	mov    edx,0x8
    1c2a:	be 02 00 00 00       	mov    esi,0x2
    1c2f:	48 89 c7             	mov    rdi,rax
    1c32:	e8 31 f9 ff ff       	call   1568 <sleep@plt+0x3f8> b = b+c
    1c37:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c3e:	ba cd 00 00 00       	mov    edx,0xcd
    1c43:	be 20 00 00 00       	mov    esi,0x20
    1c48:	48 89 c7             	mov    rdi,rax
    1c4b:	e8 e3 f8 ff ff       	call   1533 <sleep@plt+0x3c3> a = 0xcd
    1c50:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c57:	ba 20 00 00 00       	mov    edx,0x20
    1c5c:	be 02 00 00 00       	mov    esi,0x2
    1c61:	48 89 c7             	mov    rdi,rax
    1c64:	e8 1e fa ff ff       	call   1687 <sleep@plt+0x517> vm buf addr+b = a => 0xcd
    1c69:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c70:	ba 08 00 00 00       	mov    edx,0x8
    1c75:	be 02 00 00 00       	mov    esi,0x2
    1c7a:	48 89 c7             	mov    rdi,rax
    1c7d:	e8 e6 f8 ff ff       	call   1568 <sleep@plt+0x3f8> b = b+c
    1c82:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1c89:	ba 66 00 00 00       	mov    edx,0x66
    1c8e:	be 20 00 00 00       	mov    esi,0x20
    1c93:	48 89 c7             	mov    rdi,rax
    1c96:	e8 98 f8 ff ff       	call   1533 <sleep@plt+0x3c3> a = 0x66
    1c9b:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1ca2:	ba 20 00 00 00       	mov    edx,0x20
    1ca7:	be 02 00 00 00       	mov    esi,0x2
    1cac:	48 89 c7             	mov    rdi,rax
    1caf:	e8 d3 f9 ff ff       	call   1687 <sleep@plt+0x517> vm buf addr+b = a => 0x66
    1cb4:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    1cbb:	ba 08 00 00 00       	mov    edx,0x8
    1cc0:	be 02 00 00 00       	mov    esi,0x2
    1cc5:	48 89 c7             	mov    rdi,rax
    1cc8:	e8 9b f8 ff ff       	call   1568 <sleep@plt+0x3f8> b = b+c
    1ccd:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr
    1cd4:	48 8d 48 33          	lea    rcx,[rax+0x33] expected result addr
    1cd8:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] vm buf addr
    1cdf:	48 83 c0 53          	add    rax,0x53 stmts result addr
    1ce3:	ba 06 00 00 00       	mov    edx,0x6 num bytes cmp
    1ce8:	48 89 ce             	mov    rsi,rcx expected result addr
    1ceb:	48 89 c7             	mov    rdi,rax stmts result addr
    1cee:	e8 3d f4 ff ff       	call   1130 <memcmp@plt>
    1cf3:	85 c0                	test   eax,eax
    1cf5:	0f 94 c0             	sete   al
    1cf8:	0f b6 c0             	movzx  eax,al
    1cfb:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax
    1d01:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0
    1d08:	74 58                	je     1d62 <sleep@plt+0xbf2>
    1d0a:	48 8d 3d 08 03 00 00 	lea    rdi,[rip+0x308]        # 2019 <sleep@plt+0xea9>
    1d11:	b8 00 00 00 00       	mov    eax,0x0
    1d16:	e8 f5 f3 ff ff       	call   1110 <printf@plt>
    1d1b:	be 00 00 00 00       	mov    esi,0x0
    1d20:	48 8d 3d 07 03 00 00 	lea    rdi,[rip+0x307]        # 202e <sleep@plt+0xebe>
    1d27:	b8 00 00 00 00       	mov    eax,0x0
    1d2c:	e8 1f f4 ff ff       	call   1150 <open@plt>
    1d31:	89 c1                	mov    ecx,eax
    1d33:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    1d3a:	ba 64 00 00 00       	mov    edx,0x64
    1d3f:	48 89 c6             	mov    rsi,rax
    1d42:	89 cf                	mov    edi,ecx
    1d44:	e8 d7 f3 ff ff       	call   1120 <read@plt>
    1d49:	48 89 c2             	mov    rdx,rax
    1d4c:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    1d53:	48 89 c6             	mov    rsi,rax
    1d56:	bf 01 00 00 00       	mov    edi,0x1
    1d5b:	e8 90 f3 ff ff       	call   10f0 <write@plt>
    1d60:	eb 11                	jmp    1d73 <sleep@plt+0xc03>
    1d62:	48 8d 3d cb 02 00 00 	lea    rdi,[rip+0x2cb]        # 2034 <sleep@plt+0xec4>
    1d69:	b8 00 00 00 00       	mov    eax,0x0
    1d6e:	e8 9d f3 ff ff       	call   1110 <printf@plt>
    1d73:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0
    1d7a:	0f 94 c0             	sete   al
    1d7d:	0f b6 c0             	movzx  eax,al
    1d80:	89 c7                	mov    edi,eax
    1d82:	e8 d9 f3 ff ff       	call   1160 <exit@plt>

main:
    1d87:	f3 0f 1e fa          	endbr64
    1d8b:	55                   	push   rbp
    1d8c:	48 89 e5             	mov    rbp,rsp
    1d8f:	48 81 ec 20 01 00 00 	sub    rsp,0x120 alloc local vars
    1d96:	89 bd ec fe ff ff    	mov    DWORD PTR [rbp-0x114],edi argc
    1d9c:	48 89 b5 e0 fe ff ff 	mov    QWORD PTR [rbp-0x120],rsi argv ptr
    1da3:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
    1daa:	00 00 
    1dac:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax to stack
    1db0:	31 c0                	xor    eax,eax
    1db2:	48 8b 85 e0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x120] argv ptr
    1db9:	48 8b 00             	mov    rax,QWORD PTR [rax] dereference argv ptr
    1dbc:	48 89 c6             	mov    rsi,rax argv addr
    1dbf:	48 8d 3d 79 02 00 00 	lea    rdi,[rip+0x279] format str addr
    1dc6:	b8 00 00 00 00       	mov    eax,0x0 num vec reg req
    1dcb:	e8 40 f3 ff ff       	call   1110 <printf@plt> print format, argv
    1dd0:	48 8d 3d 81 02 00 00 	lea    rdi,[rip+0x281]        # 2058 <sleep@plt+0xee8>
    1dd7:	e8 04 f3 ff ff       	call   10e0 <puts@plt>
    1ddc:	48 8d 3d c5 02 00 00 	lea    rdi,[rip+0x2c5]        # 20a8 <sleep@plt+0xf38>
    1de3:	e8 f8 f2 ff ff       	call   10e0 <puts@plt>
    1de8:	48 8d 3d 01 03 00 00 	lea    rdi,[rip+0x301]        # 20f0 <sleep@plt+0xf80>
    1def:	e8 ec f2 ff ff       	call   10e0 <puts@plt>
    1df4:	48 8d 3d 45 03 00 00 	lea    rdi,[rip+0x345]        # 2140 <sleep@plt+0xfd0>
    1dfb:	e8 e0 f2 ff ff       	call   10e0 <puts@plt>
    1e00:	48 8d 3d 89 03 00 00 	lea    rdi,[rip+0x389]        # 2190 <sleep@plt+0x1020>
    1e07:	e8 d4 f2 ff ff       	call   10e0 <puts@plt>
    1e0c:	48 8d 3d ba 03 00 00 	lea    rdi,[rip+0x3ba]        # 21cd <sleep@plt+0x105d>
    1e13:	e8 c8 f2 ff ff       	call   10e0 <puts@plt>
    1e18:	48 8d 3d b9 03 00 00 	lea    rdi,[rip+0x3b9]        # 21d8 <sleep@plt+0x1068>
    1e1f:	e8 bc f2 ff ff       	call   10e0 <puts@plt>
    1e24:	48 8d 3d fd 03 00 00 	lea    rdi,[rip+0x3fd]        # 2228 <sleep@plt+0x10b8>
    1e2b:	e8 b0 f2 ff ff       	call   10e0 <puts@plt>
    1e30:	48 8d 3d 41 04 00 00 	lea    rdi,[rip+0x441]        # 2278 <sleep@plt+0x1108>
    1e37:	e8 a4 f2 ff ff       	call   10e0 <puts@plt>
    1e3c:	48 8b 05 cd 21 00 00 	mov    rax,QWORD PTR [rip+0x21cd] stdout file addr
    1e43:	b9 01 00 00 00       	mov    ecx,0x1 buf size
    1e48:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    1e4d:	be 00 00 00 00       	mov    esi,0x0 buf addr
    1e52:	48 89 c7             	mov    rdi,rax stdout file addr
    1e55:	e8 e6 f2 ff ff       	call   1140 <setvbuf@plt> set stdout to unbuffered
    1e5a:	48 8d 95 f0 fe ff ff 	lea    rdx,[rbp-0x110] vm buf addr
    1e61:	b8 00 00 00 00       	mov    eax,0x0 value
    1e66:	b9 20 00 00 00       	mov    ecx,0x20 num qwords to set
    1e6b:	48 89 d7             	mov    rdi,rdx vm buf addr
    1e6e:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax zero 256 bytes code buf
    1e71:	48 89 fa             	mov    rdx,rdi
    1e74:	89 02                	mov    DWORD PTR [rdx],eax zero 4 more bytes
    1e76:	48 83 c2 04          	add    rdx,0x4
    1e7a:	66 89 02             	mov    WORD PTR [rdx],ax zero 2 more bytes
    1e7d:	48 83 c2 02          	add    rdx,0x2
    1e81:	88 02                	mov    BYTE PTR [rdx],al zero 1 more byte
    1e83:	48 83 c2 01          	add    rdx,0x1
    1e87:	48 8d 85 f0 fe ff ff 	lea    rax,[rbp-0x110] code buf adrr
    1e8e:	48 89 c7             	mov    rdi,rax vm buf addr
    1e91:	e8 01 fc ff ff       	call   1a97 <sleep@plt+0x927> execute program
    1e96:	b8 00 00 00 00       	mov    eax,0x0
    1e9b:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] retrieve stack guard canary
    1e9f:	64 48 33 0c 25 28 00 	xor    rcx,QWORD PTR fs:0x28 compare with expected canary
    1ea6:	00 00 
    1ea8:	74 05                	je     1eaf <sleep@plt+0xd3f> equal jump end
    1eaa:	e8 51 f2 ff ff       	call   1100 <__stack_chk_fail@plt> unequal/compromised stack fail
    1eaf:	c9                   	leave
    1eb0:	c3                   	ret
