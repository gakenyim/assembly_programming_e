# MUL Arithmetic Operations and EFLAGS

## mul1.asm

### Operation

The program performs an 8-bit unsigned multiplication.

The operands are:

    al = 25
    num2 = 10

The instruction is:

    mul byte [num2]

For an 8-bit `MUL`, the CPU multiplies al by the 8-bit operand and stores the full 16-bit result in ax.

Therefore:

    25 × 10 = 250

In hexadecimal:

    0x19 × 0xa = 0xfa

The result is stored as:
(gdb) info register ax
ax             0xfa                250
(gdb) info register al
al             0xfa                -6
(gdb) info register ah
ah             0x0                 0

### GDB Result

Immediately after executing the `MUL` instruction, GDB showed:

    ax = 0xfa = 250
    al = 0xfa = -6
    ah = 0x0 = 0

This confirms that the multiplication produced 250.

GDB displayed AL as `-6` because it was interpreting the 8-bit value `0xFA` as a signed value. As an unsigned value, `0xFA` is 250.

### EFLAGS Analysis

GDB displayed:
(gdb) info registers eflags
eflags         0x202               [ IF ]

For the `MUL` instruction, CF and OF are defined according to whether the upper half of the product is zero. The other arithmetic flags are undefined.

| Flag | Status | Explanation 

1. CF - Cleared (0): The upper 8 bits of the 16-bit product are zero (`AH = 0`), so the product fits completely in the lower 8 bits. 
2. OF - Cleared (0): The upper half of the product is zero, so there is no overflow beyond the 8-bit result. 
3. PF - Undefined: `MUL` does not define the Parity Flag. 
4. AF - Undefined: `MUL` does not define the Auxiliary Carry Flag. 
4. ZF - Undefined: `MUL` does not define the Zero Flag. 
5. SF - Undefined: `MUL` does not define the Sign Flag. 

The IF flag shown by GDB is the Interrupt Flag and is unrelated to the multiplication.

### Important Observation

For an 8-bit `MUL`, the complete result is stored in AX.

In this example:

    25 × 10 = 250
    ax = 0xfa

Because AH is zero, the entire product fits in the lower 8 bits. Therefore CF and OF are both cleared.

The other arithmetic flags should not be interpreted because their values are undefined after `MUL`.

## mul2.asm

### Operation

The program performs a 16-bit unsigned multiplication.

The operands are:

    ax = 3000
    num2 = 200

The instruction is:

    mul word [num2]

For a 16-bit `MUL`, the CPU multiplies ax by the 16-bit operand and stores the complete 32-bit result in dx:ax.

Therefore:

    3000 × 200 = 600000

In hexadecimal:

    600000 = 0x927C0

The result is divided between dx and ax:

(gdb) info register ax
ax             0x27c0              10176
(gdb) info register dx
dx             0x9                 9
    dx = 0x9
    ax = 0x27C0

Together:

    dx:ax = 0x927C0

### GDB Result

Immediately after executing the `MUL` instruction, GDB showed:

    ax = 0x27c0 = 10176
    dx = 0x9 = 9

The complete result is obtained by combining dx and ax:

    dx:ax = 0009:27C0
          = 0x000927C0
          = 600000

This can also be verified mathematically:

    3000 × 200 = 600000

### EFLAGS Analysis

GDB displayed:
(gdb) info registers eflags
eflags         0xa03               [ CF IF OF ]

For the `MUL` instruction, CF and OF are defined according to whether the upper half of the product is zero.

In this case:

    dx = 0x0009

Since dx is nonzero, the upper half of the product is not zero.

| Flag | Status | Explanation 

1. CF - Set (1): The upper 16 bits of the 32-bit product are nonzero (`DX = 9`), so the product does not fit completely in 16 bits. 
2. OF - Set (1): The upper half of the product is nonzero, so the product cannot be represented using only the lower 16 bits. 
3. PF - Undefined: `MUL` does not define the Parity Flag. 
4. AF - Undefined: `MUL` does not define the Auxiliary Carry Flag. 
5. ZF - Undefined: `MUL` does not define the Zero Flag. 
6. SF - Undefined: `MUL` does not define the Sign Flag. 

The IF flag shown by GDB is the Interrupt Flag and is unrelated to the multiplication.

### Important Observation

This example demonstrates that a 16-bit `MUL` produces a 32-bit result in the `dx:ax` register pair.

The multiplication is:

    3000 × 200 = 600000

The CPU stores:

    dx = 0x0009
    ax = 0x27C0

Because dx is nonzero, CF and OF are both set.

The other arithmetic flags are undefined after `MUL` and should not be interpreted.