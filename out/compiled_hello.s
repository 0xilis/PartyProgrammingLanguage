; compiled_hello.s, (c) Keffaber 2024
; this is meant to show the x86_64 asm output
; that the Party compiler should produce
; from hello.party.
global start
section .text

epic:
  mov rax, 0x2000004 ; write
  mov rdi, 1 ; stdout
  mov rsi, msg
  mov rdx, msg.len
  syscall
  mov rdi, 0
  ret
start:
  call epic
  mov rax, 0x2000001 ; exit
  mov rdi, 0
  syscall

section .data
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg