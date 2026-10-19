; nasm -f elf64 04_while_loop.asm -o 04_while_loop.o
; ld -m elf_x86_64 -o 04_while_loop 04_while_loop.o
; ./04_while_loop

 section .data
    newline db 10 ; 10 is ASCII for newline so the output does not become 12345

section .bss
    digit resb 1

section .text
    global _start

_start:
    mov r12, 1 ;r12=1-used as a counter              

    jmp check_condition ;before execution check whether the condition is true       

loop_body:
    ; Convert counter to ASCII
    mov rax, r12
    add al, '0' ; convert to ASCII '0'=48
    mov [digit], al

    ; Print number
    mov rax, 1 ;write system calll
    mov rdi, 1 ; stdout
    mov rsi, digit ; what to print
    mov rdx, 1 ; print 1 byte
    syscall; ask Linux to perform it

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    inc r12                  

check_condition:
    cmp r12, 6
    jl loop_body     ; if r12 < 6, jump to loop_body

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

##result
; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ ./04_while_loop
; 1
; 2
; 3
; 4
; 5
; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$    