.include "entry.s"
/* OPCODE : TRAPV*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_TRAPV: 

    /* TRAPV will set %d0 to 12345678 if V flag is set*/
    
                mov.l #0x00000000, %d0 /* Clear %d0*/
                
                move #0x00, %ccr        /* Clear V flag*/
                trapv
                cmpi.l #0x00000000 , %d0  /* Check of %d0 was updated (should not be_)*/
                bne TEST_FAIL

               /* Easy658K does not use exception vectors*/
                move #0x02, %ccr        /* Set V flag*/
                trapv
                cmpi.l #0x12345678 , %d0  /* Check of %d0 was updated (should not be_)*/
                bne TEST_FAIL


                rts   


               
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
