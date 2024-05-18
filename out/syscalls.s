global start
section .text

start:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, introduction
 mov rdx, 69
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_1
 mov rdx, 78
 syscall
 mov rax, 0x2000088
 mov rdi, PartyInternalVar_2
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_3
 mov rdx, 102
 syscall
 mov rax, 0x2000039
 mov rdi, PartyInternalVar_4
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_5
 mov rdx, 41
 syscall
 mov rax, 0x200000a
 mov rdi, PartyInternalVar_6
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_7
 mov rdx, 50
 syscall
 mov rax, 0x2000089
 mov rdi, PartyInternalVar_8
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_9
 mov rdx, 32
 syscall
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret
 ret

section .data
introduction: db " This is in example of cool things you can do with Party's !syscall()",69
PartyInternalVar_1: db "Making a directory at /tmp/cool via invoking the kernel syscall for mkdir...\n",78
.len: equ $ - PartyInternalVar_1
PartyInternalVar_2: db "/tmp/coo",8
.len: equ $ - PartyInternalVar_2
PartyInternalVar_3: db "Making a symlink to that directory at /tmp/reallycool via invoking the kernel syscall for symlink...\n",102
.len: equ $ - PartyInternalVar_3
PartyInternalVar_4: db "/tmp/reallycoo",14
.len: equ $ - PartyInternalVar_4
PartyInternalVar_5: db "Remove the symlink by calling unlink...\n",41
.len: equ $ - PartyInternalVar_5
PartyInternalVar_6: db "/tmp/reallycoo",14
.len: equ $ - PartyInternalVar_6
PartyInternalVar_7: db "And finally; removing the /tmp/cool directory...\n",50
.len: equ $ - PartyInternalVar_7
PartyInternalVar_8: db "/tmp/reallycoo",14
.len: equ $ - PartyInternalVar_8
PartyInternalVar_9: db "That's all for now! Exiting...\n",32
.len: equ $ - PartyInternalVar_9
