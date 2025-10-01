.include "entry.s"
/* OPCODE : MULS.L, MULU.L*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_MULU_L:

    /** Some sanity checks **/

    /** Basic **/
    mov.l #0xFFF, %d0
    mulu.l #0x10000, %d0
    cmp.l #0xFFF0000, %d0
    bne TEST_FAIL

    /** Overflow **/
    mov.l #0x10000, %d0
    mulu.l #0x10000, %d0
    bne TEST_FAIL | Z flag must be set
    bvc TEST_FAIL | V flag must be set.
    cmp.l #0x0, %d0
    bne TEST_FAIL

    /** A random loop */
    mov.w #0, %ccr

    mov.l #0, %d6 | Flags accu
    mov.l #0, %d7 | Result accu
    mov.l #0xF1AC021A, %d5 | Outer var
    mov.l #0x01FAA10A, %d4 | Inner var

    mov.l #0x10, %d3 | Outer counter
mulul_outer:
    mov.l #0x10, %d2 | Inner counter
mulul_inner:
    mov.l %d4, %d1
    mulu.l %d5, %d1
    add.l %d1, %d7
    clr.l %d1
    mov.w %ccr, %d1
    add.l %d1, %d6
    dbf %d2, mulul_inner
    dbf %d3, mulul_outer

    cmp.l #0xE1AB5384, %d7 | Equal to 0xF1AC021A * 0x01FAA10A * 0x11 * 0x11
    bne TEST_FAIL
    cmp.l #0x1264, %d6
    bne TEST_FAIL


op_MULU_Q:
    /** Multiply with quad word result **/
    mov.l #0x10000, %d0
    mulu.l #0x10000, %d1, %d0  | Multiply 0x10000 * %d0, use %d1 for high order results
    cmp.l #0x0, %d0
    bne TEST_FAIL
    cmp.l #0x1, %d1
    bne TEST_FAIL

    rts
