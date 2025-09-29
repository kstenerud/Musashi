.include "entry.s"
/* OPCODE : SBCD*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_SBCD: 

    /* Test with X Flag CLEARED*/
                mov.l #0x00000110, %a0 /* Address pointer-X*/
                mov.l #0x00000120, %a1 /* Address pointer-Y*/
                mov.l #0x00000000, %d0 /* BCD byte-X*/
                mov.l #0x00000000, %d1 /* BCD byte-Y*/
                mov.l #0x00000000, %d2
                mov.l #0x00000000, %d3 /* Cumulative -(An) BCD results*/
                mov.l #0x00000000, %d4 /* Cumulative number of times C was set*/
                mov.l #0x00000000, %d5 /* Cumulative Register BCD results*/
                mov.l #0x00000099, %d6 /* Inner loop counter*/
                mov.l #0x00000099, %d7 /* Outer loop counter*/

SBCD_OUTER1:    mov.l %d7 , %d0
SBCD_INNER1:    mov.l %d6 , %d1
                andi.b #0xEF , %ccr     /* Clear X Flag*/
                mov.l #0x00000110, %a0 /* Address pointer-X*/
                mov.l #0x00000120, %a1 /* Address pointer-Y*/
                mov.b %d0 , -1(%a0)
                mov.b %d1 , -1(%a1)
                
                sbcd %d0 , %d1
                bcc SBCD_NO_C1          /* Check C Flag  bcc/bcs 0*/
                add.l #1 , %d4
SBCD_NO_C1:     add.l %d1 , %d5
                
                sbcd -(%a0) , -(%a1)
                bcc SBCD_NO_C2          /* Check C Flag  bcc/bcs 0*/
                add.l #1 , %d4
SBCD_NO_C2:     add.b (%a1) , %d3


                dbf %d6 , SBCD_INNER1
                mov.l #0x00000099, %d6
                dbf %d7 , SBCD_OUTER1
                cmpi.l #0x00005D18 , %d4  /* Check the cumulative results*/
                bne TEST_FAIL
                cmpi.l #0x001BE6B2 , %d5
                bne TEST_FAIL
                cmpi.l #0x000000B2 , %d3
                bne TEST_FAIL

    /* Test with X Flag SET*/
                mov.l #0x00000110, %a0 /* Address pointer-X*/
                mov.l #0x00000120, %a1 /* Address pointer-Y*/
                mov.l #0x00000000, %d0 /* BCD byte-X*/
                mov.l #0x00000000, %d1 /* BCD byte-Y*/
                mov.l #0x00000000, %d2
                mov.l #0x00000000, %d3 /* Cumulative -(An) BCD results*/
                mov.l #0x00000000, %d4 /* Cumulative number of times C was set*/
                mov.l #0x00000000, %d5 /* Cumulative Register BCD results*/
                mov.l #0x00000099, %d6 /* Inner loop counter*/
                mov.l #0x00000099, %d7 /* Outer loop counter*/

SBCD_OUTER2:    mov.l %d7 , %d0
SBCD_INNER2:    mov.l %d6 , %d1
                ori.b #0x10 , %ccr      /* Set X Flag*/
                mov.l #0x00000110, %a0 /* Address pointer-X*/
                mov.l #0x00000120, %a1 /* Address pointer-Y*/
                mov.b %d0 , -1(%a0)
                mov.b %d1 , -1(%a1)
                
                sbcd %d0 , %d1
                bcc SBCD_NO_C3          /* Check C Flag  bcc/bcs 0*/
                add.l #1 , %d4
SBCD_NO_C3:     add.l %d1 , %d5
                
                sbcd -(%a0) , -(%a1)
                bcc SBCD_NO_C4          /* Check C Flag  bcc/bcs 0*/
                add.l #1 , %d4
SBCD_NO_C4:     add.b (%a1) , %d3

                dbf %d6 , SBCD_INNER2
                mov.l #0x00000099, %d6
                dbf %d7 , SBCD_OUTER2
                cmpi.l #0x00005DE8 , %d4  /* Check the cumulative results*/
                bne TEST_FAIL
                cmpi.l #0x001BF5E2 , %d5
                bne TEST_FAIL
                cmpi.l #0x000000B2 , %d3
                bne TEST_FAIL


            /* Quick check of Z Flag*/
                mov.b #0x00, %d0 
                mov.b #0x00, %d1 
                move #0x00, %ccr              /* Set Z flag to 0*/
                sbcd %d1,%d0                  /* Should NOT set Z Flag to 1*/
                beq TEST_FAIL                       /* Check Z Flag  beq/bne*/

                mov.b #0x01, %d0 
                mov.b #0x00, %d1 
                move #0x04, %ccr              /* Set Z flag to 0*/
                sbcd %d1,%d0                  /* Should NOT set Z Flag to 1*/
                beq TEST_FAIL                       /* Check Z Flag  beq/bne*/

                rts   
               
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
