; nasm -f elf32 04_register_indirect.asm -o 04_register_indirect.o && ld -m elf_i386 04_register_indirect.o -o 04_register_indirect && gdb ./04_register_indirect
section .data

    num dd 50 ; num-> label for memory location containing the value 50, dd -> define doublewords(4 bytes),50 -> the value stored there

;lay asm
;lay reg
;break _start -> set breaking point to start
;run
;si - move code line to line
;info reg - display the contents of all registers

section .text
global _start

_start:

<<<<<<< HEAD
    mov ebx, num    
    mov eax, [ebx]
=======
    mov ebx, num ; load the address of num into EBX
    mov eax, [ebx] ; load the value stored in the memory location pointed to by EBX into EAX
>>>>>>> 7546164 (register_indirect_understanding)

    mov ecx, eax ; copy the value from EAX into ECX

    mov eax, 1 ; syscall number (sys_exit)
    int 0x80          ; call kernel; asks Linux kernel to perform the system call