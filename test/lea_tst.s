.include "entry.s"
/* OPCODE : LEA_TST*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_TST: 

    /* Test just one addressing mode*/

            mov.l #0x00000100, %a0
            
    /* (An) - BYTE       */
            mov.b #0x00 , (%a0)
            tst.b (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.b #0xF5 , (%a0)
            tst.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            
    /* (An) - WORD       */
            mov.w #0x0000 , (%a0)
            tst.w (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.w #0xF567 , (%a0)
            tst.w (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            
    /* (An) - LONG       */
            mov.l #0x00000000 , (%a0)
            tst.l (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.l #0xF56789ab , (%a0)
            tst.l (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/


            rts
    
     
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
