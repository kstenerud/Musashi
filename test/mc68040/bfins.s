.include "entry.s"
/* OPCODE : BFINS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

.set SRC_LOC,   STACK2_BASE - 0x100
.set BF_LOC1, SRC_LOC+0
.set BF_LOC2, SRC_LOC+4

/** See UM page 40*/

op_BFINS:
    mov.l #0x01234567, BF_LOC1
    mov.l #0xCB, %d1
    bfins %d1, BF_LOC1, #12, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /* Same thing, with data register */
    mov.l #0x01234567, BF_LOC1
    mov.l #12, %d0
    mov.l #0xCB, %d1
    bfins %d1, BF_LOC1, %d0, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /* Data register has "wrap around" behavior */
    mov.l #0x01234567, %d1
    mov.l #30, %d0
    mov.l #0x3, %d2
    bfins %d2, %d1, %d0, #4 | Change 0x67 => 0x64, 01 => C1
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0xC1234564, %d1
    bne TEST_FAIL

    /* Same thing, but offseted into oblivion*/
    mov.l #0x01234567, BF_LOC1
    mov.l #12+BF_LOC1*8, %d0
    mov.l #0x9A, %d2
    bfins %d2, 0, %d0, #8 | Change 0x34 => 0x9A
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x129A567, BF_LOC1
    bne TEST_FAIL

    /* Same thing, but negative offset */
    mov.l #0x01234567, BF_LOC1
    mov.l #12+(BF_LOC1-0xABCDEF)*8, %d0
    mov.l #0x9A, %d2
    bfins %d2, 0xABCDEF, %d0, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x129A567, BF_LOC1
    bne TEST_FAIL

    /** Touch 5 bytes **/
    mov.l #0x01234566, BF_LOC1
    mov.l #0x89ABCDEF, BF_LOC2
    mov.l #0xC0FEFEDE, %d2
    bfins %d2, BF_LOC1, #31, #32 | Change 0x66 => 0x67, 0x89ABCDEF => 0x81FDFDBD
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x1234567, BF_LOC1
    bne TEST_FAIL
    mov.l BF_LOC2, %d0
    cmp.l #0x81FDFDBD, BF_LOC2
    bne TEST_FAIL

    /** Zero flag **/
    mov.l #0xFFFFFFFF, BF_LOC1
    mov.l #0xFFFFFFFF, BF_LOC2
    mov.l #0x0, %d2
    bfins %d2, BF_LOC1, #31, #32
    bne TEST_FAIL | Z = 1
    bmi TEST_FAIL | N = 0
    cmp.l #0xFFFFFFFE, BF_LOC1
    bne TEST_FAIL
    cmp.l #0x1, BF_LOC2
    bne TEST_FAIL

    /** Write to 'dirty' memory */
    mov.l #0xFFFFFFFF, -(%a7)
    mov.l #0, %d0
    bfins %d0, (%a7), 0, 3
    cmp.b #0x1F, (%a7)
    bne TEST_FAIL
    adda.l #4, %a7

    /** Write to 'dirty' register - non zero offset*/
    mov.l #0xAAAAAAAA, %d0
    mov.l #19, %d1
    bfins %d1, %d0, 12, 7
    cmp.l #0xAAA26AAA, %d0
    bne TEST_FAIL

    /** Write to 'dirty' memory - non zero offset*/
    mov.l #0xAAAAAAAA, -(%a7)
    mov.l #19, %d1
    bfins %d1, (%a7), 12, 7
    cmp.l #0xAAA26AAA, (%a7)+
    bne TEST_FAIL

    /** Write to 'dirty' register - non even offset*/
    mov.l #0xAAAAAAAA, %d0
    mov.l #19, %d1
    bfins %d1, %d0, 13, 7
    cmp.l #0xAAA93AAA, %d0
    bne TEST_FAIL

    /** Write to 'dirty' memory - non zero offset*/
    mov.l #0xAAAAAAAA, -(%a7)
    mov.l #19, %d1
    bfins %d1, (%a7), 13, 7
    cmp.l #0xAAA93AAA, (%a7)+
    bne TEST_FAIL

    rts
