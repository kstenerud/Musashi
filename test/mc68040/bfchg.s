.include "entry.s"
/* OPCODE : BFCHG*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

.set SRC_LOC,   STACK2_BASE - 0x100
.set BF_LOC1, SRC_LOC+0
.set BF_LOC2, SRC_LOC+4


/** See UM page 40*/

op_BFCHG:
    mov.l #0x01234567, BF_LOC1
    bfchg BF_LOC1, #12, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /* Same thing, with data register */
    mov.l #0x01234567, BF_LOC1
    mov.l #12, %d0
    bfchg BF_LOC1, %d0, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /* Data register has "wrap around" behavior */
    mov.l #0x01234567, %d1
    mov.l #30, %d0
    bfchg %d1, %d0, #4 | Change 0x67 => 0x64, 01 => C1
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0xC1234564, %d1
    bne TEST_FAIL

    /* Same thing, but offseted into oblivion*/
    mov.l #0x01234567, BF_LOC1
    mov.l #12+BF_LOC1*8, %d0
    bfchg 0, %d0, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /* Same thing, but negative offset */
    mov.l #0x01234567, BF_LOC1
    mov.l #12+(BF_LOC1-0xABCDEF)*8, %d0
    bfchg 0xABCDEF, %d0, #8 | Change 0x34 => 0xCB
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0
    cmp.l #0x12CB567, BF_LOC1
    bne TEST_FAIL

    /** Touch 5 bytes **/
    mov.l #0x01234567, BF_LOC1
    mov.l #0x89ABCDEF, BF_LOC2
    bfchg BF_LOC1, #31, #32 | Change 0x67 => 0x66, 0x89ABCDEF => 0x76543211
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1
    cmp.l #0x1234566, BF_LOC1
    bne TEST_FAIL
    cmp.l #0x76543211, BF_LOC2
    bne TEST_FAIL

    /** Zero flag **/
    mov.l #0x00, BF_LOC1
    mov.l #0x00, BF_LOC2
    bfchg BF_LOC1, #31, #32
    bne TEST_FAIL | Z = 1
    bmi TEST_FAIL | N = 0
    cmp.l #0x1, BF_LOC1
    bne TEST_FAIL
    cmp.l #0xFFFFFFFE, BF_LOC2
    bne TEST_FAIL


    rts

