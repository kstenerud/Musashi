.include "entry.s"
/* OPCODE : SUB_I*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_SUB_I: 
    
    /* EA = Dn  - Byte*/
            mov.l #0x12345678 , %d0      /* populate test data*/
            subi.b #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0x10 , %d0                            
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0xA5 , %d0                            
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.b #0xC3 , %d0                            
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    /* EA = Dn  - WORD*/
            mov.l #0x12345678 , %d0      /* populate test data*/
            subi.w #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0x7000 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0xA55A , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.w #0x411E , %d0                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    /* EA = Dn  - LONG*/
            mov.l #0x12345678  , %d0      /* populate test data*/
            subi.l #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xF0000000 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0x855AA55A , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xA0000000 , %d0                          
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.l #0xFCD9B11E , %d0                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    

    /* EA = x.L  - Byte*/
            mov.l #0x000F0100 , %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            subi.b #0 , (0x000F0103)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0x10 , (0x000F0103)                         
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0xA5 , (0x000F0103)                         
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.b #0xC3 , (0x000F0103)                         
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    /* EA = x.L- WORD*/
            mov.l #0x000F0100 , %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            subi.w #0 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0x7000 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0xA55A , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.w #0xFCDA , (0x000F0100)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    /* EA = x.L- LONG*/
            mov.l #0x12345678  , (0x000F0100)  /* populate test data*/
            subi.l #0 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xF0000000 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0x855AA55A , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xA0000000 , (0x000F0100)                           
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.l #0xFCD9B11E , (0x000F0100)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
            rts
    
    

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
