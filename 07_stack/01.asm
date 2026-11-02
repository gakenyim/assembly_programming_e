; nasm -f elf64 01.asm -o 01.o
; ld 01.o -o 01
; ./01 to run the program
section .text ;tells the assembler that this is the code section
    global _start ; entry point for the program

_start:
    mov rax, 100 ; load 100 into rax
    mov rbx, 200 ; load 200 into rbx

    push rax ; push rax onto the stack
    push rbx ; push rbx onto the stack
    nop ; no operation

    pop rcx ; pop the top of the stack into rcx
    pop rdx ; pop the next value into rdx
    nop ; no operation

    mov rax, 60 ; syscall number for exit
    xor rdi, rdi ; exit code 0
    syscall ; make the syscall

## End of program ##
# Check the values of rax and rbx after the program has run
;(gdb) info registers rax rbx
; rax            0x64                100
; rbx            0xc8                200

# After popping the values from the stack into rcx and rdx
# Check the values of rcx and rdx
; (gdb) info registers rcx rdx
; rcx            0xc8                200
; rdx            0x64                100