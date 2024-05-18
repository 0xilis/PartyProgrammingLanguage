global start
section .text

joe_cool:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_1
 mov rdx, 24
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_2
 mov rdx, 50
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_3
 mov rdx, 44
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_4
 mov rdx, 50
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_5
 mov rdx, 100
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_6
 mov rdx, 42
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_7
 mov rdx, 71
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_8
 mov rdx, 119
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_9
 mov rdx, 86
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_10
 mov rdx, 27
 syscall
 ret
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_11
 mov rdx, 48
 syscall
 mov rax, 0x2000001
 mov rdi, 1
 syscall
 ret

start:
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_12
 mov rdx, 44
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_13
 mov rdx, 74
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_14
 mov rdx, 104
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_15
 mov rdx, 91
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_16
 mov rdx, 83
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_17
 mov rdx, 46
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_18
 mov rdx, 50
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_19
 mov rdx, 47
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_20
 mov rdx, 28
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_21
 mov rdx, 54
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_22
 mov rdx, 14
 syscall
 call joe_cool
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_23
 mov rdx, 31
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_24
 mov rdx, 48
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_25
 mov rdx, 76
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_26
 mov rdx, 60
 syscall
 nop
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_27
 mov rdx, 48
 syscall
  mov rdi, 0 ;blind inline assembly!
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_28
 mov rdx, 45
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_29
 mov rdx, 99
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, coolBeans
 mov rdx, 73
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, weCanDoThisNow
 mov rdx, 35
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_30
 mov rdx, 65
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_31
 mov rdx, 41
 syscall
 mov rax, 0x2000004
 mov rdi, 1
 mov rsi, PartyInternalVar_32
 mov rdx, 42
 syscall
 mov rax, 0x2000001
 mov rdi, 0
 syscall
 ret

section .data
PartyInternalVar_1: db "We're in joe_cool now!\n",24
.len: equ $ - PartyInternalVar_1
PartyInternalVar_2: db "Also; if you're reading the sample.party file...\n",50
.len: equ $ - PartyInternalVar_2
PartyInternalVar_3: db "Notice how there are no args for joe_cool?\n",44
.len: equ $ - PartyInternalVar_3
PartyInternalVar_4: db "Party allows you to have functions with no args!\n",50
.len: equ $ - PartyInternalVar_4
PartyInternalVar_5: db "Party currently does not support function args; but when they are; this will still remain in-tact.\n",100
.len: equ $ - PartyInternalVar_5
PartyInternalVar_6: db "Party also has auto return on functions.\n",42
.len: equ $ - PartyInternalVar_6
PartyInternalVar_7: db "This means that it will auto insert a return at the end of functions.\n",71
.len: equ $ - PartyInternalVar_7
PartyInternalVar_8: db "Meaning you don't have to constantly write return; and don't have to worry about undefined behavior if you forget to.\n",119
.len: equ $ - PartyInternalVar_8
PartyInternalVar_9: db "With that being said; you can still use return to return from functions if you wish!\n",86
.len: equ $ - PartyInternalVar_9
PartyInternalVar_10: db "Let's return from here...\n",27
.len: equ $ - PartyInternalVar_10
PartyInternalVar_11: db "Uh-oh. This code should have been unreachable.\n",48
.len: equ $ - PartyInternalVar_11
PartyInternalVar_12: db "Welcome to the Party programming language.\n",44
.len: equ $ - PartyInternalVar_12
PartyInternalVar_13: db "Party is a compiled language; with the compiler made entirely in Python!\n",74
.len: equ $ - PartyInternalVar_13
PartyInternalVar_14: db "It's limited; but that at the very least comes with the benefit of being easy to learn [in my opinion]\n",104
.len: equ $ - PartyInternalVar_14
PartyInternalVar_15: db "Commas are not supported in strings; hence why I am using a lot of semi-colons right now.\n",91
.len: equ $ - PartyInternalVar_15
PartyInternalVar_16: db "Look below these println calls in the sample.party file; there are some comments.\n",83
.len: equ $ - PartyInternalVar_16
PartyInternalVar_17: db "Above is clarity for why I did [] for these.\n",46
.len: equ $ - PartyInternalVar_17
PartyInternalVar_18: db "It also shows off how single-line comments work.\n",50
.len: equ $ - PartyInternalVar_18
PartyInternalVar_19: db "That's why I asked you to look. It's helpful!\n",47
.len: equ $ - PartyInternalVar_19
PartyInternalVar_20: db "Now; lets call a function.\n",28
.len: equ $ - PartyInternalVar_20
PartyInternalVar_21: db "The function we are going to call is named joe_cool.\n",54
.len: equ $ - PartyInternalVar_21
PartyInternalVar_22: db "Calling now!\n",14
.len: equ $ - PartyInternalVar_22
PartyInternalVar_23: db "And now; we're back in start!\n",31
.len: equ $ - PartyInternalVar_23
PartyInternalVar_24: db "In Party; think of start as the main function.\n",48
.len: equ $ - PartyInternalVar_24
PartyInternalVar_25: db "Unlike C; which has start auto call main; Party just uses start by itself.\n",76
.len: equ $ - PartyInternalVar_25
PartyInternalVar_26: db "You can also insert nops into the assembly by doing this: \n",60
.len: equ $ - PartyInternalVar_26
PartyInternalVar_27: db "You can also insert inline assembly by doing: \n",48
.len: equ $ - PartyInternalVar_27
PartyInternalVar_28: db "We are now going to save a string variable.\n",45
.len: equ $ - PartyInternalVar_28
PartyInternalVar_29: db "In Party; you need to give a default value when declaring variables; you can't just declare them.\n",99
.len: equ $ - PartyInternalVar_29
coolBeans: db " This is a string variable, and because of that, I can use commas and ()!",73
weCanDoThisNow: db " We can also declare integers, too.",35
exitSyscallNumber: dq  0x2000001
PartyInternalVar_30: db "This is the end of the sample. We're going to exit using !exit.\n",65
.len: equ $ - PartyInternalVar_30
PartyInternalVar_31: db "!exit is a wrapper for exit[0] syscall.\n",41
.len: equ $ - PartyInternalVar_31
PartyInternalVar_32: db "This is all for our sample. Bye for now!\n",42
.len: equ $ - PartyInternalVar_32
