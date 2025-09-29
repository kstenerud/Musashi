.include "entry.s"
/* OPCODE : BOOL_I*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_BOOL_I: 
        
    /* Dn -- BYTE*/
            mov.l #0x12345678 , %d0  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.b  #0xFF , %d0
            eori.b #0x5A , %d0
            and.b  #0xF0 , %d0
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.b  #0x00 , %d0
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/

    /* Dn -- WORD*/
            mov.l #0x12345678 , %d1  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.w  #0xFFFF , %d1
            eori.w #0x5A5A , %d1
            and.w  #0xF0F0 , %d1
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.w  #0x0000 , %d1
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/

    /* Dn -- LONG*/
            mov.l #0x12345678 , %d2  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.l  #0xFFFFFFFF , %d2
            eori.l #0x5A5A5A5A , %d2
            and.l  #0xF0F0F0F0 , %d2
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.l  #0x00000000 , %d2
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/

    
    /* (An) -- BYTE*/
            mov.l #0x00000100 , %a0  
            mov.l #0x12345678 , (%a0)  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.b  #0xFF , (%a0)
            eori.b #0x5A , (%a0)
            and.b  #0xF0 , (%a0)
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.b  #0x00 , (%a0)
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            cmpi.b #0x00 , (%a0)
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            
    /* (An) -- WORD*/
            mov.l #0x12345678 , (%a0)  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.w  #0xFFFF , (%a0)
            eori.w #0x5A5A , (%a0)
            and.w  #0xF0F0 , (%a0)
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.w  #0x0000 , (%a0)
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            cmpi.w #0x00 , (%a0)
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            
    /* (An) -- LONG*/
            mov.l #0x12345678 , (%a0)  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            ori.l  #0xFFFFFFFF , (%a0)
            eori.l #0x5A5A5A5A , (%a0)
            and.l  #0xF0F0F0F0 , (%a0)
            bvs TEST_FAIL                       /* Check V,C are cleared*/
            bcs TEST_FAIL
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            and.l  #0x00000000 , (%a0)
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            cmpi.l #0x00 , (%a0)
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            


    /* (An)+ -- BYTE*/
            mov.l #0x00000100 , %a0  
            mov.l #0x00A5FF88 , (%a0)  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            
            ori.b  #0xF5 , (%a0)+
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            eori.b #0xFF , (%a0)+
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            and.b  #0xAA , (%a0)+
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            mov.l #0x00000100 , %a0  
            cmpi.l #0xF55AAA88 , (%a0)
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            
            
    /* (An)+ -- WORD*/
            mov.l #0x00000100 , %a0  
            mov.l #0x00000104 , %a1  
            mov.l #0x00005a5a , (%a0)  
            mov.l #0x12345678 , (%a1)  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            
            ori.w  #0x5678 , (%a0)+
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            eori.w #0xFFFF , (%a0)+
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            and.w  #0xA55A , (%a0)+
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            mov.l #0x00000100 , %a0  
            cmpi.l #0x5678a5a5 , (%a0)
            mov.l #0x00000104 , %a0  
            cmpi.l #0x00105678 , (%a0)
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            
    /* (An)+ -- LONG*/
            mov.l #0x00000100 , %a0  
            mov.l #0x00000000 , (%a0)+  
            mov.l #0x5a5a5a5a , (%a0)+  
            mov.l #0xFFFFFFFF , (%a0)+  
            mov.l #0x00000100 , %a0  
            mov.w #0x000F, %ccr          /* pre-set Flags*/
            
            ori.l  #0x12345678 , (%a0)+
            bmi TEST_FAIL                       /* Verify if N flag is cleared*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            eori.l #0xFFFFFFFF , (%a0)+
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            and.l  #0xA5A5A55A , (%a0)+
            bpl TEST_FAIL                       /* Verify if N flag is set*/
            beq TEST_FAIL                       /* Verify if Z flag is cleared*/
            
            mov.l #0x00000100 , %a0  
            cmpi.l #0x12345678 , (%a0)+
            cmpi.l #0xa5a5a5a5 , (%a0)+
            cmpi.l #0xa5a5a55a , (%a0)+
            bne TEST_FAIL                       /* Verify if Z flag is set*/
            
            rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
