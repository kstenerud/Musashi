.include "entry.s"
/* OPCODE : SCC*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
.set SRC_LOC,   STACK2_BASE - 0x100

op_SCC:         move #0x01 , %ccr             
                scc (SRC_LOC)                   /* Clear the EA byte*/
                cmpi.b #0x00 , (SRC_LOC)
                bne TEST_FAIL

                move #0x00 , %ccr
                scc (SRC_LOC)                   /* Set the EA byte to 0xFF*/
                cmpi.b #0xFF , (SRC_LOC)
                bne TEST_FAIL

                rts
                


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
