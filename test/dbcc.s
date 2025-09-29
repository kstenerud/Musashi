.include "entry.s"
/* OPCODE : DBCC*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_DBCC:        mov.l #0x00000003 , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Accumulator*/
                move #0x00 , %ccr
                
DBCC_LOOP1:     addi.b #0x1 , %d1
                dbf %d0 , DBCC_LOOP1
                
                cmpi.l #0x00000004 , %d1  /* Check Accumulator results*/
                bne TEST_FAIL
                  
DBCC_LOOP2:     addi.b #0x1 , %d1
                dbcc %d0 , DBCC_LOOP2    /* Dont loop*/
                
                cmpi.l #0x00000005 , %d1  /* Check Accumulator results*/
                bne TEST_FAIL
            
                rts
                

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
