# Party Programming Language

A rather limited compiled language with weird syntax meant for a CS Final, but with great speed. Compiler made in Python and meant to compile Mach-Os for x86_64 macOS (albeit it shouldn't be *too hard* to add support for x86_64 ELF binaries for Linux, or arm64 macOS Mach-Os...).

It is currently heavily incomplete and in a near-unusable state at the moment (although for the stuff that is implemented like function calls and blind inline assembly, you can compile valid x86_64 with!), I'll try my best to finish it to a usable state soon.

### Docs

Since this is still indev, my docs are limited, as I don't want to constantly redo docs while changing stuff about the language. However, I do document a couple parts of the language here.

### Auto Return

Party, by default, will insert a "ret" instruction at the end of functions. This is helpful in cases like these:

```
funky epic {
  !println("Hello World!")
}

funky start {
  !epic
  // we need to call exit(0) or else we will SEGV
  !exit
}
```
Without auto return, this would be compiled into x86_64 as:

```s
global start
section .text

epic:
 mov rax, 0x2000004 ; write
 mov rdi, 1 ; stdout
 mov rsi, msg
 mov rdx, msg.len
 syscall

start:
 call epic
 mov rax, 0x2000001 ; exit
 mov rdi, 0
 syscall
```
The program would first call the epic function, which will call the kernel syscall for write(1,"Hello World!",10). However, what would happen after we reached syscall? In x86_64, the `%rip` register (Relative Instruction Pointer) points to the next instruction after, but there are no other instructions in the `epic` function. But, what is below the epic function? That's right; the `start` function! Meaning, the next instruction in the binary will be `call epic`, so after the syscall we'd end up at the first instruction of `start`, which would take us back to `epic` and result in an infinite loop of printing println("Hello World!")! Party's auto return feature prevents you from making these mistakes, so you don't need to worry about inserting a `return` at the end of your functions since the compiler will do it for you.

If you ever need to, you can turn auto return off via `#define __NO_AUTORETURN 1`, and turn it back on with `#define __NO_AUTORETURN 0`.

### "Blind" Assembly

Party supports doing "blind" inline assembly via `blind {}`. What this means is that it will forcibly insert whatever assembly you put in and not make changes to the rest of the code to account for this inline assembly. This is useful when you need to do things that the Party programming language does not yet support.

### (Not Yet Implemented) Variable types

Party has `int` and `string` types. In C, most compilers will make `int` a 32-bit integer even on 64bit machines. However, Party has all `int`s be 64-bit. Be aware that there is no unsigned int type.

### Assembling and Linking binaries

To turn the output assembly code into a usable Mach-O, install NASM from brew (or another package manager), cd to the directory with the hello.s file and:

```sh
nasm -f macho64 hello.s
ld -macosx_version_min 10.7.0 -lSystem -o hello hello.o -syslibroot \`xcrun -sdk macosx --show-sdk-path\`
```

Make sure you also have XCode installed. This outputs some warnings but still seems to work on Monterey...

### Contributing

Contributions are welcome; but not yet, because this is still not yet graded and I want to have the submitted version for the final contain only my own code. However, after this, I will change this section of the README to allow contributing. This is licensed under MIT in the meantime anyway so you can fork this if you really want, I just can't really accept PRs at the moment.