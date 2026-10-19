; nasm -f elf64 02_dec_jnz.asm -o 02_dec_jnz.o
; ld -m elf_x86_64 -o 02_dec_jnz 02_dec_jnz.o
; ./02_dec_jnz

section .data
    message db "Hello, Assembly!", 10
    length equ $ - message

section .text
    global _start

_start:
    mov r12, 5          

repeat:
    ; Print message
    mov rax, 1 - syscall number for write          
    mov rdi, 1 - file descriptor for stdout
    mov rsi, message - pointer to the message to write
    mov rdx, length - number of bytes to write
    syscall - request the kernel to perform the write operation

    dec r12                   
    jnz repeat                 

    ; Exit program
    mov rax, 60
    xor rdi, rdi
    syscall

##result
; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ ./02_dec_jnz
; Hello, Assembly!
; Hello, Assembly!
; Hello, Assembly!
; Hello, Assembly!
; Hello, Assembly!
; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$