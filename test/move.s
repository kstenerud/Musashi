.include "entry.s"
/* OPCODE : MOVE*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_MOVE: 
            mov.l #0x11223344  , %d0
            mov.l #0x55667788  , %d1
            mov.l #0x8899aabb  , %d2
            mov.l #0xccddeeff  , %d3
            mov.l #0x00000000  , %d4
            mov.l #0x00000000  , %d5
            mov.l #0x00000000  , %d6
            mov.l #0x00000000  , %d7         
            mov.l #0x44332211  , %a0
            mov.l #0x88776655  , %a1
            mov.l #0xbbaa9988  , %a2
            mov.l #0xffeeddcc  , %a3
            
            mov.b %d0 , %d4              /* BYTE - DATA REGISTER*/
            beq TEST_FAIL               /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL               /* Check N Flag  bmi/bpl*/
            cmpi.l #0x00000044 , %d4                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
            mov.w %d1 , %d5              /* WORD - DATA REGISTER*/
            beq TEST_FAIL               /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL               /* Check N Flag  bmi/bpl*/
            cmpi.l #0x00007788 , %d5                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
            mov.l %d2 , %d6              /* LONG - DATA REGISTER*/
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x8899aabb , %d6                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/

            mov.w %a1 , %d5              /* WORD - ADDRESS REGISTER*/
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x00006655 , %d5                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
            mov.l %a2 , %d6              /* LONG - ADDRESS REGISTER*/
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0xbbaa9988  , %d6                         
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
            
    
            movea.w %d2 , %a4             /* WORD - ADDRESS REGISTER as SOURCE ## MOVEA*/
            cmpa.l %d2 , %a4                          
            beq TEST_FAIL                       /* Check Z Flag  beq/bne ## comopare fails because %a4 was sign extended*/
        
            movea.l %d1 , %a5             /* LONG - ADDRESS REGISTER as SOURCE ## MOVEA*/
            cmpa.l %d1  , %a5                         
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        


  /* Too mamy EA combinations to test, so we focus on a few of the more complicted EA's */
  
            mov.l #0x11223344  , %d0
            mov.l #0x00010100  , %d1
            mov.l #0x8899aabb  , %d2
            mov.l #0x00000001  , %d3
            mov.l #0x00000000  , %d4
            mov.l #0x00000000  , %d5
            mov.l #0x00000000  , %d6
            mov.l #0x00000000  , %d7         
            mov.l #0x00000000  , %a0
            mov.l #0x00010100  , %a1

    /* x(An,AL) --> x.L*/
            mov.b #0x5A , 4(%a0,%a1.l)    /* BYTE */
            lea 4(%a0,%a1.l) , %a3    
            mov.b 4(%a0,%a1.l) , (0x00010105)    
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.b #0x5A , 5(%a0,%a1.l)                            
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x.L --> n(An,Dw)*/
MOVE2:      mov.b  (0x00010105) , 7(%a0,%d1.w)    /* BYTE  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.b #0x5A , 7(%a0,%d1.w)                            
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x(%pc,Ds) --> x.w*/
            mov.b  MOVE1(%pc,%d3), (0x0100) /* BYTE  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bpl TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.b #0xB9 ,1+MOVE2                            
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                    
    /* #x -->    n(An,AL)*/
            mov.b  #0x78, 7(%a0,%d1.w)    /* BYTE  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.b #0x78 ,7(%a0,%d1.w)                         
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
            mov.l #0x11223344  , %d0
            mov.l #0x00010100  , %d1
            mov.l #0x8899aabb  , %d2
            mov.l #0x00000002  , %d3
            mov.l #0x00000000  , %d4
            mov.l #0x00000000  , %d5
            mov.l #0x00000000  , %d6
            mov.l #0x00000000  , %d7         
            mov.l #0x00000000  , %a0
            mov.l #0x00010100  , %a1
            
    /* x(An,AL) --> x.L*/
            mov.w #0x5A5A , 4(%a0,%a1.l)    /* WORD  */
            lea 4(%a0,%a1.l) , %a4    
            mov.w 4(%a0,%a1.l) , (0x00010104)    
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.w #0x5A5A , 4(%a0,%a1.l)                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x.L --> n(An,Dw)*/
MOVE1:      mov.w  (0x00010104) , 6(%a0,%d1.w)    /* WORD  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.w #0x5A5A , 6(%a0,%d1.w)                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x(%pc,Ds) --> x.w*/
            mov.w  MOVE1(%pc,%d3), (0x0100) /* WORD  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.w #0x31B9, MOVE1
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                    
    /* #x -->    n(An,AL)*/
            mov.w  #0x7878, 6(%a0,%d1.w)    /* WORD  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.w #0x7878 ,6(%a0,%d1.w)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
/* ---*/
        
            mov.l #0x11223344  , %d0
            mov.l #0x00010100  , %d1
            mov.l #0x8899aabb  , %d2
            mov.l #0x00000002  , %d3
            mov.l #0x00000000  , %d4
            mov.l #0x00000000  , %d5
            mov.l #0x00000000  , %d6
            mov.l #0x00000000  , %d7         
            mov.l #0x00000000  , %a0
            mov.l #0x00010100  , %a1
            
    /* x(An,AL) --> x.L*/
            mov.l #0x5A5A1234 , 4(%a0,%a1.l)    /* LONG  */
            lea 4(%a0,%a1.l) , %a4    
            mov.l 4(%a0,%a1.l) , (0x00010104)    
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x5A5A1234 , 4(%a0,%a1.l)                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x.L --> n(An,Dw)*/
MOVE3:      mov.l  (0x00010104) , 6(%a0,%d1.w)    /* LONG  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x5A5A1234 , 6(%a0,%d1.w)                          
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                
    /* x(%pc,Ds) --> x.w*/
            mov.l  MOVE3(%pc,%d3), (0x0100) /* LONG  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x21B90001 , MOVE3
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
                    
    /* #x -->    n(An,AL)*/
            mov.l  #0x78782323, 6(%a0,%d1.w)    /* LONG  */
            beq TEST_FAIL                       /* Check Z Flag  beq/bne*/
            bmi TEST_FAIL                       /* Check N Flag  bmi/bpl*/
            cmpi.l #0x78782323 ,6(%a0,%d1.w)                           
            bne TEST_FAIL                       /* Check Z Flag  beq/bne*/
        
        
         rts

    
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
