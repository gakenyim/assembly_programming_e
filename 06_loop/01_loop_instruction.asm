; nasm -f elf64 01_loop_instruction.asm -o 01_loop_instruction.o
; ld -m elf_x86_64 -o 01_loop_instruction 01_loop_instruction.o
; ./01_loop_instruction

section .data
    message db "Hello, Assembly!", 10
    length equ $ - message

section .text
    global _start

_start:
    mov rcx, 5                  ; Repeat 5 times

repeat:
    ; Print the message
    mov rax, 1              
    mov rdi, 1                  
    mov rsi, message
    mov rdx, length
    syscall

    loop repeat    

    
    mov rax, 60          
    xor rdi, rdi
    syscall

##result
; Breakpoint 1, 0x0000000000401000 in _start ()
; (gdb) info registers rcx
; rcx            0x0                 0
; (gdb) si
; 0x0000000000401005 in repeat ()
; (gdb) info registers rcx
; rcx            0x5                 5
; (gdb) si
; 0x000000000040100a in repeat ()
; (gdb) si
; 0x000000000040100f in repeat ()
; (gdb) si
; 0x0000000000401019 in repeat ()
; (gdb) si
; 0x000000000040101e in repeat ()
; (gdb) si
; Hello, Assembly!
; 0x0000000000401020 in repeat ()
; (gdb) 