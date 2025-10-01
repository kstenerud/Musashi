.include "entry.s"
/* OPCODE : NBCD*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_NBCD: 
    
       /* NBCD to a  Register*/
       
                mov.l #0x00000000, %d0 /* BCD byte*/
                mov.l #0x00000000, %d1 
                mov.l #0x00000000, %d2
                mov.l #0x00000000, %d3 /* Cumulative number of times Z was set*/
                mov.l #0x00000000, %d4 /* Cumulative number of times C was set*/
                mov.l #0x00000000, %d5 /* Cumulative BCD results*/
                mov.l #0x00000099, %d6
                mov.l #0x00000099, %d7 /* Loop counter*/

NBCD_LOOP:      mov.l %d7 , %d0
                move #0x04, %ccr        /* Set Z flag to 0*/

                nbcd %d0
                
                bcc NBCD_NO_C         /* Check C Flag */
                add.l #1 , %d4
NBCD_NO_C:      bne NBCD_NO_Z         /* Check Z Flag */
                add.l #1 , %d3
NBCD_NO_Z:      add.l %d0 , %d5         /* Add results into %d5*/

                dbf %d7 , NBCD_LOOP
                
                cmpi.l #0x00000001 , %d3  /* Check the cumulative results*/
                bne TEST_FAIL
                cmpi.l #0x00000099 , %d4
                bne TEST_FAIL
                cmpi.l #0x00002E3B , %d5
                bne TEST_FAIL
           

       /* NBCD to a memory location*/
       
                mov.l #0x00000000, %d0 /* BCD byte*/
                mov.l #0x00000000, %d1 
                mov.l #0x00000000, %d2
                mov.l #0x00000000, %d3 /* Cumulative number of times Z was set*/
                mov.l #0x00000000, %d4 /* Cumulative number of times C was set*/
                mov.l #0x00000000, %d5 /* Cumulative BCD results*/
                mov.l #0x00000099, %d6
                mov.l #0x00000099, %d7 /* Loop counter*/

NBCD_LOOP1:     mov.b %d7 , (0x00000100)
                move #0x04, %ccr        /* Set Z flag to 0*/

                nbcd (0x00000100)
                mov.b (0x00000100) , %d0
                
                bcc NBCD_NO_C1        /* Check C Flag */
                add.l #1 , %d4
NBCD_NO_C1:     bne NBCD_NO_Z1        /* Check Z Flag */
                add.l #1 , %d3
NBCD_NO_Z1:     add.l %d0 , %d5         /* Add results into %d5*/

                dbf %d7 , NBCD_LOOP1
                
                cmpi.l #0x00000001 , %d3  /* Check the cumulative results*/
                bne TEST_FAIL
                cmpi.l #0x00000000 , %d4
                bne TEST_FAIL
                cmpi.l #0x00002E3B , %d5
                bne TEST_FAIL
           

                rts   


               
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
