00000000004012a4 <main>:
  4012a4:	f3 0f 1e fa          	endbr64 allow indirect jumps
  4012a8:	41 57                	push   r15 save
  4012aa:	0f 57 c0             	xorps  xmm0,xmm0 zero xmm0
  4012ad:	41 56                	push   r14 save
  4012af:	41 55                	push   r13 save
  4012b1:	41 54                	push   r12 save
  4012b3:	55                   	push   rbp save current stack frame
  4012b4:	53                   	push   rbx save
  4012b5:	48 83 ec 28          	sub    rsp,0x28 alloc local vars
  4012b9:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
  4012c0:	00 00 
  4012c2:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax stack guard canaray to stack
  4012c7:	31 c0                	xor    eax,eax zero eax
  4012c9:	ff cf                	dec    edi dec argc
  4012cb:	0f 11 04 24          	movups XMMWORD PTR [rsp],xmm0 zero 16 bytes of buf
  4012cf:	48 c7 44 24 10 00 00 	mov    QWORD PTR [rsp+0x10],0x0 zero 8 bytes of buf
  4012d6:	00 00 
  4012d8:	7e 4f                	jle    401329 <main+0x85> jump handle_img_header_input if argc-1 <= 0

  ...

handle_img_header_input:
  401329:	49 89 e4             	mov    r12,rsp save buf addr
  40132c:	41 83 c8 ff          	or     r8d,0xffffffff err code -1
  401330:	31 ff                	xor    edi,edi stdin fd
  401332:	ba 08 00 00 00       	mov    edx,0x8 num bytes read
  401337:	48 8d 0d 12 0e 00 00 	lea    rcx,[rip+0xe12] err str addr # 402150 <_IO_stdin_used+0x150>
  40133e:	4c 89 e6             	mov    rsi,r12 buf addr
  401341:	e8 45 03 00 00       	call   40168b <read_exact>

check_magic:
  401346:	81 3c 24 63 49 4d 47 	cmp    DWORD PTR [rsp],0x474d4963
  40134d:	74 14                	je     401363 <main+0xbf>

handle_err:
  40134f:       48 8d 3d 1d 0e 00 00    lea    rdi,[rip+0xe1d]        # 402173 <_IO_stdin_used+0x173>
  401356:       e8 15 fe ff ff          call   401170 <puts@plt>
  40135b:       83 cf ff                or     edi,0xffffffff
  40135e:       e8 dd fe ff ff          call   401240 <exit@plt>

check_version:
  401363:       66 83 7c 24 04 02       cmp    WORD PTR [rsp+0x4],0x2
  401369:       48 8d 3d 20 0e 00 00    lea    rdi,[rip+0xe20] err str addr # 402190 <_IO_stdin_used+0x190>
  401370:       75 e4                   jne    401356 <main+0xb2> jump handle_error if not version 2

handle_framebuffer:
  401372:       4c 89 e7                mov    rdi,r12 buf addr
  401375:       e8 65 04 00 00          call   4017df <initialize_framebuffer>

malloc_img_content_buf:
  40137a:       0f b6 5c 24 06          movzx  ebx,BYTE PTR [rsp+0x6] x
  40137f:       0f b6 54 24 07          movzx  edx,BYTE PTR [rsp+0x7] y
  401384:       0f af da                imul   ebx,edx x * y
  401387:       48 63 db                movsxd rbx,ebx x * y
  40138a:       48 c1 e3 02             shl    rbx,0x2 4 * x * y
  40138e:       48 89 df                mov    rdi,rbx 4 * x * y
  401391:       e8 6a fe ff ff          call   401200 <malloc@plt>
  401396:       48 8d 3d 0f 0e 00 00    lea    rdi,[rip+0xe0f] err str addr # 4021ac <_IO_stdin_used+0x1ac>
  40139d:       48 89 c5                mov    rbp,rax save img content buf addr
  4013a0:       48 85 c0                test   rax,rax 
  4013a3:       74 b1                   je     401356 <main+0xb2> jump handle_err if content buf addr zero

handle_img_content_input:
  4013a5:       89 da                   mov    edx,ebx 4 * x * y
  4013a7:       48 89 c6                mov    rsi,rax img content buf addr
  4013aa:       41 83 c8 ff             or     r8d,0xffffffff err code
  4013ae:       31 ff                   xor    edi,edi stdin fd
  4013b0:       48 8d 0d 2a 0e 00 00    lea    rcx,[rip+0xe2a] err str addr # 4021e1 <_IO_stdin_used+0x1e1>
  4013b7:       e8 cf 02 00 00          call   40168b <read_exact>

check_img_content:
  4013bc:       0f b6 44 24 07          movzx  eax,BYTE PTR [rsp+0x7] y
  4013c1:       0f b6 54 24 06          movzx  edx,BYTE PTR [rsp+0x6] x
  4013c6:       0f af d0                imul   edx,eax x * y
  4013c9:       31 c0                   xor    eax,eax zero counter
1:
  4013cb:       39 c2                   cmp    edx,eax
  4013cd:	7e 30                	jle    4013ff <main+0x15b> jump handle_display if x * y <= counter
  4013cf:	0f b6 4c 85 03       	movzx  ecx,BYTE PTR [rbp+rax*4+0x3]
  4013d4:	48 ff c0             	inc    rax
  4013d7:	8d 71 e0             	lea    esi,[rcx-0x20]
  4013da:	40 80 fe 5e          	cmp    sil,0x5e
  4013de:	76 eb                	jbe    4013cb <main+0x127> jump 1 if 4th byte - 0x20 of 4 byte int img pixel <= 0x5e

handle_4th_byte_err:
  4013e0:	48 8b 3d b9 d9 00 00 	mov    rdi,QWORD PTR [rip+0xd9b9] stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  4013e7:	48 8d 15 0f 0e 00 00 	lea    rdx,[rip+0xe0f] err str addr # 4021fd <_IO_stdin_used+0x1fd>
  4013ee:	be 01 00 00 00       	mov    esi,0x1
  4013f3:	31 c0                	xor    eax,eax num vec reg used
  4013f5:	e8 56 fe ff ff       	call   401250 <__fprintf_chk@plt>
  4013fa:	e9 5c ff ff ff       	jmp    40135b <main+0xb7> jump handle_err

handle_display:
  4013ff:	48 89 ee             	mov    rsi,rbp img content buf addr
  401402:	4c 89 e7             	mov    rdi,r12 buf addr
  401405:	4c 8d 25 14 2c 00 00 	lea    r12,[rip+0x2c14] des outp addr # 404020 <desired_output>
  40140c:	31 db                	xor    ebx,ebx zero
  40140e:	e8 c8 02 00 00       	call   4016db <display>

  401413:	44 8b 74 24 08       	mov    r14d,DWORD PTR [rsp+0x8] (x+1) * y
  401418:	4c 8b 6c 24 10       	mov    r13,QWORD PTR [rsp+0x10] frame buf addr
  40141d:	41 81 fe 38 07 00 00 	cmp    r14d,0x738
  401424:	0f 94 c3             	sete   bl allow_flag=1 if (x+1) * y == 0x738
  401427:	31 ed                	xor    ebp,ebp zero counter
  401429:	45 31 ff             	xor    r15d,r15d zero
1:
  40142c:	81 fd 38 07 00 00    	cmp    ebp,0x738
  401432:	74 3c                	je     401470 <main+0x1cc> jump 3 if counter == 0x738
  401434:	41 39 ee             	cmp    r14d,ebp
  401437:	76 37                	jbe    401470 <main+0x1cc> jump 3 if (x+1) * y <= counter
  401439:	41 8a 45 13          	mov    al,BYTE PTR [r13+0x13] frame buf addr + 0x13 byte
  40143d:	41 3a 44 24 13       	cmp    al,BYTE PTR [r12+0x13] des outp addr + 0x13 byte
  401442:	41 0f 45 df          	cmovne ebx,r15d allow_flag=0 if des outp addr + 0x13 byte != frame buf addr + 0x13 byte
  401446:	3c 20                	cmp    al,0x20
  401448:	74 1a                	je     401464 <main+0x1c0> jump 2 if frame buf addr + 0x13 byte == 0x20
  40144a:	3c 0a                	cmp    al,0xa
  40144c:	74 16                	je     401464 <main+0x1c0> jump 2 if frame buf addr + 0x13 byte == 0xa
  40144e:	ba 18 00 00 00       	mov    edx,0x18 num bytes cmp
  401453:	4c 89 e6             	mov    rsi,r12 des outp addr
  401456:	4c 89 ef             	mov    rdi,r13 frame buf addr
  401459:	e8 82 fd ff ff       	call   4011e0 <memcmp@plt>
  40145e:	85 c0                	test   eax,eax
  401460:	41 0f 45 df          	cmovne ebx,r15d allow_flag=0 if not eq
2:
  401464:	ff c5                	inc    ebp
  401466:	49 83 c5 18          	add    r13,0x18 next 24 bytes of frame buf
  40146a:	49 83 c4 18          	add    r12,0x18 next 24 byte of des outp
  40146e:	eb bc                	jmp    40142c <main+0x188> jump 1
3:
  401470:	85 db                	test   ebx,ebx
  401472:	74 07                	je     40147b <main+0x1d7> jump end if allow_flag == 0
  401474:	31 c0                	xor    eax,eax
  401476:	e8 1b 01 00 00       	call   401596 <win>

end:
  40147b:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
  401480:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401487:	00 00 
  401489:	74 05                	je     401490 <main+0x1ec>
  40148b:	e8 00 fd ff ff       	call   401190 <__stack_chk_fail@plt>
  401490:	48 83 c4 28          	add    rsp,0x28
  401494:	31 c0                	xor    eax,eax
  401496:	5b                   	pop    rbx
  401497:	5d                   	pop    rbp
  401498:	41 5c                	pop    r12
  40149a:	41 5d                	pop    r13
  40149c:	41 5e                	pop    r14
  40149e:	41 5f                	pop    r15
  4014a0:	c3                   	ret

00000000004016db <display>:
  4016db:	f3 0f 1e fa          	endbr64 allow indirect jumps
  4016df:	41 57                	push   r15 save
  4016e1:	41 56                	push   r14 save
  4016e3:	41 55                	push   r13 save
  4016e5:	49 89 f5             	mov    r13,rsi img content buf addr
  4016e8:	41 54                	push   r12 save
  4016ea:	45 31 e4             	xor    r12d,r12d counter1 zero
  4016ed:	55                   	push   rbp save
  4016ee:	53                   	push   rbx save
  4016ef:	48 89 fb             	mov    rbx,rdi buf addr
  4016f2:	48 83 ec 48          	sub    rsp,0x48 alloc local vars
  4016f6:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
  4016fd:	00 00 
  4016ff:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax stack guard canary to stack
  401704:	31 c0                	xor    eax,eax
  401706:	4c 8d 74 24 1f       	lea    r14,[rsp+0x1f] buf0x38+0x1f addr
1:
  40170b:	0f b6 43 07          	movzx  eax,BYTE PTR [rbx+0x7] y
  40170f:	44 39 e0             	cmp    eax,r12d
  401712:	0f 8e 9a 00 00 00    	jle    4017b2 <display+0xd7> jump 4 if y <= counter1
  401718:	31 ed                	xor    ebp,ebp counter2 zero
2:
  40171a:	44 0f b6 7b 06       	movzx  r15d,BYTE PTR [rbx+0x6] x
  40171f:	41 39 ef             	cmp    r15d,ebp
  401722:	0f 8e 82 00 00 00    	jle    4017aa <display+0xcf> jump 3 if x <= counter2
  401728:	41 8d 47 01          	lea    eax,[r15+0x1] x+1
  40172c:	4c 8d 05 a0 09 00 00 	lea    r8,[rip+0x9a0] format str addr as arg 5.[38;2;%03d;%03d;%03dm%c.[0m # 4020d3 <_IO_stdin_used+0xd3>
  401733:	b9 19 00 00 00       	mov    ecx,0x19 num bytes as arg 4
  401738:	4c 89 f7             	mov    rdi,r14 buf0x38+0x1f addr as arg 1
  40173b:	41 0f af c4          	imul   eax,r12d (x+1)*counter1
  40173f:	be 19 00 00 00       	mov    esi,0x19 max num bytes as arg 2
  401744:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax save (x+1)*counter1
  401748:	44 29 e0             	sub    eax,r12d ((x+1)*counter1)-counter1
  40174b:	01 e8                	add    eax,ebp ((x+1)*counter1)-counter1+counter2
  40174d:	52                   	push   rdx push rdx for stack alignment
  40174e:	48 98                	cdqe
  401750:	49 8d 44 85 00       	lea    rax,[r13+rax*4+0x0] img content buf array4 address for pixel ((x+1)*counter1)-counter1+counter2
  401755:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3] 4th byte
  401759:	52                   	push   rdx 4th byte as arg 9
  40175a:	0f b6 50 02          	movzx  edx,BYTE PTR [rax+0x2] 3rd byte
  40175e:	52                   	push   rdx 3rd byte as arg 8
  40175f:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1] 2nd byte
  401763:	52                   	push   rdx 2nd byte as arg 7
  401764:	44 0f b6 08          	movzx  r9d,BYTE PTR [rax] 1st byte as arg 6
  401768:	ba 01 00 00 00       	mov    edx,0x1 security flag as arg 3
  40176d:	31 c0                	xor    eax,eax num vec args used
  40176f:	e8 dc f9 ff ff       	call   401150 <__snprintf_chk@plt>
  401774:	89 e8                	mov    eax,ebp counter2
  401776:	44 8b 54 24 2c       	mov    r10d,DWORD PTR [rsp+0x2c] (x+1)*counter1 as current row offset
  40177b:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14] 16 bytes of buf0x38+0x1f
  40177f:	99                   	cdq
  401780:	48 83 c4 20          	add    rsp,0x20 clean up snprintf stack args
  401784:	ff c5                	inc    ebp inc counter2
  401786:	41 f7 ff             	idiv   r15d counter2 / x with remainder in rdx as current column offset
  401789:	42 8d 04 12          	lea    eax,[rdx+r10*1] current row + current column offset as current pixel offset
  40178d:	31 d2                	xor    edx,edx
  40178f:	f7 73 08             	div    DWORD PTR [rbx+0x8] (x+1)*y
  401792:	48 6b d2 18          	imul   rdx,rdx,0x18 array24 offset
  401796:	48 03 53 10          	add    rdx,QWORD PTR [rbx+0x10] frame buf addr
  40179a:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0 16 bytes of buf0x38+0x1f to frame buf
  40179d:	49 8b 46 10          	mov    rax,QWORD PTR [r14+0x10] 8 bytes of buf0x38+0x1f
  4017a1:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax 8 bytes of buf0x38+0x1f to frame buf
  4017a5:	e9 70 ff ff ff       	jmp    40171a <display+0x3f> jump 2
3:
  4017aa:	41 ff c4             	inc    r12d inc counter1
  4017ad:	e9 59 ff ff ff       	jmp    40170b <display+0x30> jump 1
4:
  4017b2:	48 8b 7b 10          	mov    rdi,QWORD PTR [rbx+0x10]
  4017b6:	e8 b5 f9 ff ff       	call   401170 <puts@plt>
  4017bb:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
  4017c0:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  4017c7:	00 00 
  4017c9:	74 05                	je     4017d0 <display+0xf5>
  4017cb:	e8 c0 f9 ff ff       	call   401190 <__stack_chk_fail@plt>
  4017d0:	48 83 c4 48          	add    rsp,0x48
  4017d4:	5b                   	pop    rbx
  4017d5:	5d                   	pop    rbp
  4017d6:	41 5c                	pop    r12
  4017d8:	41 5d                	pop    r13
  4017da:	41 5e                	pop    r14
  4017dc:	41 5f                	pop    r15
  4017de:	c3                   	ret

00000000004017df <initialize_framebuffer>:
  4017df:	f3 0f 1e fa          	endbr64 allow indirect jumps
  4017e3:	41 54                	push   r12 save
  4017e5:	49 89 fc             	mov    r12,rdi buf addr
  4017e8:	55                   	push   rbp save
  4017e9:	53                   	push   rbx save
  4017ea:	48 83 ec 30          	sub    rsp,0x30 alloc local vars
  4017ee:	0f b6 7f 06          	movzx  edi,BYTE PTR [rdi+0x6] x
  4017f2:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 stack guard canary
  4017f9:	00 00 
  4017fb:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax stack guard canary to stack
  401800:	31 c0                	xor    eax,eax zero
  401802:	41 0f b6 44 24 07    	movzx  eax,BYTE PTR [r12+0x7] y
  401808:	ff c7                	inc    edi x+1
  40180a:	0f af f8             	imul   edi,eax (x+1) * y
  40180d:	41 89 7c 24 08       	mov    DWORD PTR [r12+0x8],edi (x+1) * y
  401812:	48 63 ff             	movsxd rdi,edi (x+1) * y
  401815:	48 6b ff 18          	imul   rdi,rdi,0x18 (x+1) * y *  0x18
  401819:	48 ff c7             	inc    rdi ((x+1) * y * 0x18) + 1
  40181c:	e8 df f9 ff ff       	call   401200 <malloc@plt>
  401821:	49 89 44 24 10       	mov    QWORD PTR [r12+0x10],rax save frame buf addr
  401826:	48 85 c0             	test   rax,rax
  401829:	75 14                	jne    40183f <initialize_framebuffer+0x60> jump if frame buf addr not zero

handle_malloc_err:
  40182b:	48 8d 3d be 08 00 00 	lea    rdi,[rip+0x8be] err str addr ERROR: Failed to allocate memory for the framebuffer! # 4020f0 <_IO_stdin_used+0xf0>
  401832:	e8 39 f9 ff ff       	call   401170 <puts@plt>
  401837:	83 cf ff             	or     edi,0xffffffff exit code -1
  40183a:	e8 01 fa ff ff       	call   401240 <exit@plt>

  40183f:	31 db                	xor    ebx,ebx zero counter
  401841:	48 8d 6c 24 0f       	lea    rbp,[rsp+0xf]
1: copy format plus values to frame buf (x+1) * y times
  401846:	41 39 5c 24 08       	cmp    DWORD PTR [r12+0x8],ebx (x+1) * y
  40184b:	76 54                	jbe    4018a1 <initialize_framebuffer+0xc2> jump if (x+1) * y <= counter
  40184d:	52                   	push   rdx save rdx
  40184e:	41 b9 ff 00 00 00    	mov    r9d,0xff 255 first arg converted to ascii format 32 35 35
  401854:	ba 01 00 00 00       	mov    edx,0x1 security flag val
  401859:	48 89 ef             	mov    rdi,rbp buf0x28+0xf as str buf
  40185c:	6a 20                	push   0x20
  40185e:	4c 8d 05 6e 08 00 00 	lea    r8,[rip+0x86e] # format str addr 1b 5b33383b 323b2530 33643b25 !...[38;2;%03d;% # 4020d3 <_IO_stdin_used+0xd3>
  401865:	b9 19 00 00 00       	mov    ecx,0x19 num bytes written to str buf
  40186a:	31 c0                	xor    eax,eax num vec regs used
  40186c:	68 ff 00 00 00       	push   0xff
  401871:	be 19 00 00 00       	mov    esi,0x19 max num bytes written to str buf
  401876:	68 ff 00 00 00       	push   0xff
  40187b:	e8 d0 f8 ff ff       	call   401150 <__snprintf_chk@plt>
  401880:	0f 10 45 00          	movups xmm0,XMMWORD PTR [rbp+0x0] 16 str buf bytes to xmm0
  401884:	48 6b c3 18          	imul   rax,rbx,0x18 str buf counter offset
  401888:	48 ff c3             	inc    rbx inc counter
  40188b:	49 03 44 24 10       	add    rax,QWORD PTR [r12+0x10] frame buf addr
  401890:	48 83 c4 20          	add    rsp,0x20 clean up snprinf stack args
  401894:	0f 11 00             	movups XMMWORD PTR [rax],xmm0 16 str buf bytes to frame buf counter offset
  401897:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10] last 8 str buf bytes
  40189b:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx last 8 str buf bytes to frame buf
  40189f:	eb a5                	jmp    401846 <initialize_framebuffer+0x67> jump 1
2:
  4018a1:	41 0f b6 5c 24 06    	movzx  ebx,BYTE PTR [r12+0x6] counter to x
  4018a7:	48 8d 6c 24 0f       	lea    rbp,[rsp+0xf] str buf addr
3:
  4018ac:	41 39 5c 24 08       	cmp    DWORD PTR [r12+0x8],ebx
  4018b1:	76 55                	jbe    401908 <initialize_framebuffer+0x129> jump end if (x+1) * y <= counter
  4018b3:	50                   	push   rax save rax
  4018b4:	ba 01 00 00 00       	mov    edx,0x1 security flag as arg 3
  4018b9:	45 31 c9             	xor    r9d,r9d zero as arg 6
  4018bc:	4c 8d 05 10 08 00 00 	lea    r8,[rip+0x810] format str addr [38;2;%03d;%03d;%03dm%c.[0m as arg 5 # 4020d3 <_IO_stdin_used+0xd3>
  4018c3:	6a 0a                	push   0xa 10 as arg 9
  4018c5:	b9 19 00 00 00       	mov    ecx,0x19 num bytes as arg 4
  4018ca:	be 19 00 00 00       	mov    esi,0x19 max num bytes as arg 2
  4018cf:	48 89 ef             	mov    rdi,rbp str buf addr as arg 1
  4018d2:	6a 00                	push   0x0 zero as arg 8
  4018d4:	31 c0                	xor    eax,eax num vec regs used
  4018d6:	6a 00                	push   0x0 zero as arg 7
  4018d8:	e8 73 f8 ff ff       	call   401150 <__snprintf_chk@plt>
  4018dd:	0f 10 4d 00          	movups xmm1,XMMWORD PTR [rbp+0x0] 16 str buf bytes to xmm1
  4018e1:	48 63 c3             	movsxd rax,ebx counter
  4018e4:	48 83 c4 20          	add    rsp,0x20 clean up snprintf stack args
  4018e8:	48 6b c0 18          	imul   rax,rax,0x18 counter * 0x18 offset as pixel offset
  4018ec:	49 03 44 24 10       	add    rax,QWORD PTR [r12+0x10] frame buf addr + pixel offset
  4018f1:	0f 11 08             	movups XMMWORD PTR [rax],xmm1 16 str buf bytes to frame buf
  4018f4:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10] 8 str buf bytes to rdx
  4018f8:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx 8 str buf bytes to frame buf
  4018fc:	41 0f b6 44 24 06    	movzx  eax,BYTE PTR [r12+0x6] x
  401902:	8d 5c 03 01          	lea    ebx,[rbx+rax*1+0x1] counter = counter + x + 1 selects each 77th pixel offset
  401906:	eb a4                	jmp    4018ac <initialize_framebuffer+0xcd> jump 3
end:
  401908:	48 8b 44 24 28       	mov    rax,QWORD PTR [rsp+0x28]
  40190d:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401914:	00 00 
  401916:	74 05                	je     40191d <initialize_framebuffer+0x13e>
  401918:	e8 73 f8 ff ff       	call   401190 <__stack_chk_fail@plt>
  40191d:	48 83 c4 30          	add    rsp,0x30 clean up stack
  401921:	4c 89 e0             	mov    rax,r12 return 
  401924:	5b                   	pop    rbx
  401925:	5d                   	pop    rbp
  401926:	41 5c                	pop    r12
  401928:	c3                   	ret
