; Assemble the file   : nasm -f elf32 sub2.asm -o sub2.o
; Link                : ld -m elf_i386 sub2.o -o sub2
; Run/Execute         : ./sub2
; sub16.asm
section .data
    num1 dw 1000
    num2 dw 2000
    result dw 0

section .text
    global _start

_start:
    mov ax, [num1]
    sub ax, [num2]       ; AX = 1000 - 2000
    mov [result], ax


exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
