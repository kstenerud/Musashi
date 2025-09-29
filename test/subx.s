.include "entry.s"
/* OPCODE : SUBX*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_SUBX: 


  /** Register to Register*/
                mov.l #0xa5a5a5a5, %d0       /* Initial Data-X  Inner loop*/
                mov.l #0x8167E123, %d1       /* Initial Data-Y  Outer loop*/
                mov.l #0xa5a5a5a5, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4       /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                mov.l #0x0000001E, %d7       /* Outer loop counter*/
                mov.l #0x00000100, %a0       /* Address for memory EA operations*/


SUBX_OUTER1:    
 
    /* BYTE    */
                mov.l %d2 , %d0
                subx.b %d1 , %d0             
                move %sr , %d3      
                andi.l #0x1F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
 
    /* WORD      */
                mov.l %d2 , %d0
                subx.w %d1 , %d0             
                move %sr , %d3      
                andi.l #0x1F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
 
    /* LONG      */
                mov.l %d2 , %d0
                subx.l %d1 , %d0             
                move %sr , %d3      
                andi.l #0x1F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
                
                ror.l #0x1 , %d1
                dbf %d6 , SUBX_OUTER1
                ror.l #0x1 , %d2
                mov.l #0x8167E123, %d1       /* Initial Data-Y*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                dbf %d7 , SUBX_OUTER1
                
                cmpi.l #0xFCAA913E , %d4      /* Check the data results*/
                bne TEST_FAIL
                cmpi.l #0x00007E89 , %d5      /* Check the Flag results*/
                bne TEST_FAIL
                   
    
    
    /* -(An) , -(An)*/
    
                mov.l #0x00000000, %d0       /* BYTE Flag Results Accumulator     */
                mov.l #0x00000000, %d1        
                mov.l #0x00000000, %d2      
                mov.l #0x00000100, %a0       /* Address for Data-X*/
                mov.l #0x00000200, %a1       /* Address for Data-Y*/
                mov.l #0x11FF5580 , (%a0)+   /* Populate test data*/
                mov.l #0x1111FFFF , (%a0)+   /* Populate test data*/
                mov.l #0x80FF337F , (%a0)+   /* Populate test data*/
                mov.l #0x44444444 , (%a0)+   /* Populate test data*/
                mov.l #0x80FF337F , (%a1)+   /* Populate test data*/
                mov.l #0x1111FFFF , (%a1)+   /* Populate test data*/
                mov.l #0x33333333 , (%a1)+   /* Populate test data*/
                mov.l #0x5580EECC , (%a1)+   /* Populate test data*/
                

                mov.l #0x0000000F, %d6       /* Loop counter*/
                
SUBX_LOOP3:     subx.b -(%a0) , -(%a1)
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d0               /* Copy flag results into accumulator    */
                add.b (%a1) , %d1     
                dbf %d6 , SUBX_LOOP3


                mov.l #0x00000110, %a0       /* Address for Data-X*/
                mov.l #0x00000210, %a1       /* Address for Data-Y*/
                mov.l #0x00000007, %d6       /* Loop counter*/
                
SUBX_LOOP4:     subx.w -(%a0) , -(%a1)
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d0               /* Copy flag results into accumulator    */
                add.w (%a1) , %d1     
                dbf %d6 , SUBX_LOOP4


                mov.l #0x00000110, %a0       /* Address for Data-X*/
                mov.l #0x00000210, %a1       /* Address for Data-Y*/
                mov.l #0x00000003, %d6       /* Loop counter*/
                
SUBX_LOOP5:     subx.l -(%a0) , -(%a1)
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d0               /* Copy flag results into accumulator    */
                add.l (%a1) , %d1     
                dbf %d6 , SUBX_LOOP5


                cmpi.l #0x000000B1 , %d0      /* Check the flag results*/
                bne TEST_FAIL
                cmpi.l #0x62C6F417 , %d1      /* Check the data results */
                bne TEST_FAIL
 
                rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
