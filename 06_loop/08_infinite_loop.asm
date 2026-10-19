; nasm -f elf64 08_infinite_loop.asm -o 08_infinite_loop.o
; ld -m elf_x86_64 -o 08_infinite_loop 08_infinite_loop.o
; ./08_infinite_loop

section .data
    message db "Running...", 10
    length equ $ - message

section .text
    global _start

repeat:
    ; Print message
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, length
    syscall

    jmp repeat                 ; Jump back unconditionally

    ##result
    ;the message running... loops an infinite amount of times and can stop it by pressing Ctrl+C