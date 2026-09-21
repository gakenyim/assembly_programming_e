; nasm -f elf32 03_direct_memory.asm && ld -m elf_i386 03_direct_memory.o && ./a.out

;gdb ./a.out
;lay asm
;lay reg
;break _start -> set breaking point to start
;run
;si - move code line to line
;p &num1 - inspect the address of num1
;and then inspect the value at that address using *(&num1)
;p &num2 - inspect the address of num2
;and then inspect the value at that address using *(&num2)
; num2 is 4 bytes after num1 in memory because dd reserves 4 bytes for each variable
;info registers eax - inspect the value of the EAX register; works for other registers as wellsi
;c - continuining

section .data
;num1 and num2 are variables stored in memory
    num1 dd 10
    num2 dd 20

section .text
global _start

_start:

    mov eax, [num1]
    add eax, [num2]

    mov ebx, eax ; move the result from eax to ebx

    mov eax, 1 ; changes EAX to 1 because Linux uses EAX = 1 for the 32-bit exit system call.
    int 0x80