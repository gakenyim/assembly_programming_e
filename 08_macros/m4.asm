; nasm -f elf64 m4.asm -o m4.o
; ld m4.o -o m4
; ./m4
section .data
    msg db "Hello!", 10
    len equ $ - msg

section .text
    global _start

%macro PRINT_FIVE_TIMES 0
    %rep 5 ; %rep tells the nasm to repeat the instruction 5 times
        mov rax, 1
        mov rdi, 1
        mov rsi, msg
        mov rdx, len
        syscall
    %endrep ; %endrep marks the end of the instructions to repeat
%endmacro

_start:
    PRINT_FIVE_TIMES

    mov rax, 60
    xor rdi, rdi
    syscall

    ## End of program ##
; miche@MGs-LAPTOP:~/assembly_programming_e/08_macros$ ./m4
; Hello!
; Hello!
; Hello!
; Hello!
; Hello!