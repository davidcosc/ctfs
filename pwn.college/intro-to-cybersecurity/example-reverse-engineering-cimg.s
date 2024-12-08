# main buf = rsp+0x10 with size 0x28

Disassembly of section .text:

00000000004012a4 <main>:
  4012a4:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  4012a8:	41 57                	push   r15 # save
  4012aa:	0f 57 c0             	xorps  xmm0,xmm0 # zero xmm0
  4012ad:	41 56                	push   r14 # save
  4012af:	41 55                	push   r13 # save
  4012b1:	41 54                	push   r12 # save
  4012b3:	55                   	push   rbp # save current stack frame
  4012b4:	53                   	push   rbx # save
  4012b5:	48 83 ec 38          	sub    rsp,0x38 # alloc local vars
  4012b9:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  4012c0:	00 00 
  4012c2:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax # stack guard canary to stack
  4012c7:	31 c0                	xor    eax,eax # zero eax
  4012c9:	ff cf                	dec    edi # argc - 1 => sets zero flag if zero
  4012cb:	0f 11 44 24 10       	movups XMMWORD PTR [rsp+0x10],xmm0 # zero 16 bytes of main buf
  4012d0:	48 c7 44 24 20 00 00 	mov    QWORD PTR [rsp+0x20],0x0 # # zero 8 bytes of main buf
  4012d7:	00 00 
  4012d9:	7e 4f                	jle    40132a <main+0x86> # jump get_img_header from stdin if no cmd arg
handle_cmd_arg:
  4012db:	48 8b 6e 08          	mov    rbp,QWORD PTR [rsi+0x8] # cmd arg 2 addr
  4012df:	48 83 c9 ff          	or     rcx,0xffffffffffffffff # -1
  4012e3:	48 8d 35 bf 0e 00 00 	lea    rsi,[rip+0xebf] # img format str addr as arg 2 # 4021a9 <_IO_stdin_used+0x1a9>
  4012ea:	48 89 ef             	mov    rdi,rbp # cmd arg 2 addr
  4012ed:	f2 ae                	repnz scas al,BYTE PTR es:[rdi] # get cmd arg 2 str len: ecx = -1 minus 1 for each cmd arg 2 char until checked char is zero aka null term
  4012ef:	48 f7 d1             	not    rcx # - len to + len
  4012f2:	48 8d 7c 0d fa       	lea    rdi,[rbp+rcx*1-0x6] # last 6 bytes of cmd arg 2 str as arg 1
  4012f7:	e8 f4 fe ff ff       	call   4011f0 <strcmp@plt> # check img format is .cimg
  4012fc:	85 c0                	test   eax,eax
  4012fe:	74 15                	je     401315 <main+0x71> jump img_as_stdin if correct extension
handle_img_fmt_err:
  401300:	48 8d 35 a8 0e 00 00 	lea    rsi,[rip+0xea8] # img extension err str as arg 2 # 4021af <_IO_stdin_used+0x1af>
  401307:	bf 01 00 00 00       	mov    edi,0x1 # security flag val as arg 1
  40130c:	31 c0                	xor    eax,eax # num vec args used
  40130e:	e8 fd fe ff ff       	call   401210 <__printf_chk@plt> # printf err str with stack overflow check
  401313:	eb 4a                	jmp    40135f <main+0xbb> crash
img_as_stdin:
  401315:	31 f6                	xor    esi,esi # O_RDONLY as arg 2
  401317:	48 89 ef             	mov    rdi,rbp # cmd arg 2 addr as file name addr as arg 1
  40131a:	31 c0                	xor    eax,eax # num vec args used
  40131c:	e8 0f ff ff ff       	call   401230 <open@plt>
  401321:	31 f6                	xor    esi,esi # stdin fd as arg 2
  401323:	89 c7                	mov    edi,eax # img fd as arg 1
  401325:	e8 76 fe ff ff       	call   4011a0 <dup2@plt> # img file fd as stdin fd
get_img_header:
  40132a:	48 8d 5c 24 10       	lea    rbx,[rsp+0x10] # main buf addr
  40132f:	41 83 c8 ff          	or     r8d,0xffffffff # -1 exit code as arg 5
  401333:	31 ff                	xor    edi,edi # zero as arg 1
  401335:	ba 0c 00 00 00       	mov    edx,0xc # 12 as num bytes read as arg 3
  40133a:	48 8d 0d 92 0e 00 00 	lea    rcx,[rip+0xe92] # img header err str addr as arg 4 # 4021d3 <_IO_stdin_used+0x1d3>
  401341:	48 89 de             	mov    rsi,rbx # main buf addr as in buf as arg 2
  401344:	e8 12 03 00 00       	call   40165b <read_exact> # read img header to main buf
  401349:	81 7c 24 10 63 49 4d 	cmp    DWORD PTR [rsp+0x10],0x474d4963 # magic number
  401350:	47 
  401351:	74 14                	je     401367 <main+0xc3> # jump check_version if correct magic number
print_err:
  401353:	48 8d 3d 9c 0e 00 00 	lea    rdi,[rip+0xe9c]        # 4021f6 <_IO_stdin_used+0x1f6>
  40135a:	e8 11 fe ff ff       	call   401170 <puts@plt>
crash:
  40135f:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401362:	e8 d9 fe ff ff       	call   401240 <exit@plt>
check_version:
  401367:	66 83 7c 24 14 03    	cmp    WORD PTR [rsp+0x14],0x3 # img version
  40136d:	48 8d 3d 9f 0e 00 00 	lea    rdi,[rip+0xe9f] # img version err str addr # 402213 <_IO_stdin_used+0x213>
  401374:	75 e4                	jne    40135a <main+0xb6> # jump print_err call if img version not 0x3
set_framebuffer:
  401376:	48 89 df             	mov    rdi,rbx # main buf addr as arg 1
  401379:	48 8d 6c 24 0e       	lea    rbp,[rsp+0xe] # directive code addr
  40137e:	e8 b8 04 00 00       	call   40183b <initialize_framebuffer>
handle_directives:
  401383:	8b 44 24 18          	mov    eax,DWORD PTR [rsp+0x18] # directive flag
  401387:	8d 50 ff             	lea    edx,[rax-0x1] # directive flag - 1
  40138a:	89 54 24 18          	mov    DWORD PTR [rsp+0x18],edx # directive flag - 1 to directive flag addr
  40138e:	85 c0                	test   eax,eax
  401390:	74 4b                	je     4013dd <main+0x139> # jump display_img if directive flag zero aka no more directives
  401392:	48 8d 0d 96 0e 00 00 	lea    rcx,[rip+0xe96] # err str addr # 40222f <_IO_stdin_used+0x22f>
  401399:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1
  40139d:	48 89 ee             	mov    rsi,rbp # directive code addr
  4013a0:	31 ff                	xor    edi,edi # stdin fd
  4013a2:	ba 02 00 00 00       	mov    edx,0x2 # num bytes read
  4013a7:	e8 af 02 00 00       	call   40165b <read_exact> read directive code
  4013ac:	0f b7 4c 24 0e       	movzx  ecx,WORD PTR [rsp+0xe] # directive code
  4013b1:	66 83 f9 01          	cmp    cx,0x1
  4013b5:	75 0a                	jne    4013c1 <main+0x11d> # jump handle_directive_code_err if directive code ne 1
  4013b7:	48 89 df             	mov    rdi,rbx # main buf addr as arg 1
  4013ba:	e8 ec 02 00 00       	call   4016ab <handle_1>
  4013bf:	eb c2                	jmp    401383 <main+0xdf> # jump handle_directives
handle_directive_code_err:
  4013c1:	48 8b 3d d8 d9 00 00 	mov    rdi,QWORD PTR [rip+0xd9d8] # stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  4013c8:	48 8d 15 87 0e 00 00 	lea    rdx,[rip+0xe87] # directive code err str addr # 402256 <_IO_stdin_used+0x256>
  4013cf:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  4013d4:	31 c0                	xor    eax,eax # numm vec regs used
  4013d6:	e8 75 fe ff ff       	call   401250 <__fprintf_chk@plt>
  4013db:	eb 82                	jmp    40135f <main+0xbb> # jump crash
display_img:
  4013dd:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20] # frame buf addr
  4013e2:	31 db                	xor    ebx,ebx # allow_win to zero
  4013e4:	4c 8d 25 35 2c 00 00 	lea    r12,[rip+0x2c35]        # 404020 <desired_output>
  4013eb:	e8 80 fd ff ff       	call   401170 <puts@plt> # display image
check_num_pixels:
  4013f0:	44 8b 74 24 1c       	mov    r14d,DWORD PTR [rsp+0x1c] # actual num pixels
  4013f5:	4c 8b 6c 24 20       	mov    r13,QWORD PTR [rsp+0x20] # frame buf addr
  4013fa:	41 81 fe 38 07 00 00 	cmp    r14d,0x738
  401401:	0f 94 c3             	sete   bl # allow_win = 1 if actual num pixels eq 0x738
check_pixel_items:
  401404:	31 ed                	xor    ebp,ebp # counter
  401406:	45 31 ff             	xor    r15d,r15d # zero
1:
  401409:	44 39 f5             	cmp    ebp,r14d
  40140c:	73 3f                	jae    40144d <main+0x1a9> # jump 3 counter >= actual num pixels
  40140e:	81 fd 38 07 00 00    	cmp    ebp,0x738
  401414:	74 37                	je     40144d <main+0x1a9> # jump 3 counter == expected num pixels
  401416:	41 8a 45 13          	mov    al,BYTE PTR [r13+0x13] # actual pixel val
  40141a:	41 3a 44 24 13       	cmp    al,BYTE PTR [r12+0x13] # expected pixel val
  40141f:	41 0f 45 df          	cmovne ebx,r15d # allow_win = zero if actual ne expected pixel val
  401423:	3c 20                	cmp    al,0x20
  401425:	74 1a                	je     401441 <main+0x19d> # jump 2 if pixel val eq space
  401427:	3c 0a                	cmp    al,0xa
  401429:	74 16                	je     401441 <main+0x19d> # jump 2 if pixel val eq line feed
  40142b:	ba 18 00 00 00       	mov    edx,0x18 # num bytes
  401430:	4c 89 e6             	mov    rsi,r12 # actual pixel item addr
  401433:	4c 89 ef             	mov    rdi,r13 # expected pixel item addr
  401436:	e8 a5 fd ff ff       	call   4011e0 <memcmp@plt>
  40143b:	85 c0                	test   eax,eax
  40143d:	41 0f 45 df          	cmovne ebx,r15d # allow_win = zero if pixel items differ
2:
  401441:	ff c5                	inc    ebp # counter ++
  401443:	49 83 c5 18          	add    r13,0x18 # next actual pixel item addr
  401447:	49 83 c4 18          	add    r12,0x18 # next expected pixel item addr
  40144b:	eb bc                	jmp    401409 <main+0x165> # jump 1
3:
  40144d:	85 db                	test   ebx,ebx
  40144f:	74 07                	je     401458 <main+0x1b4> # jump check_stack_tampered if allow_win eq zero
  401451:	31 c0                	xor    eax,eax # zero eax
  401453:	e8 0e 01 00 00       	call   401566 <win>
check_stack_tampered:
  401458:	48 8b 44 24 28       	mov    rax,QWORD PTR [rsp+0x28] # stack guard canary from stack
  40145d:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401464:	00 00 
  401466:	74 05                	je     40146d <main+0x1c9> # jump end if not corrupted
  401468:	e8 23 fd ff ff       	call   401190 <__stack_chk_fail@plt> # fail
end:
  40146d:	48 83 c4 38          	add    rsp,0x38 # clean up stack local vars
  401471:	31 c0                	xor    eax,eax # return zero
  401473:	5b                   	pop    rbx # restore
  401474:	5d                   	pop    rbp # restore
  401475:	41 5c                	pop    r12 # restore
  401477:	41 5d                	pop    r13 # restore
  401479:	41 5e                	pop    r14 # restore
  40147b:	41 5f                	pop    r15 # restore
  40147d:	c3                   	ret

# rdi = fd to read
# rsi = input buf addr
# rdx = num bytes read
# rcx = err str addr
# r8 = exit code
000000000040165b <read_exact>:
  40165b:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  40165f:	41 54                	push   r12 save
  401661:	48 63 d2             	movsxd rdx,edx # num bytes read
  401664:	49 89 cc             	mov    r12,rcx # err str addr
  401667:	55                   	push   rbp # save
  401668:	44 89 c5             	mov    ebp,r8d # exit code
  40166b:	53                   	push   rbx # save
  40166c:	48 89 d3             	mov    rbx,rdx # num bytes read
  40166f:	e8 5c fb ff ff       	call   4011d0 <read@plt>
  401674:	39 c3                	cmp    ebx,eax
  401676:	74 2e                	je     4016a6 <read_exact+0x4b> # jump end if actual bytes read eq to expected bytes read
  401678:	48 8b 3d 21 d7 00 00 	mov    rdi,QWORD PTR [rip+0xd721] # stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  40167f:	4c 89 e2             	mov    rdx,r12 # err str addr
  401682:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  401687:	31 c0                	xor    eax,eax # num vec args used
  401689:	e8 c2 fb ff ff       	call   401250 <__fprintf_chk@plt>
  40168e:	48 8b 35 0b d7 00 00 	mov    rsi,QWORD PTR [rip+0xd70b] # stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  401695:	bf 0a 00 00 00       	mov    edi,0xa # lf
  40169a:	e8 21 fb ff ff       	call   4011c0 <fputc@plt>
  40169f:	89 ef                	mov    edi,ebp # exit code
  4016a1:	e8 9a fb ff ff       	call   401240 <exit@plt>
end:
  4016a6:	5b                   	pop    rbx # restore
  4016a7:	5d                   	pop    rbp # restore
  4016a8:	41 5c                	pop    r12 # restore
  4016aa:	c3                   	ret

# rdi = main buf addr
00000000004016ab <handle_1>:
  4016ab:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  4016af:	41 57                	push   r15 # save
  4016b1:	41 56                	push   r14 # save
  4016b3:	41 55                	push   r13 # save
  4016b5:	41 54                	push   r12 # save
  4016b7:	55                   	push   rbp # save
  4016b8:	53                   	push   rbx # save
  4016b9:	48 89 fb             	mov    rbx,rdi # main buf addr
  4016bc:	48 83 ec 48          	sub    rsp,0x48 # alloc local vars
  4016c0:	0f b6 6f 06          	movzx  ebp,BYTE PTR [rdi+0x6] # x
  4016c4:	0f b6 57 07          	movzx  edx,BYTE PTR [rdi+0x7] # y
  4016c8:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  4016cf:	00 00 
  4016d1:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax # stack guard canary to stack
  4016d6:	31 c0                	xor    eax,eax # zero eax
  4016d8:	0f af ea             	imul   ebp,edx # (x*y) as num pixels
  4016db:	48 63 ed             	movsxd rbp,ebp # num pixels
  4016de:	48 c1 e5 02          	shl    rbp,0x2 # x*y*4 as num pixel input items
  4016e2:	48 89 ef             	mov    rdi,rbp # num pixel input items as arg 1
  4016e5:	e8 16 fb ff ff       	call   401200 <malloc@plt>
  4016ea:	48 85 c0             	test   rax,rax
  4016ed:	75 0e                	jne    4016fd <handle_1+0x52> # jump read_img_pixels if success
handle_malloc_err:
  4016ef:	48 8d 3d dd 09 00 00 	lea    rdi,[rip+0x9dd] # err str addr # 4020d3 <_IO_stdin_used+0xd3>
  4016f6:	e8 75 fa ff ff       	call   401170 <puts@plt>
  4016fb:	eb 57                	jmp    401754 <handle_1+0xa9> # jump exit err
read_img_pixels:
  4016fd:	89 ea                	mov    edx,ebp # num pixel input items as arg 3
  4016ff:	48 89 c6             	mov    rsi,rax # input buf addr as arg 2
  401702:	41 83 c8 ff          	or     r8d,0xffffffff # exit code -1 as arg 5
  401706:	31 ff                	xor    edi,edi # sdin fd as arg 1
  401708:	48 8d 0d f9 09 00 00 	lea    rcx,[rip+0x9f9] # err str addr as arg 4 # 402108 <_IO_stdin_used+0x108>
  40170f:	49 89 c4             	mov    r12,rax # input buf addr
  401712:	e8 44 ff ff ff       	call   40165b <read_exact> # read img pixels
check_pixels:
  401717:	0f b6 43 07          	movzx  eax,BYTE PTR [rbx+0x7] # y
  40171b:	0f b6 53 06          	movzx  edx,BYTE PTR [rbx+0x6] # x
  40171f:	0f af d0             	imul   edx,eax # (x*y) as num pixels
  401722:	31 c0                	xor    eax,eax # counter
1:
  401724:	39 c2                	cmp    edx,eax
  401726:	7e 34                	jle    40175c <handle_1+0xb1> # jump handle_img_content if x <= counter
  401728:	41 0f b6 4c 84 03    	movzx  ecx,BYTE PTR [r12+rax*4+0x3] # 4th byte of current input pixel item
  40172e:	48 ff c0             	inc    rax # counter ++
  401731:	8d 71 e0             	lea    esi,[rcx-0x20] # 4th byte val - 0x20
  401734:	40 80 fe 5e          	cmp    sil,0x5e
  401738:	76 ea                	jbe    401724 <handle_1+0x79> # jump 1 if 4th byte val - 0x20 <= 0x5e
handle_pixel_val_err:
  40173a:	48 8b 3d 5f d6 00 00 	mov    rdi,QWORD PTR [rip+0xd65f] # stderr file addr # 40eda0 <stderr@GLIBC_2.2.5>
  401741:	48 8d 15 dc 09 00 00 	lea    rdx,[rip+0x9dc] # err str addr # 402124 <_IO_stdin_used+0x124>
  401748:	be 01 00 00 00       	mov    esi,0x1 # security flag val
  40174d:	31 c0                	xor    eax,eax # num vec regs used
  40174f:	e8 fc fa ff ff       	call   401250 <__fprintf_chk@plt>
exit_err:
  401754:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401757:	e8 e4 fa ff ff       	call   401240 <exit@plt>
handle_img_content:
  40175c:	45 31 ed             	xor    r13d,r13d # zero y_counter
  40175f:	4c 8d 74 24 1f       	lea    r14,[rsp+0x1f] # tmp fb pixel item buf addr
1:
  401764:	0f b6 43 07          	movzx  eax,BYTE PTR [rbx+0x7] # y
  401768:	44 39 e8             	cmp    eax,r13d
  40176b:	0f 8e 99 00 00 00    	jle    40180a <handle_1+0x15f> # jump check_stack_tampered if y <= y_counter
  401771:	31 ed                	xor    ebp,ebp # zero x_counter
2:
  401773:	44 0f b6 7b 06       	movzx  r15d,BYTE PTR [rbx+0x6] # x
  401778:	41 39 ef             	cmp    r15d,ebp
  40177b:	0f 8e 81 00 00 00    	jle    401802 <handle_1+0x157> # jump 3 if x <= x_counter
  401781:	41 8d 47 01          	lea    eax,[r15+0x1] # x+1
  401785:	4c 8d 05 ca 09 00 00 	lea    r8,[rip+0x9ca] # pixel item format str addr as arg 5 # 402156 <_IO_stdin_used+0x156>
  40178c:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes as arg 4
  401791:	4c 89 f7             	mov    rdi,r14 # tmp pixel item buf addr as arg 1
  401794:	41 0f af c5          	imul   eax,r13d # (x+1)*y_counter as sum fb pixels in rows before current pixel
  401798:	be 19 00 00 00       	mov    esi,0x19 # num bytes as arg 2
  40179d:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax # save sum fb pixels in rows before current pixel
  4017a1:	44 29 e8             	sub    eax,r13d # remove fb additional pixel count for line feeds to get sum pixels in rows before current pixel
  4017a4:	01 e8                	add    eax,ebp add x_counter as current pixel number = sum prev row pixels + sum prev pix in current row
  4017a6:	52                   	push   rdx
  4017a7:	48 98                	cdqe
  4017a9:	49 8d 04 84          	lea    rax,[r12+rax*4] # current input pixel item addr
  4017ad:	0f b6 50 03          	movzx  edx,BYTE PTR [rax+0x3] # 4th pixel input byte as arg 9
  4017b1:	52                   	push   rdx
  4017b2:	0f b6 50 02          	movzx  edx,BYTE PTR [rax+0x2] # 3rd pixel input byte as arg 8
  4017b6:	52                   	push   rdx
  4017b7:	0f b6 50 01          	movzx  edx,BYTE PTR [rax+0x1] # 2nd pixel input byte as arg 7
  4017bb:	52                   	push   rdx
  4017bc:	44 0f b6 08          	movzx  r9d,BYTE PTR [rax] # 1st pixel input byte as arg 6
  4017c0:	ba 01 00 00 00       	mov    edx,0x1 # security flag val as arg 3
  4017c5:	31 c0                	xor    eax,eax # num vec regs used
  4017c7:	e8 84 f9 ff ff       	call   401150 <__snprintf_chk@plt> # convert and cp current input pixel to tmp fb pixel item buf
  4017cc:	89 e8                	mov    eax,ebp # x_counter
  4017ce:	44 8b 54 24 2c       	mov    r10d,DWORD PTR [rsp+0x2c] # num fb pixels in rows before current pixel
  4017d3:	41 0f 10 06          	movups xmm0,XMMWORD PTR [r14] # 16 bytes of tmp fb pixel buf to xmm0
  4017d7:	99                   	cdq
  4017d8:	48 83 c4 20          	add    rsp,0x20 # clean up snprinf stack args
  4017dc:	ff c5                	inc    ebp # x_counter ++
  4017de:	41 f7 ff             	idiv   r15d # not inc x_counter / x
  4017e1:	42 8d 04 12          	lea    eax,[rdx+r10*1] # current fb pixel num
  4017e5:	31 d2                	xor    edx,edx
  4017e7:	f7 73 0c             	div    DWORD PTR [rbx+0xc] # current fb pixel num / sum num fb pixels in rows before current pixel
  4017ea:	48 6b d2 18          	imul   rdx,rdx,0x18 # current fb pixel item offset
  4017ee:	48 03 53 10          	add    rdx,QWORD PTR [rbx+0x10] # current fb pixel item offset addr in frame buffer
  4017f2:	0f 11 02             	movups XMMWORD PTR [rdx],xmm0 # 16 bytes of tmp fb pixel buf to frame buffer
  4017f5:	49 8b 46 10          	mov    rax,QWORD PTR [r14+0x10] # remaining 8 bytes of tmp fb pixel buf
  4017f9:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax # remaining 8 bytes of tmp fb pixel buf to frame buffer
  4017fd:	e9 71 ff ff ff       	jmp    401773 <handle_1+0xc8> # jump 2
3:
  401802:	41 ff c5             	inc    r13d # y_counter ++
  401805:	e9 5a ff ff ff       	jmp    401764 <handle_1+0xb9> jump 1
check_stack_tampered:
  40180a:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38] # stack guard canary from stack
  40180f:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401816:	00 00 
  401818:	74 05                	je     40181f <handle_1+0x174> # jump end if not corrupted
  40181a:	e8 71 f9 ff ff       	call   401190 <__stack_chk_fail@plt> # fail
end:
  40181f:	48 83 c4 48          	add    rsp,0x48 # clean up stack local vars
  401823:	5b                   	pop    rbx # restore
  401824:	5d                   	pop    rbp # restore
  401825:	41 5c                	pop    r12 # restore
  401827:	41 5d                	pop    r13 # restore
  401829:	41 5e                	pop    r14 # restore
  40182b:	41 5f                	pop    r15 # restore
  40182d:	c3                   	ret

# rdi = rbx = r12 = main buf addr
000000000040183b <initialize_framebuffer>:
  40183b:	f3 0f 1e fa          	endbr64 # allow indirect jumps
  40183f:	41 54                	push   r12 # save
  401841:	49 89 fc             	mov    r12,rdi # main buf addr
  401844:	55                   	push   rbp # save
  401845:	53                   	push   rbx # save
  401846:	48 83 ec 30          	sub    rsp,0x30 # alloc local vars
  40184a:	0f b6 7f 06          	movzx  edi,BYTE PTR [rdi+0x6] # x
  40184e:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28 # stack guard canary
  401855:	00 00 
  401857:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax # stack guard canary to stack
  40185c:	31 c0                	xor    eax,eax # zero eax
  40185e:	41 0f b6 44 24 07    	movzx  eax,BYTE PTR [r12+0x7] # y
  401864:	ff c7                	inc    edi # (x+1)
  401866:	0f af f8             	imul   edi,eax # (x+1)+y as num pixels
  401869:	41 89 7c 24 0c       	mov    DWORD PTR [r12+0xc],edi # num pixels to main buf + img header offset
  40186e:	48 63 ff             	movsxd rdi,edi # num pixels
  401871:	48 6b ff 18          	imul   rdi,rdi,0x18 # (x+1)*y*0x18 as  num pixels * pixel array item size
  401875:	48 ff c7             	inc    rdi # num pixels * pixel array item size + 1 as arg 1
  401878:	e8 83 f9 ff ff       	call   401200 <malloc@plt>
  40187d:	49 89 44 24 10       	mov    QWORD PTR [r12+0x10],rax # frame buf addr to main buf + img header offset + pixels offset
  401882:	48 85 c0             	test   rax,rax
  401885:	75 14                	jne    40189b <initialize_framebuffer+0x60> # jump fill_buffer if malloc success
handle_malloc_fail:
  401887:	48 8d 3d e5 08 00 00 	lea    rdi,[rip+0x8e5] # err str addr # 402173 <_IO_stdin_used+0x173>
  40188e:	e8 dd f8 ff ff       	call   401170 <puts@plt>
  401893:	83 cf ff             	or     edi,0xffffffff # exit code -1
  401896:	e8 a5 f9 ff ff       	call   401240 <exit@plt>
fill_buffer:
  40189b:	31 db                	xor    ebx,ebx # zero counter
  40189d:	48 8d 6c 24 0f       	lea    rbp,[rsp+0xf] # tmp pixel item buf addr
1: # fill frame buf with spaces
  4018a2:	41 39 5c 24 0c       	cmp    DWORD PTR [r12+0xc],ebx # num pixels
  4018a7:	76 54                	jbe    4018fd <initialize_framebuffer+0xc2> # jump 2 if num pixels <= counter
  4018a9:	52                   	push   rdx # push for stack alignment of snprinft args
  4018aa:	41 b9 ff 00 00 00    	mov    r9d,0xff # 255 as arg 6
  4018b0:	ba 01 00 00 00       	mov    edx,0x1 # security flag val as arg 3
  4018b5:	48 89 ef             	mov    rdi,rbp # tmp pixel item buf addr as arg 1
  4018b8:	6a 20                	push   0x20 # space as arg 9
  4018ba:	4c 8d 05 95 08 00 00 	lea    r8,[rip+0x895] # pixel item format str addr as arg 5 # 402156 <_IO_stdin_used+0x156>
  4018c1:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes as arg 4
  4018c6:	31 c0                	xor    eax,eax # num vec regs used
  4018c8:	68 ff 00 00 00       	push   0xff # 255 as arg 8
  4018cd:	be 19 00 00 00       	mov    esi,0x19 # num bytes as arg 2
  4018d2:	68 ff 00 00 00       	push   0xff # 255 as arg 7
  4018d7:	e8 74 f8 ff ff       	call   401150 <__snprintf_chk@plt>
  4018dc:	0f 10 45 00          	movups xmm0,XMMWORD PTR [rbp+0x0] # 16 bytes of tmp pixel item buf to xmm0
  4018e0:	48 6b c3 18          	imul   rax,rbx,0x18 # current pixel item array offset based on counter
  4018e4:	48 ff c3             	inc    rbx # inc counter for next pixel item
  4018e7:	49 03 44 24 10       	add    rax,QWORD PTR [r12+0x10] # frame buf addr + current pixel item offset
  4018ec:	48 83 c4 20          	add    rsp,0x20 # clean up snprintf stack args
  4018f0:	0f 11 00             	movups XMMWORD PTR [rax],xmm0 # 16 bytes of tmp pixel item buf to frame buf + current pixel item offset addr
  4018f3:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10] # remaining 8 bytes of tmp pixel item buf
  4018f7:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx # remaining 8 bytes of tmp pixel item buf to frame buf
  4018fb:	eb a5                	jmp    4018a2 <initialize_framebuffer+0x67> # jump 1
2: # set each (x+1) aka last byte in a pixel row of the image to a new line to separate rows
  4018fd:	41 0f b6 5c 24 06    	movzx  ebx,BYTE PTR [r12+0x6] # set counter to x
  401903:	48 8d 6c 24 0f       	lea    rbp,[rsp+0xf] # tmp pixel item buf addr
3:
  401908:	41 39 5c 24 0c       	cmp    DWORD PTR [r12+0xc],ebx # num pixels
  40190d:	76 55                	jbe    401964 <initialize_framebuffer+0x129> # jump 4 if num pixels <= counter
  40190f:	50                   	push   rax # push for stack alignment of snprinft args
  401910:	ba 01 00 00 00       	mov    edx,0x1 # security flag val as arg 3
  401915:	45 31 c9             	xor    r9d,r9d # zero as arg 6
  401918:	4c 8d 05 37 08 00 00 	lea    r8,[rip+0x837] # pixel item format str addr as arg 5 # 402156 <_IO_stdin_used+0x156>
  40191f:	6a 0a                	push   0xa # line feed as arg 9
  401921:	b9 19 00 00 00       	mov    ecx,0x19 # num bytes as arg 4
  401926:	be 19 00 00 00       	mov    esi,0x19 # num bytes as arg 2
  40192b:	48 89 ef             	mov    rdi,rbp # tmp piixe item buf addr as arg 1
  40192e:	6a 00                	push   0x0 # zero as arg 8
  401930:	31 c0                	xor    eax,eax # num vec args used
  401932:	6a 00                	push   0x0 # zero as arg 7
  401934:	e8 17 f8 ff ff       	call   401150 <__snprintf_chk@plt>
  401939:	0f 10 4d 00          	movups xmm1,XMMWORD PTR [rbp+0x0] # 16 bytes tmp pixel item buf to xmm0
  40193d:	48 63 c3             	movsxd rax,ebx # counter
  401940:	48 83 c4 20          	add    rsp,0x20 # clean up snprintf stack args
  401944:	48 6b c0 18          	imul   rax,rax,0x18 # current pixel item array offset
  401948:	49 03 44 24 10       	add    rax,QWORD PTR [r12+0x10] # frame buf addr + current pixel item offset
  40194d:	0f 11 08             	movups XMMWORD PTR [rax],xmm1 # 16 bytes of tmp pixel item buf to frame buf + current pixel item offset addr
  401950:	48 8b 55 10          	mov    rdx,QWORD PTR [rbp+0x10] # remaining 8 bytes of tmp pixel item buf
  401954:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx # remaining 8 bytes of tmp pixel item buf to frame buf
  401958:	41 0f b6 44 24 06    	movzx  eax,BYTE PTR [r12+0x6] # x
  40195e:	8d 5c 03 01          	lea    ebx,[rbx+rax*1+0x1] # counter + x + 1 => this selects each last (x+1) pixel of an img pixel row
  401962:	eb a4                	jmp    401908 <initialize_framebuffer+0xcd> # jump 3
4:
  401964:	48 8b 44 24 28       	mov    rax,QWORD PTR [rsp+0x28] # stack guard canary from stack
  401969:	64 48 33 04 25 28 00 	xor    rax,QWORD PTR fs:0x28
  401970:	00 00 
  401972:	74 05                	je     401979 <initialize_framebuffer+0x13e> # jump end if not tampered
  401974:	e8 17 f8 ff ff       	call   401190 <__stack_chk_fail@plt> # fail
end:
  401979:	48 83 c4 30          	add    rsp,0x30 # clean up stack local vars
  40197d:	4c 89 e0             	mov    rax,r12 # return main buf addr
  401980:	5b                   	pop    rbx # restore
  401981:	5d                   	pop    rbp # restore
  401982:	41 5c                	pop    r12 # restore
  401984:	c3                   	ret
