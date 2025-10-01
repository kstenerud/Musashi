.include "entry.s"
/* OPCODE : RTR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_RTR: 

    /* Leventhal claims only 5 LSB's are popped from the stack to the %ccr*/
    
                lea RTR_DONE , %a0
                mov.l %a0, -(%a7)     /* push destination %pc to the stack*/
                mov.w #0xFF15 , -(%a7)       /* push flags=0xFFFF to the stack*/
                rtr

RTR_DONE:       move %sr , %d0
                andi #0x1F , %d0
                cmpi #0x15 , %d0
                bne TEST_FAIL
                
                rts   


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
