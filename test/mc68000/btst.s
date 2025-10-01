.include "entry.s"
/* OPCODE : BTST*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_BTST: 

.set SRC_LOC,   STACK2_BASE - 0x200
.set DST_LOC,   SRC_LOC + 0x100

/*  Bit Number Static */
    
            /* EA = Dn  - LONG only*/
            mov.l #0x80000001 , %d0      /* populate test data*/
            btst.l #0 , %d0              
            beq TEST_FAIL               /* branch if Z set*/
            btst.l #1 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.l #31 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            
            
            /* EA = (An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x81 , (%a0)          /* populate test data*/
            mov.b (%a0) , %d1            /* Check to see if data in memory is 0x81*/
            btst.b #0 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , (%a0)            /* */
            beq TEST_FAIL               /* branch if Z set*/
            
            
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            btst.b #0 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , (%a0)+           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            btst.b #0 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            btst.b #0 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , 2(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = n(An,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            btst.b #0 , 0(%a0,%d0.w)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , 0(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , 1(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,R.L)  - BYTE only*/
            btst.b #0 , 0(%a0,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , 1(%a0,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.W)  - BYTE only*/
            btst.b #0 , 0(%a0,%a1.w)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , 0(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , 1(%a0,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.L)  - BYTE only*/
            btst.b #0 , 0(%a0,%a1.l)  
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , 0(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , 1(%a0,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x.W  - BYTE only*/
            btst.b #0 , (0x0100)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , (0x0101)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , (0x0102)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x.L  - BYTE only*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            btst.b #0 , (DST_LOC)
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #1 , (DST_LOC+1)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #7 , (DST_LOC+2)       /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x(%pc)  - BYTE only*/
            lea op_BTST(%pc) , %a5
            btst.b #0 , op_BTST(%pc) 
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b #3 ,op_BTST0(%pc)     /* */
            beq TEST_FAIL               /* branch if Z set*/
            btst.b #6 , op_BTST12(%pc)    /* */
            beq TEST_FAIL               /* branch if Z set*/
  
  
            /* EA = n(%pc,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
    
op_BTST0:   btst.b #0 , op_BTST0(%pc,%d0.w)            
            bne TEST_FAIL               /* branch if Z clear*/
            
            lea op_BTST1(%pc,%d1.w) , %a5
op_BTST1:   btst.b #1 , op_BTST1(%pc,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST2:   btst.b #7 , op_BTST2(%pc,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,R.L)  - BYTE only*/
op_BTST3:   btst.b #0 , op_BTST3(%pc,%d0.l)  
            bne TEST_FAIL               /* branch if Z clear*/
op_BTST4:   btst.b #1 , op_BTST4(%pc,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST5:   btst.b #7 , op_BTST5(%pc,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,A.W)  - BYTE only*/
op_BTST6:   btst.b #0 , op_BTST6(%pc,%a1.w)
            bne TEST_FAIL               /* branch if Z clear*/
op_BTST7:   btst.b #1 , op_BTST7(%pc,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST8:   btst.b #7 , op_BTST8(%pc,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,A.L)  - BYTE only*/
op_BTST9:   btst.b #0 , op_BTST9(%pc,%a1.l)  
            bne TEST_FAIL               /* branch if Z clear*/
op_BTST10:  btst.b #1 , op_BTST10(%pc,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST11:  btst.b #7 , op_BTST11(%pc,%a2.l)      /* */
op_BTST12:  bne TEST_FAIL               /* branch if Z clear*/
 


/* Bit Number Dynamic*/
    
            /* EA = Dn  - LONG only*/
            mov.l #0x80000001 , %d0      /* populate test data*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #31, %d7              /* populate bit number to test*/
            
            btst.l %d5 , %d0              
            beq TEST_FAIL               /* branch if Z set*/
            btst.l %d6 , %d0              /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.l %d7 , %d0             /* */
            beq TEST_FAIL               /* branch if Z set*/
            
            
            /* EA = (An)  - BYTE only*/
            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test           */
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100*/
            mov.b #0x81 , (%a0)          /* populate test data*/
            mov.b (%a0) , %d1            /* Check to see if data in memory is 0x81*/
            btst.b %d5 , (%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , (%a0)            /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , (%a0)            /* */
            beq TEST_FAIL               /* branch if Z set*/
            
/* ---*/

    
            /* EA = (An)+  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address 0x100 */
            btst.b %d5 , (%a0)+            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , (%a0)+           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , (%a0)+           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = -(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.l #0x00000103 , %a0      /* point to memory to address */
            btst.b %d5 , -(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , -(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , -(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = n(An)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            btst.b %d5 , 0(%a0)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , 1(%a0)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , 2(%a0)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = n(An,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            btst.b %d5 , 0(%a0,%d0.w)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , 0(%a0,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , 1(%a0,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,R.L)  - BYTE only*/
            btst.b %d5 , 0(%a0,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , 0(%a0,%d1.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , 1(%a0,%d1.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.W)  - BYTE only*/
            btst.b %d5 , 0(%a0,%a1.w)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , 0(%a0,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , 1(%a0,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
            /* EA = n(An,A.L)  - BYTE only*/
            btst.b %d5 , 0(%a0,%a1.l)  
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , 0(%a0,%a2.l)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , 1(%a0,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x.W  - BYTE only*/
            btst.b %d5 , (0x0100)            
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , (0x0101)           /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , (0x0102)           /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x.L  - BYTE only*/
            mov.l #DST_LOC, %a0      /* point to memory to address 0x100 */
            mov.b #0x01 , (%a0)+         /* populate test data*/
            mov.b #0xFC , (%a0)+         /* populate test data*/
            mov.b #0x80 , (%a0)+         /* populate test data*/
            btst.b %d5 , (DST_LOC)
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d6 , (DST_LOC+1)       /* */
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d7 , (DST_LOC+2)       /* */
            beq TEST_FAIL               /* branch if Z set*/
        
        
            /* EA = x(%pc)  - BYTE only*/
            mov.l #3,  %d6              /* populate bit number to test*/
            mov.l #6,  %d7              /* populate bit number to test*/
            lea op_BTST(%pc) , %a5
            btst.b %d5 , op_BTST(%pc) 
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d6 ,op_BTST0(%pc)     /* */
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d7 , op_BTST12(%pc)    /* */
            beq TEST_FAIL               /* branch if Z set*/
  
  
            /* EA = n(%pc,R.W)  - BYTE only*/
            mov.l #0x00000100 , %a0      /* point to memory to address*/
            mov.l #0x00000000 , %a1      /* point to memory to address*/
            mov.l #0x00000001 , %a2      /* point to memory to address*/
            mov.l #0x00000000 , %d0      /* point to memory to address*/
            mov.l #0x00000001 , %d1      /* point to memory to address*/
            mov.l #1,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test*/
    
op_BTST20:  btst.b %d5 , op_BTST20(%pc,%d0.w)            
            beq TEST_FAIL               /* branch if Z set*/
            lea op_BTST21(%pc,%d1.w) , %a5
op_BTST21:  btst.b %d6 , op_BTST21(%pc,%d1.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST22:  btst.b %d7 , op_BTST22(%pc,%d1.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,R.L)  - BYTE only*/
op_BTST23:  btst.b %d5 , op_BTST23(%pc,%d0.l)  
            beq TEST_FAIL               /* branch if Z set*/
op_BTST24:  btst.b %d6 , op_BTST24(%pc,%d1.l)      /**/
            beq TEST_FAIL               /* branch if Z set*/
op_BTST25:  btst.b %d7 , op_BTST25(%pc,%d1.l)      /**/
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,A.W)  - BYTE only*/
op_BTST26:  btst.b %d5 , op_BTST26(%pc,%a1.w)
            beq TEST_FAIL               /* branch if Z set*/
op_BTST27:  btst.b %d6 , op_BTST27(%pc,%a2.w)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST28:  btst.b %d7 , op_BTST28(%pc,%a2.w)      /* */
            bne TEST_FAIL               /* branch if Z clear*/
            /* EA = n(%pc,A.L)  - BYTE only*/
op_BTST29:  btst.b %d5 , op_BTST29(%pc,%a1.l)  
            beq TEST_FAIL               /* branch if Z set*/
op_BTST30:  btst.b %d6 , op_BTST30(%pc,%a2.l)      /* */
            beq TEST_FAIL               /* branch if Z set*/
op_BTST31:  btst.b %d7 , op_BTST31(%pc,%a2.l)      /* */
op_BTST32:  bne TEST_FAIL               /* branch if Z clear*/
 
            /* EA = #x  - BYTE only*/

            mov.l #0,  %d5              /* populate bit number to test*/
            mov.l #3,  %d6              /* populate bit number to test*/
            mov.l #7,  %d7              /* populate bit number to test*/
            
            btst.b %d5 , #0x88
            bne TEST_FAIL               /* branch if Z clear*/
            btst.b %d6 , #0x88
            beq TEST_FAIL               /* branch if Z set*/
            btst.b %d7 , #0x88
            beq TEST_FAIL               /* branch if Z set*/
            

    rts
 
 
  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
