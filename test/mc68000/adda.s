.include "entry.s"
/* OPCODE : ADDA*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_ADDA: 

  /** <EA> to Register*/
                mov.l #0xa5a5a5a5, %d0       /* Initial Data-X  Inner loop*/
                mov.l #0x8167E123, %d1       
                mov.l #0xa5a5a5a5, %d2
                mov.l #0x00000000, %d3
                mov.l #0x00000000, %d4       /* Cumulative data results*/
                mov.l #0x00000000, %d5       /* Cumulative flag results*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                mov.l #0x0000001E, %d7       /* Outer loop counter*/
                mov.l #0x00000100, %a0       /* Address for memory EA operations*/
                mov.l #0x8167E123, %a1       /* Initial Data-Y  Outer loop*/

ADDA_OUTER1:    

    /* WORD      */
                /*mov.l %d1 , (%a0)       * !!! Easy68K is not altering the whole 32-bits of the address register*/
                /*adda.w (%a0) , %a1*/
                /*add.l %a1 , %d4               * Copy data results into data accumulator*/
 
    /* LONG      */
                mov.l %d1 , (%a0)
                adda.l (%a0) , %a1             
                add.l %a1 , %d4               /* Copy data results into data accumulator   */
                
                ror.l #0x1 , %d1
                dbf %d6 , ADDA_OUTER1
                ror.l #0x1 , %d1
                mov.l %d1 , %a1
                mov.l #0x8167E123, %d1       /* Initial Data-Y*/
                mov.l #0x0000001E, %d6       /* Inner loop counter*/
                dbf %d7 , ADDA_OUTER1
                
                cmpi.l #0xAC04DB4C , %d4      /* Check the data results*/
                bne TEST_FAIL
              
                 
                rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
