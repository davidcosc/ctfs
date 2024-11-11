Disassembly of section .text:

0000000000001180 <.text>:
crash:
    1269:	f3 0f 1e fa          	endbr64 allow indirect jumps
    126d:	55                   	push   rbp save current stack frame
    126e:	48 89 e5             	mov    rbp,rsp create new stack frame
    1271:	48 83 ec 10          	sub    rsp,0x10 allo local vars
    1275:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi err str addr
    1279:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] err str addr
    127d:	48 89 c6             	mov    rsi,rax err str addr
    1280:	48 8d 3d 81 0d 00 00 	lea    rdi,[rip+0xd81] format str addr # 2008 <sleep@plt+0xe98>
    1287:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    128c:	e8 7f fe ff ff       	call   1110 <printf@plt> print format err
    1291:	bf 01 00 00 00       	mov    edi,0x1 exit code
    1296:	e8 c5 fe ff ff       	call   1160 <exit@plt>

read_reg:
    129b:	f3 0f 1e fa          	endbr64 allow indirect jumps
    129f:	55                   	push   rbp save current stack frame
    12a0:	48 89 e5             	mov    rbp,rsp create new stack frame
    12a3:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    12a7:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    12ab:	89 f0                	mov    eax,esi reg num
    12ad:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al reg num
    12b0:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 reg a:
    12b4:	75 0d                	jne    12c3 <sleep@plt+0x153> not reg num 0x8 jump reg b
    12b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    12ba:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    12c1:	eb 7e                	jmp    1341 <sleep@plt+0x1d1> jump end
    12c3:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10  reg b:
    12c7:	75 0d                	jne    12d6 <sleep@plt+0x166> not reg num 0x10 jump reg c
    12c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    12cd:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    12d4:	eb 6b                	jmp    1341 <sleep@plt+0x1d1> jump end
    12d6:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 reg c:
    12da:	75 0d                	jne    12e9 <sleep@plt+0x179> not reg num 0x1 jump reg d
    12dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    12e0:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    12e7:	eb 58                	jmp    1341 <sleep@plt+0x1d1> jump end
    12e9:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 reg d:
    12ed:	75 0d                	jne    12fc <sleep@plt+0x18c> not reg num 0x40 jump reg e
    12ef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    12f3:	0f b6 80 03 04 00 00 	movzx  eax,BYTE PTR [rax+0x403] reg d val
    12fa:	eb 45                	jmp    1341 <sleep@plt+0x1d1> jump end
    12fc:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 reg e:
    1300:	75 0d                	jne    130f <sleep@plt+0x19f> not reg num 0x20 jump reg f
    1302:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm buf addr
    1306:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg 3 val
    130d:	eb 32                	jmp    1341 <sleep@plt+0x1d1> jump end
    130f:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 reg f:
    1313:	75 0d                	jne    1322 <sleep@plt+0x1b2> not reg num 0x4 jump reg g
    1315:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1319:	0f b6 80 05 04 00 00 	movzx  eax,BYTE PTR [rax+0x405] reg f val
    1320:	eb 1f                	jmp    1341 <sleep@plt+0x1d1> jump end
    1322:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 reg g:
    1326:	75 0d                	jne    1335 <sleep@plt+0x1c5> not reg num 0x2 jump unknown reg
    1328:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    132c:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1333:	eb 0c                	jmp    1341 <sleep@plt+0x1d1> jump end
    1335:	48 8d 3d e8 0c 00 00 	lea    rdi,[rip+0xce8] unknown reg: str addr# 2024 <sleep@plt+0xeb4>
    133c:	e8 28 ff ff ff       	call   1269 <sleep@plt+0xf9> crash
    1341:	c9                   	leave end: clean up stack
    1342:	c3                   	ret

write_reg:
    1343:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1347:	55                   	push   rbp save current stack frame
    1348:	48 89 e5             	mov    rbp,rsp create new stack frame
    134b:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    134f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    1353:	89 f1                	mov    ecx,esi 1st instr byte
    1355:	89 d0                	mov    eax,edx 2nd instr byte
    1357:	89 ca                	mov    edx,ecx 1st instr byte
    1359:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl 1st instr byte as reg num
    135c:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al 2nd instr byte as reg val
    135f:	80 7d f4 08          	cmp    BYTE PTR [rbp-0xc],0x8 reg a:
    1363:	75 13                	jne    1378 <sleep@plt+0x208> not reg num 0x8 jump reg b
    1365:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1369:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    136d:	88 90 00 04 00 00    	mov    BYTE PTR [rax+0x400],dl reg val to reg a addr
    1373:	e9 90 00 00 00       	jmp    1408 <sleep@plt+0x298> jump end
    1378:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10 reg b:
    137c:	75 10                	jne    138e <sleep@plt+0x21e> not reg num 0x10 jump reg c
    137e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1382:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    1386:	88 90 01 04 00 00    	mov    BYTE PTR [rax+0x401],dl reg val to reg b addr
    138c:	eb 7a                	jmp    1408 <sleep@plt+0x298> jump end
    138e:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1 reg c:
    1392:	75 10                	jne    13a4 <sleep@plt+0x234> not reg num 0x1 jump reg d
    1394:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1398:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    139c:	88 90 02 04 00 00    	mov    BYTE PTR [rax+0x402],dl reg val to reg c addr
    13a2:	eb 64                	jmp    1408 <sleep@plt+0x298> jump end
    13a4:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40 reg d:
    13a8:	75 10                	jne    13ba <sleep@plt+0x24a> not reg num 0x40 jump reg e
    13aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    13ae:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    13b2:	88 90 03 04 00 00    	mov    BYTE PTR [rax+0x403],dl reg val to reg d addr
    13b8:	eb 4e                	jmp    1408 <sleep@plt+0x298> jump end
    13ba:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20 reg e:
    13be:	75 10                	jne    13d0 <sleep@plt+0x260> not reg num 0x20 jump reg f
    13c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    13c4:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    13c8:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl reg val to reg e addr
    13ce:	eb 38                	jmp    1408 <sleep@plt+0x298> jump end
    13d0:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4 reg f:
    13d4:	75 10                	jne    13e6 <sleep@plt+0x276> not reg num 0x4 jump reg g
    13d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    13da:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    13de:	88 90 05 04 00 00    	mov    BYTE PTR [rax+0x405],dl reg val to reg f addr
    13e4:	eb 22                	jmp    1408 <sleep@plt+0x298> jump end
    13e6:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2 reg g:
    13ea:	75 10                	jne    13fc <sleep@plt+0x28c> not reg num 0x2 jump unknown reg
    13ec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    13f0:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10] reg val
    13f4:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg val to reg g addr
    13fa:	eb 0c                	jmp    1408 <sleep@plt+0x298> jump end
    13fc:	48 8d 3d 21 0c 00 00 	lea    rdi,[rip+0xc21] unknown reg: str addr # 2024 <sleep@plt+0xeb4>
    1403:	e8 61 fe ff ff       	call   1269 <sleep@plt+0xf9> crash
    1408:	c9                   	leave end: clean up stack
    1409:	c3                   	ret

read_mem:
    140a:	f3 0f 1e fa          	endbr64 allow indirect jumps
    140e:	55                   	push   rbp save current stack frame
    140f:	48 89 e5             	mov    rbp,rsp create new stack frame
    1412:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    1416:	89 f0                	mov    eax,esi offset
    1418:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al offset
    141b:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] offset
    141f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm mem addr
    1423:	48 98                	cdqe
    1425:	0f b6 84 02 00 03 00 	movzx  eax,BYTE PTR [rdx+rax*1+0x300] val at vm mem addr + offset + 0x300
    142c:	00 
    142d:	5d                   	pop    rbp restore prev stack frame
    142e:	c3                   	ret

write_mem:
    142f:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1433:	55                   	push   rbp save current stack frame
    1434:	48 89 e5             	mov    rbp,rsp create new stack frame
    1437:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    143b:	89 f1                	mov    ecx,esi offset
    143d:	89 d0                	mov    eax,edx val
    143f:	89 ca                	mov    edx,ecx offset
    1441:	88 55 f4             	mov    BYTE PTR [rbp-0xc],dl offset
    1444:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al val
    1447:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc] offset
    144b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm mem addr
    144f:	48 98                	cdqe
    1451:	0f b6 4d f0          	movzx  ecx,BYTE PTR [rbp-0x10] val
    1455:	88 8c 02 00 03 00 00 	mov    BYTE PTR [rdx+rax*1+0x300],cl val to vm mem addr + offset + 300
    145c:	90                   	nop
    145d:	5d                   	pop    rbp restore prev stack frame
    145e:	c3                   	ret

inter_write_reg::
    145f:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1463:	55                   	push   rbp save current stack frame
    1464:	48 89 e5             	mov    rbp,rsp create new stack frame
    1467:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    146b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    146f:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instr
    1473:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd instr byte
    1477:	0f b6 d0             	movzx  edx,al 2nd instr byte as arg 3
    147a:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] 1st instr byte
    147e:	0f b6 c8             	movzx  ecx,al 1st instr byte
    1481:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1485:	89 ce                	mov    esi,ecx 1st instr byte as arg 2
    1487:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    148a:	e8 b4 fe ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    148f:	90                   	nop
    1490:	c9                   	leave clean up stack
    1491:	c3                   	ret

inter_add:
    1492:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1496:	55                   	push   rbp save current stack frame
    1497:	48 89 e5             	mov    rbp,rsp create new stack frame
    149a:	53                   	push   rbx save rbx
    149b:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    149f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm mem addr
    14a3:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instr
    14a7:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] 1st instr byte
    14ab:	0f b6 d0             	movzx  edx,al 1st instr byte
    14ae:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    14b2:	89 d6                	mov    esi,edx 1st instr byte
    14b4:	48 89 c7             	mov    rdi,rax vm mem addr
    14b7:	e8 df fd ff ff       	call   129b <sleep@plt+0x12b> read_reg
    14bc:	89 c3                	mov    ebx,eax reg 1 val
    14be:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd instr byte
    14c2:	0f b6 d0             	movzx  edx,al 2nd instr byte
    14c5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    14c9:	89 d6                	mov    esi,edx 2nd instr byte
    14cb:	48 89 c7             	mov    rdi,rax vm mem addr
    14ce:	e8 c8 fd ff ff       	call   129b <sleep@plt+0x12b> read_reg
    14d3:	01 d8                	add    eax,ebx reg 2 val + reg 1 val
    14d5:	0f b6 d0             	movzx  edx,al reg 2 val + reg 1 val as arg 3
    14d8:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] 1st instr byte
    14dc:	0f b6 c8             	movzx  ecx,al 1st instr byte
    14df:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    14e3:	89 ce                	mov    esi,ecx 1st instr byte as arg 2
    14e5:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    14e8:	e8 56 fe ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    14ed:	90                   	nop
    14ee:	48 83 c4 18          	add    rsp,0x18 clean up local vars
    14f2:	5b                   	pop    rbx restore rbx
    14f3:	5d                   	pop    rbp restore prev stack frame
    14f4:	c3                   	ret

inter_push_pop:
    14f5:	f3 0f 1e fa          	endbr64 allow indirect jumps
    14f9:	55                   	push   rbp save current stack frame
    14fa:	48 89 e5             	mov    rbp,rsp create new stack frame
    14fd:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1501:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    1505:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instr
    1509:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] push: 2nd instr byte
    150d:	84 c0                	test   al,al
    150f:	74 4c                	je     155d <sleep@plt+0x3ed> 2nd instr byte zero jump pop
    1511:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1515:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    151c:	8d 50 01             	lea    edx,[rax+0x1] reg e val + 1
    151f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1523:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl reg e val + 1 to reg e addr
    1529:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd instr byte
    152d:	0f b6 d0             	movzx  edx,al 2nd instr byte
    1530:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1534:	89 d6                	mov    esi,edx 2nd instr byte as arg 2
    1536:	48 89 c7             	mov    rdi,rax vm mem addr
    1539:	e8 5d fd ff ff       	call   129b <sleep@plt+0x12b> read_reg
    153e:	0f b6 d0             	movzx  edx,al reg val as arg 3
    1541:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1545:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    154c:	0f b6 c8             	movzx  ecx,al reg e val
    154f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1553:	89 ce                	mov    esi,ecx reg e val as arg 2
    1555:	48 89 c7             	mov    rdi,rax vm mem addr
    1558:	e8 d2 fe ff ff       	call   142f <sleep@plt+0x2bf> write_mem
    155d:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] pop: 1st instr byte
    1561:	84 c0                	test   al,al
    1563:	74 4c                	je     15b1 <sleep@plt+0x441> 1st instr byte zero jump end
    1565:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1569:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    1570:	0f b6 d0             	movzx  edx,al reg e val
    1573:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1577:	89 d6                	mov    esi,edx reg e val as arg 2
    1579:	48 89 c7             	mov    rdi,rax vm mem addr
    157c:	e8 89 fe ff ff       	call   140a <sleep@plt+0x29a> read_mem
    1581:	0f b6 d0             	movzx  edx,al mem val as arg 3
    1584:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] 1st instr byte
    1588:	0f b6 c8             	movzx  ecx,al 1st instr byte
    158b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    158f:	89 ce                	mov    esi,ecx 1st instr byte as arg 2
    1591:	48 89 c7             	mov    rdi,rax vm mem addr
    1594:	e8 aa fd ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    1599:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    159d:	0f b6 80 04 04 00 00 	movzx  eax,BYTE PTR [rax+0x404] reg e val
    15a4:	8d 50 ff             	lea    edx,[rax-0x1] reg e val - 1
    15a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    15ab:	88 90 04 04 00 00    	mov    BYTE PTR [rax+0x404],dl reg e val - 1 to reg e addr
    15b1:	90                   	nop end:
    15b2:	c9                   	leave clean up stack
    15b3:	c3                   	ret

inter_reg_to_mem:
    15b4:	f3 0f 1e fa          	endbr64 allow indirect jumps
    15b8:	55                   	push   rbp save current stack frame
    15b9:	48 89 e5             	mov    rbp,rsp create new stack frame
    15bc:	53                   	push   rbx save rbx
    15bd:	48 83 ec 18          	sub    rsp,0x18 alloc local vars
    15c1:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm mem addr
    15c5:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instr
    15c9:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd instr byte
    15cd:	0f b6 d0             	movzx  edx,al 2nd instr byte
    15d0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    15d4:	89 d6                	mov    esi,edx 2nd instr byte as arg 2
    15d6:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    15d9:	e8 bd fc ff ff       	call   129b <sleep@plt+0x12b> read_reg
    15de:	0f b6 d8             	movzx  ebx,al reg 2 val
    15e1:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] 1st instr byte
    15e5:	0f b6 d0             	movzx  edx,al 1st instr byte
    15e8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    15ec:	89 d6                	mov    esi,edx 1st instr byte as arg 2
    15ee:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    15f1:	e8 a5 fc ff ff       	call   129b <sleep@plt+0x12b> read_reg
    15f6:	0f b6 c8             	movzx  ecx,al reg 1 val
    15f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    15fd:	89 da                	mov    edx,ebx reg 2 val as arg 3
    15ff:	89 ce                	mov    esi,ecx reg 1 val as arg 2
    1601:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    1604:	e8 26 fe ff ff       	call   142f <sleep@plt+0x2bf> write_mem
    1609:	90                   	nop
    160a:	48 83 c4 18          	add    rsp,0x18 clean up local vars
    160e:	5b                   	pop    rbx restore rbx
    160f:	5d                   	pop    rbp restore prev stack frame
    1610:	c3                   	ret


inter_mem_to_reg:
    1611:	f3 0f 1e fa          	endbr64 allo indirect jumps
    1615:	55                   	push   rbp save current stack frame
    1616:	48 89 e5             	mov    rbp,rsp create new stack frame
    1619:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    161d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    1621:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instr
    1625:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd instr byte
    1629:	0f b6 d0             	movzx  edx,al 2nd instr byte
    162c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1630:	89 d6                	mov    esi,edx 2nd instr byte
    1632:	48 89 c7             	mov    rdi,rax vm mem addr
    1635:	e8 61 fc ff ff       	call   129b <sleep@plt+0x12b> read_reg
    163a:	0f b6 d0             	movzx  edx,al reg val
    163d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1641:	89 d6                	mov    esi,edx reg val
    1643:	48 89 c7             	mov    rdi,rax vm mem addr
    1646:	e8 bf fd ff ff       	call   140a <sleep@plt+0x29a> read_mem
    164b:	0f b6 d0             	movzx  edx,al mem val as arg 3
    164e:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] 1st instr byte
    1652:	0f b6 c8             	movzx  ecx,al 1st instr byte
    1655:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1659:	89 ce                	mov    esi,ecx 1st instr byte as arg 2
    165b:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    165e:	e8 e0 fc ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    1663:	90                   	nop
    1664:	c9                   	leave clean up stack
    1665:	c3                   	ret

inter_cmp:
    1666:	f3 0f 1e fa          	endbr64 allow indirect jumps
    166a:	55                   	push   rbp save current stack frame
    166b:	48 89 e5             	mov    rbp,rsp create new stack frame
    166e:	48 83 ec 20          	sub    rsp,0x20 alloc local vars
    1672:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm mem addr
    1676:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi instr
    167a:	0f b6 45 e0          	movzx  eax,BYTE PTR [rbp-0x20] 1st instr byte
    167e:	0f b6 d0             	movzx  edx,al 1st instr byte
    1681:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1685:	89 d6                	mov    esi,edx 1st instr byte as arg 2
    1687:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    168a:	e8 0c fc ff ff       	call   129b <sleep@plt+0x12b> read_reg
    168f:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al reg 1 val
    1692:	0f b6 45 e1          	movzx  eax,BYTE PTR [rbp-0x1f] 2nd instr byte
    1696:	0f b6 d0             	movzx  edx,al 2nd instr byte
    1699:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    169d:	89 d6                	mov    esi,edx 2nd instr byte as arg 2
    169f:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    16a2:	e8 f4 fb ff ff       	call   129b <sleep@plt+0x12b> read_reg
    16a7:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al reg 2 val
    16aa:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    16ae:	c6 80 06 04 00 00 00 	mov    BYTE PTR [rax+0x406],0x0 zero to reg g addr
    16b5:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] smaller flag: reg 1 val
    16b9:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] reg 2 val
    16bc:	73 1a                	jae    16d8 <sleep@plt+0x568> reg 1 >= reg 2 val jump greater flag
    16be:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    16c2:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    16c9:	83 c8 08             	or     eax,0x8 set 0x8 flag
    16cc:	89 c2                	mov    edx,eax reg g val with 0x8 flag set
    16ce:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    16d2:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg g val with 0x8 flag set to reg g addr
    16d8:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] greater flag: reg 1 val
    16dc:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] reg 2 val
    16df:	76 1a                	jbe    16fb <sleep@plt+0x58b> reg 1 val <= reg 2 val jump eq flag
    16e1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    16e5:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    16ec:	83 c8 04             	or     eax,0x4 set 0x4 flag
    16ef:	89 c2                	mov    edx,eax reg g val with 0x4 flag set
    16f1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    16f5:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg g val with 0x4 flag set to reg g addr
    16fb:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] eq flag: reg 1 val
    16ff:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] reg 2 val
    1702:	75 1a                	jne    171e <sleep@plt+0x5ae> reg 1 not eq reg 2 val jump ne flag
    1704:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1708:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    170f:	83 c8 10             	or     eax,0x10 set 0x10 flag
    1712:	89 c2                	mov    edx,eax reg g val with 0x10 flag set
    1714:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1718:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg g val with 0x10 flag set to reg g addr
    171e:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2] ne flag: reg 1 val
    1722:	3a 45 ff             	cmp    al,BYTE PTR [rbp-0x1] reg 2 val
    1725:	74 1a                	je     1741 <sleep@plt+0x5d1> reg 1 eq reg 2 val jump zero flag
    1727:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    172b:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1732:	83 c8 02             	or     eax,0x2 set 0x2 flag
    1735:	89 c2                	mov    edx,eax reg g val with 0x2 flag set
    1737:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    173b:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg g val with 0x2 flag set to reg g addr
    1741:	80 7d fe 00          	cmp    BYTE PTR [rbp-0x2],0x0 zero flag: reg 1 val
    1745:	75 20                	jne    1767 <sleep@plt+0x5f7> not reg 1 val zero jump end
    1747:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0 reg 2 val
    174b:	75 1a                	jne    1767 <sleep@plt+0x5f7> not reg 2 val zero jump end
    174d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1751:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1758:	83 c8 01             	or     eax,0x1 set 0x1 flag
    175b:	89 c2                	mov    edx,eax reg g val with 0x1 flag set
    175d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1761:	88 90 06 04 00 00    	mov    BYTE PTR [rax+0x406],dl reg g val with 0x1 flag set to reg g addr
    1767:	90                   	nop end:
    1768:	c9                   	leave clean up stack
    1769:	c3                   	ret

inter_cmov_ip:
    176a:	f3 0f 1e fa          	endbr64 allow indirect jumps
    176e:	55                   	push   rbp save current stack frame
    176f:	48 89 e5             	mov    rbp,rsp create new stack frame
    1772:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1776:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    177a:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instr
    177e:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10] 1st instr byte as exp flag
    1782:	84 c0                	test   al,al
    1784:	74 15                	je     179b <sleep@plt+0x62b> 1st instr byte zero jump
    1786:	0f b6 55 f0          	movzx  edx,BYTE PTR [rbp-0x10]  exp flag
    178a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    178e:	0f b6 80 06 04 00 00 	movzx  eax,BYTE PTR [rax+0x406] reg g val
    1795:	21 d0                	and    eax,edx
    1797:	84 c0                	test   al,al
    1799:	74 1f                	je     17ba <sleep@plt+0x64a> reg g flags eq exp flags jump end
    179b:	0f b6 45 f1          	movzx  eax,BYTE PTR [rbp-0xf] 2nd instr byte
    179f:	0f b6 d0             	movzx  edx,al 2nd instr byte
    17a2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    17a6:	89 d6                	mov    esi,edx 2nd instr byte as arg 2
    17a8:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    17ab:	e8 eb fa ff ff       	call   129b <sleep@plt+0x12b> read_reg
    17b0:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8] vm mem addr
    17b4:	88 82 05 04 00 00    	mov    BYTE PTR [rdx+0x405],al reg val to reg f addr
    17ba:	90                   	nop end:
    17bb:	c9                   	leave clean up stack
    17bc:	c3                   	ret

inter_utils:
    17bd:	f3 0f 1e fa          	endbr64 allow indirect jumps
    17c1:	55                   	push   rbp save current stack frame
    17c2:	48 89 e5             	mov    rbp,rsp create new stack frame
    17c5:	48 83 ec 30          	sub    rsp,0x30 alloc local vars
    17c9:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi vm mem addr
    17cd:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi instr
    17d1:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] open: 1st instr byte
    17d5:	0f b6 c0             	movzx  eax,al 1st instr byte
    17d8:	83 e0 08             	and    eax,0x8
    17db:	85 c0                	test   eax,eax
    17dd:	74 5f                	je     183e <sleep@plt+0x6ce> not 1st instr byte 0x8 jump read
    17df:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    17e3:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    17ea:	0f b6 d0             	movzx  edx,al reg c val as arg 3
    17ed:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    17f1:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    17f8:	0f b6 c0             	movzx  eax,al reg b val
    17fb:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28] vm mem addr
    17ff:	48 8d b1 00 03 00 00 	lea    rsi,[rcx+0x300] mem addr
    1806:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28] vm mem addr
    180a:	0f b6 89 00 04 00 00 	movzx  ecx,BYTE PTR [rcx+0x400] reg a val
    1811:	0f b6 c9             	movzx  ecx,cl reg a val
    1814:	48 01 f1             	add    rcx,rsi mem addr + reg a val
    1817:	89 c6                	mov    esi,eax reg b val as arg 2
    1819:	48 89 cf             	mov    rdi,rcx mem addr + reg a val as arg 1
    181c:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1821:	e8 2a f9 ff ff       	call   1150 <open@plt>
    1826:	0f b6 d0             	movzx  edx,al fd as arg 3
    1829:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd instr byte
    182d:	0f b6 c8             	movzx  ecx,al 2nd instr byte
    1830:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1834:	89 ce                	mov    esi,ecx 2nd isntr byte as arg 2
    1836:	48 89 c7             	mov    rdi,rax vm mem addr
    1839:	e8 05 fb ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    183e:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] 1st instr byte
    1842:	0f b6 c0             	movzx  eax,al
    1845:	83 e0 01             	and    eax,0x1
    1848:	85 c0                	test   eax,eax
    184a:	0f 84 89 00 00 00    	je     18d9 <sleep@plt+0x769> read: not 1st instr byte 0x1 jump read2
    1850:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1854:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    185b:	0f b6 c0             	movzx  eax,al reg b val
    185e:	ba 00 01 00 00       	mov    edx,0x100
    1863:	29 c2                	sub    edx,eax 0x100 - reg b val as check val(since val is non negative byte this will always be single byte result)
    1865:	89 d0                	mov    eax,edx check val
    1867:	48 63 d0             	movsxd rdx,eax check val
    186a:	48 89 d0             	mov    rax,rdx check val
    186d:	48 01 c0             	add    rax,rax check val * 2
    1870:	48 01 c2             	add    rdx,rax check val * 3
    1873:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1877:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    187e:	0f b6 c0             	movzx  eax,al reg c val
    1881:	48 39 c2             	cmp    rdx,rax
    1884:	48 0f 46 c2          	cmovbe rax,rdx reg c val if check val * 3 > reg c val else check val * 3 (will result in reg c val for most cases)
    1888:	48 89 c1             	mov    rcx,rax reg c val
    188b:	48 8b 75 d8          	mov    rsi,QWORD PTR [rbp-0x28] vm mem addr
    188f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1893:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    189a:	0f b6 d0             	movzx  edx,al reg b val
    189d:	48 89 d0             	mov    rax,rdx reg b val
    18a0:	48 01 c0             	add    rax,rax reg b val * 2
    18a3:	48 01 d0             	add    rax,rdx reg b val * 3
    18a6:	48 01 c6             	add    rsi,rax vm mem addr + reg b val * 3 as arg 2
    18a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    18ad:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    18b4:	0f b6 c0             	movzx  eax,al reg a val
    18b7:	48 89 ca             	mov    rdx,rcx reg c val as arg 3
    18ba:	89 c7                	mov    edi,eax reg a val as arg 1
    18bc:	e8 5f f8 ff ff       	call   1120 <read@plt>
    18c1:	0f b6 d0             	movzx  edx,al num bytes read
    18c4:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd instr byte
    18c8:	0f b6 c8             	movzx  ecx,al 2nd instr byte
    18cb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    18cf:	89 ce                	mov    esi,ecx 2nd instr byte as arg 2
    18d1:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    18d4:	e8 6a fa ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    18d9:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] read2: 1st instr byte
    18dd:	0f b6 c0             	movzx  eax,al 1st instr byte
    18e0:	83 e0 02             	and    eax,0x2
    18e3:	85 c0                	test   eax,eax
    18e5:	0f 84 8a 00 00 00    	je     1975 <sleep@plt+0x805> not 1st instr byte 0x2 jump write
    18eb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    18ef:	48 8d 90 00 03 00 00 	lea    rdx,[rax+0x300] stack base addr
    18f6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    18fa:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    1901:	0f b6 c0             	movzx  eax,al reg b val
    1904:	48 01 d0             	add    rax,rdx stack base addr + reg b val
    1907:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax stack base addr + reg b val
    190b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    190f:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    1916:	0f b6 c0             	movzx  eax,al reg b val
    1919:	ba 00 01 00 00       	mov    edx,0x100
    191e:	29 c2                	sub    edx,eax 0x100 - reg b val as check val
    1920:	89 d0                	mov    eax,edx check val
    1922:	48 63 d0             	movsxd rdx,eax check val
    1925:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1929:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    1930:	0f b6 c0             	movzx  eax,al reg c val
    1933:	48 39 c2             	cmp    rdx,rax
    1936:	48 0f 46 c2          	cmovbe rax,rdx reg c val if check val > reg c val else check val
    193a:	88 45 ee             	mov    BYTE PTR [rbp-0x12],al reg c val
    193d:	0f b6 55 ee          	movzx  edx,BYTE PTR [rbp-0x12] reg c val as arg 3
    1941:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1945:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    194c:	0f b6 c0             	movzx  eax,al reg a val
    194f:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10] stack base addr + reg b val
    1953:	48 89 ce             	mov    rsi,rcx stack base addr + reg b val as arg 2
    1956:	89 c7                	mov    edi,eax reg a val as arg 1
    1958:	e8 c3 f7 ff ff       	call   1120 <read@plt>
    195d:	0f b6 d0             	movzx  edx,al num bytes read as arg 3
    1960:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd instr byte
    1964:	0f b6 c8             	movzx  ecx,al 2nd instr byte
    1967:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    196b:	89 ce                	mov    esi,ecx 2nd instr byte as arg 2
    196d:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    1970:	e8 ce f9 ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    1975:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] write: 1st instr byte
    1979:	0f b6 c0             	movzx  eax,al 1st instr byte
    197c:	83 e0 10             	and    eax,0x10
    197f:	85 c0                	test   eax,eax
    1981:	0f 84 8a 00 00 00    	je     1a11 <sleep@plt+0x8a1> not 1st instr byte 0x10 jump sleep
    1987:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    198b:	48 8d 90 00 03 00 00 	lea    rdx,[rax+0x300] stack base addr
    1992:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1996:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    199d:	0f b6 c0             	movzx  eax,al reg b val
    19a0:	48 01 d0             	add    rax,rdx stack base addr + reg b val
    19a3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax stack base addr + reg b val
    19a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    19ab:	0f b6 80 01 04 00 00 	movzx  eax,BYTE PTR [rax+0x401] reg b val
    19b2:	0f b6 c0             	movzx  eax,al reg b val
    19b5:	ba 00 01 00 00       	mov    edx,0x100
    19ba:	29 c2                	sub    edx,eax 0x100 - reg b val as check val
    19bc:	89 d0                	mov    eax,edx check val
    19be:	48 63 d0             	movsxd rdx,eax check val
    19c1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    19c5:	0f b6 80 02 04 00 00 	movzx  eax,BYTE PTR [rax+0x402] reg c val
    19cc:	0f b6 c0             	movzx  eax,al reg c val
    19cf:	48 39 c2             	cmp    rdx,rax
    19d2:	48 0f 46 c2          	cmovbe rax,rdx reg c val if check val > reg c val else check val
    19d6:	88 45 ef             	mov    BYTE PTR [rbp-0x11],al reg c val
    19d9:	0f b6 55 ef          	movzx  edx,BYTE PTR [rbp-0x11] reg c val as arg 3
    19dd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    19e1:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    19e8:	0f b6 c0             	movzx  eax,al reg a val
    19eb:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] stack base addr + reg b val
    19ef:	48 89 ce             	mov    rsi,rcx stack base addr + reg b val as arg 2
    19f2:	89 c7                	mov    edi,eax reg a val as arg 1
    19f4:	e8 f7 f6 ff ff       	call   10f0 <write@plt>
    19f9:	0f b6 d0             	movzx  edx,al bytes written
    19fc:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd isntr byte
    1a00:	0f b6 c8             	movzx  ecx,al 2nd instr byte
    1a03:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1a07:	89 ce                	mov    esi,ecx 2nd instr byte as arg 2
    1a09:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    1a0c:	e8 32 f9 ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    1a11:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] sleep: 1st instr byte
    1a15:	0f b6 c0             	movzx  eax,al 1st instr byte
    1a18:	83 e0 20             	and    eax,0x20
    1a1b:	85 c0                	test   eax,eax
    1a1d:	74 2d                	je     1a4c <sleep@plt+0x8dc> not 1st instr byte 0x20 jump exit
    1a1f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1a23:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] reg a val
    1a2a:	0f b6 c0             	movzx  eax,al reg a val
    1a2d:	89 c7                	mov    edi,eax reg a val as arg 1
    1a2f:	e8 3c f7 ff ff       	call   1170 <sleep@plt>
    1a34:	0f b6 d0             	movzx  edx,al seconds left to sleep as arg 3
    1a37:	0f b6 45 d1          	movzx  eax,BYTE PTR [rbp-0x2f] 2nd isntr byte
    1a3b:	0f b6 c8             	movzx  ecx,al 2nd isntr byte
    1a3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1a42:	89 ce                	mov    esi,ecx 2nd isntr byte as arg 2
    1a44:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    1a47:	e8 f7 f8 ff ff       	call   1343 <sleep@plt+0x1d3> write_reg
    1a4c:	0f b6 45 d0          	movzx  eax,BYTE PTR [rbp-0x30] exit: 1st instr byte
    1a50:	0f b6 c0             	movzx  eax,al 1st instr byte
    1a53:	83 e0 04             	and    eax,0x4
    1a56:	85 c0                	test   eax,eax
    1a58:	74 15                	je     1a6f <sleep@plt+0x8ff> not 1st instr byte 0x4 jump end
    1a5a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28] vm mem addr
    1a5e:	0f b6 80 00 04 00 00 	movzx  eax,BYTE PTR [rax+0x400] rag a val
    1a65:	0f b6 c0             	movzx  eax,al reg a val
    1a68:	89 c7                	mov    edi,eax reg a val as arg 1
    1a6a:	e8 f1 f6 ff ff       	call   1160 <exit@plt>
    1a6f:	90                   	nop end:
    1a70:	c9                   	leave clean up stack
    1a71:	c3                   	ret

inter_instr:
    1a72:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1a76:	55                   	push   rbp save current stack frame
    1a77:	48 89 e5             	mov    rbp,rsp create new stack frame
    1a7a:	48 83 ec 10          	sub    rsp,0x10 alloc local vars
    1a7e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi vm mem addr
    1a82:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi instr
    1a86:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] write reg: 3rd instr byte
    1a8a:	84 c0                	test   al,al
    1a8c:	79 10                	jns    1a9e <sleep@plt+0x92e> not 3rd instr byte neg jump add
    1a8e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1a92:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1a96:	48 89 c7             	mov    rdi,rax vm mem addr
    1a99:	e8 c1 f9 ff ff       	call   145f <sleep@plt+0x2ef> inter_write_reg
    1a9e:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] add: 3rd instr byte
    1aa2:	0f b6 c0             	movzx  eax,al 3rd instr byte
    1aa5:	83 e0 10             	and    eax,0x10
    1aa8:	85 c0                	test   eax,eax
    1aaa:	74 10                	je     1abc <sleep@plt+0x94c> not 3rd instr byte 0x10 jump push pop
    1aac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1ab0:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1ab4:	48 89 c7             	mov    rdi,rax vm mem addr
    1ab7:	e8 d6 f9 ff ff       	call   1492 <sleep@plt+0x322> inter_add
    1abc:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] push pop: 3rd instr byte
    1ac0:	0f b6 c0             	movzx  eax,al 3rd instr byte
    1ac3:	83 e0 20             	and    eax,0x20
    1ac6:	85 c0                	test   eax,eax
    1ac8:	74 10                	je     1ada <sleep@plt+0x96a> not 3rd instr byte 0x20 jump reg to mem
    1aca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1ace:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1ad2:	48 89 c7             	mov    rdi,rax vm mem addr
    1ad5:	e8 1b fa ff ff       	call   14f5 <sleep@plt+0x385> inter_push_pop
    1ada:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] reg to mem: 3rd instr byte
    1ade:	0f b6 c0             	movzx  eax,al 3rd instr byte
    1ae1:	83 e0 01             	and    eax,0x1
    1ae4:	85 c0                	test   eax,eax
    1ae6:	74 10                	je     1af8 <sleep@plt+0x988> not 3rd instr byte 0x1 jump mem to reg
    1ae8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1aec:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1af0:	48 89 c7             	mov    rdi,rax vm mem addr
    1af3:	e8 bc fa ff ff       	call   15b4 <sleep@plt+0x444> inter_reg_to_mem
    1af8:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] mem to reg: 3rd instr byte
    1afc:	0f b6 c0             	movzx  eax,al 3rd isntr byte
    1aff:	83 e0 08             	and    eax,0x8
    1b02:	85 c0                	test   eax,eax
    1b04:	74 10                	je     1b16 <sleep@plt+0x9a6> not 3rd instr byte 0x8 jump cmp
    1b06:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1b0a:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1b0e:	48 89 c7             	mov    rdi,rax vm mem addr
    1b11:	e8 fb fa ff ff       	call   1611 <sleep@plt+0x4a1> inter_mem_to_reg
    1b16:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] cmp: 3rd instr byte
    1b1a:	0f b6 c0             	movzx  eax,al 3rd instr byte
    1b1d:	83 e0 02             	and    eax,0x2
    1b20:	85 c0                	test   eax,eax
    1b22:	74 10                	je     1b34 <sleep@plt+0x9c4> not 3rd instr byte 0x2 jump cmov ip
    1b24:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1b28:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1b2c:	48 89 c7             	mov    rdi,rax vm mem addr
    1b2f:	e8 32 fb ff ff       	call   1666 <sleep@plt+0x4f6> inter_cmp
    1b34:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] cmov_ip: 3rd instr byte
    1b38:	0f b6 c0             	movzx  eax,al
    1b3b:	83 e0 40             	and    eax,0x40
    1b3e:	85 c0                	test   eax,eax
    1b40:	74 10                	je     1b52 <sleep@plt+0x9e2> not 3rd instr byte 0x40 jump utils
    1b42:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1b46:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1b4a:	48 89 c7             	mov    rdi,rax vm mem addr
    1b4d:	e8 18 fc ff ff       	call   176a <sleep@plt+0x5fa> inter_cmov_ip
    1b52:	0f b6 45 f2          	movzx  eax,BYTE PTR [rbp-0xe] utils: 3rd instr byte
    1b56:	0f b6 c0             	movzx  eax,al 3rd instr byte
    1b59:	83 e0 04             	and    eax,0x4
    1b5c:	85 c0                	test   eax,eax
    1b5e:	74 10                	je     1b70 <sleep@plt+0xa00> not 3rd instr byte 0x4 jump end
    1b60:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8] vm mem addr
    1b64:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10] instr
    1b68:	48 89 c7             	mov    rdi,rax vm mem addr
    1b6b:	e8 4d fc ff ff       	call   17bd <sleep@plt+0x64d> inter_utils
    1b70:	90                   	nop end:
    1b71:	c9                   	leave clean up stack
    1b72:	c3                   	ret

fetch_decode_exec_loop:
    1b73:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1b77:	55                   	push   rbp save current stack frame
    1b78:	48 89 e5             	mov    rbp,rsp create new stack frame
    1b7b:	48 83 ec 20          	sub    rsp,0x20 alloc local vars
    1b7f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi vm mem addr
    1b83:	48 8d 3d ae 04 00 00 	lea    rdi,[rip+0x4ae] str addr # 2038 <sleep@plt+0xec8>
    1b8a:	e8 51 f5 ff ff       	call   10e0 <puts@plt> print str
    1b8f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] program loop start: vm mem addr
    1b93:	0f b6 80 05 04 00 00 	movzx  eax,BYTE PTR [rax+0x405] program counter reg val
    1b9a:	8d 48 01             	lea    ecx,[rax+0x1] program counter reg val + 1
    1b9d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18] vm mem addr
    1ba1:	88 8a 05 04 00 00    	mov    BYTE PTR [rdx+0x405],cl inc program counter reg val
    1ba7:	0f b6 c0             	movzx  eax,al program counter reg val pre inc
    1baa:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18] vm mem addr
    1bae:	48 63 d0             	movsxd rdx,eax program counter reg val pre inc
    1bb1:	48 89 d0             	mov    rax,rdx program counter reg val pre inc
    1bb4:	48 01 c0             	add    rax,rax program counter reg val pre inc * 2
    1bb7:	48 01 d0             	add    rax,rdx program counter reg val pre inc * 3
    1bba:	48 01 c8             	add    rax,rcx vm mem addr+program counter reg val pre inc * 3
    At this point we have calculated the vm mem offset to the next instruction to run. Instruct len 3.
    1bbd:	0f b7 10             	movzx  edx,WORD PTR [rax] 1st and 2nd instructn byte
    1bc0:	66 89 55 fd          	mov    WORD PTR [rbp-0x3],dx save 1st and 2nd isnstruct byte
    1bc4:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2] 3rd instruct byte
    1bc8:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al save 3rd instruct byte
    1bcb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18] vm mem addr
    1bcf:	0f b6 55 fd          	movzx  edx,BYTE PTR [rbp-0x3] 1st instruct byte
    1bd3:	0f b6 4d fe          	movzx  ecx,BYTE PTR [rbp-0x2] 2nd instruct byte
    1bd7:	48 c1 e1 08          	shl    rcx,0x8 2nd instruct byte to upper cx
    1bdb:	48 09 d1             	or     rcx,rdx 1st instruct byte to lower cx
    1bde:	0f b6 55 ff          	movzx  edx,BYTE PTR [rbp-0x1] 3rd instruct byte
    1be2:	48 c1 e2 10          	shl    rdx,0x10 3rd instruct byte to upper half edx
    1be6:	48 09 ca             	or     rdx,rcx 3rd, 2nd, 1st instruct byte in rdx
    1be9:	48 89 d6             	mov    rsi,rdx 3rd, 2nd, 1st instruct byte as arg 2
    1bec:	48 89 c7             	mov    rdi,rax vm mem addr as arg 1
    1bef:	e8 7e fe ff ff       	call   1a72 <sleep@plt+0x902> inter instruct
    1bf4:	eb 99                	jmp    1b8f <sleep@plt+0xa1f> jump program loop start

main:
    1bf6:	f3 0f 1e fa          	endbr64 allow indirect jumps
    1bfa:	55                   	push   rbp save current stack frame
    1bfb:	48 89 e5             	mov    rbp,rsp create new stack frame
    1bfe:	48 81 ec 20 04 00 00 	sub    rsp,0x420 alloc local vars
    1c05:	89 bd ec fb ff ff    	mov    DWORD PTR [rbp-0x414],edi argc
    1c0b:	48 89 b5 e0 fb ff ff 	mov    QWORD PTR [rbp-0x420],rsi argv ptr addr
    1c12:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
    1c19:	00 00 
    1c1b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax stack guard canary to stack
    1c1f:	31 c0                	xor    eax,eax
    1c21:	48 8b 85 e0 fb ff ff 	mov    rax,QWORD PTR [rbp-0x420] argv ptr addr
    1c28:	48 8b 00             	mov    rax,QWORD PTR [rax] dereferenced argv addr
    1c2b:	48 89 c6             	mov    rsi,rax argv addr
    1c2e:	48 8d 3d 2d 04 00 00 	lea    rdi,[rip+0x42d] format str addr # 2062 <sleep@plt+0xef2>
    1c35:	b8 00 00 00 00       	mov    eax,0x0 num vec regs used
    1c3a:	e8 d1 f4 ff ff       	call   1110 <printf@plt> print format argv
    1c3f:	48 8d 3d 32 04 00 00 	lea    rdi,[rip+0x432]        # 2078 <sleep@plt+0xf08>
    1c46:	e8 95 f4 ff ff       	call   10e0 <puts@plt>
    1c4b:	48 8d 3d 76 04 00 00 	lea    rdi,[rip+0x476]        # 20c8 <sleep@plt+0xf58>
    1c52:	e8 89 f4 ff ff       	call   10e0 <puts@plt>
    1c57:	48 8d 3d b2 04 00 00 	lea    rdi,[rip+0x4b2]        # 2110 <sleep@plt+0xfa0>
    1c5e:	e8 7d f4 ff ff       	call   10e0 <puts@plt>
    1c63:	48 8d 3d f6 04 00 00 	lea    rdi,[rip+0x4f6]        # 2160 <sleep@plt+0xff0>
    1c6a:	e8 71 f4 ff ff       	call   10e0 <puts@plt>
    1c6f:	48 8d 3d 3a 05 00 00 	lea    rdi,[rip+0x53a]        # 21b0 <sleep@plt+0x1040>
    1c76:	e8 65 f4 ff ff       	call   10e0 <puts@plt>
    1c7b:	48 8d 3d 6b 05 00 00 	lea    rdi,[rip+0x56b]        # 21ed <sleep@plt+0x107d>
    1c82:	e8 59 f4 ff ff       	call   10e0 <puts@plt>
    1c87:	48 8d 3d 6a 05 00 00 	lea    rdi,[rip+0x56a]        # 21f8 <sleep@plt+0x1088>
    1c8e:	e8 4d f4 ff ff       	call   10e0 <puts@plt>
    1c93:	48 8d 3d ae 05 00 00 	lea    rdi,[rip+0x5ae]        # 2248 <sleep@plt+0x10d8>
    1c9a:	e8 41 f4 ff ff       	call   10e0 <puts@plt>
    1c9f:	48 8b 05 3a 27 00 00 	mov    rax,QWORD PTR [rip+0x273a] stdout file addr # 43e0 <stdout@GLIBC_2.2.5>
    1ca6:	b9 01 00 00 00       	mov    ecx,0x1 buf size
    1cab:	ba 02 00 00 00       	mov    edx,0x2 type unbuffered => buf ignored
    1cb0:	be 00 00 00 00       	mov    esi,0x0 buf addr
    1cb5:	48 89 c7             	mov    rdi,rax stdout file addr
    1cb8:	e8 83 f4 ff ff       	call   1140 <setvbuf@plt> set stdout file to unbuffered
    1cbd:	48 8d 95 f0 fb ff ff 	lea    rdx,[rbp-0x410] vm mem addr
    1cc4:	b8 00 00 00 00       	mov    eax,0x0 val
    1cc9:	b9 80 00 00 00       	mov    ecx,0x80 num of qwords
    1cce:	48 89 d7             	mov    rdi,rdx vm mem addr
    1cd1:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax zero 1MB of vm mem
    1cd4:	48 89 fa             	mov    rdx,rdi vm mem addr + 1024
    1cd7:	89 02                	mov    DWORD PTR [rdx],eax zero 4 more bytes of vm mem
    1cd9:	48 83 c2 04          	add    rdx,0x4 vm mem addr + 1028
    1cdd:	66 89 02             	mov    WORD PTR [rdx],ax zero 2 more bytes of mv mem
    1ce0:	48 83 c2 02          	add    rdx,0x2 vm mem addr + 1030
    1ce4:	88 02                	mov    BYTE PTR [rdx],al zero 1 more byte of vm mem
    1ce6:	48 83 c2 01          	add    rdx,0x1 vm mem addr + 1031
    At this point 0x407 bytes rbp-0x410 to rbp-0x9 are zeroed
    1cea:	8b 05 d4 25 00 00    	mov    eax,DWORD PTR [rip+0x25d4] data section num # 42c4 <sleep@plt+0x3154>
    1cf0:	89 c2                	mov    edx,eax num bytes to cpy 8250 or 203a
    1cf2:	48 8d 85 f0 fb ff ff 	lea    rax,[rbp-0x410] vm mem addr
    1cf9:	48 8d 35 20 23 00 00 	lea    rsi,[rip+0x2320] data section vm data addr as src # 4020 <sleep@plt+0x2eb0>
    1d00:	48 89 c7             	mov    rdi,rax vm mem addr as dst
    1d03:	e8 28 f4 ff ff       	call   1130 <memcpy@plt> copy 8250 bytes of vm data to vm mem
    The following instructions copy more data from the data section to the upper part of vm mem.
    1d08:	48 8b 05 d1 25 00 00 	mov    rax,QWORD PTR [rip+0x25d1]        # 42e0 <sleep@plt+0x3170>
    1d0f:	48 8b 15 d2 25 00 00 	mov    rdx,QWORD PTR [rip+0x25d2]        # 42e8 <sleep@plt+0x3178>
    1d16:	48 89 85 f0 fe ff ff 	mov    QWORD PTR [rbp-0x110],rax
    1d1d:	48 89 95 f8 fe ff ff 	mov    QWORD PTR [rbp-0x108],rdx
    1d24:	48 8b 05 c5 25 00 00 	mov    rax,QWORD PTR [rip+0x25c5]        # 42f0 <sleep@plt+0x3180>
    1d2b:	48 8b 15 c6 25 00 00 	mov    rdx,QWORD PTR [rip+0x25c6]        # 42f8 <sleep@plt+0x3188>
    1d32:	48 89 85 00 ff ff ff 	mov    QWORD PTR [rbp-0x100],rax
    1d39:	48 89 95 08 ff ff ff 	mov    QWORD PTR [rbp-0xf8],rdx
    1d40:	48 8b 05 b9 25 00 00 	mov    rax,QWORD PTR [rip+0x25b9]        # 4300 <sleep@plt+0x3190>
    1d47:	48 8b 15 ba 25 00 00 	mov    rdx,QWORD PTR [rip+0x25ba]        # 4308 <sleep@plt+0x3198>
    1d4e:	48 89 85 10 ff ff ff 	mov    QWORD PTR [rbp-0xf0],rax
    1d55:	48 89 95 18 ff ff ff 	mov    QWORD PTR [rbp-0xe8],rdx
    1d5c:	48 8b 05 ad 25 00 00 	mov    rax,QWORD PTR [rip+0x25ad]        # 4310 <sleep@plt+0x31a0>
    1d63:	48 8b 15 ae 25 00 00 	mov    rdx,QWORD PTR [rip+0x25ae]        # 4318 <sleep@plt+0x31a8>
    1d6a:	48 89 85 20 ff ff ff 	mov    QWORD PTR [rbp-0xe0],rax
    1d71:	48 89 95 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdx
    1d78:	48 8b 05 a1 25 00 00 	mov    rax,QWORD PTR [rip+0x25a1]        # 4320 <sleep@plt+0x31b0>
    1d7f:	48 8b 15 a2 25 00 00 	mov    rdx,QWORD PTR [rip+0x25a2]        # 4328 <sleep@plt+0x31b8>
    1d86:	48 89 85 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rax
    1d8d:	48 89 95 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdx
    1d94:	48 8b 05 95 25 00 00 	mov    rax,QWORD PTR [rip+0x2595]        # 4330 <sleep@plt+0x31c0>
    1d9b:	48 8b 15 96 25 00 00 	mov    rdx,QWORD PTR [rip+0x2596]        # 4338 <sleep@plt+0x31c8>
    1da2:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
    1da9:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    1db0:	48 8b 05 89 25 00 00 	mov    rax,QWORD PTR [rip+0x2589]        # 4340 <sleep@plt+0x31d0>
    1db7:	48 8b 15 8a 25 00 00 	mov    rdx,QWORD PTR [rip+0x258a]        # 4348 <sleep@plt+0x31d8>
    1dbe:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
    1dc5:	48 89 95 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rdx
    1dcc:	48 8b 05 7d 25 00 00 	mov    rax,QWORD PTR [rip+0x257d]        # 4350 <sleep@plt+0x31e0>
    1dd3:	48 8b 15 7e 25 00 00 	mov    rdx,QWORD PTR [rip+0x257e]        # 4358 <sleep@plt+0x31e8>
    1dda:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
    1de1:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
    1de8:	48 8b 05 71 25 00 00 	mov    rax,QWORD PTR [rip+0x2571]        # 4360 <sleep@plt+0x31f0>
    1def:	48 8b 15 72 25 00 00 	mov    rdx,QWORD PTR [rip+0x2572]        # 4368 <sleep@plt+0x31f8>
    1df6:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
    1dfd:	48 89 95 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdx
    1e04:	48 8b 05 65 25 00 00 	mov    rax,QWORD PTR [rip+0x2565]        # 4370 <sleep@plt+0x3200>
    1e0b:	48 8b 15 66 25 00 00 	mov    rdx,QWORD PTR [rip+0x2566]        # 4378 <sleep@plt+0x3208>
    1e12:	48 89 45 80          	mov    QWORD PTR [rbp-0x80],rax
    1e16:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    1e1a:	48 8b 05 5f 25 00 00 	mov    rax,QWORD PTR [rip+0x255f]        # 4380 <sleep@plt+0x3210>
    1e21:	48 8b 15 60 25 00 00 	mov    rdx,QWORD PTR [rip+0x2560]        # 4388 <sleep@plt+0x3218>
    1e28:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
    1e2c:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    1e30:	48 8b 05 59 25 00 00 	mov    rax,QWORD PTR [rip+0x2559]        # 4390 <sleep@plt+0x3220>
    1e37:	48 8b 15 5a 25 00 00 	mov    rdx,QWORD PTR [rip+0x255a]        # 4398 <sleep@plt+0x3228>
    1e3e:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    1e42:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
    1e46:	48 8b 05 53 25 00 00 	mov    rax,QWORD PTR [rip+0x2553]        # 43a0 <sleep@plt+0x3230>
    1e4d:	48 8b 15 54 25 00 00 	mov    rdx,QWORD PTR [rip+0x2554]        # 43a8 <sleep@plt+0x3238>
    1e54:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
    1e58:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    1e5c:	48 8b 05 4d 25 00 00 	mov    rax,QWORD PTR [rip+0x254d]        # 43b0 <sleep@plt+0x3240>
    1e63:	48 8b 15 4e 25 00 00 	mov    rdx,QWORD PTR [rip+0x254e]        # 43b8 <sleep@plt+0x3248>
    1e6a:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    1e6e:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    1e72:	48 8b 05 47 25 00 00 	mov    rax,QWORD PTR [rip+0x2547]        # 43c0 <sleep@plt+0x3250>
    1e79:	48 8b 15 48 25 00 00 	mov    rdx,QWORD PTR [rip+0x2548]        # 43c8 <sleep@plt+0x3258>
    1e80:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    1e84:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    1e88:	48 8b 05 41 25 00 00 	mov    rax,QWORD PTR [rip+0x2541]        # 43d0 <sleep@plt+0x3260>
    1e8f:	48 8b 15 42 25 00 00 	mov    rdx,QWORD PTR [rip+0x2542]        # 43d8 <sleep@plt+0x3268>
    1e96:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1e9a:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    1e9e:	48 8d 85 f0 fb ff ff 	lea    rax,[rbp-0x410] vm mem addr
    1ea5:	48 89 c7             	mov    rdi,rax vm mem addr
    1ea8:	e8 c6 fc ff ff       	call   1b73 <sleep@plt+0xa03> fetch_decode_exec_loop
    1ead:	b8 00 00 00 00       	mov    eax,0x0
    1eb2:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8] current canary value from stack
    1eb6:	64 48 33 0c 25 28 00 	xor    rcx,QWORD PTR fs:0x28 expected canary value
    1ebd:	00 00 
    1ebf:	74 05                	je     1ec6 <sleep@plt+0xd56> canaries equal jump end
    1ec1:	e8 3a f2 ff ff       	call   1100 <__stack_chk_fail@plt> fail due to corrupted stack
    1ec6:	c9                   	leave end: clean up stack
    1ec7:	c3                   	ret
