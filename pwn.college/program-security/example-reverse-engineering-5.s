0000000000001180 <.text>:

crash:
    1269:	f3 0f 1e fa          	endbr64 allow indirect jumps
    126d:	55                   	push   rbp save current stack frame
    126e:	48 89 e5             	mov    rbp,rsp new stack frame
    1271:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1275:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi str addr
    1279:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] str addr
    127d:	48 89 c6             	mov    rsi,rax str addr
    1280:	48 8d 3d 81 0d 00 00 	lea    rdi,[rip+0xd81] format str addr # 2008 <sleep@plt+0xe98>
    1287:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    128c:	e8 7f fe ff ff       	call   1110 <printf@plt> print format, str
    1291:	bf 01 00 00 00       	mov    edi,0x1 exit instruction
    1296:	e8 c5 fe ff ff       	call   1160 <exit@plt>

read_register:
    129b:	f3 0f 1e fa          	endbr64 allow indirect jumps
    129f:	55                   	push   rbp save current stack frame
    12a0:	48 89 e5             	mov    rbp,rsp new stack frame
    12a3:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    12a7:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    12ab:	89 f0                	mov    eax,esi reg num
    12ad:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al reg num
    12b0:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 reg a?
    12b4:	75 0d                	jne    12c3 <sleep@plt+0x153> no jump reg b
    12b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    12ba:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    12c1:	eb 7e                	jmp    1341 <sleep@plt+0x1d1> jump end
    12c3:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 reg b?
    12c7:	75 0d                	jne    12d6 <sleep@plt+0x166> no jump reg c
    12c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    12cd:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    12d4:	eb 6b                	jmp    1341 <sleep@plt+0x1d1> jump end
    12d6:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 reg c?
    12da:	75 0d                	jne    12e9 <sleep@plt+0x179> no jump reg d
    12dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    12e0:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    12e7:	eb 58                	jmp    1341 <sleep@plt+0x1d1> jump end
    12e9:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10 reg d?
    12ed:	75 0d                	jne    12fc <sleep@plt+0x18c> no jump reg e
    12ef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    12f3:	0f b6 80 03 04 00 00 	movzx  eax,BYTE PTR [rax+0x403] reg d val
    12fa:	eb 45                	jmp    1341 <sleep@plt+0x1d1> jump end
    12fc:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 reg e?
    1300:	75 0d                	jne    130f <sleep@plt+0x19f> no jump reg f
    1302:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1306:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    130d:	eb 32                	jmp    1341 <sleep@plt+0x1d1> jump end
    130f:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 reg f?
    1313:	75 0d                	jne    1322 <sleep@plt+0x1b2> no jump reg g
    1315:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1319:	0f b6 80 05 04 00 00 	movzx  eax,BYTE PTR [rax+0x405] reg f val
    1320:	eb 1f                	jmp    1341 <sleep@plt+0x1d1> jump end
    1322:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 reg g?
    1326:	75 0d                	jne    1335 <sleep@plt+0x1c5> no jump unknown
    1328:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    132c:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1333:	eb 0c                	jmp    1341 <sleep@plt+0x1d1> jump end
    1335:	48 8d 3d e8 0c 00 00 	lea    rdi,[rip+0xce8] unknown register str addr # 2024 <sleep@plt+0xeb4>
    133c:	e8 28 ff ff ff       	call   1269 <sleep@plt+0xf9> crash
    1341:	c9                   	leave end: clean up stack
    1342:	c3                   	ret

write_register:
    1343:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1347:	55                   	push   rbp save current stack frame
    1348:	48 89 e5             	mov    rbp,rsp new stack frame
    134b:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    134f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1353:	89 f1                	mov    ecx,esi reg num
    1355:	89 d0                	mov    eax,edx val
    1357:	89 ca                	mov    edx,ecx reg num
    1359:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl reg num
    135c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al val
    135f:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 reg a?
    1363:	75 13                	jne    1378 <sleep@plt+0x208> no jump reg b
    1365:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1369:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    136d:	88 90 00 04 00 00    	mov    BYTE PTR [rax+0x400],dl to reg a
    1373:	e9 90 00 00 00       	jmp    1408 <sleep@plt+0x298> jump end
    1378:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 reg b?
    137c:	75 10                	jne    138e <sleep@plt+0x21e> no jump reg c
    137e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1382:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    1386:	88 90 01 04 00 00    	mov    BYTE PTR [rax+0x401],dl to reg b
    138c:	eb 7a                	jmp    1408 <sleep@plt+0x298> jump end
    138e:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 reg c?
    1392:	75 10                	jne    13a4 <sleep@plt+0x234> no jump reg d
    1394:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1398:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    139c:	88 90 02 04 00 00    	mov    BYTE PTR [rax+0x402],dl to reg c
    13a2:	eb 64                	jmp    1408 <sleep@plt+0x298> jump end
    13a4:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10 reg d?
    13a8:	75 10                	jne    13ba <sleep@plt+0x24a> no jump reg e
    13aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    13ae:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    13b2:	88 90 03 04 00 00    	mov    BYTE PTR [rax+0x403],dl to reg d
    13b8:	eb 4e                	jmp    1408 <sleep@plt+0x298> jump end
    13ba:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 reg e?
    13be:	75 10                	jne    13d0 <sleep@plt+0x260> no jump reg f
    13c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    13c4:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    13c8:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl to reg e
    13ce:	eb 38                	jmp    1408 <sleep@plt+0x298> jump end
    13d0:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 reg f?
    13d4:	75 10                	jne    13e6 <sleep@plt+0x276> no jump reg g
    13d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    13da:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    13de:	88 90 05 04 00 00    	mov    BYTE PTR [rax+0x405],dl to reg f
    13e4:	eb 22                	jmp    1408 <sleep@plt+0x298> jump end
    13e6:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 reg g?
    13ea:	75 10                	jne    13fc <sleep@plt+0x28c> no jump unknown
    13ec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    13f0:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] val
    13f4:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl to reg g
    13fa:	eb 0c                	jmp    1408 <sleep@plt+0x298> jump end
    13fc:	48 8d 3d 21 0c 00 00 	lea    rdi,[rip+0xc21] unknown register str addr # 2024 <sleep@plt+0xeb4>
    1403:	e8 61 fe ff ff       	call   1269 <sleep@plt+0xf9> crash
    1408:	c9                   	leave end: clean up stack
    1409:	c3                   	ret

read_memory:
    140a:	f3 0f 1e fa          	endbr64 allow indirect jumps
    140e:	55                   	push   rbp save current stack frame
    140f:	48 89 e5             	mov    rbp,rsp new stack fram
    1412:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1416:	89 f0                	mov    eax,esi reg val
    1418:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al reg val
    141b:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] reg val
    141f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm buf addr
    1423:	48 98                	cdqe
    1425:	0f b6 84 02 00 03 00 	movzx  eax,BYTE PTR [rdx+rax*1+0x300] vm buf addr+0x300+reg val value
    142c:	00 
    142d:	5d                   	pop    rbp restore previous stack frame
    142e:	c3                   	ret

write_memory:
    142f:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1433:	55                   	push   rbp save current stack frame
    1434:	48 89 e5             	mov    rbp,rsp new stack frame
    1437:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    143b:	89 f1                	mov    ecx,esi reg val
    143d:	89 d0                	mov    eax,edx val
    143f:	89 ca                	mov    edx,ecx reg val
    1441:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl reg val
    1444:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al val
    1447:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] reg val
    144b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm buf addr
    144f:	48 98                	cdqe
    1451:	0f b6 4d f0          	movzx  ecx,BYTE PTR [rbp-0x10] val
    1455:	88 8c 02 00 03 00 00 	mov    BYTE PTR [rdx+rax*1+0x300],cl to vm buf addr+0x300+reg val
    145c:	90                   	nop
    145d:	5d                   	pop    rbp restore previous stack frame
    145e:	c3                   	ret

interpret_write_register:
    145f:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1463:	55                   	push   rbp save current stack frame
    1464:	48 89 e5             	mov    rbp,rsp new stack frame
    1467:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    146b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    146f:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instruction
    1473:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd highest instruction byte
    1477:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte as val
    147a:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] lowest instruction byte
    147e:	0f b6 c8             	movzx  ecx,al lowest instruction byte
    1481:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1485:	89 ce                	mov    esi,ecx lowest instruction byte as reg num
    1487:	48 89 c7             	mov    rdi,rax vm buf addr
    148a:	e8 b4 fe ff ff       	call   1343 <sleep@plt+0x1d3> write register
    148f:	90                   	nop
    1490:	c9                   	leave clean up stack
    1491:	c3                   	ret

interpret_add:
    1492:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1496:	55                   	push   rbp save current stack frame
    1497:	48 89 e5             	mov    rbp,rsp new stack frame
    149a:	53                   	push   rbx save rbx sysv abi no clobber
    149b:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    149f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    14a3:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instruction
    14a7:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] lowest instruction byte
    14ab:	0f b6 d0             	movzx  edx,al lowest instruction byte
    14ae:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    14b2:	89 d6                	mov    esi,edx lowest instruction byte as reg num1
    14b4:	48 89 c7             	mov    rdi,rax vm buf addr
    14b7:	e8 df fd ff ff       	call   129b <sleep@plt+0x12b> read register
    14bc:	89 c3                	mov    ebx,eax reg num1 val
    14be:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd highest instruction byte
    14c2:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte
    14c5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    14c9:	89 d6                	mov    esi,edx 2nd highest instruction byte as reg num2
    14cb:	48 89 c7             	mov    rdi,rax vm buf addr
    14ce:	e8 c8 fd ff ff       	call   129b <sleep@plt+0x12b> read register
    14d3:	01 d8                	add    eax,ebx reg num2 val + reg num1 val
    14d5:	0f b6 d0             	movzx  edx,al reg num2 val + reg num1 val pruned to 1 byte as val
    14d8:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] lowest instruction byte
    14dc:	0f b6 c8             	movzx  ecx,al lowest instruction byte
    14df:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    14e3:	89 ce                	mov    esi,ecx lowest instruction byte as reg num1
    14e5:	48 89 c7             	mov    rdi,rax vm buf addr
    14e8:	e8 56 fe ff ff       	call   1343 <sleep@plt+0x1d3> write register
    14ed:	90                   	nop
    14ee:	48 83 c4 18          	add    rsp,0x18 clean up stack
    14f2:	5b                   	pop    rbx restore rbx
    14f3:	5d                   	pop    rbp restore preivous stack frame
    14f4:	c3                   	ret

interpret_push_pop_stack:
    14f5:	f3 0f 1e fa          	endbr64 allow indirect jumps
    14f9:	55                   	push   rbp save current stack frame
    14fa:	48 89 e5             	mov    rbp,rsp new stack frame
    14fd:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1501:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1505:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instruction
    1509:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] write memory: 2nd highest instruction byte
    150d:	84 c0                	test   al,al 2nd highest instruction byte 0x0?
    150f:	74 4c                	je     155d <sleep@plt+0x3ed> yes jump read memory
    1511:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1515:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    151c:	8d 50 01             	lea    edx,[rax+0x1] inc reg e val
    151f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1523:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl reg e val+1
    1529:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd highest instruction byte
    152d:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte
    1530:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1534:	89 d6                	mov    esi,edx 2nd highest instruction byte as reg num
    1536:	48 89 c7             	mov    rdi,rax vm buf addr
    1539:	e8 5d fd ff ff       	call   129b <sleep@plt+0x12b> read register
    153e:	0f b6 d0             	movzx  edx,al reg num val as val
    1541:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1545:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    154c:	0f b6 c8             	movzx  ecx,al reg e val
    154f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1553:	89 ce                	mov    esi,ecx reg e val as reg val
    1555:	48 89 c7             	mov    rdi,rax vm buf addr
    1558:	e8 d2 fe ff ff       	call   142f <sleep@plt+0x2bf> write memory
    155d:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] read memory: lowest instruction byte
    1561:	84 c0                	test   al,al lowest instruction byte 0x0?
    1563:	74 4c                	je     15b1 <sleep@plt+0x441> yes jump end
    1565:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1569:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    1570:	0f b6 d0             	movzx  edx,al reg e val
    1573:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1577:	89 d6                	mov    esi,edx reg e val
    1579:	48 89 c7             	mov    rdi,rax vm buf addr
    157c:	e8 89 fe ff ff       	call   140a <sleep@plt+0x29a> read memory
    1581:	0f b6 d0             	movzx  edx,al vm buf addr+0x300+reg e val value as value
    1584:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] lowest instruction byte
    1588:	0f b6 c8             	movzx  ecx,al lowest instruction byte
    158b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    158f:	89 ce                	mov    esi,ecx lowest instruction byte as reg num
    1591:	48 89 c7             	mov    rdi,rax vm buf addr
    1594:	e8 aa fd ff ff       	call   1343 <sleep@plt+0x1d3> write register
    1599:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    159d:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    15a4:	8d 50 ff             	lea    edx,[rax-0x1] dec reg e val
    15a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    15ab:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl reg e val-1
    15b1:	90                   	nop end:
    15b2:	c9                   	leave clean up stack
    15b3:	c3                   	ret

interpret_stmt:
    15b4:	f3 0f 1e fa          	endbr64 allow indirect jumps
    15b8:	55                   	push   rbp save current stack frame
    15b9:	48 89 e5             	mov    rbp,rsp new stack frame
    15bc:	53                   	push   rbx save rbx due to sysv abi no clobber
    15bd:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    15c1:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    15c5:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instruction
    15c9:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd highest instruction byte
    15cd:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte
    15d0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    15d4:	89 d6                	mov    esi,edx 2nd highest instruction byte as reg num1
    15d6:	48 89 c7             	mov    rdi,rax vm buf addr
    15d9:	e8 bd fc ff ff       	call   129b <sleep@plt+0x12b> read register
    15de:	0f b6 d8             	movzx  ebx,al reg num1 val
    15e1:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] lowest instruction byte
    15e5:	0f b6 d0             	movzx  edx,al lowest instruction byte
    15e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    15ec:	89 d6                	mov    esi,edx lowest instruction byte as reg num2
    15ee:	48 89 c7             	mov    rdi,rax vm buf addr
    15f1:	e8 a5 fc ff ff       	call   129b <sleep@plt+0x12b> read register
    15f6:	0f b6 c8             	movzx  ecx,al reg num2 val
    15f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    15fd:	89 da                	mov    edx,ebx reg num1 val as val
    15ff:	89 ce                	mov    esi,ecx reg num2 val as reg num
    1601:	48 89 c7             	mov    rdi,rax vm buf addr
    1604:	e8 26 fe ff ff       	call   142f <sleep@plt+0x2bf> write memory
    1609:	90                   	nop
    160a:	48 83 c4 18          	add    rsp,0x18 clean up stack
    160e:	5b                   	pop    rbx restore rbx
    160f:	5d                   	pop    rbp restore previous stack frame
    1610:	c3                   	ret

interpret_memory_to_register:
    1611:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1615:	55                   	push   rbp save current stack frame
    1616:	48 89 e5             	mov    rbp,rsp new stack frame
    1619:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    161d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1621:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instruction
    1625:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd highest instruction byte
    1629:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte
    162c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1630:	89 d6                	mov    esi,edx 2nd highest instruction byte as reg num
    1632:	48 89 c7             	mov    rdi,rax vm buf addr
    1635:	e8 61 fc ff ff       	call   129b <sleep@plt+0x12b> read register
    163a:	0f b6 d0             	movzx  edx,al reg num val
    163d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1641:	89 d6                	mov    esi,edx reg num val
    1643:	48 89 c7             	mov    rdi,rax vm buf addr
    1646:	e8 bf fd ff ff       	call   140a <sleep@plt+0x29a> read memory
    164b:	0f b6 d0             	movzx  edx,al vm buf addr+0x300+reg num val value as value
    164e:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] lowest instruction byte
    1652:	0f b6 c8             	movzx  ecx,al lowest instruction byte
    1655:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1659:	89 ce                	mov    esi,ecx lowest instruction byte as reg num
    165b:	48 89 c7             	mov    rdi,rax vm buf addr
    165e:	e8 e0 fc ff ff       	call   1343 <sleep@plt+0x1d3> write register
    1663:	90                   	nop
    1664:	c9                   	leave clean up stack
    1665:	c3                   	ret

interpret_test:
    1666:	f3 0f 1e fa          	endbr64 allow indirect jumps
    166a:	55                   	push   rbp save current stack frame
    166b:	48 89 e5             	mov    rbp,rsp new stack frame
    166e:	48 83 ec 20          	sub    rsp,0x20 alloc local vars
    1672:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    1676:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instruction
    167a:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] lowest instruction byte
    167e:	0f b6 d0             	movzx  edx,al lowest instruction byte
    1681:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1685:	89 d6                	mov    esi,edx lowest instruction byte as reg num1
    1687:	48 89 c7             	mov    rdi,rax vm buf addr
    168a:	e8 0c fc ff ff       	call   129b <sleep@plt+0x12b> read registers
    168f:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al reg num1 val
    1692:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd highest instruction byte
    1696:	0f b6 d0             	movzx  edx,al second highest instruction byte
    1699:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    169d:	89 d6                	mov    esi,edx 2nd highest isntruction byte as reg num2
    169f:	48 89 c7             	mov    rdi,rax vm buf addr
    16a2:	e8 f4 fb ff ff       	call   129b <sleep@plt+0x12b> read register
    16a7:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al reg num2 val
    16aa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16ae:	c6 80 06 04 00 00 00 	mov    BYTE PTR [rax+0x406],0x0 zero to reg g
    16b5:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] case 0x4: reg num1 val
    16b9:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] cmp to reg num2 val
    16bc:	73 1a                	jae    16d8 <sleep@plt+0x568> reg num1 val >= reg num2 val jump case 0x2
    16be:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16c2:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    16c9:	83 c8 04             	or     eax,0x4 0x4+g
    16cc:	89 c2                	mov    edx,eax 0x4+g
    16ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16d2:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl g = g+0x4
    16d8:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] case 0x2: reg num1 val
    16dc:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] cmp to reg num2 val
    16df:	76 1a                	jbe    16fb <sleep@plt+0x58b> reg num1 val <= reg num2 val jump case 0x8
    16e1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16e5:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    16ec:	83 c8 02             	or     eax,0x2 0x2+g
    16ef:	89 c2                	mov    edx,eax 0x2+g
    16f1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    16f5:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl g = g+0x2
    16fb:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] case 0x8: reg num1 val
    16ff:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] cmp to reg num2 val
    1702:	75 1a                	jne    171e <sleep@plt+0x5ae> reg num1 val != reg num2 val jump case 0x10
    1704:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1708:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    170f:	83 c8 08             	or     eax,0x8 0x8+g
    1712:	89 c2                	mov    edx,eax 0x8+g
    1714:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1718:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl g = g+0x8
    171e:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] case 0x10: reg num1 val
    1722:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] cmp to reg num2 val
    1725:	74 1a                	je     1741 <sleep@plt+0x5d1> reg num1 val == reg num2 val jump case zero1
    1727:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    172b:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1732:	83 c8 10             	or     eax,0x10 0x10+g
    1735:	89 c2                	mov    edx,eax 0x10+g
    1737:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    173b:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl g = g+0x10
    1741:	80 7d fe 00          	cmp    BYTE PTR [rbp-0x2],0x0 case zero1: reg num1 0x0?
    1745:	75 20                	jne    1767 <sleep@plt+0x5f7> reg num1 != 0x0 jump end
    1747:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0 case zero2: reg num2 0x0?
    174b:	75 1a                	jne    1767 <sleep@plt+0x5f7> reg num2 != 0x0 jump end
    174d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1751:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1758:	83 c8 01             	or     eax,0x1 0x1+g
    175b:	89 c2                	mov    edx,eax 0x1+g
    175d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1761:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl g = g+0x1
    1767:	90                   	nop end:
    1768:	c9                   	leave clean up stack
    1769:	c3                   	ret

interpret_conditional_jump:
    176a:	f3 0f 1e fa          	endbr64 allow indirect jumps
    176e:	55                   	push   rbp save current stack frame
    176f:	48 89 e5             	mov    rbp,rsp new stack frame
    1772:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1776:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    177a:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instruction
    177e:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] check flags: lowest instruction byte
    1782:	84 c0                	test   al,al lowest instruction byte zero?
    1784:	74 15                	je     179b <sleep@plt+0x62b> yes jump set f
    1786:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] lowest instruction byte as set flags
    178a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    178e:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val as current flags
    1795:	21 d0                	and    eax,edx compare flags
    1797:	84 c0                	test   al,al no overlapping flags?
    1799:	74 1f                	je     17ba <sleep@plt+0x64a> no overlapping flags jump end
    179b:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] set f: 2nd highest instruction byte
    179f:	0f b6 d0             	movzx  edx,al 2nd highest instruction byte
    17a2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    17a6:	89 d6                	mov    esi,edx 2nd highest instruction byte as reg num
    17a8:	48 89 c7             	mov    rdi,rax vm buf addr
    17ab:	e8 eb fa ff ff       	call   129b <sleep@plt+0x12b> read register
    17b0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm buf addr
    17b4:	88 82 05 04 00 00    	mov    BYTE PTR [rdx+0x405],al reg num val to reg f
    17ba:	90                   	nop end:
    17bb:	c9                   	leave clean up stack
    17bc:	c3                   	ret

interpret_sys:
    17bd:	f3 0f 1e fa          	endbr64 allow indirect jumps
    17c1:	55                   	push   rbp save current stack frame
    17c2:	48 89 e5             	mov    rbp,rsp new stack frame
    17c5:	48 83 ec 30          	sub    rsp,0x30 alloc local vars
    17c9:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi vm buf addr
    17cd:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi instruction
    17d1:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] open: lowest instruction byte
    17d5:	0f b6 c0             	movzx  eax,al lowest instruction byte
    17d8:	83 e0 01             	and    eax,0x1 lowest instruction byte 0x1?
    17db:	85 c0                	test   eax,eax not 0x1?
    17dd:	74 5f                	je     183e <sleep@plt+0x6ce> not 0x1 jump read
    17df:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    17e3:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    17ea:	0f b6 d0             	movzx  edx,al reg c val reg c val as mode_t
    17ed:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    17f1:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    17f8:	0f b6 c0             	movzx  eax,al reg b val
    17fb:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28] vm buf addr
    17ff:	48 8d b1 00 03 00 00 	lea    rsi,[rcx+0x300] stack base addr
    1806:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28] vm buf addr
    180a:	0f b6 89 00 04 00 00 	movzx  ecx,BYTE PTR [rcx+0x400] reg a val
    1811:	0f b6 c9             	movzx  ecx,cl reg a val
    1814:	48 01 f1             	add    rcx,rsi stack base addr+reg a val
    1817:	89 c6                	mov    esi,eax reg b val as flags
    1819:	48 89 cf             	mov    rdi,rcx stack base addr+reg a val as file name addr
    181c:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1821:	e8 2a f9 ff ff       	call   1150 <open@plt>
    1826:	0f b6 d0             	movzx  edx,al fd as val
    1829:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd highest instruction byte
    182d:	0f b6 c8             	movzx  ecx,al 2nd highest instruction byte
    1830:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1834:	89 ce                	mov    esi,ecx 2nd highest instruction byte as reg num
    1836:	48 89 c7             	mov    rdi,rax vm buf addr
    1839:	e8 05 fb ff ff       	call   1343 <sleep@plt+0x1d3> write register
    183e:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] read: lowest instruction byte
    1842:	0f b6 c0             	movzx  eax,al lowest instruction byte
    1845:	83 e0 04             	and    eax,0x4 lowest instruction byte 0x4?
    1848:	85 c0                	test   eax,eax not 0x4?
    184a:	0f 84 89 00 00 00    	je     18d9 <sleep@plt+0x769> not 0x4 jump read2
    1850:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1854:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    185b:	0f b6 c0             	movzx  eax,al reg b val
    185e:	ba 00 01 00 00       	mov    edx,0x100
    1863:	29 c2                	sub    edx,eax 0x100-reg b val => whole - reg byte val
    1865:	89 d0                	mov    eax,edx whole-b
    1867:	48 63 d0             	movsxd rdx,eax sign ext whole-b  => only relevant if negative
    186a:	48 89 d0             	mov    rax,rdx whole-b
    186d:	48 01 c0             	add    rax,rax 2*(whole-b)
    1870:	48 01 c2             	add    rdx,rax 3*(whole-b)
    1873:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1877:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    187e:	0f b6 c0             	movzx  eax,al reg c val
    1881:	48 39 c2             	cmp    rdx,rax 3*(whole-b) cmp to reg c val
    1884:	48 0f 46 c2          	cmovbe rax,rdx 3*(whole-b) if <= reg c val else reg c val
    1888:	48 89 c1             	mov    rcx,rax reg c val
    188b:	48 8b 75 d8          	mov    rsi,QWORD PTR [rbp-0x28] vm buf addr
    188f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1893:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    189a:	0f b6 d0             	movzx  edx,al reg b val
    189d:	48 89 d0             	mov    rax,rdx reg b val
    18a0:	48 01 c0             	add    rax,rax 2*reg b val
    18a3:	48 01 d0             	add    rax,rdx 3*reg b val
    18a6:	48 01 c6             	add    rsi,rax vm buf addr+3*reg b val as inbuf addr
    18a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    18ad:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    18b4:	0f b6 c0             	movzx  eax,al
    18b7:	48 89 ca             	mov    rdx,rcx reg c val as num bytes read
    18ba:	89 c7                	mov    edi,eax reg a val as fd
    18bc:	e8 5f f8 ff ff       	call   1120 <read@plt>
    18c1:	0f b6 d0             	movzx  edx,al num bytes read as val
    18c4:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd highest instruction byte
    18c8:	0f b6 c8             	movzx  ecx,al 2nd highest instruction byte
    18cb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    18cf:	89 ce                	mov    esi,ecx 2nd highest instruction byte as reg num
    18d1:	48 89 c7             	mov    rdi,rax vm buf addr
    18d4:	e8 6a fa ff ff       	call   1343 <sleep@plt+0x1d3> write register
    18d9:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] read2: lowest instruction byte
    18dd:	0f b6 c0             	movzx  eax,al lowest instruction byte
    18e0:	83 e0 08             	and    eax,0x8 lowest instruction byte 0x8?
    18e3:	85 c0                	test   eax,eax not 0x8?
    18e5:	0f 84 8a 00 00 00    	je     1975 <sleep@plt+0x805> no 0x8 jump write
    18eb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    18ef:	48 8d 90 00 03 00 00 	lea    rdx,[rax+0x300] stack base addr
    18f6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    18fa:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    1901:	0f b6 c0             	movzx  eax,al reg b val
    1904:	48 01 d0             	add    rax,rdx stack base addr+reg b val
    1907:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax stack base addr+reg b val
    190b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    190f:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    1916:	0f b6 c0             	movzx  eax,al reg b val
    1919:	ba 00 01 00 00       	mov    edx,0x100
    191e:	29 c2                	sub    edx,eax 0x100-reg b val => whole - reg byte val
    1920:	89 d0                	mov    eax,edx whole-b
    1922:	48 63 d0             	movsxd rdx,eax whole-b
    1925:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1929:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    1930:	0f b6 c0             	movzx  eax,al reg c val
    1933:	48 39 c2             	cmp    rdx,rax whole-b cmp to reg c val
    1936:	48 0f 46 c2          	cmovbe rax,rdx whole-b if <= reg c val else reg c val
    193a:	88 45 ee             	mov    BYTE PTR [rbp-0x12],al reg c val
    193d:	0f b6 55 ee          	movzx  edx,BYTE PTR [rbp-0x12] reg c val as num bytes read
    1941:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1945:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    194c:	0f b6 c0             	movzx  eax,al reg a val
    194f:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10] stack base addr+reg b val
    1953:	48 89 ce             	mov    rsi,rcx stack base addr+reg b val as inbuf addr
    1956:	89 c7                	mov    edi,eax reg a val as fd
    1958:	e8 c3 f7 ff ff       	call   1120 <read@plt>
    195d:	0f b6 d0             	movzx  edx,al num bytes read
    1960:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd highest instruction byte
    1964:	0f b6 c8             	movzx  ecx,al 2nd highest instruction byte
    1967:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    196b:	89 ce                	mov    esi,ecx 2nd highest instruction byte as reg num
    196d:	48 89 c7             	mov    rdi,rax vm buf addr
    1970:	e8 ce f9 ff ff       	call   1343 <sleep@plt+0x1d3> write register
    1975:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] write: lowest instruction byte
    1979:	0f b6 c0             	movzx  eax,al lowest instruction byte
    197c:	83 e0 10             	and    eax,0x10 lowest instruction byte 0x10?
    197f:	85 c0                	test   eax,eax not 0x10?
    1981:	0f 84 8a 00 00 00    	je     1a11 <sleep@plt+0x8a1> not 0x10 jump sleep
    1987:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    198b:	48 8d 90 00 03 00 00 	lea    rdx,[rax+0x300] stack base addr
    1992:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1996:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    199d:	0f b6 c0             	movzx  eax,al reg b val
    19a0:	48 01 d0             	add    rax,rdx stack base addr+reg b val
    19a3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax stack base addr+reg b val
    19a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    19ab:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    19b2:	0f b6 c0             	movzx  eax,al reg b val
    19b5:	ba 00 01 00 00       	mov    edx,0x100
    19ba:	29 c2                	sub    edx,eax 0x100 - reg b val => whole - reg byte val
    19bc:	89 d0                	mov    eax,edx whole-b
    19be:	48 63 d0             	movsxd rdx,eax whole-b
    19c1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    19c5:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    19cc:	0f b6 c0             	movzx  eax,al reg c val
    19cf:	48 39 c2             	cmp    rdx,rax whole-b cmp to reg c val
    19d2:	48 0f 46 c2          	cmovbe rax,rdx whole-b if <= reg c val else reg c val
    19d6:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al reg c val
    19d9:	0f b6 55 ef          	movzx  edx,BYTE PTR [rbp-0x11] reg c val as num bytes written
    19dd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    19e1:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    19e8:	0f b6 c0             	movzx  eax,al reg a val
    19eb:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] stack base addr+reg b val
    19ef:	48 89 ce             	mov    rsi,rcx stack base addr+reg b val as outbuf addr
    19f2:	89 c7                	mov    edi,eax reg a val as fd
    19f4:	e8 f7 f6 ff ff       	call   10f0 <write@plt>
    19f9:	0f b6 d0             	movzx  edx,al num bytes written as val
    19fc:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd highest instruction byte
    1a00:	0f b6 c8             	movzx  ecx,al 2nd highest instruction byte
    1a03:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1a07:	89 ce                	mov    esi,ecx 2nd highest instruction byte as reg num
    1a09:	48 89 c7             	mov    rdi,rax vm buf addr
    1a0c:	e8 32 f9 ff ff       	call   1343 <sleep@plt+0x1d3> write register
    1a11:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] sleep: lowest instruction byte
    1a15:	0f b6 c0             	movzx  eax,al lowest instruction byte
    1a18:	83 e0 20             	and    eax,0x20 lowest instruction byte 0x20?
    1a1b:	85 c0                	test   eax,eax not 0x20?
    1a1d:	74 2d                	je     1a4c <sleep@plt+0x8dc> not 0x20 jump exit
    1a1f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1a23:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    1a2a:	0f b6 c0             	movzx  eax,al reg a val
    1a2d:	89 c7                	mov    edi,eax reg a val as time
    1a2f:	e8 3c f7 ff ff       	call   1170 <sleep@plt>
    1a34:	0f b6 d0             	movzx  edx,al time slept as val
    1a37:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd highest instruction byte
    1a3b:	0f b6 c8             	movzx  ecx,al 2nd highest instruction byte
    1a3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1a42:	89 ce                	mov    esi,ecx 2nd highest instruction byte as reg num
    1a44:	48 89 c7             	mov    rdi,rax vm buf addr
    1a47:	e8 f7 f8 ff ff       	call   1343 <sleep@plt+0x1d3> write register
    1a4c:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] exit: lowest instruction byte
    1a50:	0f b6 c0             	movzx  eax,al lowest instruction byte
    1a53:	83 e0 02             	and    eax,0x2 lowest instruction byte 0x2?
    1a56:	85 c0                	test   eax,eax not 0x2?
    1a58:	74 15                	je     1a6f <sleep@plt+0x8ff> not 0x2 jump end
    1a5a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm buf addr
    1a5e:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    1a65:	0f b6 c0             	movzx  eax,al reg a val
    1a68:	89 c7                	mov    edi,eax reg a val as exit code
    1a6a:	e8 f1 f6 ff ff       	call   1160 <exit@plt>
    1a6f:	90                   	nop end:
    1a70:	c9                   	leave clean up stack
    1a71:	c3                   	ret

interpret_instruction:
    1a72:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1a76:	55                   	push   rbp save current stack frame
    1a77:	48 89 e5             	mov    rbp,rsp new stack frame
    1a7a:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1a7e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm buf addr
    1a82:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instruction
    1a86:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] write register: highest instruction byte
    1a8a:	0f b6 c0             	movzx  eax,al highest instruction byte
    1a8d:	83 e0 04             	and    eax,0x4 highest instruction byte 0x4?
    1a90:	85 c0                	test   eax,eax not 0x4?
    1a92:	74 10                	je     1aa4 <sleep@plt+0x934> not 0x4 jump add
    1a94:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1a98:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1a9c:	48 89 c7             	mov    rdi,rax vm buf addr
    1a9f:	e8 bb f9 ff ff       	call   145f <sleep@plt+0x2ef> interpret write register
    1aa4:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] add: highest instruction byte
    1aa8:	0f b6 c0             	movzx  eax,al highest instruction byte
    1aab:	83 e0 20             	and    eax,0x20 highest instruction byte 0x20?
    1aae:	85 c0                	test   eax,eax not 0x20?
    1ab0:	74 10                	je     1ac2 <sleep@plt+0x952> not 0x20 jump push_pop_stack
    1ab2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1ab6:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1aba:	48 89 c7             	mov    rdi,rax vm buf addr
    1abd:	e8 d0 f9 ff ff       	call   1492 <sleep@plt+0x322> interpret add
    1ac2:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] push_pop_stack: highest instruction byte
    1ac6:	0f b6 c0             	movzx  eax,al highest instruction byte
    1ac9:	83 e0 01             	and    eax,0x1 highest instruction byte 0x1?
    1acc:	85 c0                	test   eax,eax not 0x1?
    1ace:	74 10                	je     1ae0 <sleep@plt+0x970> not 0x1 jump stmt
    1ad0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1ad4:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1ad8:	48 89 c7             	mov    rdi,rax vm buf addr
    1adb:	e8 15 fa ff ff       	call   14f5 <sleep@plt+0x385> interpret_push_pop_stack
    1ae0:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] stmt: highest instruction byte
    1ae4:	0f b6 c0             	movzx  eax,al highest instruction byte
    1ae7:	83 e0 08             	and    eax,0x8 highest instruction byte 0x8?
    1aea:	85 c0                	test   eax,eax not 0x8?
    1aec:	74 10                	je     1afe <sleep@plt+0x98e> not 0x8 jump memory to register
    1aee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1af2:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1af6:	48 89 c7             	mov    rdi,rax vm buf addr
    1af9:	e8 b6 fa ff ff       	call   15b4 <sleep@plt+0x444> interpret stmt
    1afe:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] memory to register: highest instruction byte
    1b02:	0f b6 c0             	movzx  eax,al highest instruction byte
    1b05:	83 e0 10             	and    eax,0x10 highest instruction byte 0x10?
    1b08:	85 c0                	test   eax,eax not 0x10?
    1b0a:	74 10                	je     1b1c <sleep@plt+0x9ac> not 0x10 jump test
    1b0c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1b10:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] isntruction
    1b14:	48 89 c7             	mov    rdi,rax vm buf addr
    1b17:	e8 f5 fa ff ff       	call   1611 <sleep@plt+0x4a1> interpret memory to register
    1b1c:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] test: highest instruction byte
    1b20:	84 c0                	test   al,al highest instruction byte negative?
    1b22:	79 10                	jns    1b34 <sleep@plt+0x9c4> not negative jump set f flag based
    1b24:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1b28:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1b2c:	48 89 c7             	mov    rdi,rax vm bfu addr
    1b2f:	e8 32 fb ff ff       	call   1666 <sleep@plt+0x4f6> interpret_test
    1b34:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] interpret conditional jump: highest instruction byte
    1b38:	0f b6 c0             	movzx  eax,al highest instruction byte
    1b3b:	83 e0 40             	and    eax,0x40 highest instruction byte 0x40?
    1b3e:	85 c0                	test   eax,eax not 0x40?
    1b40:	74 10                	je     1b52 <sleep@plt+0x9e2> not 0x40 jump sys
    1b42:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1b46:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1b4a:	48 89 c7             	mov    rdi,rax vm buf addr
    1b4d:	e8 18 fc ff ff       	call   176a <sleep@plt+0x5fa> interpret_conditional_jump
    1b52:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] sys: highest instruction byte
    1b56:	0f b6 c0             	movzx  eax,al highest instruction byte
    1b59:	83 e0 02             	and    eax,0x2 highest instruction byte 0x2?
    1b5c:	85 c0                	test   eax,eax not 0x2?
    1b5e:	74 10                	je     1b70 <sleep@plt+0xa00> not 0x2 jump end
    1b60:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1b64:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instruction
    1b68:	48 89 c7             	mov    rdi,rax vm buf addr
    1b6b:	e8 4d fc ff ff       	call   17bd <sleep@plt+0x64d> interpret sys
    1b70:	90                   	nop end:
    1b71:	c9                   	leave clean up stack
    1b72:	c3                   	ret

interpreter_loop:
    1b73:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1b77:	55                   	push   rbp save current stack frame
    1b78:	48 89 e5             	mov    rbp,rsp new stack frame
    1b7b:	48 83 ec 20          	sub    rsp,0x20 allo local vars
    1b7f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm buf addr
    1b83:	48 8d 3d ae 04 00 00 	lea    rdi,[rip+0x4ae] interpreter loop str addr # 2038 <sleep@plt+0xec8>
    1b8a:	e8 51 f5 ff ff       	call   10e0 <puts@plt> print str
    1b8f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] loop: vm buf addr
    1b93:	0f b6 80 05 04 00 00 	movzx  eax,BYTE PTR [rax+0x405] reg f as counter init value 0 since entire buffer was zeroed in main
    1b9a:	8d 48 01             	lea    ecx,[rax+0x1] counter+1
    1b9d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18] vm buf addr
    1ba1:	88 8a 05 04 00 00    	mov    BYTE PTR [rdx+0x405],cl inc counter
    1ba7:	0f b6 c0             	movzx  eax,al counter
    1baa:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18] vm buf addr
    1bae:	48 63 d0             	movsxd rdx,eax counter
    1bb1:	48 89 d0             	mov    rax,rdx counter
    1bb4:	48 01 c0             	add    rax,rax 2*counter
    1bb7:	48 01 d0             	add    rax,rdx 3*counter
    1bba:	48 01 c8             	add    rax,rcx vm buf addr+3*counter aka next instruction addr
    1bbd:	0f b7 10             	movzx  edx,WORD PTR [rax] 2 bytes of copied instruction
    1bc0:	66 89 55 fd          	mov    WORD PTR [rbp-0x3],dx 2 bytes of copied instruction
    1bc4:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2] 1 more byte of copied instruction
    1bc8:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al 1 more byte of copied instruction
    1bcb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm buf addr
    1bcf:	0f b6 55 fd          	movzx  edx,BYTE PTR [rbp-0x3] first byte of copied instruction
    1bd3:	0f b6 4d fe          	movzx  ecx,BYTE PTR [rbp-0x2] second byte of copied instruction
    1bd7:	48 c1 e1 08          	shl    rcx,0x8 second byte of copied instruction to high part of ecx
    1bdb:	48 09 d1             	or     rcx,rdx first byte of copied instruction to low part of ecx
    1bde:	0f b6 55 ff          	movzx  edx,BYTE PTR [rbp-0x1] third byte of copied instruction
    1be2:	48 c1 e2 10          	shl    rdx,0x10 high part of edx
    1be6:	48 09 ca             	or     rdx,rcx edx = 0, 3rd, 2nd, 1st byte
    1be9:	48 89 d6             	mov    rsi,rdx instruction
    1bec:	48 89 c7             	mov    rdi,rax vm buf addr
    1bef:	e8 7e fe ff ff       	call   1a72 <sleep@plt+0x902> interpret instruction
    1bf4:	eb 99                	jmp    1b8f <sleep@plt+0xa1f> jump loop

main:
    1bf6:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1bfa:	55                   	push   rbp save current stack frame
    1bfb:	48 89 e5             	mov    rbp,rsp new stack frame
    1bfe:	48 81 ec 20 04 00 00 	sub    rsp,0x420 alloc local vars
    1c05:	89 bd ec fb ff ff    	mov    DWORD PTR [rbp-0x414],edi argc
    1c0b:	48 89 b5 e0 fb ff ff 	mov    QWORD PTR [rbp-0x420],rsi argv ptr addr
    1c12:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
    1c19:	00 00 
    1c1b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax to stack
    1c1f:	31 c0                	xor    eax,eax
    1c21:	48 8b 85 e0 fb ff ff 	mov    rax,QWORD PTR [rbp-0x420] argv ptr addr
    1c28:	48 8b 00             	mov    rax,QWORD PTR [rax] dereferenced argv addr
    1c2b:	48 89 c6             	mov    rsi,rax argv addr
    1c2e:	48 8d 3d 2d 04 00 00 	lea    rdi,[rip+0x42d] format str # 2062 <sleep@plt+0xef2>
    1c35:	b8 00 00 00 00       	mov    eax,0x0 num vec args used
    1c3a:	e8 d1 f4 ff ff       	call   1110 <printf@plt> print format, argv
    1c3f:	48 8d 3d 32 04 00 00 	lea    rdi,[rip+0x432] str addr # 2078 <sleep@plt+0xf08>
    1c46:	e8 95 f4 ff ff       	call   10e0 <puts@plt> print str addr
    1c4b:	48 8d 3d 76 04 00 00 	lea    rdi,[rip+0x476] str addr # 20c8 <sleep@plt+0xf58>
    1c52:	e8 89 f4 ff ff       	call   10e0 <puts@plt> print str addr
    1c57:	48 8d 3d b2 04 00 00 	lea    rdi,[rip+0x4b2] str addr # 2110 <sleep@plt+0xfa0>
    1c5e:	e8 7d f4 ff ff       	call   10e0 <puts@plt> print str
    1c63:	48 8d 3d f6 04 00 00 	lea    rdi,[rip+0x4f6] str addr # 2160 <sleep@plt+0xff0>
    1c6a:	e8 71 f4 ff ff       	call   10e0 <puts@plt> print str
    1c6f:	48 8d 3d 3a 05 00 00 	lea    rdi,[rip+0x53a] str addr # 21b0 <sleep@plt+0x1040>
    1c76:	e8 65 f4 ff ff       	call   10e0 <puts@plt> print str
    1c7b:	48 8d 3d 6b 05 00 00 	lea    rdi,[rip+0x56b] str addr # 21ed <sleep@plt+0x107d>
    1c82:	e8 59 f4 ff ff       	call   10e0 <puts@plt> print str
    1c87:	48 8d 3d 6a 05 00 00 	lea    rdi,[rip+0x56a] str addr # 21f8 <sleep@plt+0x1088>
    1c8e:	e8 4d f4 ff ff       	call   10e0 <puts@plt> print str
    1c93:	48 8d 3d ae 05 00 00 	lea    rdi,[rip+0x5ae] str addr # 2248 <sleep@plt+0x10d8>
    1c9a:	e8 41 f4 ff ff       	call   10e0 <puts@plt> print str
    1c9f:	48 8b 05 3a 26 00 00 	mov    rax,QWORD PTR [rip+0x263a] stdout file addr # 42e0 <stdout@GLIBC_2.2.5>
    1ca6:	b9 01 00 00 00       	mov    ecx,0x1 buf size
    1cab:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    1cb0:	be 00 00 00 00       	mov    esi,0x0 buf addr
    1cb5:	48 89 c7             	mov    rdi,rax stdout file addr
    1cb8:	e8 83 f4 ff ff       	call   1140 <setvbuf@plt> set stdout to unbuffered
    1cbd:	48 8d 95 f0 fb ff ff 	lea    rdx,[rbp-0x410] vm buf addr
    1cc4:	b8 00 00 00 00       	mov    eax,0x0 value
    1cc9:	b9 80 00 00 00       	mov    ecx,0x80
    1cce:	48 89 d7             	mov    rdi,rdx vm buf addr
    1cd1:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax zero 128*8=1024 bytes of vm buf
    1cd4:	48 89 fa             	mov    rdx,rdi vm buf addr+0x400
    1cd7:	89 02                	mov    DWORD PTR [rdx],eax zero 4 additional bytes of vm buf
    1cd9:	48 83 c2 04          	add    rdx,0x4 vm buf addr+0x404
    1cdd:	66 89 02             	mov    WORD PTR [rdx],ax zero 2 additional bytes of vm buf
    1ce0:	48 83 c2 02          	add    rdx,0x2 vm buf addr+0x406
    1ce4:	88 02                	mov    BYTE PTR [rdx],al zero 1 additional byte of vm buf
    1ce6:	48 83 c2 01          	add    rdx,0x1 vm buf addr+0x407 => zeroes the entire vm buf including all vm registers excluding the stack guard canary
    1cea:	8b 05 e4 25 00 00    	mov    eax,DWORD PTR [rip+0x25e4] constant 0x2b2 # 42d4 <sleep@plt+0x3164>
    1cf0:	89 c2                	mov    edx,eax 0x2b2 num bytes to copy
    1cf2:	48 8d 85 f0 fb ff ff 	lea    rax,[rbp-0x410] dst vm buf addr
    1cf9:	48 8d 35 20 23 00 00 	lea    rsi,[rip+0x2320] src addr # 4020 <sleep@plt+0x2eb0>
    1d00:	48 89 c7             	mov    rdi,rax vm buf addr
    1d03:	e8 28 f4 ff ff       	call   1130 <memcpy@plt>
    1d08:	48 8b 05 f1 25 00 00 	mov    rax,QWORD PTR [rip+0x25f1]        # 4300 <stdout@GLIBC_2.2.5+0x20>
    1d0f:	48 8b 15 f2 25 00 00 	mov    rdx,QWORD PTR [rip+0x25f2]        # 4308 <stdout@GLIBC_2.2.5+0x28>
    1d16:	48 89 85 f0 fe ff ff 	mov    QWORD PTR [rbp-0x110],rax
    1d1d:	48 89 95 f8 fe ff ff 	mov    QWORD PTR [rbp-0x108],rdx
    1d24:	48 8b 05 e5 25 00 00 	mov    rax,QWORD PTR [rip+0x25e5]        # 4310 <stdout@GLIBC_2.2.5+0x30>
    1d2b:	48 8b 15 e6 25 00 00 	mov    rdx,QWORD PTR [rip+0x25e6]        # 4318 <stdout@GLIBC_2.2.5+0x38>
    1d32:	48 89 85 00 ff ff ff 	mov    QWORD PTR [rbp-0x100],rax
    1d39:	48 89 95 08 ff ff ff 	mov    QWORD PTR [rbp-0xf8],rdx
    1d40:	48 8b 05 d9 25 00 00 	mov    rax,QWORD PTR [rip+0x25d9]        # 4320 <stdout@GLIBC_2.2.5+0x40>
    1d47:	48 8b 15 da 25 00 00 	mov    rdx,QWORD PTR [rip+0x25da]        # 4328 <stdout@GLIBC_2.2.5+0x48>
    1d4e:	48 89 85 10 ff ff ff 	mov    QWORD PTR [rbp-0xf0],rax
    1d55:	48 89 95 18 ff ff ff 	mov    QWORD PTR [rbp-0xe8],rdx
    1d5c:	48 8b 05 cd 25 00 00 	mov    rax,QWORD PTR [rip+0x25cd]        # 4330 <stdout@GLIBC_2.2.5+0x50>
    1d63:	48 8b 15 ce 25 00 00 	mov    rdx,QWORD PTR [rip+0x25ce]        # 4338 <stdout@GLIBC_2.2.5+0x58>
    1d6a:	48 89 85 20 ff ff ff 	mov    QWORD PTR [rbp-0xe0],rax
    1d71:	48 89 95 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdx
    1d78:	48 8b 05 c1 25 00 00 	mov    rax,QWORD PTR [rip+0x25c1]        # 4340 <stdout@GLIBC_2.2.5+0x60>
    1d7f:	48 8b 15 c2 25 00 00 	mov    rdx,QWORD PTR [rip+0x25c2]        # 4348 <stdout@GLIBC_2.2.5+0x68>
    1d86:	48 89 85 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rax
    1d8d:	48 89 95 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdx
    1d94:	48 8b 05 b5 25 00 00 	mov    rax,QWORD PTR [rip+0x25b5]        # 4350 <stdout@GLIBC_2.2.5+0x70>
    1d9b:	48 8b 15 b6 25 00 00 	mov    rdx,QWORD PTR [rip+0x25b6]        # 4358 <stdout@GLIBC_2.2.5+0x78>
    1da2:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
    1da9:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    1db0:	48 8b 05 a9 25 00 00 	mov    rax,QWORD PTR [rip+0x25a9]        # 4360 <stdout@GLIBC_2.2.5+0x80>
    1db7:	48 8b 15 aa 25 00 00 	mov    rdx,QWORD PTR [rip+0x25aa]        # 4368 <stdout@GLIBC_2.2.5+0x88>
    1dbe:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
    1dc5:	48 89 95 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdx
    1dcc:	48 8b 05 9d 25 00 00 	mov    rax,QWORD PTR [rip+0x259d]        # 4370 <stdout@GLIBC_2.2.5+0x90>
    1dd3:	48 8b 15 9e 25 00 00 	mov    rdx,QWORD PTR [rip+0x259e]        # 4378 <stdout@GLIBC_2.2.5+0x98>
    1dda:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
    1de1:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
    1de8:	48 8b 05 91 25 00 00 	mov    rax,QWORD PTR [rip+0x2591]        # 4380 <stdout@GLIBC_2.2.5+0xa0>
    1def:	48 8b 15 92 25 00 00 	mov    rdx,QWORD PTR [rip+0x2592]        # 4388 <stdout@GLIBC_2.2.5+0xa8>
    1df6:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
    1dfd:	48 89 95 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdx
    1e04:	48 8b 05 85 25 00 00 	mov    rax,QWORD PTR [rip+0x2585]        # 4390 <stdout@GLIBC_2.2.5+0xb0>
    1e0b:	48 8b 15 86 25 00 00 	mov    rdx,QWORD PTR [rip+0x2586]        # 4398 <stdout@GLIBC_2.2.5+0xb8>
    1e12:	48 89 45 80          	mov    QWORD PTR [rbp-0x80],rax
    1e16:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    1e1a:	48 8b 05 7f 25 00 00 	mov    rax,QWORD PTR [rip+0x257f]        # 43a0 <stdout@GLIBC_2.2.5+0xc0>
    1e21:	48 8b 15 80 25 00 00 	mov    rdx,QWORD PTR [rip+0x2580]        # 43a8 <stdout@GLIBC_2.2.5+0xc8>
    1e28:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
    1e2c:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    1e30:	48 8b 05 79 25 00 00 	mov    rax,QWORD PTR [rip+0x2579]        # 43b0 <stdout@GLIBC_2.2.5+0xd0>
    1e37:	48 8b 15 7a 25 00 00 	mov    rdx,QWORD PTR [rip+0x257a]        # 43b8 <stdout@GLIBC_2.2.5+0xd8>
    1e3e:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    1e42:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1e46:	48 8b 05 73 25 00 00 	mov    rax,QWORD PTR [rip+0x2573]        # 43c0 <stdout@GLIBC_2.2.5+0xe0>
    1e4d:	48 8b 15 74 25 00 00 	mov    rdx,QWORD PTR [rip+0x2574]        # 43c8 <stdout@GLIBC_2.2.5+0xe8>
    1e54:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
    1e58:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    1e5c:	48 8b 05 6d 25 00 00 	mov    rax,QWORD PTR [rip+0x256d]        # 43d0 <stdout@GLIBC_2.2.5+0xf0>
    1e63:	48 8b 15 6e 25 00 00 	mov    rdx,QWORD PTR [rip+0x256e]        # 43d8 <stdout@GLIBC_2.2.5+0xf8>
    1e6a:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    1e6e:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    1e72:	48 8b 05 67 25 00 00 	mov    rax,QWORD PTR [rip+0x2567]        # 43e0 <stdout@GLIBC_2.2.5+0x100>
    1e79:	48 8b 15 68 25 00 00 	mov    rdx,QWORD PTR [rip+0x2568]        # 43e8 <stdout@GLIBC_2.2.5+0x108>
    1e80:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    1e84:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    1e88:	48 8b 05 61 25 00 00 	mov    rax,QWORD PTR [rip+0x2561]        # 43f0 <stdout@GLIBC_2.2.5+0x110>
    1e8f:	48 8b 15 62 25 00 00 	mov    rdx,QWORD PTR [rip+0x2562]        # 43f8 <stdout@GLIBC_2.2.5+0x118>
    1e96:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1e9a:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx zero 256 bytes vm buf rbp-0x110 to 0x10 => vm buf addr+0x300 to 0x400
    1e9e:	48 8d 85 f0 fb ff ff 	lea    rax,[rbp-0x410] vm buf addr
    1ea5:	48 89 c7             	mov    rdi,rax vm buf addr
    1ea8:	e8 c6 fc ff ff       	call   1b73 <sleep@plt+0xa03> interpreter_loop
    1ead:	b8 00 00 00 00       	mov    eax,0x0 return value
    1eb2:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] current canary from stack
    1eb6:	64 48 33 0c 25 28 00 	xor    rcx,QWORD PTR fs:0x28 eq expected stack guard canary?
    1ebd:	00 00 
    1ebf:	74 05                	je     1ec6 <sleep@plt+0xd56> canary correct jump clean up stack
    1ec1:	e8 3a f2 ff ff       	call   1100 <__stack_chk_fail@plt> fail due to corrupted stack
    1ec6:	c9                   	leave clean up stack:
    1ec7:	c3                   	ret
