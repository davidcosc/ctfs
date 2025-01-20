00000000004012e4 <main>:
  4012e4:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  4012e8:	41 57                	push   r15 # save
  4012ea:	41 56                	push   r14 # save
  4012ec:	41 55                	push   r13 # save
  4012ee:	41 54                	push   r12 # save
  4012f0:	55                   	push   rbp # save
  4012f1:	53                   	push   rbx # save
  4012f2:	48 81 ec 00 10 00 00 	sub    rsp,0x1000 # alloc local vars
  4012f9:	48 83 0c 24 00       	or     QWORD PTR [rsp],0x0 # zero 8 bytes of local vars
  4012fe:	48 83 ec 38          	sub    rsp,0x38 # alloc local vars
  401302:	b9 06 04 00 00       	mov    ecx,0x406 # num dwords to zero
  401307:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  40130e:	00 00 
  401310:	48 89 84 24 28 10 00 	mov    QWORD PTR [rsp+0x1028],rax # stack guard canary to stack
  401317:	00 
  401318:	31 c0                	xor    eax,eax # zero eax
  40131a:	41 89 f8             	mov    r8d,edi # argc
  40131d:	48 8d 7c 24 10       	lea    rdi,[rsp+0x10] # main buf addr
  401322:	48 8d 5c 24 10       	lea    rbx,[rsp+0x10] # main buf addr
  401327:	41 ff c8             	dec    r8d # argc --
  40132a:	f3 ab                	rep stos DWORD PTR es:[rdi],eax # zero 0x1018 aka 4120 bytes main buf
  40132c:	7e 4f                	jle    40137d <main+0x99> jump read_header if argc <= 0
handle_cmd_arg:
  40132e:	48 8b 6e 08          	mov    rbp,QWORD PTR [rsi+0x8] # 2nd argv addr
  401332:	48 83 c9 ff          	or     rcx,0xffffffffffffffff # num bytes read start -1
  401336:	48 8d 35 68 1f 00 00 	lea    rsi,[rip+0x1f68] # extension str addr # 4032a5 <_IO_stdin_used+0x2a5>
  40133d:	48 89 ef             	mov    rdi,rbp # 2nd argv addr
  401340:	f2 ae                	repnz scas al,BYTE PTR es:[rdi] # cmp and dec ecx until zero null term
  401342:	48 f7 d1             	not    rcx # num bytes read to positive as len 2nd arg
  401345:	48 8d 7c 0d fa       	lea    rdi,[rbp+rcx*1-0x6] # last 6 bytes of 2nd arg addr
  40134a:	e8 e1 fe ff ff       	call   401230 <strcmp@plt> # cmp exp to 2nd arg file name extension
  40134f:	85 c0                	test   eax,eax
  401351:	74 15                	je     401368 <main+0x84> # jump if correct extension
handle_extension_err:
  401353:	48 8d 35 51 1f 00 00 	lea    rsi,[rip+0x1f51] # err str addr # 4032ab <_IO_stdin_used+0x2ab>
  40135a:	bf 01 00 00 00       	mov    edi,0x1 # security flag val
  40135f:	31 c0                	xor    eax,eax# num vec regs used
  401361:	e8 ea fe ff ff       	call   401250 <__printf_chk@plt>
  401366:	eb 45                	jmp    4013ad <main+0xc9> # jump crash
2nd_arg_file_as_stdin:
  401368:	31 f6                	xor    esi,esi # O_RDONLY
  40136a:	48 89 ef             	mov    rdi,rbp # file name addr
  40136d:	31 c0                	xor    eax,eax # num vec regs used
  40136f:	e8 fc fe ff ff       	call   401270 <open@plt>
  401374:	31 f6                	xor    esi,esi # stdin fd
  401376:	89 c7                	mov    edi,eax # img file fd
  401378:	e8 53 fe ff ff       	call   4011d0 <dup2@plt>
read_header:
  40137d:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401381:	31 ff                	xor    edi,edi # stdin fd
  401383:	48 8d 0d 45 1f 00 00 	lea    rcx,[rip+0x1f45] # err str addr # 4032cf <_IO_stdin_used+0x2cf>
  40138a:	48 89 de             	mov    rsi,rbx # main buf addr
  40138d:	ba 0c 00 00 00       	mov    edx,0xc # num bytes read
  401392:	e8 64 03 00 00       	call   4016fb <read_exact>
check_magic:
  401397:	81 7c 24 10 63 49 4d 	cmp    DWORD PTR [rsp+0x10],0x474d4963 # magic num
  40139e:	47 
  40139f:	74 14                	je     4013b5 <main+0xd1> # jump check version if magic check success
handle_magic_err:
  4013a1:	48 8d 3d 4a 1f 00 00 	lea    rdi,[rip+0x1f4a] # err str addr # 4032f2 <_IO_stdin_used+0x2f2>
  4013a8:	e8 f3 fd ff ff       	call   4011a0 <puts@plt>
crash:
  4013ad:	83 cf ff             	or     edi,0xffffffff # exit code -1
  4013b0:	e8 cb fe ff ff       	call   401280 <exit@plt>
check_version:
  4013b5:	66 83 7c 24 14 03    	cmp    WORD PTR [rsp+0x14],0x3 # version 3
  4013bb:	48 8d 3d 4d 1f 00 00 	lea    rdi,[rip+0x1f4d] # err str addr # 40330f <_IO_stdin_used+0x30f>
  4013c2:	75 e4                	jne    4013a8 <main+0xc4> jump pre crash if version check fail
init_fb:
  4013c4:	48 89 df             	mov    rdi,rbx # main buf addr
  4013c7:	48 8d 6c 24 0e       	lea    rbp,[rsp+0xe] # directive code buf addr
  4013cc:	e8 61 0a 00 00       	call   401e32 <initialize_framebuffer>
handle_directives:
  4013d1:	8b 44 24 18          	mov    eax,DWORD PTR [rsp+0x18] # direcitve count
  4013d5:	8d 50 ff             	lea    edx,[rax-0x1] # directive count --
  4013d8:	89 54 24 18          	mov    DWORD PTR [rsp+0x18],edx # directive count -- to directive count addr
  4013dc:	85 c0                	test   eax,eax
  4013de:	0f 84 80 00 00 00    	je     401464 <main+0x180> # jump check_fb if directive count zero
  4013e4:	48 8d 0d 40 1f 00 00 	lea    rcx,[rip+0x1f40] # err str addr # 40332b <_IO_stdin_used+0x32b>
  4013eb:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  4013ef:	48 89 ee             	mov    rsi,rbp # directive code buf addr
  4013f2:	31 ff                	xor    edi,edi # stdin fd
  4013f4:	ba 02 00 00 00       	mov    edx,0x2 # num bytes read
  4013f9:	e8 fd 02 00 00       	call   4016fb <read_exact>
  4013fe:	0f b7 4c 24 0e       	movzx  ecx,WORD PTR [rsp+0xe] # directive code
  401403:	66 83 f9 03          	cmp    cx,0x3
  401407:	74 32                	je     40143b <main+0x157> jump dir_3 if directive code three
  401409:	77 16                	ja     401421 <main+0x13d> jump dir_4 if directive code > three
  40140b:	66 83 f9 01          	cmp    cx,0x1
  40140f:	74 20                	je     401431 <main+0x14d> # jump dir_1 if dir code one
  401411:	66 83 f9 02          	cmp    cx,0x2
  401415:	75 2e                	jne    401445 <main+0x161> # jump directive_err if dir code < 1
dir_2:
  401417:	48 89 df             	mov    rdi,rbx
  40141a:	e8 be 04 00 00       	call   4018dd <handle_2>
  40141f:	eb b0                	jmp    4013d1 <main+0xed> # jump handle_directives
dir_4:
  401421:	66 83 f9 04          	cmp    cx,0x4
  401425:	75 1e                	jne    401445 <main+0x161># jump directive_err if dir code > 4
  401427:	48 89 df             	mov    rdi,rbx # main buf addr
  40142a:	e8 07 08 00 00       	call   401c36 <handle_4>
  40142f:	eb a0                	jmp    4013d1 <main+0xed> # jump handle_directives
dir_1:
  401431:	48 89 df             	mov    rdi,rbx # main buf addr
  401434:	e8 21 03 00 00       	call   40175a <handle_1>
  401439:	eb 96                	jmp    4013d1 <main+0xed> # jump handle_directives
dir_3:
  40143b:	48 89 df             	mov    rdi,rbx # main buf addr
  40143e:	e8 a2 06 00 00       	call   401ae5 <handle_3>
  401443:	eb 8c                	jmp    4013d1 <main+0xed> # jump handle_directives
directive_err:
  401445:	48 8b 3d 54 e9 00 00 	mov    rdi,QWORD PTR [rip+0xe954] # stderr file addr # 40fda0 <stderr@GLIBC_2.2.5>
  40144c:	48 8d 15 ff 1e 00 00 	lea    rdx,[rip+0x1eff] # err str addr # 403352 <_IO_stdin_used+0x352>
  401453:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  401458:	31 c0                	xor    eax,eax # num vec regs used
  40145a:	e8 31 fe ff ff       	call   401290 <__fprintf_chk@plt>
  40145f:	e9 49 ff ff ff       	jmp    4013ad <main+0xc9> # jump crash
check_fb:
  401464:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20] # frame buf addr
  401469:	31 db                	xor    ebx,ebx # zero allow_flag
  40146b:	4c 8d 25 ae 3b 00 00 	lea    r12,[rip+0x3bae] # 405020 <desired_output>
  401472:	e8 29 fd ff ff       	call   4011a0 <puts@plt> # print current cimg
  401477:	44 8b 74 24 1c       	mov    r14d,DWORD PTR [rsp+0x1c] # (x+1)*y as dimensions
  40147c:	4c 8b 6c 24 20       	mov    r13,QWORD PTR [rsp+0x20] # frame buf addr
  401481:	41 81 fe 38 07 00 00 	cmp    r14d,0x738
  401488:	0f 94 c3             	sete   bl # allow_flag = 1 if dimensions == 0x738
  40148b:	31 ed                	xor    ebp,ebp # zero counter
  40148d:	45 31 ff             	xor    r15d,r15d # zero
1:
  401490:	41 39 ee             	cmp    r14d,ebp
  401493:	76 3f                	jbe    4014d4 <main+0x1f0> # jump check_total if dimensions <= counter
  401495:	81 fd 38 07 00 00    	cmp    ebp,0x738
  40149b:	74 37                	je     4014d4 <main+0x1f0> # jump check_total if counter == 0x738
  40149d:	41 8a 45 13          	mov    al,BYTE PTR [r13+0x13] # 13th byte of current frame buf item
  4014a1:	41 3a 44 24 13       	cmp    al,BYTE PTR [r12+0x13] # 13th byte of expected frame buf item
  4014a6:	41 0f 45 df          	cmovne ebx,r15d # zero allow_flag if ne
  4014aa:	3c 20                	cmp    al,0x20
  4014ac:	74 1a                	je     4014c8 <main+0x1e4> # jump 2 if current byte == 0x20
  4014ae:	3c 0a                	cmp    al,0xa
  4014b0:	74 16                	je     4014c8 <main+0x1e4> # jump 2 if current byte == 0xa
  4014b2:	ba 18 00 00 00       	mov    edx,0x18 # num bytes
  4014b7:	4c 89 e6             	mov    rsi,r12 # expected frame buf item addr
  4014ba:	4c 89 ef             	mov    rdi,r13 # current frame buf itemm addr
  4014bd:	e8 5e fd ff ff       	call   401220 <memcmp@plt>
  4014c2:	85 c0                	test   eax,eax
  4014c4:	41 0f 45 df          	cmovne ebx,r15d # zero allow_flag if ne
2:
  4014c8:	ff c5                	inc    ebp # counter ++
  4014ca:	49 83 c5 18          	add    r13,0x18 # next expected frame buf item
  4014ce:	49 83 c4 18          	add    r12,0x18 # next  frame buf item
  4014d2:	eb bc                	jmp    401490 <main+0x1ac> # jump 1
check_total:
  4014d4:	48 81 3d d1 e8 00 00 	cmp    QWORD PTR [rip+0xe8d1],0x190        # 40fdb0 <total_data>
  4014db:	90 01 00 00 
  4014df:	77 0c                	ja     4014ed <main+0x209>
  4014e1:	80 e3 01             	and    bl,0x1
  4014e4:	74 07                	je     4014ed <main+0x209>
  4014e6:	31 c0                	xor    eax,eax
  4014e8:	e8 19 01 00 00       	call   401606 <win>
  4014ed:	48 8b 84 24 28 10 00 	mov    rax,QWORD PTR [rsp+0x1028]
  4014f4:	00 
  4014f5:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  4014fc:	00 00 
  4014fe:	74 05                	je     401505 <main+0x221>
  401500:	e8 bb fc ff ff       	call   4011c0 <__stack_chk_fail@plt>
  401505:	48 81 c4 38 10 00 00 	add    rsp,0x1038
  40150c:	31 c0                	xor    eax,eax
  40150e:	5b                   	pop    rbx
  40150f:	5d                   	pop    rbp
  401510:	41 5c                	pop    r12
  401512:	41 5d                	pop    r13
  401514:	41 5e                	pop    r14
  401516:	41 5f                	pop    r15
  401518:	c3                   	ret

0000000000401ae5 <handle_3>:
  401ae5:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  401ae9:	41 54                	push   r12 # save
  401aeb:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401aef:	ba 01 00 00 00       	mov    edx,0x1 # num bytes
  401af4:	48 8d 0d f3 16 00 00 	lea    rcx,[rip+0x16f3] # read sprite err str addr # 4031ee <_IO_stdin_used+0x1ee>
  401afb:	55                   	push   rbp # save
  401afc:	48 89 fd             	mov    rbp,rdi # main buf addr
  401aff:	31 ff                	xor    edi,edi # stdin fd
  401b01:	53                   	push   rbx # save
  401b02:	48 83 ec 10          	sub    rsp,0x10 # alloc local vars
  401b06:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # sentinel stack guard canary
  401b0d:	00 00 
  401b0f:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax # stack guard canary to stack
  401b14:	31 c0                	xor    eax,eax # zero
  401b16:	48 8d 74 24 05       	lea    rsi,[rsp+0x5] # sid addr
  401b1b:	e8 db fb ff ff       	call   4016fb <read_exact>
  401b20:	48 8d 74 24 06       	lea    rsi,[rsp+0x6] # width addr
  401b25:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401b29:	31 ff                	xor    edi,edi # stdin fd
  401b2b:	48 8d 0d 7f 16 00 00 	lea    rcx,[rip+0x167f] # err str addr # 4031b1 <_IO_stdin_used+0x1b1>
  401b32:	ba 01 00 00 00       	mov    edx,0x1 # num bytes
  401b37:	e8 bf fb ff ff       	call   4016fb <read_exact>
  401b3c:	ba 01 00 00 00       	mov    edx,0x1 # num bytes
  401b41:	31 ff                	xor    edi,edi # stdin fd
  401b43:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  401b47:	48 8d 74 24 07       	lea    rsi,[rsp+0x7] # height addr
  401b4c:	48 8d 0d 7c 16 00 00 	lea    rcx,[rip+0x167c] # err str addr # 4031cf <_IO_stdin_used+0x1cf>
  401b53:	e8 a3 fb ff ff       	call   4016fb <read_exact>
  401b58:	0f b6 44 24 05       	movzx  eax,BYTE PTR [rsp+0x5] # sid
  401b5d:	8a 54 24 06          	mov    dl,BYTE PTR [rsp+0x6] # width
  401b61:	48 c1 e0 04          	shl    rax,0x4 # sid * 16 as sprite ele offset
  401b65:	48 01 e8             	add    rax,rbp # main buf addr
  401b68:	88 50 19             	mov    BYTE PTR [rax+0x19],dl # width to sptrite ele addr + 0x19
  401b6b:	48 8b 78 20          	mov    rdi,QWORD PTR [rax+0x20] # sprite ele addr + 0x20 val
  401b6f:	8a 54 24 07          	mov    dl,BYTE PTR [rsp+0x7] # height
  401b73:	88 50 18             	mov    BYTE PTR [rax+0x18],dl # height to sprite ele addr + 0x18
  401b76:	48 85 ff             	test   rdi,rdi
  401b79:	74 05                	je     401b80 <handle_3+0x9b> # jump 1 if sprite ele addr + 0x20 eq zero
  401b7b:	e8 00 f6 ff ff       	call   401180 <free@plt>
1:
  401b80:	44 0f b6 64 24 06    	movzx  r12d,BYTE PTR [rsp+0x6] # width
  401b86:	0f b6 54 24 07       	movzx  edx,BYTE PTR [rsp+0x7] # height
  401b8b:	44 0f af e2          	imul   r12d,edx # width*height
  401b8f:	49 63 fc             	movsxd rdi,r12d # width*height as arg 1
  401b92:	e8 a9 f6 ff ff       	call   401240 <malloc@plt>
  401b97:	48 89 c3             	mov    rbx,rax # sprite buf addr
  401b9a:	48 85 c0             	test   rax,rax
  401b9d:	75 0e                	jne    401bad <handle_3+0xc8> # jump read sprite bytes if malloc success
  401b9f:	48 8d 3d 2d 15 00 00 	lea    rdi,[rip+0x152d] # err str addr # 4030d3 <_IO_stdin_used+0xd3>
  401ba6:	e8 f5 f5 ff ff       	call   4011a0 <puts@plt>
  401bab:	eb 55                	jmp    401c02 <handle_3+0x11d> # jump crash
read_sprite_bytes:
  401bad:	44 89 e2             	mov    edx,r12d # width*height as arg 3
  401bb0:	48 89 c6             	mov    rsi,rax # sprite buf addr as arg 2
  401bb3:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1 as arg 5
  401bb7:	31 ff                	xor    edi,edi # stdin fd as arg 1
  401bb9:	48 8d 0d 48 15 00 00 	lea    rcx,[rip+0x1548] # err str addr as arg 4 # 403108 <_IO_stdin_used+0x108>
  401bc0:	e8 36 fb ff ff       	call   4016fb <read_exact>
check_sprite_bytes:
  401bc5:	0f b6 44 24 07       	movzx  eax,BYTE PTR [rsp+0x7] # height
  401bca:	0f b6 54 24 06       	movzx  edx,BYTE PTR [rsp+0x6] # width
  401bcf:	0f af d0             	imul   edx,eax # width*height
  401bd2:	31 c0                	xor    eax,eax # zero counter
  401bd4:	39 c2                	cmp    edx,eax
  401bd6:	7e 32                	jle    401c0a <handle_3+0x125> # jump handle_sprite_bytes if width*height <= counter
  401bd8:	0f b6 0c 03          	movzx  ecx,BYTE PTR [rbx+rax*1] # sprite buf addr + counter byte val as cur val
  401bdc:	48 ff c0             	inc    rax # counter ++
  401bdf:	8d 71 e0             	lea    esi,[rcx-0x20] # cur val - 0x20
  401be2:	40 80 fe 5e          	cmp    sil,0x5e
  401be6:	76 ec                	jbe    401bd4 <handle_3+0xef> jump if cur val - 0x20 <= 0x5e
handle_sprite_byte_check_fail:
  401be8:	48 8b 3d b1 e1 00 00 	mov    rdi,QWORD PTR [rip+0xe1b1] # stderr file addr # 40fda0 <stderr@GLIBC_2.2.5>
  401bef:	48 8d 15 2e 15 00 00 	lea    rdx,[rip+0x152e] # err str addr # 403124 <_IO_stdin_used+0x124>
  401bf6:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  401bfb:	31 c0                	xor    eax,eax # num vec regs used
  401bfd:	e8 8e f6 ff ff       	call   401290 <__fprintf_chk@plt>
crash:
  401c02:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401c05:	e8 76 f6 ff ff       	call   401280 <exit@plt>
handle_sprite_bytes:
  401c0a:	0f b6 44 24 05       	movzx  eax,BYTE PTR [rsp+0x5] # sid
  401c0f:	48 c1 e0 04          	shl    rax,0x4 # sid*16
  401c13:	48 89 5c 28 20       	mov    QWORD PTR [rax+rbp*1+0x20],rbx # sprite buf addr to main buf sprite offset
check_canary:
  401c18:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8] # actual stack guard canary
  401c1d:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28 #  exp stack guard canary
  401c24:	00 00 
  401c26:	74 05                	je     401c2d <handle_3+0x148> # jump end if canary check success
  401c28:	e8 93 f5 ff ff       	call   4011c0 <__stack_chk_fail@plt> # fail
end:
  401c2d:	48 83 c4 10          	add    rsp,0x10 # clean up stack local vars
  401c31:	5b                   	pop    rbx # restore
  401c32:	5d                   	pop    rbp # restore
  401c33:	41 5c                	pop    r12 # restore
  401c35:	c3                   	ret

0000000000401c36 <handle_4>:
  401c36:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  401c3a:	41 57                	push   r15 # save
  401c3c:	41 56                	push   r14 # save
  401c3e:	41 55                	push   r13 # save
  401c40:	41 54                	push   r12 # save
  401c42:	55                   	push   rbp # save
  401c43:	53                   	push   rbx # save
  401c44:	4c 8d 9c 24 00 00 fc 	lea    r11,[rsp-0x40000]
  401c4b:	ff 
alloc_local_var_loop:
  401c4c:	48 81 ec 00 10 00 00 	sub    rsp,0x1000 # alloc local vars
  401c53:	83 0c 24 00          	or     DWORD PTR [rsp],0x0
  401c57:	4c 39 dc             	cmp    rsp,r11
  401c5a:	75 f0                	jne    401c4c <handle_4+0x16> # jump alloc_local_var_loop if alloc var space <= 0x40000
  401c5c:	48 83 ec 38          	sub    rsp,0x38 # alloc local vars
read_4:
  401c60:	48 8d 0d a9 15 00 00 	lea    rcx,[rip+0x15a9] # sprite render record err str addr as arg 4 # 403210 <_IO_stdin_used+0x210>
  401c67:	ba 06 00 00 00       	mov    edx,0x6 # num bytes read as arg 3
  401c6c:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1 as arg 5
  401c70:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  401c77:	00 00 
  401c79:	48 89 84 24 28 00 04 	mov    QWORD PTR [rsp+0x40028],rax # stack guard canary to stack
  401c80:	00 
  401c81:	31 c0                	xor    eax,eax # zero
  401c83:	48 89 fb             	mov    rbx,rdi # main buf addr
  401c86:	48 8d 74 24 09       	lea    rsi,[rsp+0x9] # inbuf addr as arg 2
  401c8b:	31 ff                	xor    edi,edi # stdin fd as arg 1
  401c8d:	e8 69 fa ff ff       	call   4016fb <read_exact>
zero_var_space:
  401c92:	48 8d 7c 24 0f       	lea    rdi,[rsp+0xf] # rendered sprite buf addr
  401c97:	b9 00 00 01 00       	mov    ecx,0x10000
  401c9c:	31 c0                	xor    eax,eax # zero
  401c9e:	0f b6 54 24 09       	movzx  edx,BYTE PTR [rsp+0x9] # inbuf byte 1 as sid
  401ca3:	44 8a 54 24 0a       	mov    r10b,BYTE PTR [rsp+0xa] # inbuf byte 2 as r_color
  401ca8:	48 8d 74 24 0f       	lea    rsi,[rsp+0xf] # rendered sprite buf addr
  401cad:	f3 ab                	rep stos DWORD PTR es:[rdi],eax # zero 0x40000 bytes of local var space

  401caf:	44 8a 5c 24 0b       	mov    r11b,BYTE PTR [rsp+0xb] # inbuf byte 3 as g_color
  401cb4:	40 8a 6c 24 0c       	mov    bpl,BYTE PTR [rsp+0xc] # inbuf byte 4 as b_color
  401cb9:	48 c1 e2 04          	shl    rdx,0x4 # sid * 16
  401cbd:	48 01 da             	add    rdx,rbx # main buf addr + sid * 16 as sprite ele addr
  401cc0:	44 0f b6 62 18       	movzx  r12d,BYTE PTR [rdx+0x18] # sprite ele height
1:
  401cc5:	41 39 cc             	cmp    r12d,ecx # ecx as h_counter  is zero after being decreased by rep stos
  401cc8:	7e 58                	jle    401d22 <handle_4+0xec> # jump if sprite ele height <= h_counter
  401cca:	44 0f b6 42 19       	movzx  r8d,BYTE PTR [rdx+0x19] # sprite ele width
  401ccf:	31 ff                	xor    edi,edi # zero w_counter
  401cd1:	44 89 c0             	mov    eax,r8d # sprite ele width
  401cd4:	0f af c1             	imul   eax,ecx # sprite ele width * h_counter as prev rows offset
2:
  401cd7:	41 39 f8             	cmp    r8d,edi
  401cda:	7e 42                	jle    401d1e <handle_4+0xe8> # jump 3 if sprite ele width <= w_counter
  401cdc:	4c 8b 4a 20          	mov    r9,QWORD PTR [rdx+0x20] # sprite ele buf addr
  401ce0:	44 88 14 86          	mov    BYTE PTR [rsi+rax*4],r10b # r_color to rendered sprite buf item byte 0
  401ce4:	44 88 5c 86 01       	mov    BYTE PTR [rsi+rax*4+0x1],r11b # g_color to rendered sprit buf item byte 1
  401ce9:	40 88 6c 86 02       	mov    BYTE PTR [rsi+rax*4+0x2],bpl # b_color to rendered sprite buf item byte 2
  401cee:	4d 85 c9             	test   r9,r9
  401cf1:	75 1b                	jne    401d0e <handle_4+0xd8> # jump no_sbuf_err if valid sprite ele buf addr
handle_sbuf_err:
  401cf3:	48 8b 35 a6 e0 00 00 	mov    rsi,QWORD PTR [rip+0xe0a6] # stderr file addr # 40fda0 <stderr@GLIBC_2.2.5>
  401cfa:	48 8d 3d 3c 15 00 00 	lea    rdi,[rip+0x153c] # sprite render err str addr # 40323d <_IO_stdin_used+0x23d>
  401d01:	e8 da f4 ff ff       	call   4011e0 <fputs@plt>
  401d06:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401d09:	e8 72 f5 ff ff       	call   401280 <exit@plt>
no_sbuf_err:
  401d0e:	45 8a 0c 01          	mov    r9b,BYTE PTR [r9+rax*1] # sprite ele char
  401d12:	ff c7                	inc    edi # w_counter ++
  401d14:	44 88 4c 86 03       	mov    BYTE PTR [rsi+rax*4+0x3],r9b # sprite ele char to rendered sprite buf item byte 3
  401d19:	48 ff c0             	inc    rax
  401d1c:	eb b9                	jmp    401cd7 <handle_4+0xa1> # jump 2
3:
  401d1e:	ff c1                	inc    ecx # h_counter ++
  401d20:	eb a3                	jmp    401cc5 <handle_4+0x8f> # jump 1
4:
  401d22:	44 0f b6 6c 24 0e    	movzx  r13d,BYTE PTR [rsp+0xe] # sprite x offset
  401d28:	44 0f b6 7c 24 0d    	movzx  r15d,BYTE PTR [rsp+0xd] # sprite y offset
  401d2e:	45 31 e4             	xor    r12d,r12d # zero h_counter
1:
  401d31:	0f b6 44 24 09       	movzx  eax,BYTE PTR [rsp+0x9] # sid
  401d36:	48 c1 e0 04          	shl    rax,0x4 # sid * 16
  401d3a:	0f b6 44 18 18       	movzx  eax,BYTE PTR [rax+rbx*1+0x18] # sprite ele height
  401d3f:	44 39 e0             	cmp    eax,r12d
  401d42:	0f 8e b3 00 00 00    	jle    401dfb <handle_4+0x1c5> # jump check canary if sprite ele height <= h_counter
  401d48:	31 ed                	xor    ebp,ebp # zero w_counter
2:
  401d4a:	0f b6 44 24 09       	movzx  eax,BYTE PTR [rsp+0x9] # sid
  401d4f:	48 c1 e0 04          	shl    rax,0x4 # sid * 16
  401d53:	0f b6 44 18 19       	movzx  eax,BYTE PTR [rax+rbx*1+0x19] # sprite ele width
  401d58:	39 e8                	cmp    eax,ebp
  401d5a:	0f 8e 90 00 00 00    	jle    401df0 <handle_4+0x1ba> # jump 3 if sprite ele width <= w_counter
  401d60:	41 0f af c4          	imul   eax,r12d sprite ele width * h_counter as prev rows offset
  401d64:	44 0f b6 73 06       	movzx  r14d,BYTE PTR [rbx+0x6] # x
  401d69:	48 8d bc 24 0f 00 04 	lea    rdi,[rsp+0x4000f] # sprite tmp fb buf addr
  401d70:	00 
  401d71:	52                   	push   rdx
  401d72:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes
  401d77:	4c 8d 05 d8 13 00 00 	lea    r8,[rip+0x13d8] # format str addr # 403156 <_IO_stdin_used+0x156>
  401d7e:	be 19 00 00 00       	mov    esi,0x19 # num bytes
  401d83:	01 e8                	add    eax,ebp # prev rows offset + w_counter as current pixel offset
  401d85:	48 98                	cdqe
  401d87:	0f b6 54 84 1a       	movzx  edx,BYTE PTR [rsp+rax*4+0x1a] # current pixel char with rsp+0x1a as rendered sprite buf item base + 0x3
  401d8c:	52                   	push   rdx
  401d8d:	0f b6 54 84 21       	movzx  edx,BYTE PTR [rsp+rax*4+0x21] # current pixel b_color with rsp+0x21 as rendered sprite buf item base + 0x2 accounting fo 8 byte stack offset for the previous push
  401d92:	52                   	push   rdx
  401d93:	0f b6 54 84 28       	movzx  edx,BYTE PTR [rsp+rax*4+0x28] # current pixel g_color
  401d98:	52                   	push   rdx
  401d99:	44 0f b6 4c 84 2f    	movzx  r9d,BYTE PTR [rsp+rax*4+0x2f] # current pixel r_color
  401d9f:	ba 01 00 00 00       	mov    edx,0x1 # security flag val
  401da4:	31 c0                	xor    eax,eax # num vec regs
  401da6:	e8 c5 f3 ff ff       	call   401170 <__snprintf_chk@plt>
  401dab:	41 8d 46 01          	lea    eax,[r14+0x1] # x+1
  401daf:	48 83 c4 20          	add    rsp,0x20 # clean up snprintf stack args
  401db3:	0f 10 84 24 0f 00 04 	movups xmm0,XMMWORD PTR [rsp+0x4000f] # tmp fb buf current pxiel content
  401dba:	00 
  401dbb:	41 0f af c5          	imul   eax,r13d
  401dbf:	89 c1                	mov    ecx,eax
  401dc1:	42 8d 44 3d 00       	lea    eax,[rbp+r15*1+0x0]
  401dc6:	ff c5                	inc    ebp # w_counter ++
  401dc8:	99                   	cdq
  401dc9:	41 f7 fe             	idiv   r14d
  401dcc:	8d 04 11             	lea    eax,[rcx+rdx*1]
  401dcf:	31 d2                	xor    edx,edx
  401dd1:	f7 73 0c             	div    DWORD PTR [rbx+0xc] # x*y
  401dd4:	48 6b d2 18          	imul   rdx,rdx,0x18
  401dd8:	48 03 53 10          	add    rdx,QWORD PTR [rbx+0x10]
  401ddc:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0 # tmp fb buf current pixel content to frame buffer
  401ddf:	48 8b 84 24 1f 00 04 	mov    rax,QWORD PTR [rsp+0x4001f]
  401de6:	00 
  401de7:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
  401deb:	e9 5a ff ff ff       	jmp    401d4a <handle_4+0x114> # jump 2
3:
  401df0:	41 ff c4             	inc    r12d # h_counter ++
  401df3:	41 ff c5             	inc    r13d # w_counter ++
  401df6:	e9 36 ff ff ff       	jmp    401d31 <handle_4+0xfb> # jump 1
check_canary:
  401dfb:	48 8b 84 24 28 00 04 	mov    rax,QWORD PTR [rsp+0x40028] # actual stack guard canary
  401e02:	00 
  401e03:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28 # exp stack guard canary
  401e0a:	00 00 
  401e0c:	74 05                	je     401e13 <handle_4+0x1dd> jump end if stack guard canary check success
  401e0e:	e8 ad f3 ff ff       	call   4011c0 <__stack_chk_fail@plt>
end:
  401e13:	48 81 c4 38 00 04 00 	add    rsp,0x40038 # clean up stack local vars
  401e1a:	5b                   	pop    rbx # restore
  401e1b:	5d                   	pop    rbp # restore
  401e1c:	41 5c                	pop    r12 # restore
  401e1e:	41 5d                	pop    r13 # restore
  401e20:	41 5e                	pop    r14 # restore
  401e22:	41 5f                	pop    r15 # restore
  401e24:	c3                   	ret
