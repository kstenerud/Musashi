.include "entry.s"
/* OPCODE : BFEXTS, BFEXTU*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

.set SRC_LOC,   STACK2_BASE - 0x100
.set BF_LOC1, SRC_LOC+0
.set BF_LOC2, SRC_LOC+4

/** See UM page 40*/

op_BFEXT:
    /**
     * BFEXTU
     */
    mov.l #0x01234567, BF_LOC1
    bfextu BF_LOC1, #12, #8, %d0
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x34, %d0
    bne TEST_FAIL

    /* Same thing, with data register */
    mov.l #0x01234567, BF_LOC1
    mov.l #13, %d0
    bfextu BF_LOC1, %d0, #8, %d0
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x68, %d0
    bne TEST_FAIL

    /* Data register has "wrap around" behavior */
    mov.l #0x01234567, %d1
    mov.l #30, %d0
    bfextu %d1, %d0, #4, %d0
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xC, %d0
    bne TEST_FAIL

    /* Same thing, but offseted into oblivion*/
    mov.l #0x01234567, BF_LOC1
    mov.l #12+BF_LOC1*8, %d0
    bfextu 0, %d0, #8, %d0 | Grabs 0x34
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x34, %d0
    bne TEST_FAIL

    /* Same thing, but negative offset */
    mov.l #0x01234567, BF_LOC1
    mov.l #13+(BF_LOC1-0xABCDEF)*8, %d0
    bfextu 0xABCDEF, %d0, #9, %d0 | Grabs 0xD1
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0xD1, %d0
    bne TEST_FAIL

    /** Touch 5 bytes **/
    mov.l #0x01234567, BF_LOC1
    mov.l #0x89ABCDEF, BF_LOC2
    bfextu BF_LOC1, #31, #32, %d0 | Grabs 0xC4D5E6F7
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xC4D5E6F7, %d0
    bne TEST_FAIL

    /** Zero flag **/
    mov.l #0x00, BF_LOC1
    mov.l #0x00, BF_LOC2
    bfextu BF_LOC1, #31, #32, %d0
    bne TEST_FAIL | Z = 1
    bmi TEST_FAIL | N = 0
    cmp.l #0x0, %d0
    bne TEST_FAIL


    /**
     * BFEXTS
     */
    mov.l #0x01234567, BF_LOC1
    bfexts BF_LOC1, #12, #8, %d0
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x34, %d0
    bne TEST_FAIL

    /* Same thing, with data register */
    mov.l #0x01234567, BF_LOC1
    mov.l #13, %d0
    bfexts BF_LOC1, %d0, #8, %d0
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x68, %d0
    bne TEST_FAIL

    /* Data register has "wrap around" behavior */
    mov.l #0x01234567, %d1
    mov.l #30, %d0
    bfexts %d1, %d0, #4, %d0
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xFFFFFFFC, %d0
    bne TEST_FAIL

    /* Same thing, but offseted into oblivion*/
    mov.l #0x01234567, BF_LOC1
    mov.l #12+BF_LOC1*8, %d0
    bfexts 0, %d0, #8, %d0 | Grabs 0x34
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x34, %d0
    bne TEST_FAIL

    /* Same thing, but negative offset */
    mov.l #0x01234567, BF_LOC1
    mov.l #14+(BF_LOC1-0xABCDEF)*8, %d0
    bfexts 0xABCDEF, %d0, #9, %d0 | Grabs 0x1A2
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xFFFFFFA2, %d0
    bne TEST_FAIL

    /** Touch 5 bytes **/
    mov.l #0x01234567, BF_LOC1
    mov.l #0x89ABCDEF, BF_LOC2
    bfexts BF_LOC1, #31, #32, %d0 | Grabs 0xC4D5E6F7
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xC4D5E6F7, %d0
    bne TEST_FAIL

    /** Zero flag **/
    mov.l #0x00, BF_LOC1
    mov.l #0x00, BF_LOC2
    bfexts BF_LOC1, #31, #32, %d0
    bne TEST_FAIL | Z = 1
    bmi TEST_FAIL | N = 0
    cmp.l #0x0, %d0
    bne TEST_FAIL


    rts


