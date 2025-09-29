.include "entry.s"
/* OPCODE : CMPM*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_CMPM: 

                mov.l #0x00000100, %a0       /* Address for Data-X*/
                mov.l #0x00000200, %a1       /* Address for Data-Y*/
                mov.l #0x00000000, %d0       
                mov.l #0x00000000, %d1       
                mov.l #0x00000000, %d2       
                
                mov.l #0x11FF5580 , (%a0)+   /* Populate test data*/
                mov.l #0x1111FFFF , (%a0)+   /* Populate test data*/
                mov.l #0x33333333 , (%a0)+   /* Populate test data*/
                mov.l #0x44444444 , (%a0)+   /* Populate test data*/
                
                mov.l #0x80FF337F , (%a1)+   /* Populate test data*/
                mov.l #0xFFFF1111 , (%a1)+   /* Populate test data*/
                mov.l #0x33333333 , (%a1)+   /* Populate test data*/
                mov.l #0x44444444 , (%a1)+   /* Populate test data*/
                
                mov.l #0x00000100, %a0       /* Address for Data-X*/
                mov.l #0x00000200, %a1       /* Address for Data-Y*/
                mov.l #0x0000000F, %d6       /* Loop counter*/
                
CMPM_LOOP1:     cmpm.b (%a0)+ , (%a1)+
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d0               /* Copy flag results into accumulator                */
                dbf %d6 , CMPM_LOOP1


                mov.l #0x00000100, %a0       /* Address for Data-X*/
                mov.l #0x00000200, %a1       /* Address for Data-Y*/
                mov.l #0x00000007, %d6       /* Loop counter*/
                
CMPM_LOOP2:     cmpm.w (%a0)+ , (%a1)+
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d1               /* Copy flag results into accumulator                */
                dbf %d6 , CMPM_LOOP2


                mov.l #0x00000100, %a0       /* Address for Data-X*/
                mov.l #0x00000200, %a1       /* Address for Data-Y*/
                mov.l #0x00000003, %d6       /* Loop counter*/
                
CMPM_LOOP3:     cmpm.l (%a0)+ , (%a1)+
                move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d2               /* Copy flag results into accumulator                */
                dbf %d6 , CMPM_LOOP3


                cmpi.l #0x0000004C , %d0      /* Check the data results*/
                bne TEST_FAIL
                cmpi.l #0x00000024 , %d1      
                bne TEST_FAIL
                cmpi.l #0x00000012 , %d2      
                bne TEST_FAIL
        
                rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
