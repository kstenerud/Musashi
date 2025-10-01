.include "entry.s"
/* OPCODE : SUB_I*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_SUB_I: 
    
.set SRC_LOC,   STACK2_BASE - 0x100
.set DST_LOCB,  SRC_LOC + 3

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
            mov.l #SRC_LOC , %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            subi.b #0 , (DST_LOCB)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0x10 , (DST_LOCB)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.b #0xA5 , (DST_LOCB)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.b #0xC3 , (DST_LOCB)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    /* EA = x.L- WORD*/
            mov.l #SRC_LOC, %a0      /* populate test data*/
            mov.l #0x12345678 ,(%a0)     /* populate test data*/
            subi.w #0 , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0x7000 , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.w #0xA55A , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.w #0xFCDA , (SRC_LOC)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
    
    /* EA = x.L- LONG*/
            mov.l #0x12345678  , (SRC_LOC)  /* populate test data*/
            subi.l #0 , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xF0000000 , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0x855AA55A , (SRC_LOC)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            subi.l #0xA0000000 , (SRC_LOC)
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            cmpi.l #0xFCD9B11E , (SRC_LOC)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
            rts
    
    

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
