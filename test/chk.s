.include "entry.s"
/* OPCODE : CHK*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_CHK: 
            mov.w #0x1122, %d0
            mov.w #0x1122, %d1
            chk %d0 , %d1 
            
            nop
            nop
            
            mov.w #0x1122, %d1
            chk #0x1122 , %d1 
                    
    /* Comment out when using Easy68K*/
            mov.w #0x1122, %d1
            chk #00122 , %d1
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL                   /* branch if Z set*/

            mov.w #0x1122, %d0
            mov.w #0x8000, %d1
            chk %d0 , %d1
            cmp.l #0xEEEE0006 , %d6
            bne TEST_FAIL                   /* branch if Z set*/

            rts
      
                          
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
