.include "entry.s"
/* OPCODE : NEGS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_NEGS: 

    /* NOT - BYTE*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            not.b %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.b %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.b #0x00 , %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.b #0x80 , (%a0)
            not.b (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.b #0x80 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

    /* NOT - WORD*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            not.w %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.w %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.w #0x0000 , %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.w #0x5a5a , (%a0)
            not.w (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.w (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.w #0x5a5a , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

    /* NOT - LONG*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            not.l %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.l %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.l #0x00000000 , %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.l #0x5a5a1234 , (%a0)
            not.l (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            not.l (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne*/
            cmpi.l #0x5a5a1234 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

/* ----- */

    /* NEG - BYTE*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x00000080, %d1
            neg.b %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcs TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            neg.b %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvc TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.b #0x80 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.b #0x7F , (%a0)
            neg.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.b #0xF5 , (%a0)
            neg.b (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.b #0x0B , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

/* -----         */

    /* NEG - WORD*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x00008000, %d1
            neg.w %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcs TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            neg.w %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvc TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.w #0x8000 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.w #0x7FFF , (%a0)
            neg.w (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.w #0xF578 , (%a0)
            neg.w (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.w #0x0A88 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

/* -----         */

    /* NEG - LONG*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x80000000, %d1
            neg.l %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcs TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            neg.l %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvc TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.l #0x80000000 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.l #0x7FFFFFFF , (%a0)
            neg.l (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.l #0xF5781234 , (%a0)
            neg.l (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.l #0x0A87EDCC , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/


/* -----         */

    /* NEGX - BYTE*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x00000080, %d1
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.b %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.b %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.b %d1
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.b #0x7F , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.b %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.b #0x81 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.b #0x7F , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.b #0x7F , (%a0)
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.b #0xF5 , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.b (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.b #0x0A , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.b (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.b #0xF6 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

    

/* -----         */

    /* NEGX - WORD*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x00008000, %d1
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.w %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.w %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.w %d1
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.w #0x7FFF , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.w %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.w #0x8001 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.w #0x7FFF , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.w (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.w #0xF567 , (%a0)            
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.w (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.w #0xF567 , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.w (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.w #0x0A98 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.w (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.w #0xF568 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

            
/* -----         */

    /* NEGX - LONG*/
            mov.l #0x00000100, %a0
            mov.l #0x00000000, %d0
            mov.l #0x80000000, %d1
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.l %d0
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.l %d0
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 1*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 1*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.l %d1
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.l #0x7FFFFFFF , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.l %d1
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 0*/
            cmpi.l #0x80000001 , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            mov.l #0x7FFF , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.l (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.l #0xF5671234 , (%a0)            
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.l (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 1*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            mov.l #0xF5675678 , (%a0)
            ori.b #0x10 , %ccr        /* Set X Flag*/
            negx.l (%a0)
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.l #0x0A98A987 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/
            andi.b #0xEF , %ccr       /* Clear X Flag*/
            negx.l (%a0)
            bpl TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            beq TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bcc TEST_FAIL                   /* Check C Flag  bcc/bcs 0*/
            bvs TEST_FAIL                   /* Check V Flag  bvc/bvs 1*/
            cmpi.l #0xF5675679 , (%a0)
            bne TEST_FAIL                   /* Check Z Flag  beq/bne*/

            
/* -----         */

    /* CLR - BYTE*/
            mov.l #0x00000100, %a0
            mov.l #0x12345678, %d0
            mov.l #0x12345678, %d1                   
            mov.l #0x12345678, %d2                   
            mov.l #0x12345600, %d4                   
            mov.l #0x12340000, %d5                   
            mov.l #0x00000000, %d6                   
            
            clr.b %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            cmp.l %d0 , %d4
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            
            clr.w %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            cmp.l %d1 , %d5
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            
            clr.l %d2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            bmi TEST_FAIL                   /* Check N Flag  bmi/bpl 0*/
            cmp.l %d2 , %d6
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/

            rts      
            
      
                          
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
