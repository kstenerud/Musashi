.include "entry.s"
/* OPCODE : BSET*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_BSET: 

.set SRC_LOC,   STACK2_BASE - 0x200
.set DST_LOC,   SRC_LOC + 0x100

/*  Bit Number Static */
    
            /* EA = Dn  - LONG only*/
            mov.l #0x00000000 , %d0      /* populate test data*/
            bset.l #0 , %d0              
            bne TEST_FAIL               /* branch if Z clear*/
            bset.l #1 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.l #15 , %d0             /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.l #31 , %d0             /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.l #0x80008003 , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x00 , (%a0)          /* populate test data*/
            bset.b #0 , (%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #7 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x81 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bset.b #0 , (%a0)+            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x02 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
 
        
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            bset.b #7 , -(%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #0 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000102 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x80 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x01 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/

        
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bset.b #0 , 0(%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #4 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x10 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/

                
            /* EA = n(An,D.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000004 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bset.b #0 , 0(%a0,%d0.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , 0(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #2 , 1(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,D.L)  - BYTE only*/
            bset.b #3 , 2(%a0,%d0.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #4 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #5 , 1(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.W)  - BYTE only*/
            bset.b #6 , 0(%a0,%a1.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , 0(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #7 , 1(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.L)  - BYTE only*/
            bset.b #0 , 2(%a0,%a2.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #0 , 3(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , 4(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.l #0x41122C00 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.l #0x02800101 , (%a0)+
            bne TEST_FAIL
 

        
            /* EA = x.W  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            bset.b #0 , (0x0100)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , (0x0100)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x03 , (%a0)+
            bne TEST_FAIL

            
            /* EA = x.L  - BYTE only*/
            mov.l #DST_LOC , %a0      /* point to memory to address 0x100 */
            mov.b #0x00 , (%a0)          /* populate test data*/
            bset.b #0 , (DST_LOC)
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #1 , (DST_LOC)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b #2 , (DST_LOC)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            cmpi.b #0x07 , (%a0)+
            bne TEST_FAIL


/* Bit Number Dynamic*/
    
            /* EA = Dn  - LONG only*/
            mov.l #0x00000000 , %d0      /* populate test data*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #31, %d7              /* populate bit number to test*/
            
            bset.l %d5 , %d0              
            bne TEST_FAIL               /* branch if Z clear*/
            bset.l %d6 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.l %d7 , %d0             /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.l #0x80000003 , %d0
            bne TEST_FAIL               /* branch if Z clear*/

            
            /* EA = (An)  - BYTE only*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test           */
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x00 , (%a0)          /* populate test data*/
            bset.b %d5 , (%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x83 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            
    
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            bset.b %d5 , (%a0)+            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x02 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x80 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            bset.b %d5 , -(%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000103 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x02 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x80 , -(%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            bset.b %d5 , 0(%a0)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , 2(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.b #0x01 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x02 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.b #0x80 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                
            /* EA = n(An,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            bset.b %d5 , 0(%a0,%d0.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , 0(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , 1(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,R.L)  - BYTE only*/
            bset.b %d5 , 2(%a0,%d0.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , 3(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , 4(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.W)  - BYTE only*/
            bset.b %d5 , 5(%a0,%a1.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , 6(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , 7(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(An,A.L)  - BYTE only*/
            bset.b %d5 , 8(%a0,%a1.l)  
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , 9(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , 10(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            cmpi.l #0x01028100 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
            cmpi.l #0x02810002 , (%a0)+
            bne TEST_FAIL
 
            
            /* EA = x.W  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            bset.b %d5 , (0x0100)            
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , (0x0100)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , (0x0100)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            cmpi.b #0x83 , (%a0)+
            bne TEST_FAIL               /* branch if Z clear*/
                    
            /* EA = x.L  - BYTE only*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            mov.b #0x00 , (%a0)+         /* populate test data*/
            bset.b %d5 , (DST_LOC)
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d6 , (DST_LOC)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            bset.b %d7 , (DST_LOC)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            cmpi.b #0x83 , (%a0)
            bne TEST_FAIL               /* branch if Z clear*/
                    

    rts


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
