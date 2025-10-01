.include "entry.s"
/* OPCODE : JMP, JSR */
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_JMP:
            /* Jump with fancy calling convention */
            mov.l #jr_ret, %a6
            mov.l #test_routine2, %a5
            jmp (%a5)
jr_ret:
            cmp.l #0x89ABCDEF, %d0
            bne TEST_FAIL

            /* Jump to subroutine */
            mov.l #test_routine, %a5
            jsr (%a5)
            cmp.l #0x01234567, %d0
            bne TEST_FAIL
            rts

test_routine:
            mov.l #0x01234567, %d0
            rts

test_routine2:
            mov.l #0x89ABCDEF, %d0
            jmp (%a6)
