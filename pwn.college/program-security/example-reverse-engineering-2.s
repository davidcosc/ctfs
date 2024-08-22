Disassembly of section .text:

00000000000012c0 <.text>:
padding:
    13a9:	f3 0f 1e fa          	endbr64
    13ad:	55                   	push   rbp
    13ae:	48 89 e5             	mov    rbp,rsp
    13b1:	90                   	nop
    13b2:	90                   	nop
    13b3:	90                   	nop
    13b4:	90                   	nop
    13b5:	90                   	nop
    13b6:	90                   	nop
    13b7:	90                   	nop
    13b8:	90                   	nop
    13b9:	90                   	nop
    13ba:	90                   	nop
    ...
    2141:	90                   	nop
    2142:	90                   	nop
    2143:	90                   	nop
    2144:	5d                   	pop    rbp
    2145:	c3                   	ret

win:
    2146:	f3 0f 1e fa          	endbr64
    214a:	55                   	push   rbp
    214b:	48 89 e5             	mov    rbp,rsp
    214e:	48 81 ec 20 01 00 00 	sub    rsp,0x120
    2155:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    215c:	00 00 
    215e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    2162:	31 c0                	xor    eax,eax
    2164:	48 8d 3d 9d 0e 00 00 	lea    rdi,[rip+0xe9d]        # 3008 <open@plt+0x1d58>
    216b:	e8 40 f0 ff ff       	call   11b0 <puts@plt>
    2170:	be 00 00 00 00       	mov    esi,0x0
    2175:	48 8d 3d a8 0e 00 00 	lea    rdi,[rip+0xea8]        # 3024 <open@plt+0x1d74>
    217c:	b8 00 00 00 00       	mov    eax,0x0
    2181:	e8 2a f1 ff ff       	call   12b0 <open@plt>
    2186:	89 85 e8 fe ff ff    	mov    DWORD PTR [rbp-0x118],eax
    218c:	83 bd e8 fe ff ff 00 	cmp    DWORD PTR [rbp-0x118],0x0
    2193:	79 49                	jns    21de <open@plt+0xf2e>
    2195:	e8 b6 f0 ff ff       	call   1250 <__errno_location@plt>
    219a:	8b 00                	mov    eax,DWORD PTR [rax]
    219c:	89 c7                	mov    edi,eax
    219e:	e8 9d f0 ff ff       	call   1240 <strerror@plt>
    21a3:	48 89 c6             	mov    rsi,rax
    21a6:	48 8d 3d 83 0e 00 00 	lea    rdi,[rip+0xe83]        # 3030 <open@plt+0x1d80>
    21ad:	b8 00 00 00 00       	mov    eax,0x0
    21b2:	e8 d9 ef ff ff       	call   1190 <printf@plt>
    21b7:	e8 54 f0 ff ff       	call   1210 <geteuid@plt>
    21bc:	85 c0                	test   eax,eax
    21be:	0f 84 94 00 00 00    	je     2258 <open@plt+0xfa8>
    21c4:	48 8d 3d 95 0e 00 00 	lea    rdi,[rip+0xe95]        # 3060 <open@plt+0x1db0>
    21cb:	e8 e0 ef ff ff       	call   11b0 <puts@plt>
    21d0:	48 8d 3d b1 0e 00 00 	lea    rdi,[rip+0xeb1]        # 3088 <open@plt+0x1dd8>
    21d7:	e8 d4 ef ff ff       	call   11b0 <puts@plt>
    21dc:	eb 7a                	jmp    2258 <open@plt+0xfa8>
    21de:	48 8d 8d f0 fe ff ff 	lea    rcx,[rbp-0x110]
    21e5:	8b 85 e8 fe ff ff    	mov    eax,DWORD PTR [rbp-0x118]
    21eb:	ba 00 01 00 00       	mov    edx,0x100
    21f0:	48 89 ce             	mov    rsi,rcx
    21f3:	89 c7                	mov    edi,eax
    21f5:	e8 06 f0 ff ff       	call   1200 <read@plt>
    21fa:	89 85 ec fe ff ff    	mov    DWORD PTR [rbp-0x114],eax
    2200:	83 bd ec fe ff ff 00 	cmp    DWORD PTR [rbp-0x114],0x0
    2207:	7f 24                	jg     222d <open@plt+0xf7d>
    2209:	e8 42 f0 ff ff       	call   1250 <__errno_location@plt>
    220e:	8b 00                	mov    eax,DWORD PTR [rax]
    2210:	89 c7                	mov    edi,eax
    2212:	e8 29 f0 ff ff       	call   1240 <strerror@plt>
    2217:	48 89 c6             	mov    rsi,rax
    221a:	48 8d 3d bf 0e 00 00 	lea    rdi,[rip+0xebf]        # 30e0 <open@plt+0x1e30>
    2221:	b8 00 00 00 00       	mov    eax,0x0
    2226:	e8 65 ef ff ff       	call   1190 <printf@plt>
    222b:	eb 2c                	jmp    2259 <open@plt+0xfa9>
    222d:	8b 85 ec fe ff ff    	mov    eax,DWORD PTR [rbp-0x114]
    2233:	48 63 d0             	movsxd rdx,eax
    2236:	48 8d 85 f0 fe ff ff 	lea    rax,[rbp-0x110]
    223d:	48 89 c6             	mov    rsi,rax
    2240:	bf 01 00 00 00       	mov    edi,0x1
    2245:	e8 56 f0 ff ff       	call   12a0 <write@plt>
    224a:	48 8d 3d b9 0e 00 00 	lea    rdi,[rip+0xeb9]        # 310a <open@plt+0x1e5a>
    2251:	e8 5a ef ff ff       	call   11b0 <puts@plt>
    2256:	eb 01                	jmp    2259 <open@plt+0xfa9>
    2258:	90                   	nop
    2259:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    225d:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
    2264:	00 00 
    2266:	74 05                	je     226d <open@plt+0xfbd>
    2268:	e8 f3 ef ff ff       	call   1260 <__stack_chk_fail@plt>
    226d:	c9                   	leave
    226e:	c3                   	ret

main:
    226f:	f3 0f 1e fa          	endbr64
    2273:	55                   	push   rbp
    2274:	48 89 e5             	mov    rbp,rsp
    2277:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    227e:	89 bd 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],edi
    2284:	48 89 b5 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rsi
    228b:	48 89 95 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdx
    2292:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    2299:	00 00 
    229b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    229f:	31 c0                	xor    eax,eax
    22a1:	83 bd 3c ff ff ff 00 	cmp    DWORD PTR [rbp-0xc4],0x0
    22a8:	7f 1f                	jg     22c9 <open@plt+0x1019>
    22aa:	48 8d 0d 63 11 00 00 	lea    rcx,[rip+0x1163]        # 3414 <open@plt+0x2164>
    22b1:	ba 39 00 00 00       	mov    edx,0x39
    22b6:	48 8d 35 4f 0e 00 00 	lea    rsi,[rip+0xe4f]        # 310c <open@plt+0x1e5c>
    22bd:	48 8d 3d 50 0e 00 00 	lea    rdi,[rip+0xe50]        # 3114 <open@plt+0x1e64>
    22c4:	e8 07 ef ff ff       	call   11d0 <__assert_fail@plt>
    22c9:	48 8d 3d 4d 0e 00 00 	lea    rdi,[rip+0xe4d]        # 311d <open@plt+0x1e6d>
    22d0:	e8 db ee ff ff       	call   11b0 <puts@plt>
    22d5:	48 8b 85 30 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd0]
    22dc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    22df:	48 89 c6             	mov    rsi,rax
    22e2:	48 8d 3d 38 0e 00 00 	lea    rdi,[rip+0xe38]        # 3121 <open@plt+0x1e71>
    22e9:	b8 00 00 00 00       	mov    eax,0x0
    22ee:	e8 9d ee ff ff       	call   1190 <printf@plt>
    22f3:	48 8d 3d 23 0e 00 00 	lea    rdi,[rip+0xe23]        # 311d <open@plt+0x1e6d>
    22fa:	e8 b1 ee ff ff       	call   11b0 <puts@plt>
    22ff:	bf 0a 00 00 00       	mov    edi,0xa
    2304:	e8 e7 ee ff ff       	call   11f0 <putchar@plt>
    2309:	48 8b 05 20 2d 00 00 	mov    rax,QWORD PTR [rip+0x2d20]        # 5030 <stdin@GLIBC_2.2.5>
    2310:	b9 00 00 00 00       	mov    ecx,0x0
    2315:	ba 02 00 00 00       	mov    edx,0x2
    231a:	be 00 00 00 00       	mov    esi,0x0
    231f:	48 89 c7             	mov    rdi,rax
    2322:	e8 b9 ee ff ff       	call   11e0 <setvbuf@plt>
    2327:	48 8b 05 0a 2d 00 00 	mov    rax,QWORD PTR [rip+0x2d0a]        # 5038 <stdout@GLIBC_2.2.5>
    232e:	b9 01 00 00 00       	mov    ecx,0x1
    2333:	ba 02 00 00 00       	mov    edx,0x2
    2338:	be 00 00 00 00       	mov    esi,0x0
    233d:	48 89 c7             	mov    rdi,rax
    2340:	e8 9b ee ff ff       	call   11e0 <setvbuf@plt>
    2345:	48 8d 3d ec 0d 00 00 	lea    rdi,[rip+0xdec]        # 3138 <open@plt+0x1e88>
    234c:	e8 5f ee ff ff       	call   11b0 <puts@plt>
    2351:	48 8d 3d 58 0e 00 00 	lea    rdi,[rip+0xe58]        # 31b0 <open@plt+0x1f00>
    2358:	e8 53 ee ff ff       	call   11b0 <puts@plt>
    235d:	48 8d 3d c4 0e 00 00 	lea    rdi,[rip+0xec4]        # 3228 <open@plt+0x1f78>
    2364:	e8 47 ee ff ff       	call   11b0 <puts@plt>
    2369:	48 8d 3d 30 0f 00 00 	lea    rdi,[rip+0xf30]        # 32a0 <open@plt+0x1ff0>
    2370:	e8 3b ee ff ff       	call   11b0 <puts@plt>
    2375:	48 8d 3d 64 0f 00 00 	lea    rdi,[rip+0xf64]        # 32e0 <open@plt+0x2030>
    237c:	e8 2f ee ff ff       	call   11b0 <puts@plt>
mprotect_rwx:
    2381:	c7 85 50 ff ff ff 00 	mov    DWORD PTR [rbp-0xb0],0x0 alloc count
    2388:	00 00 00
    238b:	48 8d 05 17 f0 ff ff 	lea    rax,[rip+0xfffffffffffff017] padding addr
    2392:	48 25 00 f0 ff ff    	and    rax,0xfffffffffffff000
    2398:	48 2d 00 10 00 00    	sub    rax,0x1000 base addr
    239e:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax save base addr
    23a5:	90                   	nop
    23a6:	8b 85 50 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb0] loop start: count
    23ac:	8d 50 01             	lea    edx,[rax+0x1] count+1
    23af:	89 95 50 ff ff ff    	mov    DWORD PTR [rbp-0xb0],edx inc count
    23b5:	c1 e0 0c             	shl    eax,0xc multiply 0x1000
    23b8:	48 63 d0             	movsxd rdx,eax count*0x1000
    23bb:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] base addr
    23c2:	48 01 d0             	add    rax,rdx base addr + count*0x1000
    23c5:	ba 07 00 00 00       	mov    edx,0x7 rwx
    23ca:	be 00 10 00 00       	mov    esi,0x1000 num of bytes to mprotect
    23cf:	48 89 c7             	mov    rdi,rax start at base addr + count*0x1000
    23d2:	e8 a9 ed ff ff       	call   1180 <mprotect@plt> rwx protect 4096 bytes
    23d7:	85 c0                	test   eax,eax return code
    23d9:	74 cb                	je     23a6 <open@plt+0x10f6> success jump loop start
change_bytes:
    23db:	c7 85 54 ff ff ff 00 	mov    DWORD PTR [rbp-0xac],0x0 alloc count
    23e2:	00 00 00 
    23e5:	e9 ce 00 00 00       	jmp    24b8 <open@plt+0x1208> jump loop cond
    23ea:	8b 85 54 ff ff ff    	mov    eax,DWORD PTR [rbp-0xac] loop start: count
    23f0:	83 c0 01             	add    eax,0x1 count+1
    23f3:	89 c6                	mov    esi,eax count+1
    23f5:	48 8d 3d 43 0f 00 00 	lea    rdi,[rip+0xf43] format str addr
    23fc:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    2401:	e8 8a ed ff ff       	call   1190 <printf@plt> print format, count+1
    2406:	48 8d 3d 47 0f 00 00 	lea    rdi,[rip+0xf47] format str addr
    240d:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    2412:	e8 79 ed ff ff       	call   1190 <printf@plt> print format
    2417:	48 8d 85 4e ff ff ff 	lea    rax,[rbp-0xb2] change byte buf addr
    241e:	48 89 c6             	mov    rsi,rax change byte buf addr
    2421:	48 8d 3d 45 0f 00 00 	lea    rdi,[rip+0xf45] format str addr
    2428:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    242d:	e8 4e ee ff ff       	call   1280 <__isoc99_scanf@plt> read format checked change byte
    2432:	48 8d 3d 38 0f 00 00 	lea    rdi,[rip+0xf38] format addr
    2439:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    243e:	e8 4d ed ff ff       	call   1190 <printf@plt> print format
    2443:	48 8d 85 4d ff ff ff 	lea    rax,[rbp-0xb3] value buf addr
    244a:	48 89 c6             	mov    rsi,rax value buf addr
    244d:	48 8d 3d 2f 0f 00 00 	lea    rdi,[rip+0xf2f] format str addr
    2454:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    2459:	e8 22 ee ff ff       	call   1280 <__isoc99_scanf@plt> read format checked value
    245e:	0f b6 8d 4d ff ff ff 	movzx  ecx,BYTE PTR [rbp-0xb3] value
    2465:	0f b7 85 4e ff ff ff 	movzx  eax,WORD PTR [rbp-0xb2] change byte
    246c:	0f b7 d0             	movzx  edx,ax change byte
    246f:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8] base addr
    2476:	48 01 d0             	add    rax,rdx base addr + change byte
    2479:	89 ca                	mov    edx,ecx value
    247b:	88 10                	mov    BYTE PTR [rax],dl value to change byte addr
    247d:	0f b6 85 4d ff ff ff 	movzx  eax,BYTE PTR [rbp-0xb3] value
    2484:	0f b6 c0             	movzx  eax,al
    2487:	0f b7 95 4e ff ff ff 	movzx  edx,WORD PTR [rbp-0xb2] change byte
    248e:	0f b7 ca             	movzx  ecx,dx change byte
    2491:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8] base addr
    2498:	48 01 d1             	add    rcx,rdx base addr + change byte
    249b:	89 c2                	mov    edx,eax value
    249d:	48 89 ce             	mov    rsi,rcx change byte addr
    24a0:	48 8d 3d e1 0e 00 00 	lea    rdi,[rip+0xee1] format str addr
    24a7:	b8 00 00 00 00       	mov    eax,0x0 num vect reg req for float
    24ac:	e8 df ec ff ff       	call   1190 <printf@plt> print format, change byte addr, value
    24b1:	83 85 54 ff ff ff 01 	add    DWORD PTR [rbp-0xac],0x1 inc count
    24b8:	83 bd 54 ff ff ff 04 	cmp    DWORD PTR [rbp-0xac],0x4 loop cond: count 4?
    24bf:	0f 8e 25 ff ff ff    	jle    23ea <open@plt+0x113a> <= jump loop start
    24c5:	48 c7 45 d0 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
    24cc:	00 
    24cd:	48 c7 45 d8 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
    24d4:	00 
    24d5:	48 c7 45 e0 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    24dc:	00 
    24dd:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [rbp-0x18],0x0
    24e4:	66 c7 45 ec 00 00    	mov    WORD PTR [rbp-0x14],0x0
    24ea:	48 8d 3d bf 0e 00 00 	lea    rdi,[rip+0xebf]        # 33b0 <open@plt+0x2100>
    24f1:	e8 ba ec ff ff       	call   11b0 <puts@plt>
    24f6:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    24fa:	ba 1d 00 00 00       	mov    edx,0x1d
    24ff:	48 89 c6             	mov    rsi,rax
    2502:	bf 00 00 00 00       	mov    edi,0x0
    2507:	e8 f4 ec ff ff       	call   1200 <read@plt>
    250c:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2513:	48 89 c7             	mov    rdi,rax
    2516:	e8 55 ed ff ff       	call   1270 <MD5_Init@plt>
    251b:	48 8d 4d d0          	lea    rcx,[rbp-0x30]
    251f:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2526:	ba 1d 00 00 00       	mov    edx,0x1d
    252b:	48 89 ce             	mov    rsi,rcx
    252e:	48 89 c7             	mov    rdi,rax
    2531:	e8 fa ec ff ff       	call   1230 <MD5_Update@plt>
    2536:	48 8d 95 60 ff ff ff 	lea    rdx,[rbp-0xa0]
    253d:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    2541:	48 89 d6             	mov    rsi,rdx
    2544:	48 89 c7             	mov    rdi,rax
    2547:	e8 d4 ec ff ff       	call   1220 <MD5_Final@plt>
    254c:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2550:	ba 1d 00 00 00       	mov    edx,0x1d
    2555:	be 00 00 00 00       	mov    esi,0x0
    255a:	48 89 c7             	mov    rdi,rax
    255d:	e8 3e ec ff ff       	call   11a0 <memset@plt>
    2562:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2566:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    256a:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    256e:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    2572:	48 8d 3d 5f 0e 00 00 	lea    rdi,[rip+0xe5f]        # 33d8 <open@plt+0x2128>
    2579:	e8 32 ec ff ff       	call   11b0 <puts@plt>
    257e:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2582:	ba 1d 00 00 00       	mov    edx,0x1d
    2587:	48 8d 35 82 2a 00 00 	lea    rsi,[rip+0x2a82]        # 5010 <open@plt+0x3d60>
    258e:	48 89 c7             	mov    rdi,rax
    2591:	e8 fa ec ff ff       	call   1290 <memcmp@plt>
    2596:	85 c0                	test   eax,eax
    2598:	75 14                	jne    25ae <open@plt+0x12fe>
    259a:	b8 00 00 00 00       	mov    eax,0x0
    259f:	e8 a2 fb ff ff       	call   2146 <open@plt+0xe96>
    25a4:	bf 00 00 00 00       	mov    edi,0x0
    25a9:	e8 12 ec ff ff       	call   11c0 <exit@plt>
    25ae:	48 8d 3d 47 0e 00 00 	lea    rdi,[rip+0xe47]        # 33fc <open@plt+0x214c>
    25b5:	e8 f6 eb ff ff       	call   11b0 <puts@plt>
    25ba:	bf 01 00 00 00       	mov    edi,0x1
    25bf:	e8 fc eb ff ff       	call   11c0 <exit@plt>
