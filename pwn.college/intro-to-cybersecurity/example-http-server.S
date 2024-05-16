.intel_syntax noprefix
.globl _start

.section .text

_start:
	mov rdx, 0  # IPPROTO_IP
	mov rsi, 1  # SOCK_STREAM
	mov rdi, 2  # AF_INET
	call socket

	mov r12, rax # save sock fd

	mov rdx, [sockaddr_len+rip]
	lea rsi, [sockaddr_in+rip]
	mov rdi, r12 # sock fd
	call bind

	mov rsi, 0 # backlog 0 aka no limit to max number of pending connections
	mov rdi, r12 # sock fd
	call listen

	0:
	mov rdx, 0 # NULL pointer
	mov rsi, 0 # NULL pointer
	mov rdi, r12 # sock fd
	call accept

	mov r13, rax # save accept sock fd

	call fork

	cmp rax, 0
	jz handle_child_connection

	mov rdi, r13 # accept sock fd
	call close

	jmp 0b

handle_child_connection:
	mov rdi, r12 # sock fd
	call close

	sub rsp, 0x8 # allocate bin var
	sub rsp, 0x100 # allocate stack space for file content variable
	sub rsp, 0x100 # allocate stack space for reverse file content variable
	sub rsp, 0x20 # allocate stack space for file name variable
	sub rsp, 0x200 # allocate stack space for 256 byte buffer variable

	mov rdx, 0x200 # size
	mov rsi, rsp # buff addr
	mov rdi, r13 # accept sock fd
	call read

	mov r12, rax # save bytes read

	mov rdx, ' '
        lea rsi, [rsp+0x420]
        lea rdi, [rsp]
        call delim_cp

	cmp rax, 4
	jz handle_child_post

	jmp handle_child_get

handle_child_post:
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

	mov rdx, 0777 # mode in octal
	mov rsi, 0101 # O_WRONLY | O_CREAT in octal
	lea rdi, [rsp+0x200] # file name start addr
	call open

	mov r14, rax # save open file fd

	mov rdx, r12
	lea rsi, [rsp+0x320]
	mov rdi, r14 # open file fd
	call write

	mov rdi, r14 # open file fd
	call close

	mov rdx, [stat_ln_len+rip]
	lea rsi, [stat_ln+rip]
	mov rdi, r13 # accept sock fd
	call write

	jmp close_and_exit

handle_child_get:
	mov rdx, ' '
        lea rsi, [rsp+0x200]
        lea rdi, [rsp+4]
        call delim_cp

        mov byte ptr [rsp+rax+0x200], 0x0 # NULL term file name

	mov rdx, 0000 # mode in octal
        mov rsi, 0000 # O_RDONLY in octal
        lea rdi, [rsp+0x200] # file name start addr
        call open

	mov r14, rax # save open file fd

	mov rdx, 0x200 # size
        lea rsi, [rsp+0x320] # buff addr
        mov rdi, r14 # open file fd
        call read

	mov r15, rax # save bytes read

	mov rdi, r14 # open file fd
	call close

	mov rdx, [stat_ln_len+rip]
        lea rsi, [stat_ln+rip]
        mov rdi, r13 # accept sock fd
        call write

	mov rdx, r15 #  bytes to write
	lea rsi, [rsp+0x320] #  buff addr
	mov rdi, r13 # accept sock fd
	call write

	jmp close_and_exit

close_and_exit:
	mov rdi, r13 # accept sock fd
	call close

	add rsp, 0x428 # Clean up var from stack

	mov rdi, 0 #ret code
	call exit

socket:
	mov rax, 41
	syscall
	ret

bind:
	mov rax, 49
	syscall
	ret

listen:
	mov rax, 50
	syscall
	ret

accept:
	mov rax, 43
	syscall
	ret

fork:
	mov rax, 57
	syscall
	ret

close:
	mov rax, 3
	syscall
	ret

read:
	mov rax, 0
	syscall
	ret

open:
	mov rax, 2
	syscall
	ret

write:
	mov rax, 1
	syscall
	ret

exit:
	mov rax, 60
	syscall
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

.section .data

stat_ln: .ascii "HTTP/1.0 200 OK\r\n\r\n"
stat_ln_len: .quad stat_ln_len - stat_ln
sockaddr_in: .byte 0x02, 0x00,  0x00, 0x50,  0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
sockaddr_len: .quad sockaddr_len - sockaddr_in
