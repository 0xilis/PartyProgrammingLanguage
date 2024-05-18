global start
section .text

joe_cool:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_1
 mov rdx, 22
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_2
 mov rdx, 48
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_3
 mov rdx, 42
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_4
 mov rdx, 48
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_5
 mov rdx, 98
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_6
 mov rdx, 40
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_7
 mov rdx, 69
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_8
 mov rdx, 117
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_9
 mov rdx, 84
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_10
 mov rdx, 25
 syscall
 ret
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_11
 mov rdx, 46
 syscall
 mov rax, 0x2000001
 mov rdi, 1
syscall
 ret

start:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_12
 mov rdx, 42
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_13
 mov rdx, 72
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_14
 mov rdx, 102
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_15
 mov rdx, 89
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_16
 mov rdx, 81
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_17
 mov rdx, 44
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_18
 mov rdx, 48
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_19
 mov rdx, 45
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_20
 mov rdx, 26
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_21
 mov rdx, 52
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_22
 mov rdx, 12
 syscall
 call joe_cool
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_23
 mov rdx, 29
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_24
 mov rdx, 46
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_25
 mov rdx, 74
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_26
 mov rdx, 58
 syscall
 nop
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_27
 mov rdx, 46
 syscall
  mov rdi, 0 ;blind inline assembly!
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_28
 mov rdx, 63
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_29
 mov rdx, 39
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_30
 mov rdx, 40
 syscall
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret

section .data
PartyInternalVar_1: db "We're in joe_cool now!",22
.len: equ $ - PartyInternalVar_1
PartyInternalVar_2: db "Also; if you're reading the sample.party file...",48
.len: equ $ - PartyInternalVar_2
PartyInternalVar_3: db "Notice how there are no args for joe_cool?",42
.len: equ $ - PartyInternalVar_3
PartyInternalVar_4: db "Party allows you to have functions with no args!",48
.len: equ $ - PartyInternalVar_4
PartyInternalVar_5: db "Party currently does not support function args; but when they are; this will still remain in-tact.",98
.len: equ $ - PartyInternalVar_5
PartyInternalVar_6: db "Party also has auto return on functions.",40
.len: equ $ - PartyInternalVar_6
PartyInternalVar_7: db "This means that it will auto insert a return at the end of functions.",69
.len: equ $ - PartyInternalVar_7
PartyInternalVar_8: db "Meaning you don't have to constantly write return; and don't have to worry about undefined behavior if you forget to.",117
.len: equ $ - PartyInternalVar_8
PartyInternalVar_9: db "With that being said; you can still use return to return from functions if you wish!",84
.len: equ $ - PartyInternalVar_9
PartyInternalVar_10: db "Let's return from here...",25
.len: equ $ - PartyInternalVar_10
PartyInternalVar_11: db "Uh-oh. This code should have been unreachable.",46
.len: equ $ - PartyInternalVar_11
PartyInternalVar_12: db "Welcome to the Party programming language.",42
.len: equ $ - PartyInternalVar_12
PartyInternalVar_13: db "Party is a compiled language; with the compiler made entirely in Python!",72
.len: equ $ - PartyInternalVar_13
PartyInternalVar_14: db "It's limited; but that at the very least comes with the benefit of being easy to learn [in my opinion]",102
.len: equ $ - PartyInternalVar_14
PartyInternalVar_15: db "Commas are not supported in strings; hence why I am using a lot of semi-colons right now.",89
.len: equ $ - PartyInternalVar_15
PartyInternalVar_16: db "Look below these println calls in the sample.party file; there are some comments.",81
.len: equ $ - PartyInternalVar_16
PartyInternalVar_17: db "Above is clarity for why I did [] for these.",44
.len: equ $ - PartyInternalVar_17
PartyInternalVar_18: db "It also shows off how single-line comments work.",48
.len: equ $ - PartyInternalVar_18
PartyInternalVar_19: db "That's why I asked you to look. It's helpful!",45
.len: equ $ - PartyInternalVar_19
PartyInternalVar_20: db "Now; lets call a function.",26
.len: equ $ - PartyInternalVar_20
PartyInternalVar_21: db "The function we are going to call is named joe_cool.",52
.len: equ $ - PartyInternalVar_21
PartyInternalVar_22: db "Calling now!",12
.len: equ $ - PartyInternalVar_22
PartyInternalVar_23: db "And now; we're back in start!",29
.len: equ $ - PartyInternalVar_23
PartyInternalVar_24: db "In Party; think of start as the main function.",46
.len: equ $ - PartyInternalVar_24
PartyInternalVar_25: db "Unlike C; which has start auto call main; Party just uses start by itself.",74
.len: equ $ - PartyInternalVar_25
PartyInternalVar_26: db "You can also insert nops into the assembly by doing this: ",58
.len: equ $ - PartyInternalVar_26
PartyInternalVar_27: db "You can also insert inline assembly by doing: ",46
.len: equ $ - PartyInternalVar_27
PartyInternalVar_28: db "This is the end of the sample. We're going to exit using !exit.",63
.len: equ $ - PartyInternalVar_28
PartyInternalVar_29: db "!exit is a wrapper for exit[0] syscall.",39
.len: equ $ - PartyInternalVar_29
PartyInternalVar_30: db "This is all for our sample. Bye for now!",40
.len: equ $ - PartyInternalVar_30
