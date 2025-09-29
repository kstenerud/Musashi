.include "entry.s"
/* OPCODE : BCLR*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_BCLR: 


/*  Bit Number Static */
            /* Status of memory at 0x100 after BCHG*/
            /* Need to be initialized here since we want to run the tests independently.*/
            mov.l #0x00000100 , %a0
            mov.l #0x01fc8000, (%a0)
    
            /* EA = Dn  - LONG only*/
            mov.l #0xFF0000FF , %d0      /* populate test data*/
            bclr.l #0 , %d0              
            beq TEST_FAIL               /* branch if Z set*/
            bclr.l #1 , %d0              /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.l #15 , %d0             /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.l #31 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.l #0x7F0000FC , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x0F , (%a0)          /* populate test data*/
            bclr.b #0 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #7 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x0E , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bclr.b #0 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
 
        
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            bclr.b #7 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #0 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000102 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/

        
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bclr.b #0 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #4 , 1(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xEF , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/

                
            /* EA = n(An,D.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bclr.b #0 , 0(%a0,%d0.w)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , 0(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #2 , 1(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,D.L)  - BYTE only*/
            bclr.b #3 , 0(%a0,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #4 , 0(%a0,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #5 , 1(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.W)  - BYTE only*/
            bclr.b #6 , 0(%a0,%a1.w)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , 0(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b #7 , 1(%a0,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.L)  - BYTE only*/
            bclr.b #0 , 0(%a0,%a1.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b #0 , 0(%a0,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , 1(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0xB6 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xEC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x59 , (%a0)+
            beq TEST_FAIL               /* branch if Z set*/
    
        
            /* EA = x.W  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            bclr.b #0 , (0x0100)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , (0x0100)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = x.L  - BYTE only*/
            mov.l #0x000F0100 , %a0      /* point to memory to address 0x100 */
            mov.b #0xFF , (%a0)          /* populate test data*/
            bclr.b #0 , (0x000F0100) 
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #1 , (0x000F0100)       /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b #2 , (0x000F0100)       /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x000F0100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0xF8 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/


/* Bit Number Dynamic*/
    
            /* EA = Dn  - LONG only*/
            mov.l #0xFF00FF00 , %d0      /* populate test data*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #31, %d7              /* populate bit number to test*/
            
            bclr.l %d5 , %d0              
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.l %d6 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.l %d7 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.l #0x7F00FF00 , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test           */
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x81 , (%a0)          /* populate test data*/
            bclr.b %d5 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , (%a0)            /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.b #0x00 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
    
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bclr.b %d5 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , (%a0)+           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            bclr.b %d5 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000103 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bclr.b %d5 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , 2(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            bclr.b %d5 , 0(%a0,%d0.w)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , 0(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d7 , 1(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,R.L)  - BYTE only*/
            bclr.b %d5 , 0(%a0,%d0.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d6 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , 1(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.W)  - BYTE only*/
            bclr.b %d5 , 0(%a0,%a1.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d6 , 0(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , 1(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.L)  - BYTE only*/
            bclr.b %d5 , 0(%a0,%a1.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d6 , 0(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , 1(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address */
            cmpi.b #0xFE , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = x.W  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            mov.b #0xFF , (%a0)+         /* populate test data*/
            bclr.b %d5 , (0x0100)            
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , (0x0101)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d7 , (0x0102)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                    
            /* EA = x.L  - BYTE only*/
            mov.l #0x000F0100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            bclr.b %d5 , (0x000F0100) 
            beq TEST_FAIL               /* branch if Z set*/
            bclr.b %d6 , (0x000F0101)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bclr.b %d7 , (0x000F0102)       /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x000F0101 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0xFC , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                    


    rts
    




  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
