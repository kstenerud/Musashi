.include "entry.s"
/* OPCODE : CHK2*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_CHK2:
            /* No trap */
            mov.w #0x6000, %d0
            mov.l #0, %d6
            chk2.w bounds1, %d0
            bcs TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            beq TEST_FAIL

            mov.w #-0x1000, %d0
            mov.l #0, %d6
            chk2.w bounds1, %d0
            bcs TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            beq TEST_FAIL

            /* Traps */
            mov.w #-0x2000, %d0
            mov.l #0, %d6
            chk2.w bounds1, %d0
            bcc TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL

            mov.w #0x7001, %d0
            mov.l #0, %d6
            chk2.w bounds1, %d0
            bcc TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL


            /** Same thing, but with address register**/
            mov.w #0x6000, %a0
            mov.l #0, %d6
            chk2.w bounds1, %a0
            bcs TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            beq TEST_FAIL


/*
broken on musashi:
            mov.l #0x16000, %a0
            mov.l #0, %d6
            chk2 bounds1, %a0
            bcc TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL
*/
            /** Dynamic bound + address register **/
            mov.l #0x70000000, -(%a7)
            mov.l #0x10000000, -(%a7)

            /* No trap */
            mov.l #0x10000000, %a0
            chk2.l (%a7), %a0
            bcs TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            beq TEST_FAIL

            /* trap */
            mov.l #0x70000001, %a0
            chk2 (%a7), %a0
            bcc TEST_FAIL
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL

            /* Restore stack */
            add.l #8, %a7
            rts

bounds1:
    .word 0xF000 | - 0x1000
    .word 0x7000 | 0x7000


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

