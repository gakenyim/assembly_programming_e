; nasm -f elf32 or.asm -o or.o
; ld -m elf_i386 -o or or.o
; ./or
; or_example.asm
; Demonstrates logical OR
; 10101010 OR 11001100 = 11101110

section .data
    val1 db 0b10101010    ; 170
    val2 db 0b11001100    ; 204

section .text
    global _start

_start:
    mov al, [val1]
    mov bl, [val2]
    or al, bl            ; al = 11101110 (0xEE, 238)

    ; Exit call
    mov eax, 1     ;sys call number to exit
    xor ebx, ebx   ; 0 for successful exit
    int 0x80       ; invoke call


; flags set
; SF (Sign Flag): Set if MSB - most significant bit is 1.
; 11101110b has MSB = 1 → SF = 1.

; PF (Parity Flag): Set if the low byte has an even number of 1s.
; 1101110b has 6 ones (even) → PF = 1.

## result
; Breakpoint 1, 0x08049000 in _start ()
; (gdb) si
; 0x08049005 in _start ()
; (gdb) si
; 0x0804900b in _start ()
; (gdb) si
; 0x0804900d in _start ()
; (gdb) info registers al bl
; al             0xee                -18 - signed 8-bit decimal  238 - unsigned 8-bit decimal
; bl             0xcc                -52 - signed 8-bit decimal  204 - unsigned 8-bit decimal
; (gdb) info registers eflags
; eflags         0x286               [ PF SF IF ]
; (gdb) 