.include "entry.s"
/* OPCODE : RTD */
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_RTD:
            mov.l %a7, %a0

            sub.w #0x8, %a7 | Simulate passing 8 bytes of arguments
            jsr test_routine
            cmpa %a0, %a7
            bne TEST_FAIL

            add.w #0x8, %a7
            jsr test_routine2
            cmpa %a0, %a7
            bne TEST_FAIL

            rts

test_routine:
            rtd #8

test_routine2:
            rtd #-8
