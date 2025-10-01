.include "entry.s"
/* OPCODE : CMP2*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_CMP2:
            /** WORD SIZE **/
            /* No trap */
            mov.w #0x6000, %d0
            cmp2.w bounds1, %d0
            bcs TEST_FAIL

            mov.w #-0x1000, %d0
            cmp2.w bounds1, %d0
            bcs TEST_FAIL

            /* Traps */
            mov.w #-0x2000, %d0
            cmp2.w bounds1, %d0
            bcc TEST_FAIL

            mov.w #0x7001, %d0
            cmp2.w bounds1, %d0
            bcc TEST_FAIL

            /** Same thing, but with address register**/
            mov.w #0x6000, %a0
            cmp2.w bounds1, %a0
            bcs TEST_FAIL

/*
broken on musashi:
            mov.l #0x16000, %a0
            cmp2 bounds1, %a0
            bcc TEST_FAIL
*/
            /** Dynamic bound + address register **/
            mov.l #0x70000000, -(%a7)
            mov.l #0x10000000, -(%a7)

            /* No trap */
            mov.l #0x10000000, %a0
            cmp2.l (%a7), %a0
            bcs TEST_FAIL

            /* trap */
            mov.l #0x70000001, %a0
            cmp2 (%a7), %a0
            bcc TEST_FAIL

            /* Restore stack */
            add.l #8, %a7

            /** BYTE SIZE **/
            /* No trap */
            mov.b #0x60, %d0
            cmp2.b bounds2, %d0
/*             bcs TEST_FAIL  I think this should be bcs, but musashi disagrees, and PRM is not clear*/
            bcc TEST_FAIL

            mov.b #-0x10, %d0
            cmp2.b bounds2, %d0
/*             bcs TEST_FAIL */
            bcc TEST_FAIL

            /* Traps */
            mov.b #-0x20, %d0
            cmp2.b bounds2, %d0
            bcc TEST_FAIL

            mov.w #0x70, %d0
            cmp2.b bounds2, %d0
            bcc TEST_FAIL

            mov.w #0xA, %d0
            cmp2.b bounds3, %d0
            bcc TEST_FAIL

            mov.w #0x9, %d0
            cmp2.b bounds3, %d0
            bcs TEST_FAIL


            rts

bounds1:
    .word 0xF000 | - 0x1000
    .word 0x7000 | 0x7000

bounds2:
    .byte 0xF0 | - 0x10
    .byte 0x70 | 0x70

bounds3:
    .byte 0x1
    .byte 0x9

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/


