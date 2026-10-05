# SUB Arithmetic Operations and EFLAGS

## sub3.asm

### Operation

The program demonstrates both `SUB` and `SBB` instructions.

The initial values are:

    ax = 0x0000
    num2 = 0x0001

The first arithmetic instruction is:

    sub ax, [num2]

This performs:

    0x0000 - 0x0001 = 0xffff

The result is stored in ax.

### Flags After SUB

GDB showed:
(gdb) info register ax
ax             0xffff              -1
(gdb) info registers eflags
eflags         0x297               [ CF PF AF SF IF ]

The arithmetic flags are:

    CF = 1
    PF = 1
    AF = 1
    ZF = 0
    SF = 1
    OF = 0

| Flag | Status | Explanation 

1. CF - Set (1): Subtracting 1 from unsigned 0 requires a borrow, so CF is set. 
2. PF - Set (1): The low byte is `11111111`, which contains eight 1-bits. Eight is even, so PF is set. 
3. AF - Set (1): Subtracting 1 from the lower nibble `0000` requires a borrow from bit 4. 
4. ZF - Cleared (0): The result is `0xffff`, which is not zero. 
5. SF - Set (1): The most significant bit of the 16-bit result is 1. 
6. OF - Cleared (0): Signed `0 - 1 = -1`, which is within the signed 16-bit range. 

### SBB Instruction

The program then executes:

    sbb ax, 0

SBB means "Subtract with Borrow". It subtracts the source operand and the previous Carry Flag from the destination.

After SUB:

    ax = 0xffff
    CF = 1

Therefore:

    0xffff - 0 - 1 = 0xfffe

GDB showed:
(gdb) info register ax
ax             0xfffe              -2
(gdb) info registers eflags
eflags         0x282               [ SF IF ]

### Flags After SBB

The arithmetic flags after SBB are:

    CF = 0
    PF = 0
    AF = 0
    ZF = 0
    SF = 1
    OF = 0

| Flag | Status | Explanation 

1. CF - Cleared (0): `0xFFFF - 1 = 0xFFFE` does not require an unsigned borrow. 
2. PF - Cleared (0): The low byte `11111110` contains seven 1-bits. Seven is odd, so PF is cleared. 
3. AF - Cleared (0): Subtracting 1 from the lower nibble `1111` produces `1110` without requiring a borrow from bit 4. 
4. ZF - Cleared (0): The result `0xFFFE` is not zero. 
5. SF - Set (1): The most significant bit of `0xFFFE` is 1. 
6. OF - Cleared (0): The signed operation is `-1 - 1 = -2`, which is within the signed 16-bit range. 

### Important Observation

This program demonstrates how `SBB` uses the Carry Flag produced by a previous subtraction.

The first operation produces:

    0x0000 - 0x0001 = 0xffff
    CF = 1

The `SBB` instruction then uses this borrow:

    0xffff - 0 - 1 = 0xfffe

Therefore, the final value in ax is:

    ax = 0xfffe

The flags must be inspected immediately after each arithmetic instruction because the following arithmetic instruction changes them.

## sub2.asm

### Operation

The program demonstrates a 16-bit `SUB` instruction.

The initial values are:

    ax = 0x03e8 (1000)
    num2 = 0x07d0 (2000)

The arithmetic instruction is:

    sub ax, [num2]

This performs:

    1000 - 2000 = -1000

The 16-bit two's-complement representation of `-1000` is:

    0xfc18

The result is stored in ax.

### Flags After SUB

GDB showed:
(gdb) info register ax
ax             0xfc18              -1000
(gdb) info registers eflags
eflags         0x287               [ CF PF SF IF ]


The arithmetic flags are:

    CF = 1
    PF = 1
    AF = 0
    ZF = 0
    SF = 1
    OF = 0

| Flag | Status | Explanation 

 1. CF - Set (1): Subtracting unsigned 2000 from 1000 requires a borrow because 1000 is smaller than 2000, so CF is set. 
 2. PF - Set (1): The low byte of the result is `0x18`, which is `00011000` in binary. It contains two 1-bits. Two is even, so PF is set. 
 3. AF - Cleared (0): The lower nibble of `0x03e8` is `8`, while the lower nibble of `0x07d0` is `0`. The subtraction `8 - 0` does not require a borrow from bit 4, so AF is cleared. 
 4. ZF - Cleared (0): The result is `0xfc18`, which is not zero, so ZF is cleared. 
 5. SF - Set (1): The most significant bit of the 16-bit result `0xfc18` is 1, indicating a negative signed result. Therefore, SF is set. 
 6. OF - Cleared (0): The signed calculation is `1000 - 2000 = -1000`. The value `-1000` is within the signed 16-bit range of `-32768` to `32767`, so signed overflow does not occur and OF is cleared. 

### Important Observation

This program demonstrates the difference between an unsigned borrow and signed overflow.

The subtraction produces:

    1000 - 2000 = -1000

The 16-bit result is:

    ax = 0xfc18

Because 1000 is smaller than 2000 when treated as unsigned values, the subtraction requires a borrow:

    CF = 1

However, the signed result is `-1000`, which is within the valid 16-bit signed range:

    -32768 to 32767

Therefore:

    OF = 0

The final arithmetic flags after `SUB` are:

    CF = 1
    PF = 1
    AF = 0
    ZF = 0
    SF = 1
    OF = 0

The `IF` flag displayed by GDB is unrelated to the `SUB` instruction.

The flags must be inspected immediately after the arithmetic instruction because later instructions can change the EFLAGS register.