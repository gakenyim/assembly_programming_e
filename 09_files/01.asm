; nasm -f elf64 01.asm -o 01.o
; ld 01.o -o 01
; ./01
section .data ; Stores variables that already have initial values
    prompt     db "Enter your name: "
    prompt_len equ $ - prompt

    output     db "Hello, "
    output_len equ $ - output

section .bss ; Reserves memory for variables that will receive values later
; We want the user to enter their name, but we don't know what their name will be so we need to reserve some memory to store the input
    input_buf resb 64

section .text ; Contains actual instructions that the CPU executes
    global _start

_start:
    ; 1. Display prompt
    mov rax, 1 ; system call number for write
    mov rdi, 1 ; file descriptor for standard output(terminal)
    mov rsi, prompt ; address of the message to display
    mov rdx, prompt_len ; number of bytes to display
    syscall; Display contents of prompt on my terminal

    ; 2. Read user's name
    mov rax, 0 ; system call number for read
    xor rdi, rdi ; file descriptor for standard input(keyboard) 
    mov rsi, input_buf ; address where input will be stored
    mov rdx, 63 ; max number of bytes to read
    syscall

    ; RAX now contains the number of bytes read.
    ; Save it because the next syscall will overwrite RAX.
    mov r12, rax

    ; 3. Display greeting prefix
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, output_len
    syscall

    ; 4. Display the actual input
    mov rax, 1
    mov rdi, 1
    mov rsi, input_buf
    mov rdx, r12             ; Reuse bytes returned by sys_read
    syscall

    ; 5. Exit
    mov rax, 60
    xor rdi, rdi
    syscall