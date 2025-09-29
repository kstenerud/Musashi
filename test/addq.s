.include "entry.s"
/* OPCODE : ADDQ*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_ADDQ:       

    /* BYTE*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00000000 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0x00000000 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7    

ADDQ_LOOP1:     addq.b #3 , %d5          
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , ADDQ_LOOP1
                
                cmpi.l #0x0000043D , %d1
                bne TEST_FAIL
                cmpi.l #0x00007F80 , %d2
                bne TEST_FAIL


    /* WORD*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00000000 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0x0000FFF0 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7   
                mov.l #0x00000100 , %a0   

ADDQ_LOOP2:     addq.w #5 , %d5   
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , ADDQ_LOOP2

                cmpi.l #0x00000029 , %d1
                bne TEST_FAIL
                cmpi.l #0x00057280 , %d2
                bne TEST_FAIL


    /* LONG*/
                mov.l #0x000000FF , %d0    /* Loop counter*/
                mov.l #0x00000000 , %d1    /* Flag results accumulator*/
                mov.l #0x00000000 , %d2    /* Data results accumulator*/
                mov.l #0x00000000 , %d3   
                mov.l #0x00000000 , %d4    
                mov.l #0xFFFFFFF0 , %d5    
                mov.l #0x00000000 , %d6    
                mov.l #0x00000000 , %d7   

ADDQ_LOOP3:     addq.l #1 , %d5          
                move %sr , %d6      
                andi.l #0x1F , %d6        /* Isolate flags*/
                add.l %d6 , %d1           /* Copy flag results into accumulator*/
                add.l %d5 , %d2           /* Copy data results into data accumulator*/
                dbf %d0 , ADDQ_LOOP3

                cmpi.l #0x0000008D , %d1
                bne TEST_FAIL
                cmpi.l #0x00007080 , %d2
                bne TEST_FAIL

    /* Check that Flags are not updated for Address registers*/
                mov.l #0x0000FFFF , %a0   
                move #0x00 , %ccr         /* Clear flags*/
                addq.w #0x7 , %a0         
                bcs TEST_FAIL

                rts
        


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
