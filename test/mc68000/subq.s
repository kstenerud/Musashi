.include "entry.s"
/* OPCODE : SUBQ*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_SUBQ:       

    /* BYTE*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00001234 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0x00000012 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7    

SUBQ_LOOP1:     subq.b #1 , %d5          
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , SUBQ_LOOP1
                
                cmpi.l #0x00000417 , %d1
                bne TEST_FAIL
                cmpi.l #0x000091B4 , %d2
                bne TEST_FAIL


    /* WORD*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00000000 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0x00000002 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7   
                mov.l #0x00000100 , %a0   

SUBQ_LOOP2:     subq.w #5 , %d5   
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , SUBQ_LOOP2

                cmpi.l #0x00000811 , %d1
                bne TEST_FAIL
                cmpi.l #0x00FD7F80 , %d2
                bne TEST_FAIL


    /* LONG*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00000000 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0x00000007 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7   

SUBQ_LOOP3:     subq.l #1 , %d5          
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , SUBQ_LOOP3

                cmpi.l #0x000007DD , %d1
                bne TEST_FAIL
                cmpi.l #0xFFFF8680 , %d2
                bne TEST_FAIL

    /* Check that Flags are not updated for Address registers*/
                mov.l #0x0001FFFF , %a0   
                move #0x00 , %ccr         /* Clear flags*/
                subq.w #0x7 , %a0         
                bcs TEST_FAIL

                rts
        
        


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
