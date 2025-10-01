
*
* Test case entry point. include this file in each test
*

* Compile/link commands:
* m68k-elf-as -march=68040  -o file.o test.s
* m68k-elf-ld -Ttext 0x10000 --oformat binary -o test.bin file.o
* m68k-elf-objdump -D test.bin -b binary -mm68k:68040


* Memory layout:
* 0x0-0x10000: RAM, contains vector table and stack (set by test_driver.cpp)
* 0x10000-...: ROM, code
* 0x100000-0x100400: Special registers.
* 0x200000-0x210000: FPSP ROM (if FP support enabled)
* 0x300000-0x310000: RAM, some tests write here
* 0x400000-0x410000: FPSP RAM (if FP support enabled)
* 0x80000000-0xA0000000: Floating point test cases ROM

.set TEST_FAIL_REG, 0x100000        | Writes to this location make a test fail
.set TEST_PASS_REG, 0x100004        | Writes to this location make a test pass
.set PRINT_REG_REG, 0x100008        | Writes to this location prints the CPU state to stdout
.set INTERRUPT_REG, 0x10000C        | Writes to this register triggers an interrupt
.set STDOUT_REG,    0x100014        | Byte-size writes to this register output to stdout
.set PRINT_FP_REG,  0x100020
.set STACK_BASE,    0x3F0
.set STACK2_BASE,   0x310000

.section .text
.globl _start
_start:

* Vector Table
* .long STACK_BASE        | Vector = 0   Reset Supervisor Stack Pointer
* .long main              | Vector = 1   Reset Initial PC
* .long 0xDEADBEEF        | Vector = 2   Bus Error
* .long 0xDEADBEEF        | Vector = 3   Address Error
* .long 0xDEADBEEF        | Vector = 4   Illegal Instruction
* .long 0xDEADBEEF        | Vector = 5   Zero Divide
* .long EXCEPTION_6       | Vector = 6   CHK Instruction
* .long EXCEPTION_7       | Vector = 7   TRAPV Instruction
* .long 0xDEADBEEF        | Vector = 8   Privilege Violation
* .long 0xDEADBEEF        | Vector = 9   Trace
* .long 0xDEADBEEF        | Vector = 10  Line A Emulator
* .long 0xDEADBEEF        | Vector = 11  Line F Emulator
* .long 0xDEADBEEF        | Vector = 12
* .long 0xDEADBEEF        | Vector = 13
* .long 0xDEADBEEF        | Vector = 14
* .long 0xDEADBEEF        | Vector = 15
* .long 0xDEADBEEF        | Vector = 16
* .long 0xDEADBEEF        | Vector = 17
* .long 0xDEADBEEF        | Vector = 18
* .long 0xDEADBEEF        | Vector = 19
* .long 0xDEADBEEF        | Vector = 20
* .long 0xDEADBEEF        | Vector = 21
* .long 0xDEADBEEF        | Vector = 22
* .long 0xDEADBEEF        | Vector = 23
* .long 0xDEADBEEF        | Vector = 24  Spurrious Interrupt
* .long 0xDEADBEEF        | Vector = 25  Level 1 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 26  Level 2 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 27  Level 3 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 28  Level 4 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 29  Level 5 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 30  Level 6 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 31  Level 7 Interrupt Autovector
* .long 0xDEADBEEF        | Vector = 32  TRAP #0
* .long 0xDEADBEEF        | Vector = 33  TRAP #1
* .long 0xDEADBEEF        | Vector = 34  TRAP #2
* .long 0xDEADBEEF        | Vector = 35  TRAP #3
* .long 0xDEADBEEF        | Vector = 36  TRAP #4
* .long 0xDEADBEEF        | Vector = 37  TRAP #5
* .long 0xDEADBEEF        | Vector = 38  TRAP #6
* .long 0xDEADBEEF        | Vector = 39  TRAP #7
* .long 0xDEADBEEF        | Vector = 40  TRAP #8
* .long 0xDEADBEEF        | Vector = 41  TRAP #9
* .long 0xDEADBEEF        | Vector = 42  TRAP #10
* .long 0xDEADBEEF        | Vector = 43  TRAP #11
* .long 0xDEADBEEF        | Vector = 44  TRAP #12
* .long 0xDEADBEEF        | Vector = 45  TRAP #13
* .long 0xDEADBEEF        | Vector = 46  TRAP #14
* .long 0xDEADBEEF        | Vector = 47  TRAP #15
* .long 0xDEADBEEF        | Vector = 48  FP BSUN
* .long 0xDEADBEEF        | Vector = 49  FP INEX
* .long 0xDEADBEEF        | Vector = 50  FP DZ
* .long 0xDEADBEEF        | Vector = 51  FP UNFL
* .long 0xDEADBEEF        | Vector = 52  FP OPERR
* .long 0xDEADBEEF        | Vector = 53  FP OVFL
* .long 0xDEADBEEF        | Vector = 54  FP SNAN
* .long 0xDEADBEEF        | Vector = 55  FP UNIMP
* .long 0xDEADBEEF        | Vector = 56  MMU Configuration error
* .long 0xDEADBEEF        | Vector = 57  MMU Illegal operation error
* .long 0xDEADBEEF        | Vector = 58  MMU Access level violation error
* .long 0xDEADBEEF        | Vector = 59  reserved
* .long 0xDEADBEEF        | Vector = 60  reserved
* .long 0xDEADBEEF        | Vector = 61  reserved
* .long 0xDEADBEEF        | Vector = 62  reserved
* .long 0xDEADBEEF        | Vector = 63  reserved

.set STACK_TOP, 0x40

main:
    mov.l #EXCEPTION_6, 0x18
    mov.l #EXCEPTION_7, 0x1C
    jsr run_test
    mov.l #1, TEST_PASS_REG
    stop #0x2700

TEST_FAIL:
    mov.l #0, TEST_FAIL_REG
    stop #0x2700

EXCEPTION_6:
    mov.l #0xEEEE0006 , %d6      | Set d6 to the exception vector
    rte

EXCEPTION_7:
    mov.l #0x12345678 , %d0      | Set d6 to the exception vector
    rte

run_test:
