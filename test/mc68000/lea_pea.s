.include "entry.s"
/* OPCODE : LEA_PEA*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_LEAPEA: 

            mov.l #0x00345678, %a0
            mov.l #0x00000000, %d4
            
    /* (An)      */
            lea (%a0) , %a6
            mov.l %a6 , %d0
            cmpi.l #0x00345678, %d0
            bne TEST_FAIL                   /* branch if Z set*/
            pea (%a0)
            cmpi.l #0x00345678, (%a7)
            bne TEST_FAIL                   /* branch if Z set*/
            addq #4 , %a7            /* Restore Stack Pointer*/
            
    /* x(An)     */
            lea 4(%a0) , %a6
            mov.l %a6 , %d0
            cmpi.l #0x0034567C, %d0
            bne TEST_FAIL                   /* branch if Z set*/
            pea 4(%a0)
            cmpi.l #0x0034567C, (%a7)
            bne TEST_FAIL                   /* branch if Z set*/
            addq #4 , %a7            /* Restore Stack Pointer         */

    /* x(An,Dn.l)        */
            lea 4(%a0,%d4) , %a6
            mov.l %a6 , %d0
            cmpi.l #0x0034567C, %d0
            bne TEST_FAIL                   /* branch if Z set*/
            pea 4(%a0,%d4.l)
            cmpi.l #0x0034567C, (%a7)
            bne TEST_FAIL                   /* branch if Z set*/
            addq #4 , %a7            /* Restore Stack Pointer*/
            
    /* x.W       */
            lea (0x1234) , %a6
            mov.l %a6 , %d0
            cmpi.w #0x1234, %d0
            bne TEST_FAIL                   /* branch if Z set*/
            pea (0x1234)
            cmpi.l #0x00001234, (%a7)
            bne TEST_FAIL                   /* branch if Z set*/
            addq #4 , %a7            /* Restore Stack Pointer*/
           
    /* x.L       */
            lea (0x00345678) , %a6
            mov.l %a6 , %d0
            cmp.l %a6, %d0
            bne TEST_FAIL                   /* branch if Z set*/
            pea (0x00345678)
            cmpi.l #0x00345678, (%a7)
            bne TEST_FAIL                   /* branch if Z set*/
            addq #4 , %a7            /* Restore Stack Pointer*/
           
    /* x(%pc)     */
            lea LEA1(%pc), %a6
            mov.l %a6 , %d0
            cmp.l %a6, %d0
            bne TEST_FAIL                   /* branch if Z set*/
LEA1:       pea LEA1(%pc)
            cmpi.l #0x0000241E, (%a7)
            beq TEST_FAIL                   /* branch if Z clear*/
            addq #4 , %a7            /* Restore Stack Pointer*/



          
            move #0x2700, %sr        /* Put flags back to initial value*/

            rts
    

             
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
