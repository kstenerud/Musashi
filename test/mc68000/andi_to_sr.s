.include "entry.s"
/* OPCODE : ANDI_TO_SR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_ANDI_TO_SR: 
    move #0x20FF, %sr
    andi.w #0xFFFF, %sr
    bpl TEST_FAIL     /* branch if Z clear*/
    bne TEST_FAIL     /* branch if N clear*/
    bvc TEST_FAIL     /* branch if V clear*/
    bcc TEST_FAIL     /* branch if C clear*/
    
    move #0x20FF, %sr
    andi.w #0xFF00, %sr
    beq TEST_FAIL     /* branch if Z set*/
    bmi TEST_FAIL     /* branch if N set*/
    bvs TEST_FAIL     /* branch if V set*/
    bcs TEST_FAIL     /* branch if C set*/
   
    move #0x2700, %sr         /* Put flags back to initial value*/

    rts
    
  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
