.intel_syntax noprefix
.globl _start

.section .text

_start:
	mov rdx, 0  # sock arg: IPPROTO_IP
	mov rsi, 1  # sock arg: SOCK_STREAM
	mov rdi, 2  # aock arg: AF_INET
	mov rax, 41 # SYS_socket
	syscall

	mov r12, rax # save sock fd

	mov rdi, r12 # bind arg: socket fd
	call bind

	mov rsi, 0 # listen arg: backlog 0 aka no limit to max number of pending connections
	mov rdi, r12 # listen arg: sock fd
	mov rax, 50 # SYS_listen
	syscall

	0:
	mov rdx, 0 # accept arg: NULL pointer
	mov rsi, 0 # accept arg: NULL pointer
	mov rdi, r12 # accept arg: sock fd
	mov rax, 43 # SYS_accept
	syscall

	mov r13, rax # save accept sock fd

	mov rax, 57 # SYS_fork
	syscall

	cmp rax, 0
	jz handle_connection

	mov rdi, r13 # close arg: sock fd
	mov rax, 3 # SYS_close
	syscall

	jmp 0b

handle_connection:
	mov rdi, r12 # close arg: sock fd
	mov rax, 3 # SYS_close
	syscall

	sub rsp, 0x8 # allocate bin var
	sub rsp, 0x100 # allocate stack space for file content variable
	sub rsp, 0x100 # allocate stack space for reverse file content variable
	sub rsp, 0x20 # allocate stack space for file name variable
	sub rsp, 0x200 # allocate stack space for 256 byte buffer variable

	mov rdx, 0x200 # read arg: size
	mov rsi, rsp # read arg: buff addr
	mov rdi, r13 # read arg: accept sock fd
	mov rax, 0 # SYS_read
	syscall

	mov r12, rax # save bytes read

	mov rdx, ' '
        lea rsi, [rsp+0x420]
        lea rdi, [rsp]
        call delim_cp

	cmp rax, 4
	jz handle_post

	jmp handle_get

handle_post:
	mov rdx, ' '
        lea rsi, [rsp+0x200]
        lea rdi, [rsp+5]
        call delim_cp

        mov byte ptr [rsp+rax+0x200], 0x0 # NULL term file name

	mov rdx, '\n'
	lea rsi, [rsp+0x221]
	lea rdi, [rsp+r12-1]
	call rev_delim_cp
	mov r12, rax # save bytes copied

	mov byte ptr [rsp+0x220], '\n'

	mov rdx, '\n'
        lea rsi, [rsp+0x320]
        lea rdi, [rsp+r12+0x220]
        call rev_delim_cp

	mov rdx, 0777 # open arg: mode in octal
	mov rsi, 0101 # open arg: O_WRONLY | O_CREAT in octal
	lea rdi, [rsp+0x200] # open arg: file name start addr
	mov rax, 2 # SYS_open
	syscall

	mov r14, rax # save open file fd

	mov rdx, r12
	lea rsi, [rsp+0x320]
	mov rdi, r14 # write arg: open file fd
	mov rax, 1 # SYS_write
	syscall

	mov rdi, r14 # close arg: open file fd
	mov rax, 3 # SYS_close
	syscall

	mov rdi, r13 # send status line arg: accept sock fd
	call send_status_line
	jmp close_and_exit

handle_get:
	mov rdx, ' '
        lea rsi, [rsp+0x200]
        lea rdi, [rsp+4]
        call delim_cp

        mov byte ptr [rsp+rax+0x200], 0x0 # NULL term file name

	mov rdx, 0000 # open arg: mode in octal
        mov rsi, 0000 # open arg: O_RDONLY in octal
        lea rdi, [rsp+0x200] # open arg: file name start addr
        mov rax, 2 # SYS_open
        syscall

	mov r14, rax # save open file fd

	mov rdx, 0x200 # read arg: size
        lea rsi, [rsp+0x320] # read arg: buff addr
        mov rdi, r14 # read arg: open file fd
        mov rax, 0 # SYS_read
        syscall

	mov r15, rax # save bytes read

	mov rdi, r14 # close arg: open file fd
	mov rax, 3 # SYS_close
	syscall

	mov rdi, r13 # send status line arg: accept sock fd
        call send_status_line

	mov rdx, r15 # write arg: bytes to write
	lea rsi, [rsp+0x320] # write arg: buff addr
	mov rdi, r13 # write arg: accept sock fd
	mov rax, 1 # SYS_write
	syscall

	jmp close_and_exit

close_and_exit:
	mov rdi, r13 # close arg: accept sock fd
	mov rax, 3 # SYS_close
	syscall

	add rsp, 0x428 # Clean up var from stack

	mov rdi, 0 # exit arg: ret code
	mov rax, 60 # SYS_exit
	syscall

bind:
	push rbp
	mov rbp, rsp

	sub rsp, 0x10 # space for 16 byte local addr var
	mov word ptr [rsp], 0x0002 # AF_INET as word little endian
	mov byte ptr [rsp+2], 0x00 # Port 80 as word in big endian
	mov byte ptr [rsp+3], 0x50
	mov byte ptr [rsp+4], 0x00 # IP 0.0.0.0 as 4 single consecutive bytes
	mov byte ptr [rsp+5], 0x00
	mov byte ptr [rsp+6], 0x00
	mov byte ptr [rsp+7], 0x00
	mov qword ptr [rsp+8], 0x0000000000000000

	mov rdx, 16 # bind arg:  sockaddr size in bytes
	mov rsi, rsp # bind arg: sockaddr struct addr
	mov rax, 49 # SYS_bind
	syscall

	mov rsp, rbp # clean up local var from stack
	pop rbp
	ret

delim_cp:
	push rbp
	mov rbp, rsp

	sub rsp, 0x8
	mov qword ptr [rsp], 0x0

	xor rax, rax

	0:
	mov al, byte ptr [rdi]
	cmp al, dl
	jz 1f

	mov byte ptr [rsi], al
	inc rdi
	inc rsi
	add qword ptr [rsp], 0x1
	jmp 0b

	1:
	mov rax, qword ptr [rsp]
	mov rsp, rbp
	pop rbp
	ret

rev_delim_cp:
	push rbp
	mov rbp, rsp

	sub rsp, 0x8
	mov qword ptr [rsp], 0x0

	xor rax, rax

	0:
	mov al, byte ptr [rdi]
	cmp al, dl
	jz 1f

	mov byte ptr [rsi], al
	dec rdi
	inc rsi
	add qword ptr [rsp], 0x1
	jmp 0b

	1:
	mov rax, qword ptr [rsp]
	mov rsp, rbp
	pop rbp
	ret

send_status_line:
	push rbp
	mov rbp, rsp

	sub rsp, 19 # space for 19 byte local resp msg var
	mov qword ptr [rsp], 'H'
	mov qword ptr [rsp+1], 'T'
	mov qword ptr [rsp+2], 'T'
	mov qword ptr [rsp+3], 'P'
	mov qword ptr [rsp+4], '/'
	mov qword ptr [rsp+5], '1'
	mov qword ptr [rsp+6], '.'
	mov qword ptr [rsp+7], '0'
	mov dword ptr [rsp+8], ' '
	mov dword ptr [rsp+9], '2'
	mov dword ptr [rsp+10], '0'
	mov dword ptr [rsp+11], '0'
	mov byte ptr [rsp+12], ' '
	mov byte ptr [rsp+13], 'O'
	mov byte ptr [rsp+14], 'K'
	mov byte ptr [rsp+15], '\r'
	mov byte ptr [rsp+16], '\n'
	mov byte ptr [rsp+17], '\r'
	mov byte ptr [rsp+18], '\n'

	mov rdx, 19 # write arg: bytes to write
	mov rsi, rsp # write arg: buff addr
	mov rax, 1 # SYS_write
	syscall

	mov rsp, rbp # clean up local var from stack
	pop rbp
	ret

.section .data
