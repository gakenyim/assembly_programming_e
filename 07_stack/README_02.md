# 02.asm - Stack and Local Variables
## Introduction 
This program demonstrates how the stack is used to store local variables and manage function calls. It uses rsp and rbp to allocate, access and release stack memory

## Stack Operations
### Calling the function
call work -> the CALL instruction pushes the return address onto the stack and transfers execution to the work function. rsp decreases by 8 bytes
Breakpoint 1, 0x0000000000401000 in _start ()
(gdb) info register rsp
rsp            0x7fffffffd890      0x7fffffffd890
(gdb) si
0x000000000040100f in work ()
(gdb) info register rsp
rsp            0x7fffffffd888      0x7fffffffd888
![alt text](image-2.png)

### Setting up the stack frame
push rbp saves the previous base pointer.
mov rbp, rsp establishes a reference point for local variables
sub rsp, 16 reserves 16 bytes of stack space for two variables
(gdb) info register rbp
rbp            0x0                 0x0
(gdb) si
0x0000000000401013 in work ()
(gdb) info register rbp rsp
rbp            0x7fffffffd880      0x7fffffffd880
rsp            0x7fffffffd880      0x7fffffffd880
(gdb) si
0x0000000000401017 in work ()
(gdb) info register rsp
rsp            0x7fffffffd870      0x7fffffffd870

### Storing local variables
mov qword [rbp - 8], 100
mov qword [rbp - 16], 200
The program stores 100 and 200 in the allocated stack space, using rbp-relative addresses
0x0000000000401027 in work ()
(gdb) info register rbp 
rbp            0x7fffffffd880      0x7fffffffd880
(gdb) info registers rax rbx 
rax            0x0                 0
rbx            0x0                 0

### Retrieving values
mov rax, [rbp - 8]
mov rbx, [rbp - 16]
The values are retrieved from the stack into the rax and rbx respectively. rax receives 100, while rbx receives 200
(gdb) info registers rax rbx 
rax            0x64                100
rbx            0xc8                200

### Restoring the stack
mov rsp, rbp releases the 16 bytes allocated for local variables
pop rbp restores the previous base pointer
ret retrieves the return address and returns execution to _start

0x0000000000401034 in work ()
(gdb) info register rbp rsp
rbp            0x0                 0x0
rsp            0x7fffffffd888      0x7fffffffd888
(gdb) si
0x0000000000401005 in _start ()

## Conclusion
This program demonstrates how the stack manages function calls and local variables. rsp changes as memory is allocated and released, while rbp provides a stable reference point for accessing local variables.

The function restores the stack before returning, demonstrating proper stack frame management.