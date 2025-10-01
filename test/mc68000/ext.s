.include "entry.s"
/* OPCODE : EXT*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_EXT: 

            mov.l #0x0000007F, %d0
            mov.l #0x00008FFF, %d1
            mov.l #0x00000000, %d2
            
            ext.w %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.l #0x0000007F , %d0
            bne TEST_FAIL                   /* branch if Z set*/
            
            ext.l %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.l #0xFFFF8FFF , %d1
            bne TEST_FAIL                   /* branch if Z set*/
            
            ext.l %d2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/


            rts


             
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
