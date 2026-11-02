; nasm -f elf64 02.asm -o 02.o
; ld 02.o -o 02
; ./02 to run the program
;using the stack to store local variables and call functions
section .text
    global _start

_start:
    call work
    mov rax, 60
    xor rdi, rdi
    syscall

work:
    push rbp ; save the old value of rbp onto the stack
    mov rbp, rsp ; set rbp to the current stack pointer
    sub rsp, 16 ; allocate 16 bytes on the stack for local variables

    mov qword [rbp - 8], 100
    mov qword [rbp - 16], 200

    mov rax, [rbp - 8]
    mov rbx, [rbp - 16]
    nop

    mov rsp, rbp
    pop rbp
    ret

    ## End of program ##
; (gdb) info registers rsp rbp
; rsp            0x7fffffffd870      0x7fffffffd870
; rbp            0x7fffffffd880      0x7fffffffd880
; (gdb) info registers rax rbx
; rax            0x64                100
; rbx            0xc8                200