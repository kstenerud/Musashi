.include "entry.s"
/* OPCODE : DIVS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_DIVS:     

                mov.l #0xa5a5a5a5, %d0        /* Initial Numerator*/
                mov.l #0x00005a5a, %d1        /* Initial Divisor*/
                mov.l #0xa5a5a5a5, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4        /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000000E, %d6       /* Inner loop counter*/
                mov.l #0x0000001E, %d7       /* Outer loop counter*/


DIVS_OUTER1:    divs %d1  , %d0               /* !! Easy68K C not always cleared*/
                move %sr , %d3      
                andi.l #0x0C , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                add.l %d0 , %d4               /* Copy data results into data accumulator   */
                lsr.l #0x1 , %d1

                dbf %d6 , DIVS_OUTER1
                lsr.l #0x1 , %d2
                mov.l %d2 , %d0
                mov.l #0x00005a5a, %d1       /* Initial Divisor*/
                mov.l #0x0000000E, %d6       /* Inner loop counter*/
                dbf %d7 , DIVS_OUTER1
                
                cmpi.l #0x4EC5D057 , %d4      /* Check the data results*/
                bne TEST_FAIL
                     
                cmpi.l #0x00000038 , %d5      /* Check the Flag results*/
                bne TEST_FAIL
          

                rts
       

   
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
