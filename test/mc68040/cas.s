.include "entry.s"
/* OPCODE : CAS, CAS2*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

.set SRC_LOC,   STACK2_BASE - 0x100
.set CAS_LOC1, SRC_LOC+0
.set CAS_LOC2, SRC_LOC+8

op_CAS:
            /**
             * CAS - LONG
             */
            mov.l #0x01234568, CAS_LOC1

            /** Cas fail**/
            mov.l #1, %d1
            mov.l #321, %d2
            cas.l %d1, %d2, CAS_LOC1
            beq TEST_FAIL
            cmp.l #0x01234568, %d1
            bne TEST_FAIL
            cmp.l CAS_LOC1, %d1
            bne TEST_FAIL

            /** Cas success */
            mov.l #0x01234568, %d1
            mov.l #321, %d2
            cas.l %d1, %d2, CAS_LOC1
            bne TEST_FAIL
            cmp.l #0x01234568, %d1
            bne TEST_FAIL
            cmp.l CAS_LOC1, %d2
            bne TEST_FAIL

            /**
             * CAS - WORD
             */
            mov.w #0x0123, CAS_LOC1

            /** Cas fail**/
            mov.w #1, %d1
            mov.w #321, %d2
            cas.w %d1, %d2, CAS_LOC1
            beq TEST_FAIL
            cmp.w #0x0123, %d1
            bne TEST_FAIL
            cmp.w CAS_LOC1, %d1
            bne TEST_FAIL

            /** Cas success */
            mov.w #0x0123, %d1
            mov.w #321, %d2
            cas.w %d1, %d2, CAS_LOC1
            bne TEST_FAIL
            cmp.w #0x0123, %d1
            bne TEST_FAIL
            cmp.w CAS_LOC1, %d2
            bne TEST_FAIL

            /**
             * CAS - BYTE
             */
            mov.b #0x7A, CAS_LOC1

            /** Cas fail**/
            mov.b #2, %d1
            mov.b #21, %d2
            cas.b %d1, %d2, CAS_LOC1
            beq TEST_FAIL
            cmp.b #0x7A, %d1
            bne TEST_FAIL
            cmp.b CAS_LOC1, %d1
            bne TEST_FAIL

            /** Cas success */
            mov.b #0x7A, %d1
            mov.b #21, %d2
            cas.b %d1, %d2, CAS_LOC1
            bne TEST_FAIL
            cmp.b #0x7A, %d1
            bne TEST_FAIL
            cmp.b CAS_LOC1, %d2
            bne TEST_FAIL


            /**
             * CAS2 - LONG
             */
            mov.l #0x01234567, CAS_LOC1
            mov.l #0x89ABCDEF, CAS_LOC2

            /** CAS2 Fail on Op1 **/
            mov.l #0, %d0
            mov.l #1, %d1
            mov.l #0, %d2
            mov.l #1, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.l %d0:%d1, %d2:%d3, %a0:%a1
            beq TEST_FAIL
            cmp.l #0x01234567, %d0
            bne TEST_FAIL
            cmp.l #0x89ABCDEF, %d1
            bne TEST_FAIL
            cmp.l #0, %d2
            bne TEST_FAIL
            cmp.l #1, %d3
            bne TEST_FAIL

            /** CAS2 Fail on Op2 **/
            mov.l #0x01234567, %d0
            mov.l #1, %d1
            mov.l #0, %d2
            mov.l #1, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.l %d0:%d1, %d2:%d3, %a0:%a1
            beq TEST_FAIL
            cmp.l #0x01234567, %d0
            bne TEST_FAIL
            cmp.l #0x89ABCDEF, %d1
            bne TEST_FAIL
            cmp.l #0, %d2
            bne TEST_FAIL
            cmp.l #1, %d3
            bne TEST_FAIL

            /** CAS2 Success **/
            mov.l #0x01234567, %d0
            mov.l #0x89ABCDEF, %d1
            mov.l #0xA, %d2
            mov.l #0xB, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.l %d0:%d1, %d2:%d3, %a0:%a1
            bne TEST_FAIL
            cmp.l #0x01234567, %d0
            bne TEST_FAIL
            cmp.l #0x89ABCDEF, %d1
            bne TEST_FAIL
            cmp.l #0xA, %d2
            bne TEST_FAIL
            cmp.l #0xB, %d3
            bne TEST_FAIL
            cmp.l CAS_LOC1, %d2
            bne TEST_FAIL
            cmp.l CAS_LOC2, %d3
            bne TEST_FAIL


            /**
             * CAS2 - WORD
             */
            mov.w #0x0123, CAS_LOC1
            mov.w #0x89AB, CAS_LOC2

            /** CAS2 Fail on Op1 **/
            mov.w #0, %d0
            mov.w #1, %d1
            mov.w #0, %d2
            mov.w #1, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.w %d0:%d1, %d2:%d3, %a0:%a1
            beq TEST_FAIL
            cmp.w #0x0123, %d0
            bne TEST_FAIL
            cmp.w #0x89AB, %d1
            bne TEST_FAIL
            cmp.w #0, %d2
            bne TEST_FAIL
            cmp.w #1, %d3
            bne TEST_FAIL

            /** CAS2 Fail on Op2 **/
            mov.w #0x0123, %d0
            mov.w #1, %d1
            mov.w #0, %d2
            mov.w #1, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.w %d0:%d1, %d2:%d3, %a0:%a1
            beq TEST_FAIL
            cmp.W #0x0123, %d0
            bne TEST_FAIL
            cmp.w #0x89AB, %d1
            bne TEST_FAIL
            cmp.w #0, %d2
            bne TEST_FAIL
            cmp.w #1, %d3
            bne TEST_FAIL

            /** CAS2 Success **/
            mov.w #0x0123, %d0
            mov.w #0x89AB, %d1
            mov.w #0xA, %d2
            mov.w #0xB, %d3
            lea.l CAS_LOC1, %a0
            lea.l CAS_LOC2, %a1
            cas2.w %d0:%d1, %d2:%d3, %a0:%a1
            bne TEST_FAIL
            cmp.w #0x0123, %d0
            bne TEST_FAIL
            cmp.w #0x89AB, %d1
            bne TEST_FAIL
            cmp.w #0xA, %d2
            bne TEST_FAIL
            cmp.w #0xB, %d3
            bne TEST_FAIL
            cmp.w CAS_LOC1, %d2
            bne TEST_FAIL
            cmp.w CAS_LOC2, %d3
            bne TEST_FAIL

            rts

