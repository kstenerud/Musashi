.include "entry.s"
/* OPCODE : op_CMP_I*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_CMP_I: 

            mov.l #0x00000100 , %a0 
            mov.l #0x00000100 , (%a0) 
 
    /* REGISTER - BYTE*/
            mov.l #0xFFFFFF80 , %d0  
            cmpi.b #0x80 , %d0
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFFF000 , %d1  
            cmpi.b #0x00 , %d1
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFFFF02 , %d2  
            cmpi.b #0xFF , %d2
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0xFFFFFF7F , %d3  
            cmpi.b #0xFF , %d3
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
         
         
    /* REGISTER - WORD*/
            mov.l #0xFFFF8000 , %d0  
            cmpi.w #0x8000 , %d0
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFF00000 , %d1  
            cmpi.w #0x0000 , %d1
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFF0002 , %d2  
            cmpi.w #0xFFFF , %d2
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0xFFFF7FFF , %d3  
            cmpi.w #0xFFFF , %d3
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
    /* REGISTER - LONG*/
            mov.l #0x80000000 , %d0  
            cmpi.l #0x80000000 , %d0
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0x00000000 , %d1  
            cmpi.l #0x00000000 , %d1
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0x00000002 , %d2  
            cmpi.l #0xFFFFFFFF , %d2
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0x7FFFFFFF , %d3  
            cmpi.l #0xFFFFFFFF , %d3
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            
            

    /* EA=x(An,Dn) - BYTE*/
            mov.l #0x00000100 , %a0  
            mov.l #0x00000004 , %d7  
            
            mov.l #0xFFFFFF80 , 12(%a0,%d7)
            mov.l #0xFFFFFF80 , 12(%a0,%d7)
            cmpi.b #0x80 , 15(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFFF000 , 12(%a0,%d7)
            cmpi.b #0x00 , 15(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFFFF02 , 12(%a0,%d7)
            cmpi.b #0xFF , 15(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0xFFFFFF7F , 12(%a0,%d7)
            cmpi.b #0xFF , 15(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
         
         
    /* EA=x(An,Dn) - WORD*/
            mov.l #0xFFFF8000 , 12(%a0,%d7)
            cmpi.w #0x8000 , 14(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFF00000 , 12(%a0,%d7)
            cmpi.w #0x0000 , 14(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0xFFFF0002 , 12(%a0,%d7)
            cmpi.w #0xFFFF , 14(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0xFFFF7FFF , 12(%a0,%d7)
            cmpi.w #0xFFFF , 14(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
    /* EA=x(An,Dn) - LONG*/
            mov.l #0x80000000 , 12(%a0,%d7)
            cmpi.l #0x80000000 , 12(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0x00000000 , 12(%a0,%d7)
            cmpi.l #0x00000000 , 12(%a0,%d7)
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcs TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            mov.l #0x00000002 , 12(%a0,%d7)
            cmpi.l #0xFFFFFFFF , 12(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvs TEST_FAIL                       /* Check V Flag  bvc/bvs*/
                
            mov.l #0x7FFFFFFF , 12(%a0,%d7)
            cmpi.l #0xFFFFFFFF , 12(%a0,%d7)
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            bcc TEST_FAIL                       /* Check C Flag  bcc/bcs*/
            bvc TEST_FAIL                       /* Check V Flag  bvc/bvs*/
            
            
            
            
            rts
            
            
  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
