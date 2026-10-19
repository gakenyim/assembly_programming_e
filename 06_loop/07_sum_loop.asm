; nasm -f elf64 07_sum_loop.asm -o 07_sum_loop.o
; ld -m elf_x86_64 -o 07_sum_loop 07_sum_loop.o
; ./07_sum_loop

section .data
    message db "Sum = "
    length equ $ - message
    newline db 10

section .bss
    result resb 1

section .text
    global _start

_start:
    mov r12, 1  ;r12=counter            
    mov r13, 0  ;r13=sum             

sum_loop:
    add r13, r12 ; r13=r13+r12               
    inc r12                    

    cmp r12, 6 ; compare counter with 6 is r12 < 6
    jl sum_loop ; if r12 < 6, jump to sum_loop


    mov rax, r13
    mov rbx, 10
    xor rdx, rdx
    div rbx ; we divide by 10 as 15/10 is 1 rem 5                 

    add al, '0' ; '0' = 48 so 1 +48 = 49 which is '1'
    mov [result], al ;[result] = '1'
    
    add dl, '0'; '0' = 48 so 5 + 48 = 53 which is '5'
    mov [result + 1], dl ;[result + 1] = '15'

    ; Print message
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, length
    syscall

    ; Print result
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 2
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

   ##result
     ; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ ./07_sum_loop
     ; Sum = 15
     ; miche@MGs-LAPTOP:~/assembly_programming_e/06_loop$ 



