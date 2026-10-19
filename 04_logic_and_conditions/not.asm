; nasm -f elf32 not.asm -o not.o
; ld -m elf_i386 -o not not.o
; ./not
; NOT 10101010 = 01010101

section .data
    val1 db 0b10101010 ; 

section .text
    global _start

_start:
    mov al, [val1]       ; 170
    not al               ; al = 01010101 (0x55, 85)

    ; Exit call
    mov eax, 1     ;sys call number to exit
    xor ebx, ebx   ; 0 for successful exit
    int 0x80       ; invoke call

## result
; Breakpoint 1, 0x08049000 in _start ()
; (gdb) si
; 0x08049005 in _start ()
; (gdb) info register al
; al             0xaa                -86 - signed 8-bit decimal  170 - unsigned 8-bit decimal
; (gdb) si
; 0x08049007 in _start ()
; (gdb) info register al
; al             0x55                85
; (gdb) si
; 0x0804900c in _start ()
; (gdb) info register al
; al             0x1                 1
; (gdb) info register eflags
; eflags         0x202               [ IF ]