; 32-bit version of 05.asm
; Demonstrates pushing and popping values on the stack in 32-bit mode
; nasm -f elf32 06.asm -o 06.o
; ld -m elf_i386 06.o -o 06
; ./06 to run the program
BITS 32
section .text
    global _start

_start:
    mov eax, 0x11223344
    mov ebx, 0x1234

    push eax ; save the value of eax on the stack
    push ebx ; save the value of ebx on the stack
    nop

    pop ebx ; restore the value of ebx from the stack
    pop eax ; restore the value of eax from the stack

    mov eax, 1
    xor ebx, ebx
    int 0x80