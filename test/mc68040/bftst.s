.include "entry.s"
/* OPCODE : BFTST*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

.set SRC_LOC,   STACK2_BASE - 0x100
.set BF_LOC1, SRC_LOC+0
.set BF_LOC2, SRC_LOC+4

/** See UM page 40*/

op_BFTST:
    mov.l #0x01234567, BF_LOC1
    bftst BF_LOC1, #12, #8
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0

    /* Same thing, with data register */
    mov.l #0x012B4567, BF_LOC1
    mov.l #12, %d0
    bftst BF_LOC1, %d0, #8
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1

    /* Data register has "wrap around" behavior */
    mov.l #0x01234565, %d1
    mov.l #30, %d0
    bftst %d1, %d0, #4
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0

    /* Same thing, but offseted into oblivion*/
    mov.l #0x01234567, BF_LOC1
    mov.l #12+BF_LOC1*8, %d0
    bftst 0, %d0, #8 | Change 0x34 => 0xFF
    beq TEST_FAIL | Z = 0
    bmi TEST_FAIL | N = 0

    /* Same thing, but negative offset */
    mov.l #0x012B4567, BF_LOC1
    mov.l #12+(BF_LOC1-0xABCDEF)*8, %d0
    bftst 0xABCDEF, %d0, #8
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1

    /** Touch 5 bytes **/
    mov.l #0x01234567, BF_LOC1
    mov.l #0x89ABCDEE, BF_LOC2
    bftst BF_LOC1, #31, #32
    beq TEST_FAIL | Z = 0
    bpl TEST_FAIL | N = 1

    /** Zero flag **/
    mov.l #0x00, BF_LOC1
    mov.l #0x00, BF_LOC2
    bftst BF_LOC1, #31, #32
    bne TEST_FAIL | Z = 1
    bmi TEST_FAIL | N = 0

    rts



