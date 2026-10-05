# DIV Arithmetic Operations and EFLAGS

## div1.asm

### Operation
The program performs unsigned integer division using the `DIV` instruction.

The dividend is:

    ax = 100

The divisor is:

    bl = 7

The instruction is:

    div bl

For an 8-bit divisor, the `DIV` instruction divides the 16-bit value in AX by the 8-bit divisor.

Therefore:

    100 / 7 = 14 remainder 2

The quotient is stored in AL and the remainder is stored in AH.

Therefore:

    al = 14
    ah = 2

### GDB Result

Immediately after executing the `DIV` instruction, GDB showed:

(gdb) info register ax
ax             0x20e               526
(gdb) info register al
al             0xe                 14
(gdb) info register ah
ah             0x2                 2

The value of AX is `0x020E` because AH and AL together form AX:

    ah = 0x2
    al = 0xe

Therefore:

    ax = 0x20e

This confirms that the quotient is 14 and the remainder is 2.

### EFLAGS Analysis

GDB displayed:
(gdb) info registers eflags
eflags         0x212               [ AF IF ]

However, the arithmetic flags cannot be interpreted as being set or cleared by the division.

For the `DIV` instruction, the following flags are undefined:

    CF
    PF
    AF
    ZF
    SF
    OF

Therefore, the value displayed by GDB for AF cannot be used to conclude anything about the division result.

The IF flag is the Interrupt Flag and is unrelated to the arithmetic operation.

| Flag | Status | Explanation 

1. CF - Undefined: `DIV` does not define the Carry Flag. 
2. PF - Undefined: `DIV` does not define the Parity Flag. 
3. AF - Undefined: `DIV` does not define the Auxiliary Carry Flag. 
4. ZF - Undefined: `DIV` does not define the Zero Flag. 
5. SF - Undefined: `DIV` does not define the Sign Flag. 
6. OF - Undefined: `DIV` does not define the Overflow Flag. 

### Important Observation

Unlike ADD and SUB, the DIV instruction does not produce defined arithmetic flags.

The important result of this instruction is the quotient and remainder:

    100 / 7 = 14 remainder 2

Therefore:

    al = 14
    ah = 2

The values displayed for the arithmetic flags after DIV should not be interpreted as indicating properties of the division result because those flags are undefined after DIV.

## div2.asm

### Operation

This program performs 16-bit unsigned integer division.
The values loaded are:

    ax = 50000
    dx = 0
    bx = 300

For a 16-bit `DIV` instruction, the dividend is the combined 32-bit value in `dx:ax`.

Therefore:

    dx:ax = 0000:C350

which represents 50000.

The instruction is:

    div bx

The division is:

    50000 / 300 = 166 remainder 200

For 16-bit division:
- The quotient is stored in ax.
- The remainder is stored in dx.

Therefore:

    ax = 166
    dx = 200

### GDB Result

Immediately after executing the `DIV` instruction, GDB showed:
(gdb) info register ax
ax             0xa6                166
(gdb) info register dx
dx             0xc8                200
(gdb) info register bx
bx             0x12c               300

The result can be verified mathematically:
   300 × 166 + 200 = 50000

Therefore, the quotient and remainder are correct.

### EFLAGS Analysis

GDB displayed:
(gdb) info registers eflags
eflags         0x212               [ AF IF ]

However, the arithmetic flags cannot be interpreted as being set or cleared by the division.

For the `DIV` instruction, the following flags are undefined:

    CF
    PF
    AF
    ZF
    SF
    OF

Therefore, the AF value displayed by GDB does not indicate anything about the division result.

The IF flag is the Interrupt Flag and is unrelated to the arithmetic operation.

| Flag | Status | Explanation 

1. CF - Undefined: `DIV` does not define the Carry Flag. 
2. PF - Undefined: `DIV` does not define the Parity Flag. 
3. AF - Undefined: `DIV` does not define the Auxiliary Carry Flag. 
4. ZF - Undefined: `DIV` does not define the Zero Flag. 
5. SF - Undefined: `DIV` does not define the Sign Flag. 
6. OF - Undefined: `DIV` does not define the Overflow Flag. 

### Important Observation
This example demonstrates that 16-bit `DIV` uses the combined `dx:ax` register pair as its dividend.

In this program:

    dx:ax = 0000:C350 = 50000

The divisor is:

    bx = 300

The CPU produces:

    ax = 166
    dx = 200

Thus:

    50000 = (300 × 166) + 200

The arithmetic flags should not be interpreted after `DIV` because CF, PF, AF, ZF, SF, and OF are undefined.