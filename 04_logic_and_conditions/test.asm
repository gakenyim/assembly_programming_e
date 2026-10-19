; nasm -f elf32 test.asm -o test.o
; ld -m elf_i386 -o test test.o
; ./test
; TEST performs bitwise AND
; 10101010 TEST 00001111
; ZF=0 because at least one bit matches (AL & BL != 0)

section .data
    val1 db 0b10101010 - 170 
    val2 db 0b00001111 - 15

section .text
    global _start

_start:
    mov al, [val1]
    mov bl, [val2]
    test al, bl          ; result not stored, flags updated
                         ; ZF = 0 (some bits overlap)

    ; Exit call
    mov eax, 1     ;sys call number to exit
    xor ebx, ebx   ; 0 for successful exit
    int 0x80       ; invoke call

##result
    ; Breakpoint 1, 0x08049000 in _start ()
    ; (gdb) si
    ; 0x08049005 in _start ()
    ; (gdb) si
    ; 0x0804900b in _start ()
    ; (gdb) si
    ; 0x0804900d in _start ()
    ; (gdb) info registers al bl
    ; al             0xaa                -86 - signed 8-bit decimal  170 - unsigned 8-bit decimal
    ; bl             0xf                 15 - signed 8-bit decimal  15 - unsigned 8-bit decimal
    ; (gdb) info registers eflags
    ; eflags         0x206               [ PF IF ]
    ; (gdb) 
    ; after AND the result is 0b00001010 (0x0A, 10) but with TEST the result is not stored, only the flags are updated.