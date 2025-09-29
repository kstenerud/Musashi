.include "entry.s"
/* OPCODE : EORI_TO_SR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_EORI_TO_SR: 

    move #0x2000, %sr
    eori.w #0x0FFF, %sr
    bpl TEST_FAIL     /* branch if Z clear*/
    bne TEST_FAIL     /* branch if N clear*/
    bvc TEST_FAIL     /* branch if V clear*/
    bcc TEST_FAIL     /* branch if C clear*/
    
    move #0x2000, %sr
    eori.w #0x0000, %sr
    beq TEST_FAIL     /* branch if Z set*/
    bmi TEST_FAIL     /* branch if N set*/
    bvs TEST_FAIL     /* branch if V set*/
    bcs TEST_FAIL     /* branch if C set*/
   
    move #0x2700, %sr        /* Put flags back to initial value*/

    rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
