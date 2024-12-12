00000000004012a4 <main>:
  4012a4:	f3 0f 1e fa          	endbr64
  4012a8:	41 57                	push   r15
  4012aa:	0f 57 c0             	xorps  xmm0,xmm0
  4012ad:	41 56                	push   r14
  4012af:	41 55                	push   r13
  4012b1:	41 54                	push   r12
  4012b3:	55                   	push   rbp
  4012b4:	53                   	push   rbx
  4012b5:	48 83 ec 38          	sub    rsp,0x38
  4012b9:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
  4012c0:	00 00 
  4012c2:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
  4012c7:	31 c0                	xor    eax,eax
  4012c9:	ff cf                	dec    edi
  4012cb:	0f 11 44 24 10       	movups XMMWORD PTR [rsp+0x10],xmm0
  4012d0:	48 c7 44 24 20 00 00 	mov    QWORD PTR [rsp+0x20],0x0
  4012d7:	00 00 
  4012d9:	7e 4f                	jle    40132a <main+0x86>
  4012db:	48 8b 6e 08          	mov    rbp,QWORD PTR [rsi+0x8]
  4012df:	48 83 c9 ff          	or     rcx,0xffffffffffffffff
  4012e3:	48 8d 35 3a 0f 00 00 	lea    rsi,[rip+0xf3a]        # 402224 <_IO_stdin_used+0x224>
  4012ea:	48 89 ef             	mov    rdi,rbp
  4012ed:	f2 ae                	repnz scas al,BYTE PTR es:[rdi]
  4012ef:	48 f7 d1             	not    rcx
  4012f2:	48 8d 7c 0d fa       	lea    rdi,[rbp+rcx*1-0x6]
  4012f7:	e8 f4 fe ff ff       	call   4011f0 <strcmp@plt>
  4012fc:	85 c0                	test   eax,eax
  4012fe:	74 15                	je     401315 <main+0x71>
  401300:	48 8d 35 23 0f 00 00 	lea    rsi,[rip+0xf23]        # 40222a <_IO_stdin_used+0x22a>
  401307:	bf 01 00 00 00       	mov    edi,0x1
  40130c:	31 c0                	xor    eax,eax
  40130e:	e8 fd fe ff ff       	call   401210 <__printf_chk@plt>
  401313:	eb 4a                	jmp    40135f <main+0xbb>
  401315:	31 f6                	xor    esi,esi
  401317:	48 89 ef             	mov    rdi,rbp
  40131a:	31 c0                	xor    eax,eax
  40131c:	e8 0f ff ff ff       	call   401230 <open@plt>
  401321:	31 f6                	xor    esi,esi
  401323:	89 c7                	mov    edi,eax
  401325:	e8 76 fe ff ff       	call   4011a0 <dup2@plt>
header:
  40132a:	48 8d 5c 24 10       	lea    rbx,[rsp+0x10]
  40132f:	41 83 c8 ff          	or     r8d,0xffffffff
  401333:	31 ff                	xor    edi,edi
  401335:	ba 0c 00 00 00       	mov    edx,0xc
  40133a:	48 8d 0d 0d 0f 00 00 	lea    rcx,[rip+0xf0d]        # 40224e <_IO_stdin_used+0x24e>
  401341:	48 89 de             	mov    rsi,rbx
  401344:	e8 32 03 00 00       	call   40167b <read_exact>
  401349:	81 7c 24 10 63 49 4d 	cmp    DWORD PTR [rsp+0x10],0x474d4963
  401350:	47 
  401351:	74 14                	je     401367 <main+0xc3>
  401353:	48 8d 3d 17 0f 00 00 	lea    rdi,[rip+0xf17]        # 402271 <_IO_stdin_used+0x271>
  40135a:	e8 11 fe ff ff       	call   401170 <puts@plt>
  40135f:	83 cf ff             	or     edi,0xffffffff
  401362:	e8 d9 fe ff ff       	call   401240 <exit@plt>
  401367:	66 83 7c 24 14 03    	cmp    WORD PTR [rsp+0x14],0x3
  40136d:	48 8d 3d 1a 0f 00 00 	lea    rdi,[rip+0xf1a]        # 40228e <_IO_stdin_used+0x28e>
  401374:	75 e4                	jne    40135a <main+0xb6>
  401376:	48 89 df             	mov    rdi,rbx
  401379:	48 8d 6c 24 0e       	lea    rbp,[rsp+0xe]
  40137e:	e8 ef 06 00 00       	call   401a72 <initialize_framebuffer>
directives:
  401383:	8b 44 24 18          	mov    eax,DWORD PTR [rsp+0x18]
  401387:	8d 50 ff             	lea    edx,[rax-0x1]
  40138a:	89 54 24 18          	mov    DWORD PTR [rsp+0x18],edx
  40138e:	85 c0                	test   eax,eax
  401390:	74 5e                	je     4013f0 <main+0x14c>
  401392:	48 8d 0d 11 0f 00 00 	lea    rcx,[rip+0xf11]        # 4022aa <_IO_stdin_used+0x2aa>
  401399:	41 83 c8 ff          	or     r8d,0xffffffff
  40139d:	48 89 ee             	mov    rsi,rbp
  4013a0:	31 ff                	xor    edi,edi
  4013a2:	ba 02 00 00 00       	mov    edx,0x2
  4013a7:	e8 cf 02 00 00       	call   40167b <read_exact>
  4013ac:	0f b7 4c 24 0e       	movzx  ecx,WORD PTR [rsp+0xe]
  4013b1:	66 83 f9 01          	cmp    cx,0x1
  4013b5:	74 10                	je     4013c7 <main+0x123>
  4013b7:	66 83 f9 02          	cmp    cx,0x2
  4013bb:	75 14                	jne    4013d1 <main+0x12d>
  4013bd:	48 89 df             	mov    rdi,rbx
  4013c0:	e8 98 04 00 00       	call   40185d <handle_2>
  4013c5:	eb bc                	jmp    401383 <main+0xdf>
  4013c7:	48 89 df             	mov    rdi,rbx
  4013ca:	e8 0b 03 00 00       	call   4016da <handle_1>
  4013cf:	eb b2                	jmp    401383 <main+0xdf> # jump directives

  4013d1:	48 8b 3d c8 d9 00 00 	mov    rdi,QWORD PTR [rip+0xd9c8]        # 40eda0 <stderr@GLIBC_2.2.5>
  4013d8:	48 8d 15 f2 0e 00 00 	lea    rdx,[rip+0xef2]        # 4022d1 <_IO_stdin_used+0x2d1>
  4013df:	be 01 00 00 00       	mov    esi,0x1
  4013e4:	31 c0                	xor    eax,eax
  4013e6:	e8 65 fe ff ff       	call   401250 <__fprintf_chk@plt>
  4013eb:	e9 6f ff ff ff       	jmp    40135f <main+0xbb>

  4013f0:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20]
  4013f5:	31 db                	xor    ebx,ebx
  4013f7:	4c 8d 25 22 2c 00 00 	lea    r12,[rip+0x2c22]        # 404020 <desired_output>
  4013fe:	e8 6d fd ff ff       	call   401170 <puts@plt>
  401403:	44 8b 74 24 1c       	mov    r14d,DWORD PTR [rsp+0x1c]
  401408:	4c 8b 6c 24 20       	mov    r13,QWORD PTR [rsp+0x20]
  40140d:	41 81 fe 38 07 00 00 	cmp    r14d,0x738
  401414:	0f 94 c3             	sete   bl
  401417:	31 ed                	xor    ebp,ebp
  401419:	45 31 ff             	xor    r15d,r15d
  40141c:	41 39 ee             	cmp    r14d,ebp
  40141f:	76 3f                	jbe    401460 <main+0x1bc>
  401421:	81 fd 38 07 00 00    	cmp    ebp,0x738
  401427:	74 37                	je     401460 <main+0x1bc>
  401429:	41 8a 45 13          	mov    al,BYTE PTR [r13+0x13]
  40142d:	41 3a 44 24 13       	cmp    al,BYTE PTR [r12+0x13]
  401432:	41 0f 45 df          	cmovne ebx,r15d
  401436:	3c 20                	cmp    al,0x20
  401438:	74 1a                	je     401454 <main+0x1b0>
  40143a:	3c 0a                	cmp    al,0xa
  40143c:	74 16                	je     401454 <main+0x1b0>
  40143e:	ba 18 00 00 00       	mov    edx,0x18
  401443:	4c 89 e6             	mov    rsi,r12
  401446:	4c 89 ef             	mov    rdi,r13
  401449:	e8 92 fd ff ff       	call   4011e0 <memcmp@plt>
  40144e:	85 c0                	test   eax,eax
  401450:	41 0f 45 df          	cmovne ebx,r15d
  401454:	ff c5                	inc    ebp
  401456:	49 83 c5 18          	add    r13,0x18
  40145a:	49 83 c4 18          	add    r12,0x18
  40145e:	eb bc                	jmp    40141c <main+0x178>
  401460:	48 81 3d 45 d9 00 00 	cmp    QWORD PTR [rip+0xd945],0x53c        # 40edb0 <total_data>
  401467:	3c 05 00 00 
  40146b:	77 0c                	ja     401479 <main+0x1d5>
  40146d:	80 e3 01             	and    bl,0x1
  401470:	74 07                	je     401479 <main+0x1d5>
  401472:	31 c0                	xor    eax,eax
  401474:	e8 0d 01 00 00       	call   401586 <win>
  401479:	48 8b 44 24 28       	mov    rax,QWORD PTR [rsp+0x28]
  40147e:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401485:	00 00 
  401487:	74 05                	je     40148e <main+0x1ea>
  401489:	e8 02 fd ff ff       	call   401190 <__stack_chk_fail@plt>
  40148e:	48 83 c4 38          	add    rsp,0x38
  401492:	31 c0                	xor    eax,eax
  401494:	5b                   	pop    rbx
  401495:	5d                   	pop    rbp
  401496:	41 5c                	pop    r12
  401498:	41 5d                	pop    r13
  40149a:	41 5e                	pop    r14
  40149c:	41 5f                	pop    r15
  40149e:	c3                   	ret
  40149f:	90                   	nop

00000000004016da <handle_1>:
  4016da:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  4016de:	41 57                	push   r15 # save
  4016e0:	41 56                	push   r14 # save
  4016e2:	41 55                	push   r13 # save
  4016e4:	41 54                	push   r12 # save
  4016e6:	55                   	push   rbp # save
  4016e7:	53                   	push   rbx # save
  4016e8:	48 89 fb             	mov    rbx,rdi # main buf addr
  4016eb:	48 83 ec 48          	sub    rsp,0x48 # alloc local vars
  4016ef:	0f b6 6f 06          	movzx  ebp,BYTE PTR [rdi+0x6] # x
  4016f3:	0f b6 57 07          	movzx  edx,BYTE PTR [rdi+0x7] # y
  4016f7:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  4016fe:	00 00 
  401700:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax # stack guard canary to stack
  401705:	31 c0                	xor    eax,eax # zero eax
  401707:	0f af ea             	imul   ebp,edx # x*y
  40170a:	48 63 ed             	movsxd rbp,ebp # x*y
  40170d:	48 c1 e5 02          	shl    rbp,0x2 # x*y*4
  401711:	48 89 ef             	mov    rdi,rbp # x*y*4
  401714:	e8 e7 fa ff ff       	call   401200 <malloc@plt>
  401719:	48 85 c0             	test   rax,rax
  40171c:	75 0e                	jne    40172c <handle_1+0x52> # jump if malloc success
malloc_fail:
  40171e:	48 8d 3d ae 09 00 00 	lea    rdi,[rip+0x9ae] # str err addr # 4020d3 <_IO_stdin_used+0xd3>
  401725:	e8 46 fa ff ff       	call   401170 <puts@plt>
  40172a:	eb 57                	jmp    401783 <handle_1+0xa9> # jump crash
read_input:
  40172c:	89 ea                	mov    edx,ebp # x*y*4
  40172e:	48 89 c6             	mov    rsi,rax # input pixel buf addr
  401731:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401735:	31 ff                	xor    edi,edi # stdin fd
  401737:	48 8d 0d ca 09 00 00 	lea    rcx,[rip+0x9ca] # err str addr # 402108 <_IO_stdin_used+0x108>
  40173e:	49 89 c4             	mov    r12,rax # input pixel buf addr
  401741:	e8 35 ff ff ff       	call   40167b <read_exact>
check_input:
  401746:	0f b6 43 07          	movzx  eax,BYTE PTR [rbx+0x7] # y
  40174a:	0f b6 53 06          	movzx  edx,BYTE PTR [rbx+0x6] # x
  40174e:	0f af d0             	imul   edx,eax # x*y
  401751:	31 c0                	xor    eax,eax # zero counter
1:
  401753:	39 c2                	cmp    edx,eax
  401755:	7e 34                	jle    40178b <handle_1+0xb1> # jump handle_input if x*y <= counter
  401757:	41 0f b6 4c 84 03    	movzx  ecx,BYTE PTR [r12+rax*4+0x3] # 4th current input pixel buf byte
  40175d:	48 ff c0             	inc    rax # counter ++
  401760:	8d 71 e0             	lea    esi,[rcx-0x20]
  401763:	40 80 fe 5e          	cmp    sil,0x5e
  401767:	76 ea                	jbe    401753 <handle_1+0x79> # jump 1 if 4th current input pixel buf byte -0x20 <= 0x5e
  401769:	48 8b 3d 30 d6 00 00 	mov    rdi,QWORD PTR [rip+0xd630] # stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  401770:	48 8d 15 ad 09 00 00 	lea    rdx,[rip+0x9ad] # err str addr # 402124 <_IO_stdin_used+0x124>
  401777:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  40177c:	31 c0                	xor    eax,eax # num vec regs used
  40177e:	e8 cd fa ff ff       	call   401250 <__fprintf_chk@plt>
crash:
  401783:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401786:	e8 b5 fa ff ff       	call   401240 <exit@plt>
handle_input:
  40178b:	45 31 ed             	xor    r13d,r13d # zero y_counter
  40178e:	4c 8d 74 24 1f       	lea    r14,[rsp+0x1f] # tmp fb pixel buf addr
  401793:	0f b6 43 07          	movzx  eax,BYTE PTR [rbx+0x7] # y
  401797:	44 39 e8             	cmp    eax,r13d
  40179a:	0f 8e 99 00 00 00    	jle    401839 <handle_1+0x15f> # jump stack_check if y <= y_counter
  4017a0:	31 ed                	xor    ebp,ebp # zero x_counter
  4017a2:	44 0f b6 7b 06       	movzx  r15d,BYTE PTR [rbx+0x6] # x
  4017a7:	41 39 ef             	cmp    r15d,ebp
  4017aa:	0f 8e 81 00 00 00    	jle    401831 <handle_1+0x157> jump 3 if x <= x_counter
  4017b0:	41 8d 47 01          	lea    eax,[r15+0x1] # x+1
  4017b4:	4c 8d 05 9b 09 00 00 	lea    r8,[rip+0x99b] # format str addr as arg 5 # 402156 <_IO_stdin_used+0x156>
  4017bb:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes as arg 4
  4017c0:	4c 89 f7             	mov    rdi,r14 # tmp fb pixel buf addr as arg 1
  4017c3:	41 0f af c5          	imul   eax,r13d # (x+1)*y
  4017c7:	be 19 00 00 00       	mov    esi,0x19 # num bytes as arg 2
  4017cc:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax
  4017d0:	44 29 e8             	sub    eax,r13d # (x+1)*y-y as num input buf pixels in prev lines
  4017d3:	01 e8                	add    eax,ebp # num input buf pixels in prev lines + x_counter
  4017d5:	52                   	push   rdx # save rdx for stack alignment
  4017d6:	48 98                	cdqe
  4017d8:	49 8d 04 84          	lea    rax,[r12+rax*4] # current input pixel item addr
  4017dc:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3]
  4017e0:	52                   	push   rdx # input pixel 4th byte as arg 9
  4017e1:	0f b6 50 02          	movzx  edx,BYTE PTR [rax+0x2]
  4017e5:	52                   	push   rdx # input pixel 3rd byte as arg 8
  4017e6:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  4017ea:	52                   	push   rdx # input pixel 2nd byte as arg 7
  4017eb:	44 0f b6 08          	movzx  r9d,BYTE PTR [rax] # input pixel 1st byte as arg 6
  4017ef:	ba 01 00 00 00       	mov    edx,0x1 # security flag val as arg 3
  4017f4:	31 c0                	xor    eax,eax # num vec regs used
  4017f6:	e8 55 f9 ff ff       	call   401150 <__snprintf_chk@plt>
  4017fb:	89 e8                	mov    eax,ebp
  4017fd:	44 8b 54 24 2c       	mov    r10d,DWORD PTR [rsp+0x2c]
  401802:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14]
  401806:	99                   	cdq
  401807:	48 83 c4 20          	add    rsp,0x20
  40180b:	ff c5                	inc    ebp
  40180d:	41 f7 ff             	idiv   r15d
  401810:	42 8d 04 12          	lea    eax,[rdx+r10*1]
  401814:	31 d2                	xor    edx,edx
  401816:	f7 73 0c             	div    DWORD PTR [rbx+0xc]
  401819:	48 6b d2 18          	imul   rdx,rdx,0x18
  40181d:	48 03 53 10          	add    rdx,QWORD PTR [rbx+0x10]
  401821:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0
  401824:	49 8b 46 10          	mov    rax,QWORD PTR [r14+0x10]
  401828:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
  40182c:	e9 71 ff ff ff       	jmp    4017a2 <handle_1+0xc8>
3:
  401831:	41 ff c5             	inc    r13d
  401834:	e9 5a ff ff ff       	jmp    401793 <handle_1+0xb9>
stack_check:
  401839:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38] # aktual stack guard canary
  40183e:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28 # expected stack guard canary
  401845:	00 00 
  401847:	74 05                	je     40184e <handle_1+0x174> # jump end if stack guard canary success
  401849:	e8 42 f9 ff ff       	call   401190 <__stack_chk_fail@plt> # fail
end:
  40184e:	48 83 c4 48          	add    rsp,0x48 # clean up stack local vars
  401852:	5b                   	pop    rbx # restore
  401853:	5d                   	pop    rbp # restore
  401854:	41 5c                	pop    r12 # restore
  401856:	41 5d                	pop    r13 # restore
  401858:	41 5e                	pop    r14 # restore
  40185a:	41 5f                	pop    r15 # restore
  40185c:	c3                   	ret

000000000040185d <handle_2>:
  40185d:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  401861:	41 57                	push   r15 # save
  401863:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401867:	ba 01 00 00 00       	mov    edx,0x1 # num bytes as arg 3
  40186c:	48 8d 0d 00 09 00 00 	lea    rcx,[rip+0x900] # base x err str addr as arg 4 # 402173 <_IO_stdin_used+0x173>
  401873:	41 56                	push   r14 # save
  401875:	41 55                	push   r13 # save
  401877:	41 54                	push   r12 # save
  401879:	49 89 fc             	mov    r12,rdi # main buf addr
  40187c:	31 ff                	xor    edi,edi # stdin fd as arg 1
  40187e:	55                   	push   rbp # save
  40187f:	53                   	push   rbx # save
  401880:	48 83 ec 38          	sub    rsp,0x38 # alloc local vars
  401884:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  40188b:	00 00 
  40188d:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax # stack guard canary to stack
  401892:	31 c0                	xor    eax,eax # zero
  401894:	48 8d 74 24 0d       	lea    rsi,[rsp+0xd] # base_x addr as arg 2
  401899:	e8 dd fd ff ff       	call   40167b <read_exact> read base_x
  40189e:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  4018a2:	31 ff                	xor    edi,edi # stdin fd
  4018a4:	48 8d 74 24 0e       	lea    rsi,[rsp+0xe] # base_y addr
  4018a9:	48 8d 0d e2 08 00 00 	lea    rcx,[rip+0x8e2] # base y err str addr # 402192 <_IO_stdin_used+0x192>
  4018b0:	ba 01 00 00 00       	mov    edx,0x1 # num bytes
  4018b5:	e8 c1 fd ff ff       	call   40167b <read_exact> read base_y
  4018ba:	41 83 c8 ff          	or     r8d,0xffffffff
  4018be:	31 ff                	xor    edi,edi
  4018c0:	48 8d 74 24 0b       	lea    rsi,[rsp+0xb]
  4018c5:	48 8d 0d e5 08 00 00 	lea    rcx,[rip+0x8e5]        # 4021b1 <_IO_stdin_used+0x1b1>
  4018cc:	ba 01 00 00 00       	mov    edx,0x1
  4018d1:	e8 a5 fd ff ff       	call   40167b <read_exact> # read width
  4018d6:	31 ff                	xor    edi,edi
  4018d8:	41 83 c8 ff          	or     r8d,0xffffffff
  4018dc:	ba 01 00 00 00       	mov    edx,0x1
  4018e1:	48 8d 74 24 0c       	lea    rsi,[rsp+0xc]
  4018e6:	48 8d 0d e2 08 00 00 	lea    rcx,[rip+0x8e2]        # 4021cf <_IO_stdin_used+0x1cf>
  4018ed:	e8 89 fd ff ff       	call   40167b <read_exact> # read height
alloc_input_pixel_buf:
  4018f2:	0f b6 5c 24 0b       	movzx  ebx,BYTE PTR [rsp+0xb] # width
  4018f7:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [rsp+0xc] # height
  4018fc:	0f af da             	imul   ebx,edx # width*height as num pixels
  4018ff:	48 63 db             	movsxd rbx,ebx # num pixels
  401902:	48 c1 e3 02          	shl    rbx,0x2 # num pixels * 4
  401906:	48 89 df             	mov    rdi,rbx
  401909:	e8 f2 f8 ff ff       	call   401200 <malloc@plt>
malloc_err:
  40190e:	48 85 c0             	test   rax,rax
  401911:	75 0e                	jne    401921 <handle_2+0xc4>
  401913:	48 8d 3d b9 07 00 00 	lea    rdi,[rip+0x7b9]        # 4020d3 <_IO_stdin_used+0xd3>
  40191a:	e8 51 f8 ff ff       	call   401170 <puts@plt>
  40191f:	eb 58                	jmp    401979 <handle_2+0x11c> # jump crash
read_pixel_data:
  401921:	89 da                	mov    edx,ebx # num pixels * 4
  401923:	48 89 c6             	mov    rsi,rax # input pixel buf addr
  401926:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  40192a:	31 ff                	xor    edi,edi # stdin fd
  40192c:	48 8d 0d d5 07 00 00 	lea    rcx,[rip+0x7d5] # data err str addr # 402108 <_IO_stdin_used+0x108>
  401933:	48 89 c5             	mov    rbp,rax # input pixel buf addr
  401936:	e8 40 fd ff ff       	call   40167b <read_exact>
  40193b:	0f b6 44 24 0c       	movzx  eax,BYTE PTR [rsp+0xc] # height
  401940:	0f b6 54 24 0b       	movzx  edx,BYTE PTR [rsp+0xb] # width
  401945:	0f af d0             	imul   edx,eax # width*height as num pixels
  401948:	31 c0                	xor    eax,eax # zero counter
check_input_pixels:
  40194a:	39 c2                	cmp    edx,eax
  40194c:	7e 33                	jle    401981 <handle_2+0x124> # jump input_pixels_to_fb_pixels if num pixels <= counter
  40194e:	0f b6 4c 85 03       	movzx  ecx,BYTE PTR [rbp+rax*4+0x3]
  401953:	48 ff c0             	inc    rax
  401956:	8d 71 e0             	lea    esi,[rcx-0x20]
  401959:	40 80 fe 5e          	cmp    sil,0x5e
  40195d:	76 eb                	jbe    40194a <handle_2+0xed> # jump check_input_pixels if 4th byte of input pixel item - 0x20 <= 0x5e
  40195f:	48 8b 3d 3a d4 00 00 	mov    rdi,QWORD PTR [rip+0xd43a] # stderr file addr       # 40eda0 <stderr@GLIBC_2.2.5>
  401966:	48 8d 15 b7 07 00 00 	lea    rdx,[rip+0x7b7] # err str addr # 402124 <_IO_stdin_used+0x124>
  40196d:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  401972:	31 c0                	xor    eax,eax # num vec regs used
  401974:	e8 d7 f8 ff ff       	call   401250 <__fprintf_chk@plt>
crash:
  401979:	83 cf ff             	or     edi,0xffffffff
  40197c:	e8 bf f8 ff ff       	call   401240 <exit@plt>
input_pixels_to_fb_pixels:
  401981:	45 31 ed             	xor    r13d,r13d # zero y_counter
  401984:	4c 8d 7c 24 0f       	lea    r15,[rsp+0xf] # tmp fb pixel buf addr
1:
  401989:	0f b6 44 24 0c       	movzx  eax,BYTE PTR [rsp+0xc] # height
  40198e:	44 39 e8             	cmp    eax,r13d
  401991:	0f 8e aa 00 00 00    	jle    401a41 <handle_2+0x1e4> # jump canary_check if height <= y_counter
  401997:	45 31 f6             	xor    r14d,r14d # zero x_counter
2:
  40199a:	0f b6 4c 24 0b       	movzx  ecx,BYTE PTR [rsp+0xb] # width
  40199f:	44 39 f1             	cmp    ecx,r14d
  4019a2:	0f 8e 91 00 00 00    	jle    401a39 <handle_2+0x1dc> # jump 3 if width <= x_counter
  4019a8:	0f b6 5c 24 0e       	movzx  ebx,BYTE PTR [rsp+0xe] # base_y
  4019ad:	0f b6 44 24 0d       	movzx  eax,BYTE PTR [rsp+0xd] # base_x
  4019b2:	41 0f af cd          	imul   ecx,r13d # width*y_counter as num pixels patched in prev lines
  4019b6:	4c 89 ff             	mov    rdi,r15 # tmp fb pixel buf addr as arg 1
  4019b9:	41 0f b6 74 24 06    	movzx  esi,BYTE PTR [r12+0x6] # x
  4019bf:	4c 8d 05 90 07 00 00 	lea    r8,[rip+0x790] # fb pixel format str addr as arg 5 # 402156 <_IO_stdin_used+0x156>
  4019c6:	44 01 f0             	add    eax,r14d # base_x + x_counter
  4019c9:	44 01 eb             	add    ebx,r13d # base_y + y_counter
  4019cc:	8d 56 01             	lea    edx,[rsi+0x1] # x+1
  4019cf:	44 01 f1             	add    ecx,r14d # num pixels patched in prev lines + x_counter
  4019d2:	41 ff c6             	inc    r14d # x_counter ++
  4019d5:	0f af da             	imul   ebx,edx # num pixels in prev lines in frame buf
  4019d8:	99                   	cdq
  4019d9:	48 63 c9             	movsxd rcx,ecx # num pixels patched in prev lines + x_counter
  4019dc:	f7 fe                	idiv   esi # base_x + x_counter / x
  4019de:	48 8d 44 8d 00       	lea    rax,[rbp+rcx*4+0x0] # current input pixel item addr
  4019e3:	be 19 00 00 00       	mov    esi,0x19 # num bytes as arg 2
  4019e8:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes as arg 4
  4019ed:	01 d3                	add    ebx,edx # num pixels in prev lines in frame buf + (base_x + x_counter / x)
  4019ef:	52                   	push   rdx # push to align stack args
  4019f0:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3]
  4019f4:	52                   	push   rdx # 4th input pixel item byte as arg 9
  4019f5:	0f b6 50 02          	movzx  edx,BYTE PTR [rax+0x2]
  4019f9:	52                   	push   rdx # 3rd input pixel item byte as arg 8
  4019fa:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1]
  4019fe:	52                   	push   rdx # 2nd input pixel item byte as arg 7
  4019ff:	44 0f b6 08          	movzx  r9d,BYTE PTR [rax] # 1st input pixel item byte as arg 6
  401a03:	ba 01 00 00 00       	mov    edx,0x1 # security flag val as arg 3
  401a08:	31 c0                	xor    eax,eax # num vec regs used
  401a0a:	e8 41 f7 ff ff       	call   401150 <__snprintf_chk@plt>
  401a0f:	89 d8                	mov    eax,ebx # num pixels in prev lines in frame buf + current pixel pos
  401a11:	31 d2                	xor    edx,edx
  401a13:	41 0f 10 07          	movups xmm0,XMMWORD PTR [r15] # 16 bytes of tmp pixel buf
  401a17:	41 f7 74 24 0c       	div    DWORD PTR [r12+0xc] # / fb dimensions
  401a1c:	48 83 c4 20          	add    rsp,0x20 # clean up snprintf stack args
  401a20:	48 6b d2 18          	imul   rdx,rdx,0x18 # fb pixel offset
  401a24:	49 03 54 24 10       	add    rdx,QWORD PTR [r12+0x10] # add frame buf addr
  401a29:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0 # 16 bytes of tmp pixel buf to frame buf
  401a2c:	49 8b 47 10          	mov    rax,QWORD PTR [r15+0x10] # 8 remaining bytes of tmp pixel buf
  401a30:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax # 8 remaining bytes of tmp pixel buf to frame buf
  401a34:	e9 61 ff ff ff       	jmp    40199a <handle_2+0x13d> # jump 2
3:
  401a39:	41 ff c5             	inc    r13d # y_counter ++
  401a3c:	e9 48 ff ff ff       	jmp    401989 <handle_2+0x12c> # jump 1
canary_check:
  401a41:	48 8b 44 24 28       	mov    rax,QWORD PTR [rsp+0x28] # actual stack guard canary
  401a46:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28 # expected stack guard canary
  401a4d:	00 00 
  401a4f:	74 05                	je     401a56 <handle_2+0x1f9> # jump end if stack guard canary check success
  401a51:	e8 3a f7 ff ff       	call   401190 <__stack_chk_fail@plt> # fail
end:
  401a56:	48 83 c4 38          	add    rsp,0x38 # clean up stack local vars
  401a5a:	5b                   	pop    rbx # restore
  401a5b:	5d                   	pop    rbp # restore
  401a5c:	41 5c                	pop    r12 # restore
  401a5e:	41 5d                	pop    r13 # restore
  401a60:	41 5e                	pop    r14 # restore
  401a62:	41 5f                	pop    r15 # restore
  401a64:	c3                   	ret
