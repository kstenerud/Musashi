.include "entry.s"
/* OPCODE : ORI_TO_SR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_ORI_TO_SR: 

    ori.w #0x2FFF, %sr
    bpl TEST_FAIL     /* branch if Z clear*/
    bne TEST_FAIL     /* branch if N clear*/
    bvc TEST_FAIL     /* branch if V clear*/
    bcc TEST_FAIL     /* branch if C clear*/
    
    move #0x2000, %sr
    ori.w #0x0000, %sr
    beq TEST_FAIL     /* branch if Z set*/
    bmi TEST_FAIL     /* branch if N set*/
    bvs TEST_FAIL     /* branch if V set*/
    bcs TEST_FAIL     /* branch if C set*/
   
    move #0x2700, %sr        /* Put flags back to initial value*/

    rts
   

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
