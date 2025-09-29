.include "entry.s"
/* OPCODE : ADD_I*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_ADD_I: 
    
    /* EA = Dn  - Byte*/
            mov.l #0x12345678 , %d0      /* populate test data*/
            addi.b #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.b #0x10 , %d0                            
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.b #0xA5 , %d0                            
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.b #0x2D , %d0                            
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    /* EA = Dn  - WORD*/
            mov.l #0x12345678 , %d0      /* populate test data*/
            addi.w #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.w #0x7000 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.w #0xA55A , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.w #0x6BD2 , %d0                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    /* EA = Dn  - LONG*/
            mov.l #0x12345678  , %d0      /* populate test data*/
            addi.l #0 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0xF0000000 , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0x855AA55A , %d0                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0xA0000000 , %d0                          
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.l #0x278EFBD2 , %d0                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    

    /* EA = x.L  - Byte*/
            mov.l #0x000F0100 , %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            addi.b #0 , (0x000F0103)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.b #0x10 , (0x000F0103)                         
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.b #0xA5 , (0x000F0103)                         
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.b #0x2D , (0x000F0103)                         
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    /* EA = x.L- WORD*/
            mov.l #0x000F0100 , %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            addi.w #0 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.w #0x7000 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.w #0xA55A , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.w #0x278E , (0x000F0100)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    /* EA = x.L- LONG*/
            mov.l #0x12345678  , (0x000F0100)  /* populate test data*/
            addi.l #0 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0xF0000000 , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0x855AA55A , (0x000F0100)                           
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            addi.l #0xA0000000 , (0x000F0100)                           
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.l #0x278EFBD2 , (0x000F0100)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
            rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
