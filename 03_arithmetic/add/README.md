# ADD Arithmetic Operations and EFLAGS
## add1.asm
### Operation

The program loads two 8-bit values:
- `num1 = 120`
- `num2 = 10`
The instruction being analyzed is:
       add al, [num2]

The operation is: 120 + 10 = 130

In binary:

      01111000(120)  + 00001010(10) = 10000010(130)
GDB confirmed that the result in AL was `0x82`, which is 130 in decimal.

### EFLAGS Analysis

1. CF - Cleared (0):The result 130 fits within the unsigned 8-bit range of 0–255, so there is no carry out of bit 7. 
2. PF - Set (1): The low byte of the result is `10000010`, which contains two 1-bits. Since two is even, PF is set. 
3. AF - Set (1): The lower nibbles are `1000` and `1010`. Their addition produces `1 0010`, causing a carry from bit 3 to bit 4. 
4. ZF - Cleared (0): The result is 130, which is not zero. 
5.  SF - Set (1): Bit 7, the most significant bit of the 8-bit result `10000010`, is 1. 
6. OF - Set (1) | The operands 120 and 10 are positive signed 8-bit numbers, but their mathematical result, 130, is outside the signed 8-bit range of -128 to 127. Therefore, signed overflow occurs. |

### GDB Result

After executing the `ADD` instruction, GDB displayed:

eax            0x82    130
(gdb) info registers eflags
eflags         0xa96               [ PF AF SF IF OF ]
    
The arithmetic flags are therefore:

    CF = 0
    PF = 1
    AF = 1
    ZF = 0
    SF = 1
    OF = 1

The `IF` flag was also displayed by GDB, but it is the Interrupt Flag and is not a result of the arithmetic operation.

### Important Observation

This example demonstrates the difference between unsigned carry and signed overflow.

The result 130 fits in an unsigned 8-bit value, so CF is cleared. However, 130 cannot be represented as a signed 8-bit value because the signed range is -128 to 127. Therefore, OF is set.

# ADD Arithmetic Operations and EFLAGS

## add3.asm

### Operation

The program loads two 16-bit values:
- `num1 = 0xFFFF`
- `num2 = 1`

The first arithmetic instruction is:
   add ax, [num2]

Initially:
    AX = 0xFFFF

The addition is:

    0xFFFF + 0x0001 = 0x10000

Because AX is only 16 bits, the stored result is:

    AX = 0x0000

The carry beyond the 16-bit range is stored in the Carry Flag.

### Flags After ADD

GDB showed:

    ax      = 0x0
   (gdb) info registers eflags 
eflags         0x257               [ CF PF AF ZF IF ]

The arithmetic flags are therefore:

    CF = 1
    PF = 1
    AF = 1
    ZF = 1
    SF = 0
    OF = 0

| Flag | Status | Explanation 

1. CF - Set (1): `0xFFFF + 1` produces `0x10000`, which requires a carry beyond the 16-bit range. 
2. PF - Set (1): The low byte of the result is `0x00`, which contains zero 1-bits. Zero is even, so PF is set. 
3. AF - Set (1): The lower nibbles are `0xF + 0x1`, producing `0x10`, so there is a carry from bit 3 to bit 4. 
4. ZF - Set (1): The 16-bit result stored in AX is `0x0000`. 
5. SF - Cleared (0): The most significant bit of the 16-bit result is 0. 
6. OF - Cleared (0): Interpreting the operands as signed values, `0xFFFF` represents -1. Therefore, `-1 + 1 = 0`, which is within the signed 16-bit range. 

### ADC Instruction
The program then executes:

    adc ax, 0

ADC means "Add with Carry". It uses the Carry Flag produced by the previous ADD.

Before ADC:

    AX = 0x0000
    CF = 1

Therefore:

    AX = 0x0000 + 0 + 1
       = 0x0001

GDB confirmed:

(gdb) info register ax
ax             0x1                 1
(gdb) info registers eflags 
eflags         0x202               [ IF ]

Since only IF is displayed, all the arithmetic flags are cleared after ADC.

### Flags After ADC

 Flag  Status | Explanation |

1. CF - Cleared (0): `0 + 0 + 1 = 1`, so there is no carry out of the 16-bit result. 
2. PF - Cleared (0): The low byte is `00000001`, which contains one 1-bit. One is odd, so PF is cleared. 
3. AF - Cleared (0): Adding 0 and the carry-in 1 does not produce a carry from bit 3 to bit 4. 
4. ZF - Cleared (0): The result is 1, not zero. 
5. SF - Cleared (0): The most significant bit of `0000000000000001` is 0. 
6. OF - Cleared (0): The signed result is 1, which is within the signed 16-bit range of -32768 to 32767. 

### Important Observation
This program demonstrates how `ADC` uses the Carry Flag from a previous addition.

The first instruction:

    add ax, [num2]

produces:

    0xFFFF + 1 = 0x0000

and sets CF to 1.

The next instruction:

    adc ax, 0

uses that carry:

    0x0000 + 0 + 1 = 0x0001

After ADC, CF is cleared because the new result does not produce another carry.

The flags must be inspected immediately after the instruction being analyzed because subsequent instructions can modify EFLAGS.