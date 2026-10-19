; nasm -f elf64 09_loop_syscall.asm -o 09_loop_syscall.o
; ld -m elf_x86_64 -o 09_loop_syscall 09_loop_syscall.o
; ./09_loop_syscall

section .data
    message db "Hello, Assembly!", 10
    length equ $ - message

section .text
    global _start

_start:
    mov rcx, 5           

repeat:
    push rcx                   

    mov rax, 1                
    mov rdi, 1                  
    mov rsi, message
    mov rdx, length
    syscall

    pop rcx                     
    loop repeat                

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

    ##result
   ; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ ./09_loop_syscall
   ; Hello, Assembly!
   ; Hello, Assembly!
   ; Hello, Assembly!
   ; Hello, Assembly!
   ; Hello, Assembly!
   ; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ 
