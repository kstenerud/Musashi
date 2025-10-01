.include "entry.s"
/* OPCODE : TRAPcc*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_TRAPcc:

    /** Override VBR with out custom handler **/
    mov.l #0, %a0
    mov.l #7, %d0 | Trapcc vector
    mov.l #trapcc_handler, (%a0, %d0.w*4)

    mov.l #0x12345678, %a6
    mov.l #1, %d0
    cmp.w #0, %d0
    trapeq.l #0x9ABCDEF | Not taken
    cmp.l #0x12345678, %a6
    bne TEST_FAIL

    mov.l #0x12345678, %a6
    mov.l #1, %d0
    cmp.w #0, %d0
    trapne.l #0x9ABCDEF | Taken
    cmp.l #0x9ABCDEF, %a6
    bne TEST_FAIL

    rts


trapcc_handler:
    /** Read the PC that trapped */
    mov.l (%a7, 2), %a6
    /** Read the extension word to trapcc */
    mov.l (%a6, -4), %a6
    /** Done **/
    rte


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

