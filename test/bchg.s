.include "entry.s"
/* OPCODE : BCHG*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_BCHG: 

.set SRC_LOC,   STACK2_BASE - 0x200
.set DST_LOC,   SRC_LOC + 0x100

/*  Bit Number Static */
    
            /* EA = Dn  - LONG only*/
            mov.l #0x80000001 , %d0      /* populate test data*/
            bchg.l #0 , %d0              
            beq TEST_FAIL               /* branch if Z set*/
            bchg.l #1 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.l #31 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.l #0x00000002 , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x81 , (%a0)          /* populate test data*/
            mov.b (%a0) , %d1            /* Check to see if data in memory is 0x81*/
            bchg.b #0 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , (%a0)            /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.b #0x02 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bchg.b #0 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , (%a0)+           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
        
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            bchg.b #0 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000103 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
        
        
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bchg.b #0 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , 2(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
                
            /* EA = n(An,D.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            bchg.b #0 , 0(%a0,%d0.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #1 , 0(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #7 , 1(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,D.L)  - BYTE only*/
            bchg.b #0 , 0(%a0,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , 1(%a0,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.W)  - BYTE only*/
            bchg.b #0 , 0(%a0,%a1.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #1 , 0(%a0,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #7 , 1(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.L)  - BYTE only*/
            bchg.b #0 , 0(%a0,%a1.l)  
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , 0(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , 1(%a0,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
    
        
            /* EA = x.W  - BYTE only*/
            bchg.b #0 , (0x0100)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #1 , (0x0101)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #7 , (0x0102)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x80 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = x.L  - BYTE only*/
            mov.l #SRC_LOC , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            bchg.b #0 , (SRC_LOC)
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b #1 , (SRC_LOC+1)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b #7 , (SRC_LOC+2)       /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x80 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            

/* Bit Number Dynamic*/
    
            /* EA = Dn  - LONG only*/
            mov.l #0x80000001 , %d0      /* populate test data*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #31, %d7              /* populate bit number to test*/
            
            bchg.l %d5 , %d0              
            beq TEST_FAIL               /* branch if Z set*/
            bchg.l %d6 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.l %d7 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.l #0x00000002 , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test           */
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x81 , (%a0)          /* populate test data*/
            mov.b (%a0) , %d1            /* Check to see if data in memory is 0x81*/
            bchg.b %d5 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , (%a0)            /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.b #0x02 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
    
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bchg.b %d5 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , (%a0)+           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            bchg.b %d5 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000103 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bchg.b %d5 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , 2(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFE , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            bchg.b %d5 , 0(%a0,%d0.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d6 , 0(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d7 , 1(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,R.L)  - BYTE only*/
            bchg.b %d5 , 0(%a0,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , 1(%a0,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.W)  - BYTE only*/
            bchg.b %d5 , 0(%a0,%a1.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d6 , 0(%a0,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d7 , 1(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.L)  - BYTE only*/
            bchg.b %d5 , 0(%a0,%a1.l)  
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , 0(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , 1(%a0,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            cmpi.b #0x00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = x.W  - BYTE only*/
            bchg.b %d5 , (0x0100)            
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d6 , (0x0101)           /* */
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d7 , (0x0102)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0xFC , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                    
            /* EA = x.L  - BYTE only*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            bchg.b %d5 , (DST_LOC)
            beq TEST_FAIL               /* branch if Z set*/
            bchg.b %d6 , (DST_LOC+1)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bchg.b %d7 , (DST_LOC+2)       /* */
            beq TEST_FAIL               /* branch if Z set*/
            mov.l #DST_LOC+1, %a0      /* point to memory to address 0x100 */
            cmpi.b #0xFE , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                    

    rts


  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
