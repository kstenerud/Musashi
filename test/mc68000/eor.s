.include "entry.s"
/* OPCODE : EOR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_EOR:   
 
  /** Register to <EA>*/

                mov.l #0x86738374, %d0       /* Initial Data-X  Inner loop*/
                mov.l #0xFC55F2FE, %d1       /* Initial Data-Y  Outer loop*/
                mov.l #0x86738374, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4       /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                mov.l #0x0000001D, %d7       /* Outer loop counter*/
                mov.l #0x00000100, %a0       /* Address for memory EA operations*/


EOR_OUTER2:    
 
    /* BYTE     */
                mov.l %d0 , (%a0)
                eor.b %d1 , (%a0)             
                move %sr , %d3      
                andi.l #0x0C , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l (%a0) , %d4             /* Copy data results into data accumulator   */
 
    /* WORD      */
                mov.l %d0 , (%a0)
                eor.w %d1 , (%a0)  
                move %sr , %d3      
                andi.l #0x0C , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l (%a0) , %d4             /* Copy data results into data accumulator   */
 
    /* LONG      */
                mov.l %d0 , (%a0)
                eor.l %d1 , (%a0)  
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l (%a0) , %d4             /* Copy data results into data accumulator   */
                
                
                lsr.l #0x1 , %d1
                dbf %d6 , EOR_OUTER2
                lsr.l #0x1 , %d2
                mov.l #0x8167E123, %d1       /* Initial Data-Y*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                dbf %d7 , EOR_OUTER2
                
                cmpi.l #0x55C5EB70 , %d4      /* Check the data results*/
                bne TEST_FAIL
                cmpi.l #0x00004430 , %d5      /* Check the Flag results*/
                bne TEST_FAIL
                   
                   
                rts
                

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
