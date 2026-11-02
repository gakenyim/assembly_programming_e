; nasm -f elf64 05.asm -o 05.o
; ld 05.o -o 05
; ./05 to run the program
; nasm assembly program demonstrating stack operations
section .text
    global _start

_start:
    mov rax, 0x1122334455667788 ; rax = 0x1122334455667788
    mov rbx, 0x1234 ; rbx = 0x1234

    push rax ; push rax onto the stack
    push rbx ; push rbx onto the stack
    nop ; no operation

    pop rbx ; pop value from stack into rbx
    pop rax ; pop value from stack into rax

    mov rax, 60 ; syscall number for exit
    xor rdi, rdi ; exit code 0
    syscall ; invoke syscall

    ## End of program ##