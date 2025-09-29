.include "entry.s"
/* OPCODE : BSR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
                bra op_BSR

BSR_FAR1:       mov.l #0x33333333 , %d3
                rts

.skip 0x100  /* Gas only. Ensure BSR_FAR1 is actually far*/
     
BSR_CLOSE1:     mov.l #0x11111111 , %d1
                rts
 


op_BSR:         bsr.s BSR_CLOSE1        /* Negative 8-bit displacement*/
                bsr.s BSR_CLOSE2        /* Positive 8-bit displacement*/
                bsr.w BSR_FAR1          /* Negative 16-bit displacement*/
                bsr.w BSR_FAR2          /* Positive 16-bit displacement*/
                
                cmpi.l #0x11111111 , %d1
                bne TEST_FAIL
                cmpi.l #0x22222222 , %d2
                bne TEST_FAIL
                cmpi.l #0x33333333 , %d3
                bne TEST_FAIL
                cmpi.l #0x44444444 , %d4
                bne TEST_FAIL
                   
                rts   
                
                
BSR_CLOSE2:     mov.l #0x22222222 , %d2
                rts


.skip 0x100  /* Gas only. Ensure BSR_FAR2 is actually far*/


BSR_FAR2:       mov.l #0x44444444 , %d4
                rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
