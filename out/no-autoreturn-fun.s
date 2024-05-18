global start
section .text

top_of_ladder:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_1
 mov rdx, 47
 syscall

ladder_down_1:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_2
 mov rdx, 11
 syscall

ladder_down_2:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_3
 mov rdx, 11
 syscall

ladder_down_3:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_4
 mov rdx, 11
 syscall

floor:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_5
 mov rdx, 51
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_6
 mov rdx, 61
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_7
 mov rdx, 16
 syscall
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret

start:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_8
 mov rdx, 10
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_9
 mov rdx, 118
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, toTheTopMsg
 mov rdx, 56
 syscall
 call top_of_ladder
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_10
 mov rdx, 27
 syscall
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret

section .data
PartyInternalVar_1: db "We reached the top of the ladder! Going down!\n",47
.len: equ $ - PartyInternalVar_1
PartyInternalVar_2: db "Step 1...\n",11
.len: equ $ - PartyInternalVar_2
PartyInternalVar_3: db "Step 2...\n",11
.len: equ $ - PartyInternalVar_3
PartyInternalVar_4: db "Step 3...\n",11
.len: equ $ - PartyInternalVar_4
PartyInternalVar_5: db "We're on the floor; we fell down from the ladder.\n",51
.len: equ $ - PartyInternalVar_5
PartyInternalVar_6: db "Hope you enjoyed this demo of some fun with no auto return!\n",61
.len: equ $ - PartyInternalVar_6
PartyInternalVar_7: db "Exiting now...\n",16
.len: equ $ - PartyInternalVar_7
PartyInternalVar_8: db "Started!\n",10
.len: equ $ - PartyInternalVar_8
PartyInternalVar_9: db "Here is a Party program with auto return disabled. This results in us reaching other functions without calling them!\n",118
.len: equ $ - PartyInternalVar_9
toTheTopMsg: db " Let's go to the top of the ladder, and then, back down!",56
PartyInternalVar_10: db "We should not reach here.\n",27
.len: equ $ - PartyInternalVar_10
