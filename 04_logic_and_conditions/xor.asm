; nasm -f elf32 xor.asm -o xor.o
; ld -m elf_i386 -o xor xor.o
; ./xor
; 10101010 XOR 11001100 = 01100110
; Demonstrates logical XOR

section .data
    val1 db 0b10101010 - 170 
    val2 db 0b11001100 - 204

section .text
    global _start

_start:
    mov al, [val1]
    mov bl, [val2]
    xor al, bl           ; al = 01100110 (0x66, 102)

    ; Exit call
    mov eax, 1     ;sys call number to exit
    xor ebx, ebx   ; 0 for successful exit
    int 0x80       ; invoke call

; flags set
; PF (Parity Flag) is Set if result’s low byte has an even number of 1s
; 01100110b has 4 ones → even → PF = 1

## result
    ; Breakpoint 1, 0x08049000 in _start ()
    ; (gdb) si
    ; 0x08049005 in _start ()
    ; (gdb) si
    ; 0x0804900b in _start ()
    ; (gdb) si
    ; 0x0804900d in _start ()
    ; (gdb) info registers al bl
    ; al             0x66                102 - signed 8-bit decimal  102 - unsigned 8-bit decimal
    ; bl             0xcc                -52 - signed 8-bit decimal  204 - unsigned 8-bit decimal
    ; (gdb) info registers eflags
    ; eflags         0x206               [ PF IF ]
    ; (gdb)