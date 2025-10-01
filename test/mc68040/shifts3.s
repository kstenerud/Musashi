.include "entry.s"
/* OPCODE : SHIFTS (v3*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

    mov.l #0x0FFFFFFFF, %d0
    mov.l #32, %d1
    lsl.l %d1, %d0
    cmp.l #0, %d0
    bne TEST_FAIL

    mov.w #0x0FFFF, %d0
    mov.w #16, %d1
    lsl.w %d1, %d0
    cmp.w #0, %d0
    bne TEST_FAIL

    mov.b #0x0FF, %d0
    mov.b #8, %d1
    lsl.b %d1, %d0
    cmp.b #0, %d0
    bne TEST_FAIL

    mov.l #0x0FFFFFFFF, %d0
    mov.l #32, %d1
    lsr.l %d1, %d0
    cmp.l #0, %d0
    bne TEST_FAIL

    mov.w #0x0FFFF, %d0
    mov.w #16, %d1
    lsr.w %d1, %d0
    cmp.w #0, %d0
    bne TEST_FAIL

    mov.b #0x0FF, %d0
    mov.b #8, %d1
    lsr.b %d1, %d0
    cmp.b #0, %d0
    bne TEST_FAIL

    rts
