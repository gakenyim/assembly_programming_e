; nasm -f elf64 03.asm -o 03.o
; ld 03.o -o 03
; ./03 to run the program
; focuses on how call and ret work and how a function can modify a register
section .text
    global _start

_start:
    mov rax, 10 ; rax =10
    call calculate ; call the calculate function which adds 5 to rax and saves the address of the next instruction on the stack

after_call:
    ; RAX should now be 15
    nop

    mov rax, 60
    xor rdi, rdi
    syscall

calculate:
    add rax, 5 ; add 5 to rax, which was passed from the caller so rax =15
    ret ; return to the instruction after the call in the caller, which is after_call label

    ; The stack is used implicitly by the call and ret instructions to save and restore the return address

    # The return address is pushed onto the stack by the call instruction and popped by the ret instruction
    # End of program #
;(gdb) si
; 0x0000000000401005 in _start ()
; (gdb) info register rax
; rax            0xa                 10
; (gdb) si
; 0x0000000000401015 in calculate ()
; (gdb) info register rax
; rax            0xa                 10
; (gdb) si
; 0x0000000000401019 in calculate ()
; (gdb) info register rax
; rax            0xf                 15
; (gdb) si
; 0x000000000040100a in after_call ()
; (gdb) info register rax
; rax            0xf                 15
; (gdb) si
; 0x000000000040100b in after_call ()
; (gdb) info register rax
; rax            0xf                 15
