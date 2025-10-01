.include "entry.s"
/* OPCODE : CMP*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_CMP:   


  /** <EA> to Register*/

                mov.l #0xa5a5a5a5, %d0       /* Initial Data-X  Inner loop*/
                mov.l #0x8167E123, %d1       /* Initial Data-Y  Outer loop*/
                mov.l #0xa5a5a5a5, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4       /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                mov.l #0x0000001E, %d7       /* Outer loop counter*/
                mov.l #0x00000100, %a0       /* Address for memory EA operations*/


CMP_OUTER1:    
 
    /* BYTE     */
                mov.l %d1 , (%a0)
                cmp.b (%a0) , %d0             
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
 
    /* WORD      */
                mov.l %d1 , (%a0)
                cmp.w (%a0) , %d0             
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
 
    /* LONG      */
                mov.l %d1 , (%a0)
                cmp.l (%a0) , %d0             
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
                
                
                lsr.l #0x1 , %d1
                dbf %d6 , CMP_OUTER1
                lsr.l #0x1 , %d2
                mov.l #0x8167E123, %d1       /* Initial Data-Y*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                dbf %d7 , CMP_OUTER1
                
                cmpi.l #0x7878712F , %d4      /* Check the data results*/
                bne TEST_FAIL
                cmpi.l #0x00005502 , %d5      /* Check the Flag results*/
                bne TEST_FAIL
                   
                   

                rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
