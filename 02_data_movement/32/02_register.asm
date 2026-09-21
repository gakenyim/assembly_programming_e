; nasm -f elf32 02_register.asm && ld -m elf_i386 02_register.o && ./a.out

;gdb ./a.out
;lay asm
;lay reg
;break _start -> set breaking point to start
;run
;si - move code line to line
;c - continuining


section .text
global _start

_start:

    mov eax, 10 ;eax=10
    mov ebx, 20 ;ebx=20

    add eax, ebx ;eax=eax+abx = 30

    mov ebx, eax ;mov eax to ebx so ebx = 30
    mov eax, 1 ;changes EAX to 1 because Linux uses EAX = 1 for the 32-bit exit system call.
    int 0x80