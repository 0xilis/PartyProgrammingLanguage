global start
section .text

epic:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_1
 mov rdx, 12
 syscall
  mov rdi, 0
 ret
 nop

start:
 call epic
 mov rax, 0x2000001
 mov rdi, 0
syscall
 ret

section .data
PartyInternalVar_1: db "Hello World!",12
.len: equ $ - PartyInternalVar_1

