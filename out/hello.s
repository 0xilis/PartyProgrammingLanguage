global start
section .text

epic:
  mov rdi, 0
 ret
 nop

start:
 call epic
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret

