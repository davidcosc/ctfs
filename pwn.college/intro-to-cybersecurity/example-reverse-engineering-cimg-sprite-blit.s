
/challenge/cimg:     file format elf64-x86-64

00000000004012e4 <main>:
  4012e4:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  4012e8:	41 57                	push   r15
  4012ea:	41 56                	push   r14
  4012ec:	41 55                	push   r13
  4012ee:	41 54                	push   r12
  4012f0:	55                   	push   rbp
  4012f1:	53                   	push   rbx

  # setup local variables
  4012f2:	48 81 ec 00 10 00 00 	sub    rsp,0x1000
  4012f9:	48 83 0c 24 00       	or     QWORD PTR [rsp],0x0 # check stack overflow by forcing page fault if allocated var space overflows into unmapped pages
  4012fe:	48 83 ec 38          	sub    rsp,0x38
  401302:	b9 06 04 00 00       	mov    ecx,0x406
  401307:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
  40130e:	00 00 
  401310:	48 89 84 24 28 10 00 	mov    QWORD PTR [rsp+0x1028],rax # stack guard canary to stack
  401317:	00 
  401318:	31 c0                	xor    eax,eax
  40131a:	41 89 f8             	mov    r8d,edi # argc
  40131d:	48 8d 7c 24 10       	lea    rdi,[rsp+0x10] # cimg header var addr
  401322:	48 8d 6c 24 10       	lea    rbp,[rsp+0x10] # cimg header var addr
  401327:	41 ff c8             	dec    r8d # argc-- => sets ZF if zero
  40132a:	f3 ab                	rep stos DWORD PTR es:[rdi],eax # zero header var
  40132c:	7e 4f                	jle    40137d <main+0x99>

  # handle input via file arg
  40132e:	4c 8b 66 08          	mov    r12,QWORD PTR [rsi+0x8]
  401332:	48 83 c9 ff          	or     rcx,0xffffffffffffffff
  401336:	48 8d 35 81 1f 00 00 	lea    rsi,[rip+0x1f81]        # 4032be <_IO_stdin_used+0x2be>
  40133d:	4c 89 e7             	mov    rdi,r12
  401340:	f2 ae                	repnz scas al,BYTE PTR es:[rdi]
  401342:	48 f7 d1             	not    rcx
  401345:	49 8d 7c 0c fa       	lea    rdi,[r12+rcx*1-0x6]
  40134a:	e8 e1 fe ff ff       	call   401230 <strcmp@plt>
  40134f:	85 c0                	test   eax,eax
  401351:	74 15                	je     401368 <main+0x84>
  401353:	48 8d 35 6a 1f 00 00 	lea    rsi,[rip+0x1f6a]        # 4032c4 <_IO_stdin_used+0x2c4>
  40135a:	bf 01 00 00 00       	mov    edi,0x1
  40135f:	31 c0                	xor    eax,eax
  401361:	e8 ea fe ff ff       	call   401250 <__printf_chk@plt>
  401366:	eb 45                	jmp    4013ad <main+0xc9>
  401368:	31 f6                	xor    esi,esi
  40136a:	4c 89 e7             	mov    rdi,r12
  40136d:	31 c0                	xor    eax,eax
  40136f:	e8 fc fe ff ff       	call   401270 <open@plt>
  401374:	31 f6                	xor    esi,esi
  401376:	89 c7                	mov    edi,eax
  401378:	e8 53 fe ff ff       	call   4011d0 <dup2@plt>

  # read header
  40137d:	41 83 c8 ff          	or     r8d,0xffffffff
  401381:	31 ff                	xor    edi,edi
  401383:	48 8d 0d 59 1f 00 00 	lea    rcx,[rip+0x1f59]        # 4032e3 <_IO_stdin_used+0x2e3>
  40138a:	48 89 ee             	mov    rsi,rbp
  40138d:	ba 0c 00 00 00       	mov    edx,0xc
  401392:	e8 64 03 00 00       	call   4016fb <read_exact> # read 12 bytes to cimg header var

  # check header magic
  401397:	81 7c 24 10 63 49 4d 	cmp    DWORD PTR [rsp+0x10],0x474d4963 # cIMG
  40139e:	47 
  40139f:	74 14                	je     4013b5 <main+0xd1>

  # handle magic error
  4013a1:	48 8d 3d 59 1f 00 00 	lea    rdi,[rip+0x1f59]        # 403301 <_IO_stdin_used+0x301>
  
  # print and exit
  4013a8:	e8 f3 fd ff ff       	call   4011a0 <puts@plt>
  4013ad:	83 cf ff             	or     edi,0xffffffff
  4013b0:	e8 cb fe ff ff       	call   401280 <exit@plt>

  # check header version
  4013b5:	66 83 7c 24 14 04    	cmp    WORD PTR [rsp+0x14],0x4

  # handle version error
  4013bb:	48 8d 3d 5c 1f 00 00 	lea    rdi,[rip+0x1f5c]        # 40331e <_IO_stdin_used+0x31e>
  4013c2:	75 e4                	jne    4013a8 <main+0xc4> jump print and exit

  # setup directive var
  4013c4:	48 89 ef             	mov    rdi,rbp # cimg header addr
  4013c7:	48 8d 5c 24 0e       	lea    rbx,[rsp+0xe] # directive code addr

  # init framebuffer
  4013cc:	e8 1d 0b 00 00       	call   401eee <initialize_framebuffer>

  # loop header directives
  4013d1:	8b 44 24 18          	mov    eax,DWORD PTR [rsp+0x18] # directive count
  4013d5:	8d 50 ff             	lea    edx,[rax-0x1] # directive count --
  4013d8:	89 54 24 18          	mov    DWORD PTR [rsp+0x18],edx # store directive count --
  4013dc:	85 c0                	test   eax,eax
  4013de:	0f 84 80 00 00 00    	je     401464 <main+0x180> # if direcive count == 0 jump display cimg

      # read directive code
      4013e4:	48 8d 0d 4f 1f 00 00 	lea    rcx,[rip+0x1f4f]        # 40333a <_IO_stdin_used+0x33a>
      4013eb:	41 83 c8 ff          	or     r8d,0xffffffff
      4013ef:	48 89 de             	mov    rsi,rbx
      4013f2:	31 ff                	xor    edi,edi
      4013f4:	ba 02 00 00 00       	mov    edx,0x2
      4013f9:	e8 fd 02 00 00       	call   4016fb <read_exact>

      # select directive handler based on directive code
      4013fe:	0f b7 4c 24 0e       	movzx  ecx,WORD PTR [rsp+0xe]
      401403:	66 83 f9 03          	cmp    cx,0x3
      401407:	74 32                	je     40143b <main+0x157>
      401409:	77 16                	ja     401421 <main+0x13d>
      40140b:	66 83 f9 01          	cmp    cx,0x1
      40140f:	74 20                	je     401431 <main+0x14d>
      401411:	66 83 f9 02          	cmp    cx,0x2
      401415:	75 2e                	jne    401445 <main+0x161>
      401417:	48 89 ef             	mov    rdi,rbp
      40141a:	e8 bd 04 00 00       	call   4018dc <handle_2>
      40141f:	eb b0                	jmp    4013d1 <main+0xed>
      401421:	66 83 f9 04          	cmp    cx,0x4
      401425:	75 1e                	jne    401445 <main+0x161>
      401427:	48 89 ef             	mov    rdi,rbp
      40142a:	e8 03 08 00 00       	call   401c32 <handle_4>
      40142f:	eb a0                	jmp    4013d1 <main+0xed>
      401431:	48 89 ef             	mov    rdi,rbp
      401434:	e8 21 03 00 00       	call   40175a <handle_1>
      401439:	eb 96                	jmp    4013d1 <main+0xed>
      40143b:	48 89 ef             	mov    rdi,rbp
      40143e:	e8 9e 06 00 00       	call   401ae1 <handle_3>
      401443:	eb 8c                	jmp    4013d1 <main+0xed>

      # handle error
      401445:	48 8b 3d 14 e7 00 00 	mov    rdi,QWORD PTR [rip+0xe714]        # 40fb60 <stderr@GLIBC_2.2.5>
      40144c:	48 8d 15 0e 1f 00 00 	lea    rdx,[rip+0x1f0e]        # 403361 <_IO_stdin_used+0x361>
      401453:	be 01 00 00 00       	mov    esi,0x1
      401458:	31 c0                	xor    eax,eax
      40145a:	e8 31 fe ff ff       	call   401290 <__fprintf_chk@plt>
      40145f:	e9 49 ff ff ff       	jmp    4013ad <main+0xc9>

  # display cimg
  401464:	31 f6                	xor    esi,esi
  401466:	48 89 ef             	mov    rdi,rbp
  401469:	4c 8d 25 b0 3b 00 00 	lea    r12,[rip+0x3bb0]        # 405020 <desired_output>
  401470:	31 ed                	xor    ebp,ebp
  401472:	e8 16 0a 00 00       	call   401e8d <display>

  # check dimensions 0x720
  401477:	44 8b 74 24 1c       	mov    r14d,DWORD PTR [rsp+0x1c] # dimensions
  40147c:	4c 8b 6c 24 20       	mov    r13,QWORD PTR [rsp+0x20]
  401481:	41 81 fe 20 07 00 00 	cmp    r14d,0x720
  401488:	40 0f 94 c5          	sete   bpl # set win true if dimensions 0x720

  # check expected cimg output
  40148c:	31 db                	xor    ebx,ebx # byte_counter
  40148e:	45 31 ff             	xor    r15d,r15d # counter
  401491:	41 39 de             	cmp    r14d,ebx
  401494:	76 3f                	jbe    4014d5 <main+0x1f1> # if dimensions <= byte_counter jump check total data amount

    401496:	81 fb 20 07 00 00    	cmp    ebx,0x720
    40149c:	74 37                	je     4014d5 <main+0x1f1>
    40149e:	41 8a 45 13          	mov    al,BYTE PTR [r13+0x13]
    4014a2:	41 3a 44 24 13       	cmp    al,BYTE PTR [r12+0x13]
    4014a7:	41 0f 45 ef          	cmovne ebp,r15d
    4014ab:	3c 20                	cmp    al,0x20
    4014ad:	74 1a                	je     4014c9 <main+0x1e5>
    4014af:	3c 0a                	cmp    al,0xa
    4014b1:	74 16                	je     4014c9 <main+0x1e5>
    4014b3:	ba 18 00 00 00       	mov    edx,0x18
    4014b8:	4c 89 e6             	mov    rsi,r12
    4014bb:	4c 89 ef             	mov    rdi,r13
    4014be:	e8 5d fd ff ff       	call   401220 <memcmp@plt>
    4014c3:	85 c0                	test   eax,eax
    4014c5:	41 0f 45 ef          	cmovne ebp,r15d
    4014c9:	ff c3                	inc    ebx
    4014cb:	49 83 c5 18          	add    r13,0x18
    4014cf:	49 83 c4 18          	add    r12,0x18
    4014d3:	eb bc                	jmp    401491 <main+0x1ad>

  # check total data amount
  4014d5:	48 81 3d 90 e6 00 00 	cmp    QWORD PTR [rip+0xe690],0x11d        # 40fb70 <total_data> data added by read exact
  4014dc:	1d 01 00 00 
  4014e0:	77 0d                	ja     4014ef <main+0x20b>
  4014e2:	40 80 e5 01          	and    bpl,0x1
  4014e6:	74 07                	je     4014ef <main+0x20b>
  4014e8:	31 c0                	xor    eax,eax
  4014ea:	e8 17 01 00 00       	call   401606 <win>

  # check stack guard canary and function epilogue
  4014ef:	48 8b 84 24 28 10 00 	mov    rax,QWORD PTR [rsp+0x1028]
  4014f6:	00 
  4014f7:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  4014fe:	00 00 
  401500:	74 05                	je     401507 <main+0x223>
  401502:	e8 b9 fc ff ff       	call   4011c0 <__stack_chk_fail@plt>
  401507:	48 81 c4 38 10 00 00 	add    rsp,0x1038
  40150e:	31 c0                	xor    eax,eax
  401510:	5b                   	pop    rbx
  401511:	5d                   	pop    rbp
  401512:	41 5c                	pop    r12
  401514:	41 5d                	pop    r13
  401516:	41 5e                	pop    r14
  401518:	41 5f                	pop    r15
  40151a:	c3                   	ret
  40151b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

0000000000401ae1 <handle_3>:
  # set up local vars and read sprite id
  401ae1:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  401ae5:	41 54                	push   r12
  401ae7:	41 83 c8 ff          	or     r8d,0xffffffff
  401aeb:	ba 01 00 00 00       	mov    edx,0x1
  401af0:	48 8d 0d f7 16 00 00 	lea    rcx,[rip+0x16f7]        # 4031ee <_IO_stdin_used+0x1ee>
  401af7:	55                   	push   rbp
  401af8:	48 89 fd             	mov    rbp,rdi # cimg header addr
  401afb:	31 ff                	xor    edi,edi
  401afd:	53                   	push   rbx
  401afe:	48 83 ec 10          	sub    rsp,0x10
  401b02:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
  401b09:	00 00 
  401b0b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax # stack guard canary to stack
  401b10:	31 c0                	xor    eax,eax
  401b12:	48 8d 74 24 05       	lea    rsi,[rsp+0x5]
  401b17:	e8 df fb ff ff       	call   4016fb <read_exact> # read 1 byte as sprite id

  # read sprite width
  401b1c:	48 8d 74 24 06       	lea    rsi,[rsp+0x6]
  401b21:	41 83 c8 ff          	or     r8d,0xffffffff
  401b25:	31 ff                	xor    edi,edi
  401b27:	48 8d 0d 83 16 00 00 	lea    rcx,[rip+0x1683]        # 4031b1 <_IO_stdin_used+0x1b1>
  401b2e:	ba 01 00 00 00       	mov    edx,0x1
  401b33:	e8 c3 fb ff ff       	call   4016fb <read_exact> # read 1 byte as sprite width

  # read sprite height
  401b38:	ba 01 00 00 00       	mov    edx,0x1
  401b3d:	31 ff                	xor    edi,edi
  401b3f:	41 83 c8 ff          	or     r8d,0xffffffff
  401b43:	48 8d 74 24 07       	lea    rsi,[rsp+0x7]
  401b48:	48 8d 0d 80 16 00 00 	lea    rcx,[rip+0x1680]        # 4031cf <_IO_stdin_used+0x1cf>
  401b4f:	e8 a7 fb ff ff       	call   4016fb <read_exact> # read 1 byte as sprite height

  # sprite width and height to sprite data header
  401b54:	0f b6 44 24 05       	movzx  eax,BYTE PTR [rsp+0x5] # sprite id
  401b59:	8a 54 24 06          	mov    dl,BYTE PTR [rsp+0x6] # sprite width
  401b5d:	48 c1 e0 04          	shl    rax,0x4 # sprite offset
  401b61:	48 01 e8             	add    rax,rbp # cimg header addr + sprite offset as sprite data header addr
  401b64:	88 50 19             	mov    BYTE PTR [rax+0x19],dl # sprite width
  401b67:	48 8b 78 20          	mov    rdi,QWORD PTR [rax+0x20] # sprite data addr
  401b6b:	8a 54 24 07          	mov    dl,BYTE PTR [rsp+0x7] # sprite height
  401b6f:	88 50 18             	mov    BYTE PTR [rax+0x18],dl # sprite height
  401b72:	48 85 ff             	test   rdi,rdi
  401b75:	74 05                	je     401b7c <handle_3+0x9b> if sprite data addr is zero jump alloc sprite data

  # free sprite data addr
  401b77:	e8 04 f6 ff ff       	call   401180 <free@plt>

  # malloc sprite data
  401b7c:	44 0f b6 64 24 06    	movzx  r12d,BYTE PTR [rsp+0x6] # sprite width
  401b82:	0f b6 54 24 07       	movzx  edx,BYTE PTR [rsp+0x7] # sprite height
  401b87:	44 0f af e2          	imul   r12d,edx # sprite width * sprite height as sprite dimensions
  401b8b:	49 63 fc             	movsxd rdi,r12d
  401b8e:	e8 ad f6 ff ff       	call   401240 <malloc@plt> # malloc dimensions
  401b93:	48 89 c3             	mov    rbx,rax # malloced sprite data addr
  401b96:	48 85 c0             	test   rax,rax
  401b99:	75 0e                	jne    401ba9 <handle_3+0xc8> #  if malloc success jump read sprite data

  # handle malloc error
  401b9b:	48 8d 3d 31 15 00 00 	lea    rdi,[rip+0x1531]        # 4030d3 <_IO_stdin_used+0xd3>
  401ba2:	e8 f9 f5 ff ff       	call   4011a0 <puts@plt>
  401ba7:	eb 55                	jmp    401bfe <handle_3+0x11d> # jump exit

  # read sprite data
  401ba9:	44 89 e2             	mov    edx,r12d # sprite dimensions
  401bac:	48 89 c6             	mov    rsi,rax # sprite data addr
  401baf:	41 83 c8 ff          	or     r8d,0xffffffff
  401bb3:	31 ff                	xor    edi,edi
  401bb5:	48 8d 0d 4c 15 00 00 	lea    rcx,[rip+0x154c]        # 403108 <_IO_stdin_used+0x108>
  401bbc:	e8 3a fb ff ff       	call   4016fb <read_exact> # read sprite dimensions num of bytes to sprite data addr

  # check sprite data bytes
  401bc1:	0f b6 44 24 07       	movzx  eax,BYTE PTR [rsp+0x7] # sprite height
  401bc6:	0f b6 54 24 06       	movzx  edx,BYTE PTR [rsp+0x6] # sprite width
  401bcb:	0f af d0             	imul   edx,eax # sprite dimensions
  401bce:	31 c0                	xor    eax,eax # zero counter

  # check sprite data bytes loop
  401bd0:	39 c2                	cmp    edx,eax
  401bd2:	7e 32                	jle    401c06 <handle_3+0x125> # if sprite dimensions <= counter jump sprite data addr to sprite data header

      # check sprite data bytes 
      401bd4:	0f b6 0c 03          	movzx  ecx,BYTE PTR [rbx+rax*1]
      401bd8:	48 ff c0             	inc    rax # counter++
      401bdb:	8d 71 e0             	lea    esi,[rcx-0x20]
      401bde:	40 80 fe 5e          	cmp    sil,0x5e
      401be2:	76 ec                	jbe    401bd0 <handle_3+0xef> if byte - 0x20 <= 0x5e jump check sprite data bytes loop

  # handle sprite data bytes error
  401be4:	48 8b 3d 75 df 00 00 	mov    rdi,QWORD PTR [rip+0xdf75]        # 40fb60 <stderr@GLIBC_2.2.5>
  401beb:	48 8d 15 32 15 00 00 	lea    rdx,[rip+0x1532]        # 403124 <_IO_stdin_used+0x124>
  401bf2:	be 01 00 00 00       	mov    esi,0x1
  401bf7:	31 c0                	xor    eax,eax
  401bf9:	e8 92 f6 ff ff       	call   401290 <__fprintf_chk@plt>

  # exit
  401bfe:	83 cf ff             	or     edi,0xffffffff
  401c01:	e8 7a f6 ff ff       	call   401280 <exit@plt>

  # sprite data addr to sprite data header
  401c06:	0f b6 44 24 05       	movzx  eax,BYTE PTR [rsp+0x5]
  401c0b:	48 c1 e0 04          	shl    rax,0x4 # sprite offset
  401c0f:	48 89 5c 28 20       	mov    QWORD PTR [rax+rbp*1+0x20],rbx

  # check stack corruption and return
  401c14:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
  401c19:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401c20:	00 00 
  401c22:	74 05                	je     401c29 <handle_3+0x148>
  401c24:	e8 97 f5 ff ff       	call   4011c0 <__stack_chk_fail@plt>
  401c29:	48 83 c4 10          	add    rsp,0x10
  401c2d:	5b                   	pop    rbx
  401c2e:	5d                   	pop    rbp
  401c2f:	41 5c                	pop    r12
  401c31:	c3                   	ret

0000000000401c32 <handle_4>:
  401c32:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  401c36:	41 57                	push   r15
  401c38:	41 56                	push   r14
  401c3a:	41 55                	push   r13
  401c3c:	41 54                	push   r12
  401c3e:	55                   	push   rbp
  401c3f:	53                   	push   rbx

  # setup local variables
  401c40:	4c 8d 9c 24 00 00 fc 	lea    r11,[rsp-0x40000]
  401c47:	ff 
  401c48:	48 81 ec 00 10 00 00 	sub    rsp,0x1000
  401c4f:	83 0c 24 00          	or     DWORD PTR [rsp],0x0 # check stack overflow by page fault on unmapped page
  401c53:	4c 39 dc             	cmp    rsp,r11
  401c56:	75 f0                	jne    401c48 <handle_4+0x16>
  401c58:	48 83 ec 48          	sub    rsp,0x48

  # read directive 4 header
  401c5c:	48 8d 0d ad 15 00 00 	lea    rcx,[rip+0x15ad]        # 403210 <_IO_stdin_used+0x210>
  401c63:	ba 09 00 00 00       	mov    edx,0x9
  401c68:	41 83 c8 ff          	or     r8d,0xffffffff
  401c6c:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
  401c73:	00 00 
  401c75:	48 89 84 24 38 00 04 	mov    QWORD PTR [rsp+0x40038],rax # stack guard canary to stack
  401c7c:	00 
  401c7d:	31 c0                	xor    eax,eax
  401c7f:	48 89 fb             	mov    rbx,rdi # save cimg header addr
  401c82:	48 8d 74 24 16       	lea    rsi,[rsp+0x16] # directive 4 header addr as sprite render header addr
  401c87:	31 ff                	xor    edi,edi
  401c89:	e8 6d fa ff ff       	call   4016fb <read_exact> # read 9 bytes to rsp+0x16 through rsp+0x1e

  # setup sprite pixel buf var
  401c8e:	48 8d 7c 24 1f       	lea    rdi,[rsp+0x1f] # sprite pixels buf addr
  401c93:	b9 00 00 01 00       	mov    ecx,0x10000
  401c98:	31 c0                	xor    eax,eax
  401c9a:	0f b6 54 24 16       	movzx  edx,BYTE PTR [rsp+0x16] # sprite id
  401c9f:	44 8a 54 24 17       	mov    r10b,BYTE PTR [rsp+0x17] # r
  401ca4:	48 8d 74 24 1f       	lea    rsi,[rsp+0x1f] # sprite pixels buf addr
  401ca9:	f3 ab                	rep stos DWORD PTR es:[rdi],eax # zero 0x10000 bytes sprite pixels buf

  # fill sprite pixels buf
  401cab:	44 8a 5c 24 18       	mov    r11b,BYTE PTR [rsp+0x18] # g
  401cb0:	40 8a 6c 24 19       	mov    bpl,BYTE PTR [rsp+0x19] # b
  401cb5:	48 c1 e2 04          	shl    rdx,0x4 # sprite id * 16 as sprite offset
  401cb9:	48 01 da             	add    rdx,rbx # cimg header addr + sprite offset as sprite data header addr
  401cbc:	44 0f b6 62 18       	movzx  r12d,BYTE PTR [rdx+0x18] # sprite data header addr + 0x18 val as sprite height

  # sprite height loop
  401cc1:	41 39 cc             	cmp    r12d,ecx # sprite height counter is 0 due to rep stos
  401cc4:	7e 58                	jle    401d1e <handle_4+0xec> # if sprite height <= sprite height counter jump fill frame buf

      # calculate current sprite row offset
      401cc6:	44 0f b6 42 19       	movzx  r8d,BYTE PTR [rdx+0x19] # sprite data header addr + 0x19 val as sprite width
      401ccb:	31 ff                	xor    edi,edi # zero sprite width counter
      401ccd:	44 89 c0             	mov    eax,r8d # sprite width
      401cd0:	0f af c1             	imul   eax,ecx # sprite width * sprite height counter as sprite row offset as current pixel offset

      # sprite width loop
      401cd3:	41 39 f8             	cmp    r8d,edi
      401cd6:	7e 42                	jle    401d1a <handle_4+0xe8> # if sprite width <= sprite width counter jump inc sprite height counter

            # fill current pixel buf color
            401cd8:	4c 8b 4a 20          	mov    r9,QWORD PTR [rdx+0x20] # sprite data header addr + 0x20 val as sprite data addr
            401cdc:	44 88 14 86          	mov    BYTE PTR [rsi+rax*4],r10b # r to sprite pixels buf addr + current pixel offset
            401ce0:	44 88 5c 86 01       	mov    BYTE PTR [rsi+rax*4+0x1],r11b # g to sprite pixels buf addr + current pixel offset
            401ce5:	40 88 6c 86 02       	mov    BYTE PTR [rsi+rax*4+0x2],bpl # b to sprite pixels buf addr + current pixel offset
            401cea:	4d 85 c9             	test   r9,r9
            401ced:	75 1b                	jne    401d0a <handle_4+0xd8> if sprite data addr is not zero jump fill current pixel buf char

            # handle sprite data addr zero error
            401cef:	48 8b 35 6a de 00 00 	mov    rsi,QWORD PTR [rip+0xde6a]        # 40fb60 <stderr@GLIBC_2.2.5>
            401cf6:	48 8d 3d 40 15 00 00 	lea    rdi,[rip+0x1540]        # 40323d <_IO_stdin_used+0x23d>
            401cfd:	e8 de f4 ff ff       	call   4011e0 <fputs@plt>
            401d02:	83 cf ff             	or     edi,0xffffffff
            401d05:	e8 76 f5 ff ff       	call   401280 <exit@plt>

            # fill current pixel buf char
            401d0a:	45 8a 0c 01          	mov    r9b,BYTE PTR [r9+rax*1] # current pixel sprite data char

      # inc sprite width counter
      401d0e:	ff c7                	inc    edi # sprite width counter ++
      401d10:	44 88 4c 86 03       	mov    BYTE PTR [rsi+rax*4+0x3],r9b # current pixel sprite data char to sprite pixels buf addr + current pixel offset
      401d15:	48 ff c0             	inc    rax # current pixel offset ++
      401d18:	eb b9                	jmp    401cd3 <handle_4+0xa1> # jump sprite width loop

  # inc sprite height counter
  401d1a:	ff c1                	inc    ecx # sprite height counter ++
  401d1c:	eb a3                	jmp    401cc1 <handle_4+0x8f> # jump sprite height loop
  
  # render sprites and blit them to frame buf
  401d1e:	45 31 ff             	xor    r15d,r15d # zero vertical repitition counter
  401d21:	48 8d bc 24 1f 00 04 	lea    rdi,[rsp+0x4001f] # rendered pixel buf addr
  401d28:	00 

  # vertical sprite repitition loop
  401d29:	0f b6 44 24 1d       	movzx  eax,BYTE PTR [rsp+0x1d] # sprite render header addr + 0x07 as vertical repititions
  401d2e:	44 39 f8             	cmp    eax,r15d
  401d31:	0f 8e 2c 01 00 00    	jle    401e63 <handle_4+0x231> # if vertical repititions <= vertical repitition counter jump check stack guard canary and funciton epliogue
  401d37:	45 31 d2             	xor    r10d,r10d zero horizontal repitition counter

      # horizontal sprite repitition loop
      401d3a:	0f b6 44 24 1c       	movzx  eax,BYTE PTR [rsp+0x1c] # sprite render header addr + 0x1c as horizontal repititions
      401d3f:	44 39 d0             	cmp    eax,r10d
      401d42:	0f 8e 13 01 00 00    	jle    401e5b <handle_4+0x229> # if horizontal repititions <= horizontal repitition counter jump inc vertical repitition counter

          # calculate horizontal and vertical pixel offsets
          401d48:	0f b6 54 24 16       	movzx  edx,BYTE PTR [rsp+0x16] # sprite id
          401d4d:	45 31 db             	xor    r11d,r11d # zero sprite height counter
          401d50:	48 c1 e2 04          	shl    rdx,0x4
          401d54:	48 01 da             	add    rdx,rbx # cimg header addr + sprite offset as sprite data header addr
          401d57:	8a 42 19             	mov    al,BYTE PTR [rdx+0x19] # sprite width
          401d5a:	41 0f af c2          	imul   eax,r10d # horizontal repitition counter * sprite width as horizontal repitition pixel offset
          401d5e:	02 44 24 1a          	add    al,BYTE PTR [rsp+0x1a] # horizontal repitition pixel offset + fixed horizontal sprite offset as horizontal pixel offset
          401d62:	44 0f b6 e0          	movzx  r12d,al # save horizontal pixel offset
          401d66:	8a 42 18             	mov    al,BYTE PTR [rdx+0x18] # sprite height
          401d69:	41 0f af c7          	imul   eax,r15d # vertical repitition counter * sprite height as vertical repitition pixel offset
          401d6d:	02 44 24 1b          	add    al,BYTE PTR [rsp+0x1b] # vertical repitition pixel offset + fixed vertical sprite offset as vertical pixel offset
          401d71:	0f b6 e8             	movzx  ebp,al # save vertical pixel offset

          # sprite to frame y loop
          401d74:	0f b6 44 24 16       	movzx  eax,BYTE PTR [rsp+0x16] # sprite id
          401d79:	48 c1 e0 04          	shl    rax,0x4
          401d7d:	0f b6 44 18 18       	movzx  eax,BYTE PTR [rax+rbx*1+0x18] # sprite height
          401d82:	44 39 d8             	cmp    eax,r11d
          401d85:	0f 8e c8 00 00 00    	jle    401e53 <handle_4+0x221> # if sprite height <= sprite height counter jump inc inner
          401d8b:	45 31 ed             	xor    r13d,r13d # zero sprite width counter

              # sprite to frame x loop
              401d8e:	0f b6 44 24 16       	movzx  eax,BYTE PTR [rsp+0x16] # sprite id
              401d93:	48 c1 e0 04          	shl    rax,0x4
              401d97:	0f b6 44 18 19       	movzx  eax,BYTE PTR [rax+rbx*1+0x19] # sprite width
              401d9c:	44 39 e8             	cmp    eax,r13d
              401d9f:	0f 8e a4 00 00 00    	jle    401e49 <handle_4+0x217> # if sprite width <= sprite width counter jump inc sprite height counter

                  401da5:	41 0f af c3          	imul   eax,r11d # sprite width * sprite height counter
                  401da9:	44 01 e8             	add    eax,r13d # sprite width * sprite height counter + sprite width counter as current sprite pixel offset
                  401dac:	48 98                	cdqe
                  401dae:	0f b6 54 84 22       	movzx  edx,BYTE PTR [rsp+rax*4+0x22] # rsp + 0x1f as sprite pixel buf => current sprite pixel char
                  401db3:	3a 54 24 1e          	cmp    dl,BYTE PTR [rsp+0x1e]
                  401db7:	0f 84 84 00 00 00    	je     401e41 <handle_4+0x20f> # if current sprite pixel char == dir 4 last byte jump inc sprite width counter

                  # print formatted pixel to rendered pixel buf
                  401dbd:	44 89 5c 24 0c       	mov    DWORD PTR [rsp+0xc],r11d
                  401dc2:	be 19 00 00 00       	mov    esi,0x19 # max len
                  401dc7:	44 0f b6 73 06       	movzx  r14d,BYTE PTR [rbx+0x6]
                  401dcc:	4c 8d 05 83 13 00 00 	lea    r8,[rip+0x1383] # format str addr 403156 <_IO_stdin_used+0x156>
                  401dd3:	44 89 54 24 08       	mov    DWORD PTR [rsp+0x8],r10d
                  401dd8:	51                   	push   rcx # push for stack align 16 byte boundary
                  401dd9:	b9 19 00 00 00       	mov    ecx,0x19 # str len
                  401dde:	52                   	push   rdx # current sprite pixel char
                  401ddf:	0f b6 54 84 31       	movzx  edx,BYTE PTR [rsp+rax*4+0x31] # b
                  401de4:	52                   	push   rdx
                  401de5:	0f b6 54 84 38       	movzx  edx,BYTE PTR [rsp+rax*4+0x38] # g
                  401dea:	52                   	push   rdx
                  401deb:	44 0f b6 4c 84 3f    	movzx  r9d,BYTE PTR [rsp+rax*4+0x3f] # r
                  401df1:	ba 01 00 00 00       	mov    edx,0x1 # security flag val
                  401df6:	31 c0                	xor    eax,eax # number vec regs used
                  401df8:	48 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],rdi # rendered pixel buf addr
                  401dfd:	e8 6e f3 ff ff       	call   401170 <__snprintf_chk@plt>

                  # rendered pixel buf to frame buf
                  401e02:	43 8d 44 25 00       	lea    eax,[r13+r12*1+0x0]
                  401e07:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20] # rendered pixel buf addr
                  401e0c:	44 8b 5c 24 2c       	mov    r11d,DWORD PTR [rsp+0x2c]
                  401e11:	99                   	cdq
                  401e12:	44 8b 54 24 28       	mov    r10d,DWORD PTR [rsp+0x28]
                  401e17:	48 83 c4 20          	add    rsp,0x20
                  401e1b:	41 f7 fe             	idiv   r14d
                  401e1e:	0f 10 07             	movups xmm0,XMMWORD PTR [rdi]
                  401e21:	44 0f af f5          	imul   r14d,ebp
                  401e25:	42 8d 04 32          	lea    eax,[rdx+r14*1]
                  401e29:	31 d2                	xor    edx,edx
                  401e2b:	f7 73 0c             	div    DWORD PTR [rbx+0xc]
                  401e2e:	48 6b d2 18          	imul   rdx,rdx,0x18
                  401e32:	48 03 53 10          	add    rdx,QWORD PTR [rbx+0x10]
                  401e36:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0
                  401e39:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
                  401e3d:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax

              # inc sprite width counter
              401e41:	41 ff c5             	inc    r13d # sprite width counter++
              401e44:	e9 45 ff ff ff       	jmp    401d8e <handle_4+0x15c> # jump sprite to frame x loop

          # inc sprite height counter
          401e49:	41 ff c3             	inc    r11d
          401e4c:	ff c5                	inc    ebp
          401e4e:	e9 21 ff ff ff       	jmp    401d74 <handle_4+0x142> # jump sprite to frame y loop

      # inc horizontal repitition counter
      401e53:	41 ff c2             	inc    r10d
      401e56:	e9 df fe ff ff       	jmp    401d3a <handle_4+0x108> # jump horizontal sprite repitition loop

  # inc vertical repitition counter
  401e5b:	41 ff c7             	inc    r15d
  401e5e:	e9 c6 fe ff ff       	jmp    401d29 <handle_4+0xf7> # jump vertical sprite repitition loop

  # check stack guard canary and funciton epliogue
  401e63:	48 8b 84 24 38 00 04 	mov    rax,QWORD PTR [rsp+0x40038]
  401e6a:	00 
  401e6b:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401e72:	00 00 
  401e74:	74 05                	je     401e7b <handle_4+0x249>
  401e76:	e8 45 f3 ff ff       	call   4011c0 <__stack_chk_fail@plt>
  401e7b:	48 81 c4 48 00 04 00 	add    rsp,0x40048
  401e82:	5b                   	pop    rbx
  401e83:	5d                   	pop    rbp
  401e84:	41 5c                	pop    r12
  401e86:	41 5d                	pop    r13
  401e88:	41 5e                	pop    r14
  401e8a:	41 5f                	pop    r15
  401e8c:	c3                   	ret
