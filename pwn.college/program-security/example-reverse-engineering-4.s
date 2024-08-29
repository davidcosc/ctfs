crash:
    1269:	f3 0f 1e fa          	endbr64 indirect jumps allowed
    126d:	55                   	push   rbp save current stack frame
    126e:	48 89 e5             	mov    rbp,rsp new stack frame
    1271:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1275:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1279:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi unknown register str addr
    127d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1281:	be 01 00 00 00       	mov    esi,0x1 exit code
    1286:	48 89 c7             	mov    rdi,rax code buf addr
    1289:	e8 99 00 00 00       	call   1327 <sleep@plt+0x1b7> exit
    128e:	90                   	nop
    128f:	c9                   	leave
    1290:	c3                   	ret

open:
    1291:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1295:	55                   	push   rbp save current stack frame
    1296:	48 89 e5             	mov    rbp,rsp new stack frame
    1299:	48 83 ec 20          	sub    rsp,0x20 alloc local vars
    129d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    12a1:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi code buf addr+register a value
    12a5:	89 55 ec             	mov    DWORD PTR [rbp-0x14],edx register b value
    12a8:	89 4d e8             	mov    DWORD PTR [rbp-0x18],ecx register c value
    12ab:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14] register b value
    12ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10] code buf addr+register a value
    12b2:	89 d6                	mov    esi,edx register b value as flags
    12b4:	48 89 c7             	mov    rdi,rax code buf addr+register a value as file name addr
    12b7:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    12bc:	e8 8f fe ff ff       	call   1150 <open@plt>
    12c1:	c9                   	leave
    12c2:	c3                   	ret

read_input:
    12c3:	f3 0f 1e fa          	endbr64 allow indirect jumps
    12c7:	55                   	push   rbp save current stack frame
    12c8:	48 89 e5             	mov    rbp,rsp new stack frame
    12cb:	48 83 ec 20          	sub    rsp,0x20 alloc local vars
    12cf:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    12d3:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi register a value
    12d6:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx code buf addr+register b value
    12da:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx register c value
    12de:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20] register c value as num bytes read
    12e2:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18] code buf addr+register b value
    12e6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc] register a value
    12e9:	48 89 ce             	mov    rsi,rcx code buf addr+register b value as inbuf
    12ec:	89 c7                	mov    edi,eax register a value as fd
    12ee:	e8 2d fe ff ff       	call   1120 <read@plt>
    12f3:	c9                   	leave
    12f4:	c3                   	ret

exit:
    1327:	f3 0f 1e fa          	endbr64 indirect jumps allowed
    132b:	55                   	push   rbp save current stack frame
    132c:	48 89 e5             	mov    rbp,rsp new stack frame
    132f:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1333:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1337:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi exit code
    133a:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc] exit code
    133d:	89 c7                	mov    edi,eax exit code
    133f:	e8 1c fe ff ff       	call   1160 <exit@plt>

read_register:
    1363:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1367:	55                   	push   rbp save current stack frame
    1368:	48 89 e5             	mov    rbp,rsp new stack frame
    136b:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    136f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1373:	89 f0                	mov    eax,esi register num
    1375:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al register num
    1378:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 a: register num 0x8?
    137c:	75 10                	jne    138e <sleep@plt+0x21e> no jump b
    137e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1382:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100] register a value
    1389:	e9 85 00 00 00       	jmp    1413 <sleep@plt+0x2a3> jump end
    138e:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 b: register num 0x2?
    1392:	75 0d                	jne    13a1 <sleep@plt+0x231> no jump c
    1394:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1398:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101] register b value
    139f:	eb 72                	jmp    1413 <sleep@plt+0x2a3> jump end
    13a1:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 c: register num 0x4?
    13a5:	75 0d                	jne    13b4 <sleep@plt+0x244> no jump d
    13a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    13ab:	0f b6 80 02 01 00 00 	movzx  eax,BYTE PTR [rax+0x102] register c value
    13b2:	eb 5f                	jmp    1413 <sleep@plt+0x2a3> jump end
    13b4:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 d: register num 0x1?
    13b8:	75 0d                	jne    13c7 <sleep@plt+0x257> no jump e
    13ba:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    13be:	0f b6 80 03 01 00 00 	movzx  eax,BYTE PTR [rax+0x103] register d value
    13c5:	eb 4c                	jmp    1413 <sleep@plt+0x2a3> jump end
    13c7:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10 e: register num 0x10?
    13cb:	75 0d                	jne    13da <sleep@plt+0x26a> no jump f
    13cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    13d1:	0f b6 80 04 01 00 00 	movzx  eax,BYTE PTR [rax+0x104] register e value
    13d8:	eb 39                	jmp    1413 <sleep@plt+0x2a3> jump end
    13da:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 f: register num 0x40?
    13de:	75 0d                	jne    13ed <sleep@plt+0x27d> no jump g
    13e0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    13e4:	0f b6 80 05 01 00 00 	movzx  eax,BYTE PTR [rax+0x105] register f value
    13eb:	eb 26                	jmp    1413 <sleep@plt+0x2a3> jump end
    13ed:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 g: register num 0x20?
    13f1:	75 0d                	jne    1400 <sleep@plt+0x290> no jump unknown
    13f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    13f7:	0f b6 80 06 01 00 00 	movzx  eax,BYTE PTR [rax+0x106] register g value
    13fe:	eb 13                	jmp    1413 <sleep@plt+0x2a3> jump end
    1400:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1404:	48 8d 35 fd 1b 00 00 	lea    rsi,[rip+0x1bfd] unknown register str addr
    140b:	48 89 c7             	mov    rdi,rax code buf addr
    140e:	e8 56 fe ff ff       	call   1269 <sleep@plt+0xf9> crash
    1413:	c9                   	leave end:
    1414:	c3                   	ret

write_register:
    1415:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1419:	55                   	push   rbp save current stack frame
    141a:	48 89 e5             	mov    rbp,rsp new stack frame
    141d:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1421:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1425:	89 f1                	mov    ecx,esi register num
    1427:	89 d0                	mov    eax,edx value
    1429:	89 ca                	mov    edx,ecx register num
    142b:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register num
    142e:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al value
    1431:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 a: register num 0x8?
    1435:	75 13                	jne    144a <sleep@plt+0x2da> no jump b
    1437:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    143b:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    143f:	88 90 00 01 00 00    	mov    BYTE PTR [rax+0x100],dl to register a addr
    1445:	e9 9a 00 00 00       	jmp    14e4 <sleep@plt+0x374> jump end
    144a:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 b: register num 0x2?
    144e:	75 13                	jne    1463 <sleep@plt+0x2f3> no jump c
    1450:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1454:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    1458:	88 90 01 01 00 00    	mov    BYTE PTR [rax+0x101],dl to register b addr
    145e:	e9 81 00 00 00       	jmp    14e4 <sleep@plt+0x374> jump end
    1463:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 c: register num 0x4?
    1467:	75 10                	jne    1479 <sleep@plt+0x309> no jump d
    1469:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    146d:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    1471:	88 90 02 01 00 00    	mov    BYTE PTR [rax+0x102],dl to register c addr
    1477:	eb 6b                	jmp    14e4 <sleep@plt+0x374> jump end
    1479:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 d: register num 0x1?
    147d:	75 10                	jne    148f <sleep@plt+0x31f> no jump e
    147f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1483:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    1487:	88 90 03 01 00 00    	mov    BYTE PTR [rax+0x103],dl to register d addr
    148d:	eb 55                	jmp    14e4 <sleep@plt+0x374> jump end
    148f:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10 e: register num 0x10?
    1493:	75 10                	jne    14a5 <sleep@plt+0x335> no jump f
    1495:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    1499:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    149d:	88 90 04 01 00 00    	mov    BYTE PTR [rax+0x104],dl to register e addr
    14a3:	eb 3f                	jmp    14e4 <sleep@plt+0x374> jump end
    14a5:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 f: register num 0x40?
    14a9:	75 10                	jne    14bb <sleep@plt+0x34b> no jump g
    14ab:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    14af:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    14b3:	88 90 05 01 00 00    	mov    BYTE PTR [rax+0x105],dl to register f addr
    14b9:	eb 29                	jmp    14e4 <sleep@plt+0x374> jump end
    14bb:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 g: register num 0x20?
    14bf:	75 10                	jne    14d1 <sleep@plt+0x361> no jump unknown
    14c1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    14c5:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    14c9:	88 90 06 01 00 00    	mov    BYTE PTR [rax+0x106],dl to register g addr
    14cf:	eb 13                	jmp    14e4 <sleep@plt+0x374> jump end
    14d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] unknown: code buf addr
    14d5:	48 8d 35 2c 1b 00 00 	lea    rsi,[rip+0x1b2c] unknown register str addr
    14dc:	48 89 c7             	mov    rdi,rax code buf addr
    14df:	e8 85 fd ff ff       	call   1269 <sleep@plt+0xf9> crash
    14e4:	c9                   	leave end:
    14e5:	c3                   	ret

write_memory:
    1507:	f3 0f 1e fa          	endbr64 allow indirect jumps
    150b:	55                   	push   rbp save current stack frame
    150c:	48 89 e5             	mov    rbp,rsp new stack frame
    150f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1513:	89 f1                	mov    ecx,esi register 1 value
    1515:	89 d0                	mov    eax,edx register 2 value
    1517:	89 ca                	mov    edx,ecx register 1 value
    1519:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register 1 value
    151c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al register 2 value
    151f:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] register 1 value
    1523:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] code buf addr
    1527:	48 98                	cdqe
    1529:	0f b6 4d f0          	movzx  ecx,BYTE PTR [rbp-0x10] register 2 value
    152d:	88 0c 02             	mov    BYTE PTR [rdx+rax*1],cl to code buf addr+register 1 value
    1530:	90                   	nop
    1531:	5d                   	pop    rbp
    1532:	c3                   	ret

interpret_imm:
    1533:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1537:	55                   	push   rbp save current stack frame
    1538:	48 89 e5             	mov    rbp,rsp new stack frame
    153b:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    153f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi code buf addr
    1543:	89 f1                	mov    ecx,esi register num
    1545:	89 d0                	mov    eax,edx value
    1547:	89 ca                	mov    edx,ecx register num
    1549:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl register num
    154c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al value
    154f:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] value
    1553:	0f b6 4d f4          	movzx  ecx,BYTE PTR [rbp-0xc] register num
    1557:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] code buf addr
    155b:	89 ce                	mov    esi,ecx register num
    155d:	48 89 c7             	mov    rdi,rax code buf addr
    1560:	e8 b0 fe ff ff       	call   1415 <sleep@plt+0x2a5> write register
    1565:	90                   	nop
    1566:	c9                   	leave
    1567:	c3                   	ret

interpret_add:
    1568:	f3 0f 1e fa          	endbr64 allow indirect jumps
    156c:	55                   	push   rbp save current stack frame
    156d:	48 89 e5             	mov    rbp,rsp new stack frame
    1570:	53                   	push   rbx save rbx to prevent clobber due to abi
    1571:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    1575:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi code buf addr
    1579:	89 f1                	mov    ecx,esi register num 1
    157b:	89 d0                	mov    eax,edx register num 2
    157d:	89 ca                	mov    edx,ecx register num 1
    157f:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl register num 1
    1582:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al register num 2
    1585:	0f b6 55 e4          	movzx  edx,BYTE PTR [rbp-0x1c] register num 1
    1589:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    158d:	89 d6                	mov    esi,edx register num 1
    158f:	48 89 c7             	mov    rdi,rax code buf addr
    1592:	e8 cc fd ff ff       	call   1363 <sleep@plt+0x1f3> read register
    1597:	89 c3                	mov    ebx,eax register 1 value
    1599:	0f b6 55 e0          	movzx  edx,BYTE PTR [rbp-0x20] register num 2
    159d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    15a1:	89 d6                	mov    esi,edx register num 2
    15a3:	48 89 c7             	mov    rdi,rax code buf addr
    15a6:	e8 b8 fd ff ff       	call   1363 <sleep@plt+0x1f3> read register
    15ab:	01 d8                	add    eax,ebx register 2+1 value
    15ad:	0f b6 d0             	movzx  edx,al register 2+1 value
    15b0:	0f b6 4d e4          	movzx  ecx,BYTE PTR [rbp-0x1c] register num 1
    15b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    15b8:	89 ce                	mov    esi,ecx register num 1
    15ba:	48 89 c7             	mov    rdi,rax code buf addr
    15bd:	e8 53 fe ff ff       	call   1415 <sleep@plt+0x2a5> write register
    15c2:	90                   	nop
    15c3:	48 83 c4 18          	add    rsp,0x18 clean up local vars
    15c7:	5b                   	pop    rbx restore tbx
    15c8:	5d                   	pop    rbp restore stack frame
    15c9:	c3                   	ret

interpret_stmt:
    1687:	f3 0f 1e fa          	endbr64 allow indirect jumps
    168b:	55                   	push   rbp save current stack frame
    168c:	48 89 e5             	mov    rbp,rsp new stack frame
    168f:	53                   	push   rbx save rbx since must not be clobbered due to abi
    1690:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    1694:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi code buf addr
    1698:	89 f1                	mov    ecx,esi register num 1
    169a:	89 d0                	mov    eax,edx register num 2
    169c:	89 ca                	mov    edx,ecx register num 1
    169e:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl register num 1
    16a1:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al register num 2
    16a4:	0f b6 55 e0          	movzx  edx,BYTE PTR [rbp-0x20] register num 2
    16a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    16ac:	89 d6                	mov    esi,edx register num 2
    16ae:	48 89 c7             	mov    rdi,rax code buf addr
    16b1:	e8 ad fc ff ff       	call   1363 <sleep@plt+0x1f3> read register
    16b6:	0f b6 d8             	movzx  ebx,al register 2 value
    16b9:	0f b6 55 e4          	movzx  edx,BYTE PTR [rbp-0x1c] register num 1
    16bd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    16c1:	89 d6                	mov    esi,edx register num 1
    16c3:	48 89 c7             	mov    rdi,rax code buf addr
    16c6:	e8 98 fc ff ff       	call   1363 <sleep@plt+0x1f3> read register
    16cb:	0f b6 c8             	movzx  ecx,al register 1 value
    16ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] code buf addr
    16d2:	89 da                	mov    edx,ebx register 2 value
    16d4:	89 ce                	mov    esi,ecx register 1 value
    16d6:	48 89 c7             	mov    rdi,rax code buf addr
    16d9:	e8 29 fe ff ff       	call   1507 <sleep@plt+0x397> write memory code buf addr+register 1 value = register 2 value
    16de:	90                   	nop
    16df:	48 83 c4 18          	add    rsp,0x18 clean up local vars
    16e3:	5b                   	pop    rbx restore rbx
    16e4:	5d                   	pop    rbp restore stack frame
    16e5:	c3                   	ret

interpret_input:
    1896:	f3 0f 1e fa          	endbr64 allow indirect jumps
    189a:	55                   	push   rbp save current stack frame
    189b:	48 89 e5             	mov    rbp,rsp new stack frame
    189e:	48 83 ec 30          	sub    rsp,0x30 alloc local vars
    18a2:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi code buf addr
    18a6:	89 f1                	mov    ecx,esi 0x20 value
    18a8:	89 d0                	mov    eax,edx 0x8 register num
    18aa:	89 ca                	mov    edx,ecx 0x20 vlaue
    18ac:	88 55 d4             	mov    BYTE PTR [rbp-0x2c],dl value
    18af:	88 45 d0             	mov    BYTE PTR [rbp-0x30],al register num
    18b2:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c] check 0x2: value
    18b6:	83 e0 02             	and    eax,0x2 check 2 bit set
    18b9:	85 c0                	test   eax,eax not set?
    18bb:	74 52                	je     190f <sleep@plt+0x79f> not set jump check 0x20
    18bd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    18c1:	0f b6 80 02 01 00 00 	movzx  eax,BYTE PTR [rax+0x102] register c value
    18c8:	0f b6 c8             	movzx  ecx,al register c value
    18cb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    18cf:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101] register b value
    18d6:	0f b6 d0             	movzx  edx,al register b value
    18d9:	48 8b 75 d8          	mov    rsi,QWORD PTR [rbp-0x28] code buf addr
    18dd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    18e1:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100] ragister a value
    18e8:	0f b6 c0             	movzx  eax,al register a value
    18eb:	48 01 c6             	add    rsi,rax code buf addr+register a value
    18ee:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    18f2:	48 89 c7             	mov    rdi,rax code buf addr
    18f5:	e8 97 f9 ff ff       	call   1291 <sleep@plt+0x121> open
    18fa:	0f b6 d0             	movzx  edx,al fd
    18fd:	0f b6 4d d0          	movzx  ecx,BYTE PTR [rbp-0x30] register num
    1901:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1905:	89 ce                	mov    esi,ecx register num
    1907:	48 89 c7             	mov    rdi,rax code buf addr
    190a:	e8 06 fb ff ff       	call   1415 <sleep@plt+0x2a5> write fd to register
    190f:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c] check 0x20: value
    1913:	83 e0 20             	and    eax,0x20 check 32 bit set
    1916:	85 c0                	test   eax,eax not set?
    1918:	0f 84 82 00 00 00    	je     19a0 <sleep@plt+0x830> not set jump check 0x8
    191e:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28] code buf addr
    1922:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1926:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101] register b value
    192d:	0f b6 c0             	movzx  eax,al register b value
    1930:	48 01 d0             	add    rax,rdx code buf addr+register b value
    1933:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax code buf addr+register b value
    1937:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    193b:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101] register b value
    1942:	0f b6 c0             	movzx  eax,al register b value
    1945:	ba 00 01 00 00       	mov    edx,0x100
    194a:	29 c2                	sub    edx,eax 0x100-register b value
    194c:	89 d0                	mov    eax,edx 0x100-register b value
    194e:	48 63 d0             	movsxd rdx,eax 0x100-register b value
    1951:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1955:	0f b6 80 02 01 00 00 	movzx  eax,BYTE PTR [rax+0x102] register c value
    195c:	0f b6 c0             	movzx  eax,al register c value
    195f:	48 39 c2             	cmp    rdx,rax 0x100-register b value <= register c value?
    1962:	48 0f 46 c2          	cmovbe rax,rdx 0x100-register rax = 0x100-register b value else rax = register c value
    1966:	88 45 ee             	mov    BYTE PTR [rbp-0x12],al register c value
    1969:	0f b6 4d ee          	movzx  ecx,BYTE PTR [rbp-0x12] register c value
    196d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1971:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100] register a value
    1978:	0f b6 f0             	movzx  esi,al register a value
    197b:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10] code buf addr+register b value
    197f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1983:	48 89 c7             	mov    rdi,rax code buf addr
    1986:	e8 38 f9 ff ff       	call   12c3 <sleep@plt+0x153> read input
    198b:	0f b6 d0             	movzx  edx,al num bytes read
    198e:	0f b6 4d d0          	movzx  ecx,BYTE PTR [rbp-0x30] register num
    1992:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] code buf addr
    1996:	89 ce                	mov    esi,ecx register num
    1998:	48 89 c7             	mov    rdi,rax code buf addr
    199b:	e8 75 fa ff ff       	call   1415 <sleep@plt+0x2a5> write num bytes read to register
    19a0:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c] check 0x8: value
    19a4:	83 e0 08             	and    eax,0x8
    19a7:	85 c0                	test   eax,eax
    19a9:	0f 84 82 00 00 00    	je     1a31 <sleep@plt+0x8c1>
    19af:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    19b3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19b7:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101]
    19be:	0f b6 c0             	movzx  eax,al
    19c1:	48 01 d0             	add    rax,rdx
    19c4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    19c8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19cc:	0f b6 80 01 01 00 00 	movzx  eax,BYTE PTR [rax+0x101]
    19d3:	0f b6 c0             	movzx  eax,al
    19d6:	ba 00 01 00 00       	mov    edx,0x100
    19db:	29 c2                	sub    edx,eax
    19dd:	89 d0                	mov    eax,edx
    19df:	48 63 d0             	movsxd rdx,eax
    19e2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    19e6:	0f b6 80 02 01 00 00 	movzx  eax,BYTE PTR [rax+0x102]
    19ed:	0f b6 c0             	movzx  eax,al
    19f0:	48 39 c2             	cmp    rdx,rax
    19f3:	48 0f 46 c2          	cmovbe rax,rdx
    19f7:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al
    19fa:	0f b6 4d ef          	movzx  ecx,BYTE PTR [rbp-0x11]
    19fe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a02:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100]
    1a09:	0f b6 f0             	movzx  esi,al
    1a0c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1a10:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a14:	48 89 c7             	mov    rdi,rax
    1a17:	e8 d9 f8 ff ff       	call   12f5 <sleep@plt+0x185>
    1a1c:	0f b6 d0             	movzx  edx,al
    1a1f:	0f b6 4d d0          	movzx  ecx,BYTE PTR [rbp-0x30]
    1a23:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a27:	89 ce                	mov    esi,ecx
    1a29:	48 89 c7             	mov    rdi,rax
    1a2c:	e8 e4 f9 ff ff       	call   1415 <sleep@plt+0x2a5>
    1a31:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c]
    1a35:	83 e0 04             	and    eax,0x4
    1a38:	85 c0                	test   eax,eax
    1a3a:	74 31                	je     1a6d <sleep@plt+0x8fd>
    1a3c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a40:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100]
    1a47:	0f b6 d0             	movzx  edx,al
    1a4a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a4e:	89 d6                	mov    esi,edx
    1a50:	48 89 c7             	mov    rdi,rax
    1a53:	e8 ec f8 ff ff       	call   1344 <sleep@plt+0x1d4>
    1a58:	0f b6 d0             	movzx  edx,al
    1a5b:	0f b6 4d d0          	movzx  ecx,BYTE PTR [rbp-0x30]
    1a5f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a63:	89 ce                	mov    esi,ecx
    1a65:	48 89 c7             	mov    rdi,rax
    1a68:	e8 a8 f9 ff ff       	call   1415 <sleep@plt+0x2a5>
    1a6d:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c]
    1a71:	83 e0 01             	and    eax,0x1
    1a74:	85 c0                	test   eax,eax
    1a76:	74 1c                	je     1a94 <sleep@plt+0x924>
    1a78:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a7c:	0f b6 80 00 01 00 00 	movzx  eax,BYTE PTR [rax+0x100]
    1a83:	0f b6 d0             	movzx  edx,al
    1a86:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1a8a:	89 d6                	mov    esi,edx
    1a8c:	48 89 c7             	mov    rdi,rax
    1a8f:	e8 93 f8 ff ff       	call   1327 <sleep@plt+0x1b7>
    1a94:	90                   	nop
    1a95:	c9                   	leave
    1a96:	c3                   	ret

execute_program:
    1a97:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1a9b:	55                   	push   rbp save current stack frame
    1a9c:	48 89 e5             	mov    rbp,rsp new stack frame
    1a9f:	48 81 ec b0 00 00 00 	sub    rsp,0xb0 alloc local vars
    1aa6:	48 89 bd 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdi code buf addr
    1aad:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
    1ab4:	00 00 
    1ab6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax to stack
    1aba:	31 c0                	xor    eax,eax
    1abc:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1ac3:	ba 52 00 00 00       	mov    edx,0x52 value
    1ac8:	be 02 00 00 00       	mov    esi,0x2 register num
    1acd:	48 89 c7             	mov    rdi,rax code buf addr
    1ad0:	e8 5e fa ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm b = 0x52
    1ad5:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1adc:	ba 08 00 00 00       	mov    edx,0x8 value
    1ae1:	be 04 00 00 00       	mov    esi,0x4 register num
    1ae6:	48 89 c7             	mov    rdi,rax code buf addr
    1ae9:	e8 45 fa ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm c = 0x8
    1aee:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1af5:	ba 00 00 00 00       	mov    edx,0x0 value
    1afa:	be 08 00 00 00       	mov    esi,0x8 register num
    1aff:	48 89 c7             	mov    rdi,rax code buf addr
    1b02:	e8 2c fa ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x0
    1b07:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b0e:	ba 08 00 00 00       	mov    edx,0x8
    1b13:	be 20 00 00 00       	mov    esi,0x20
    1b18:	48 89 c7             	mov    rdi,rax code buf addr
    1b1b:	e8 76 fd ff ff       	call   1896 <sleep@plt+0x726> interpret input
    1b20:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b27:	ba 72 00 00 00       	mov    edx,0x72 value
    1b2c:	be 02 00 00 00       	mov    esi,0x2 register num
    1b31:	48 89 c7             	mov    rdi,rax code buf addr
    1b34:	e8 fa f9 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm b = 0x72
    1b39:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b40:	ba 01 00 00 00       	mov    edx,0x1 value
    1b45:	be 04 00 00 00       	mov    esi,0x4 register num
    1b4a:	48 89 c7             	mov    rdi,rax code buf addr
    1b4d:	e8 e1 f9 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm c = 0x1
    1b52:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b59:	ba 90 00 00 00       	mov    edx,0x90 value
    1b5e:	be 08 00 00 00       	mov    esi,0x8 register num
    1b63:	48 89 c7             	mov    rdi,rax code buf addr
    1b66:	e8 c8 f9 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x90
    1b6b:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b72:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1b77:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1b7c:	48 89 c7             	mov    rdi,rax code buf addr
    1b7f:	e8 03 fb ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x72 = 0x90
    1b84:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1b8b:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1b90:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1b95:	48 89 c7             	mov    rdi,rax code buf addr
    1b98:	e8 cb f9 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x73
    1b9d:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1ba4:	ba 3a 00 00 00       	mov    edx,0x3a value
    1ba9:	be 08 00 00 00       	mov    esi,0x8 register num
    1bae:	48 89 c7             	mov    rdi,rax code buf addr
    1bb1:	e8 7d f9 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x3a
    1bb6:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1bbd:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1bc2:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1bc7:	48 89 c7             	mov    rdi,rax code buf addr
    1bca:	e8 b8 fa ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x73 = 0x3a
    1bcf:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1bd6:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1bdb:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1be0:	48 89 c7             	mov    rdi,rax code buf addr
    1be3:	e8 80 f9 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x74
    1be8:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1bef:	ba 95 00 00 00       	mov    edx,0x95 value
    1bf4:	be 08 00 00 00       	mov    esi,0x8 register num
    1bf9:	48 89 c7             	mov    rdi,rax code buf addr
    1bfc:	e8 32 f9 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x95
    1c01:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c08:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1c0d:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1c12:	48 89 c7             	mov    rdi,rax code buf addr
    1c15:	e8 6d fa ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x74 = 0x95
    1c1a:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c21:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1c26:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1c2b:	48 89 c7             	mov    rdi,rax code buf addr
    1c2e:	e8 35 f9 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x75
    1c33:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c3a:	ba 35 00 00 00       	mov    edx,0x35 value
    1c3f:	be 08 00 00 00       	mov    esi,0x8 register num
    1c44:	48 89 c7             	mov    rdi,rax code buf addr
    1c47:	e8 e7 f8 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x35
    1c4c:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c53:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1c58:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1c5d:	48 89 c7             	mov    rdi,rax code buf addr
    1c60:	e8 22 fa ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x75 = 0x35
    1c65:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c6c:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1c71:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1c76:	48 89 c7             	mov    rdi,rax code buf addr
    1c79:	e8 ea f8 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x76
    1c7e:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c85:	ba 2a 00 00 00       	mov    edx,0x2a value
    1c8a:	be 08 00 00 00       	mov    esi,0x8 register num
    1c8f:	48 89 c7             	mov    rdi,rax code buf addr
    1c92:	e8 9c f8 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x2a
    1c97:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1c9e:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1ca3:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1ca8:	48 89 c7             	mov    rdi,rax code buf addr
    1cab:	e8 d7 f9 ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x76 = 0x2a
    1cb0:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1cb7:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1cbc:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1cc1:	48 89 c7             	mov    rdi,rax code buf addr
    1cc4:	e8 9f f8 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x77
    1cc9:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buff addr
    1cd0:	ba a9 00 00 00       	mov    edx,0xa9 value
    1cd5:	be 08 00 00 00       	mov    esi,0x8 register num
    1cda:	48 89 c7             	mov    rdi,rax code buf addr
    1cdd:	e8 51 f8 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0xa9
    1ce2:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1ce9:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1cee:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1cf3:	48 89 c7             	mov    rdi,rax code buf addr
    1cf6:	e8 8c f9 ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x77 = 0xa9
    1cfb:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d02:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1d07:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1d0c:	48 89 c7             	mov    rdi,rax code buf addr
    1d0f:	e8 54 f8 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x78
    1d14:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d1b:	ba 68 00 00 00       	mov    edx,0x68 value
    1d20:	be 08 00 00 00       	mov    esi,0x8 register num
    1d25:	48 89 c7             	mov    rdi,rax code buf addr
    1d28:	e8 06 f8 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0x68
    1d2d:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d34:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1d39:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1d3e:	48 89 c7             	mov    rdi,rax code buf addr
    1d41:	e8 41 f9 ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x78 = 0x68
    1d46:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d4d:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1d52:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1d57:	48 89 c7             	mov    rdi,rax code buf addr
    1d5a:	e8 09 f8 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x79
    1d5f:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d66:	ba bc 00 00 00       	mov    edx,0xbc value
    1d6b:	be 08 00 00 00       	mov    esi,0x8 register num
    1d70:	48 89 c7             	mov    rdi,rax code buf addr
    1d73:	e8 bb f7 ff ff       	call   1533 <sleep@plt+0x3c3> interpret imm a = 0xbc
    1d78:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1d7f:	ba 08 00 00 00       	mov    edx,0x8 register num 2
    1d84:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1d89:	48 89 c7             	mov    rdi,rax code buf addr
    1d8c:	e8 f6 f8 ff ff       	call   1687 <sleep@plt+0x517> interpret stmt cba+0x79 = 0xbc
    1d91:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buff addr
    1d98:	ba 04 00 00 00       	mov    edx,0x4 register num 2
    1d9d:	be 02 00 00 00       	mov    esi,0x2 register num 1
    1da2:	48 89 c7             	mov    rdi,rax code buf addr
    1da5:	e8 be f7 ff ff       	call   1568 <sleep@plt+0x3f8> interpret add b = b+c = 0x7a
    1daa:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1db1:	48 8d 48 52          	lea    rcx,[rax+0x52] # code buf addr+input addr offset
    1db5:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] code buf addr
    1dbc:	48 83 c0 72          	add    rax,0x72 code buf addr+expected value addr offset
    1dc0:	ba 08 00 00 00       	mov    edx,0x8 num bytes to cmp
    1dc5:	48 89 ce             	mov    rsi,rcx input addr
    1dc8:	48 89 c7             	mov    rdi,rax expected value addr
    1dcb:	e8 60 f3 ff ff       	call   1130 <memcmp@plt>
    1dd0:	85 c0                	test   eax,eax equal?
    1dd2:	0f 94 c0             	sete   al 1 if equal else 0
    1dd5:	0f b6 c0             	movzx  eax,al
    1dd8:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax equal value
    1dde:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0 equal false?
    1de5:	74 58                	je     1e3f <sleep@plt+0xccf> not equal jump incorrect
    1de7:	48 8d 3d 2b 12 00 00 	lea    rdi,[rip+0x122b] correct: format str addr
    1dee:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1df3:	e8 18 f3 ff ff       	call   1110 <printf@plt> print format
    1df8:	be 00 00 00 00       	mov    esi,0x0 O_RDONLY
    1dfd:	48 8d 3d 2a 12 00 00 	lea    rdi,[rip+0x122a] /flag str addr
    1e04:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1e09:	e8 42 f3 ff ff       	call   1150 <open@plt>
    1e0e:	89 c1                	mov    ecx,eax flag fd
    1e10:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90] inbuf addr
    1e17:	ba 64 00 00 00       	mov    edx,0x64 num bytes read
    1e1c:	48 89 c6             	mov    rsi,rax inbuf addr
    1e1f:	89 cf                	mov    edi,ecx flag fd
    1e21:	e8 fa f2 ff ff       	call   1120 <read@plt> read 0x64 bytes from /flag
    1e26:	48 89 c2             	mov    rdx,rax num bytes read
    1e29:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90] inbuf addr
    1e30:	48 89 c6             	mov    rsi,rax inbuf addr
    1e33:	bf 01 00 00 00       	mov    edi,0x1 stdout fd
    1e38:	e8 b3 f2 ff ff       	call   10f0 <write@plt> write num bytes read from flag to stdout
    1e3d:	eb 11                	jmp    1e50 <sleep@plt+0xce0> jump end
    1e3f:	48 8d 3d ee 11 00 00 	lea    rdi,[rip+0x11ee] incorrect: format str addr
    1e46:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1e4b:	e8 c0 f2 ff ff       	call   1110 <printf@plt> print format
    1e50:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0 end: equal false?
    1e57:	0f 94 c0             	sete   al 1 if false else 0
    1e5a:	0f b6 c0             	movzx  eax,al
    1e5d:	89 c7                	mov    edi,eax exit code
    1e5f:	e8 fc f2 ff ff       	call   1160 <exit@plt>

main:
    1e64:	f3 0f 1e fa          	endbr64 indirect jumps allowd
    1e68:	55                   	push   rbp save current stack frame
    1e69:	48 89 e5             	mov    rbp,rsp new stack frame
    1e6c:	48 81 ec 20 01 00 00 	sub    rsp,0x120 alloc local vars
    1e73:	89 bd ec fe ff ff    	mov    DWORD PTR [rbp-0x114],edi argc
    1e79:	48 89 b5 e0 fe ff ff 	mov    QWORD PTR [rbp-0x120],rsi argv ptr
    1e80:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
    1e87:	00 00 
    1e89:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax to stack
    1e8d:	31 c0                	xor    eax,eax
    1e8f:	48 8b 85 e0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x120] argv ptr
    1e96:	48 8b 00             	mov    rax,QWORD PTR [rax] dereference argv ptr
    1e99:	48 89 c6             	mov    rsi,rax argv addr
    1e9c:	48 8d 3d 9c 11 00 00 	lea    rdi,[rip+0x119c] format str addr
    1ea3:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1ea8:	e8 63 f2 ff ff       	call   1110 <printf@plt> print format, argv
    1ead:	48 8d 3d a4 11 00 00 	lea    rdi,[rip+0x11a4] str addr
    1eb4:	e8 27 f2 ff ff       	call   10e0 <puts@plt> print str
    1eb9:	48 8d 3d e8 11 00 00 	lea    rdi,[rip+0x11e8] str addr
    1ec0:	e8 1b f2 ff ff       	call   10e0 <puts@plt> print str
    1ec5:	48 8d 3d 24 12 00 00 	lea    rdi,[rip+0x1224] str addr
    1ecc:	e8 0f f2 ff ff       	call   10e0 <puts@plt> print str
    1ed1:	48 8d 3d 68 12 00 00 	lea    rdi,[rip+0x1268] str addr
    1ed8:	e8 03 f2 ff ff       	call   10e0 <puts@plt> print str
    1edd:	48 8d 3d ac 12 00 00 	lea    rdi,[rip+0x12ac] str addr
    1ee4:	e8 f7 f1 ff ff       	call   10e0 <puts@plt> print str
    1ee9:	48 8d 3d dd 12 00 00 	lea    rdi,[rip+0x12dd] str addr
    1ef0:	e8 eb f1 ff ff       	call   10e0 <puts@plt> print str
    1ef5:	48 8d 3d dc 12 00 00 	lea    rdi,[rip+0x12dc] str addr
    1efc:	e8 df f1 ff ff       	call   10e0 <puts@plt> print str
    1f01:	48 8d 3d 20 13 00 00 	lea    rdi,[rip+0x1320] str addr
    1f08:	e8 d3 f1 ff ff       	call   10e0 <puts@plt> print str
    1f0d:	48 8d 3d 64 13 00 00 	lea    rdi,[rip+0x1364] str addr
    1f14:	e8 c7 f1 ff ff       	call   10e0 <puts@plt> print str
    1f19:	48 8b 05 f0 30 00 00 	mov    rax,QWORD PTR [rip+0x30f0] stdout file addr
    1f20:	b9 01 00 00 00       	mov    ecx,0x1 buf size
    1f25:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    1f2a:	be 00 00 00 00       	mov    esi,0x0 buf addr
    1f2f:	48 89 c7             	mov    rdi,rax stdout file addr
    1f32:	e8 09 f2 ff ff       	call   1140 <setvbuf@plt> set stdout to unbuffered
    1f37:	48 8d 95 f0 fe ff ff 	lea    rdx,[rbp-0x110] code buf addr
    1f3e:	b8 00 00 00 00       	mov    eax,0x0 value
    1f43:	b9 20 00 00 00       	mov    ecx,0x20 number qwords to set
    1f48:	48 89 d7             	mov    rdi,rdx code buf addr
    1f4b:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax set 256 bytes code buf to zero
    1f4e:	48 89 fa             	mov    rdx,rdi current code buf end addr
    1f51:	89 02                	mov    DWORD PTR [rdx],eax zero 4 more bytes
    1f53:	48 83 c2 04          	add    rdx,0x4 current code buf end addr
    1f57:	66 89 02             	mov    WORD PTR [rdx],ax zero 2 more bytes
    1f5a:	48 83 c2 02          	add    rdx,0x2 current code buf end addr
    1f5e:	88 02                	mov    BYTE PTR [rdx],al zero 1 more byte
    1f60:	48 83 c2 01          	add    rdx,0x1 current code buf end addr => total buf size 263 bytes
    1f64:	48 8d 85 f0 fe ff ff 	lea    rax,[rbp-0x110] code buf addr
    1f6b:	48 89 c7             	mov    rdi,rax code buf addr
    1f6e:	e8 24 fb ff ff       	call   1a97 <sleep@plt+0x927> execute program
    1f73:	b8 00 00 00 00       	mov    eax,0x0
    1f78:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] current canary on stack
    1f7c:	64 48 33 0c 25 28 00 	xor    rcx,QWORD PTR fs:0x28 cmp actual stack guard canary
    1f83:	00 00 
    1f85:	74 05                	je     1f8c <sleep@plt+0xe1c> equal jump end
    1f87:	e8 74 f1 ff ff       	call   1100 <__stack_chk_fail@plt> fail due to stack corruption
    1f8c:	c9                   	leave
    1f8d:	c3                   	ret
