.include "entry.s"
/* OPCODE : LEA_TAS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_TAS: 

    /* Test just one addressing mode*/

            mov.l #0x00000100, %a0
            
    /* (An)      */
            mov.b #0x00 , (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            tas (%a0)
            cmpi.b #0x80, (%a0)
            bne TEST_FAIL                   /* branch if Z set*/
            mov.b #0xF5 , (%a0)
            tas (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            tas (%a0)
            cmpi.b #0xF5, (%a0)
            bne TEST_FAIL                   /* branch if Z set*/

            rts
            
     
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
