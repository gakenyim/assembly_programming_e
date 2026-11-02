; nasm -f elf32 04.asm -o 04.o
; ld -m elf_i386 04.o -o 04
; ./04 to run the program
BITS 32
section .text
    global _start

_start:
    call work

    mov eax, 1
    xor ebx, ebx
    int 0x80

work:
    push ebp
    mov ebp, esp
    sub esp, 8

    mov dword [ebp - 4], 100
    mov dword [ebp - 8], 200

    mov eax, [ebp - 4]
    mov ebx, [ebp - 8]
    nop

    mov esp, ebp
    pop ebp
    ret

    ## End of program ##
; (gdb) si
; 0x0804902b in work ()
; (gdb) info registers eax ebx ebp esp
; eax            0x64                100
; ebx            0xc8                200
; ebp            0xffffc9f8          0xffffc9f8
; esp            0xffffc9f8          0xffffc9f8
; (gdb) si
; 0x0804902c in work ()
; (gdb) si
; 0x08049005 in _start ()
; (gdb) info registers eax ebx ebp esp
; eax            0x64                100
; ebx            0xc8                200
; ebp            0x0                 0x0
; esp            0xffffca00          0xffffca00
; (gdb) si
; 0x0804900a in _start ()
; (gdb) info registers eax ebx ebp esp
; eax            0x1                 1
; ebx            0xc8                200
; ebp            0x0                 0x0
; esp            0xffffca00          0xffffca00