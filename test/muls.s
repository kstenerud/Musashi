.include "entry.s"
/* OPCODE : MULS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_MULS:     

                mov.l #0xFE805501, %d0        /* Initial */
                mov.l #0x5697EDB6, %d1        /* Initial Y*/
                mov.l #0xFE805501, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4        /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000000E, %d6       /* Inner loop counter*/
                mov.l #0x0000000E, %d7       /* Outer loop counter*/


MULS_OUTER1:    muls %d1  , %d0             
                move %sr , %d3      
                andi.l #0x0C , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
                ror.l #0x1 , %d1

                dbf %d6 , MULS_OUTER1
                ror.l #0x1 , %d2
                mov.l %d2 , %d0
                mov.l #0x0000000E, %d6       /* Inner loop counter*/
                dbf %d7 , MULS_OUTER1
                
                cmpi.l #0xD4E2988C , %d4      /* Check the data results*/
                bne TEST_FAIL
                     
                cmpi.l #0x000003E0 , %d5      /* Check the Flag results*/
                bne TEST_FAIL
          

                rts
                
  
                
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
