.include "entry.s"
/* OPCODE : BCC*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_BCC:         move #0x00 , %ccr
                bhi.s BCC1            /* Higher Than         C=0 AND Z=0*/
                bra TEST_FAIL
                
BCC1:           move #0x01 , %ccr
                bls.w BCC2            /* Lower or Same       C=1 OR Z=1*/
                bra TEST_FAIL
                 
BCC2:           move #0x00 , %ccr
                bcc.s BCC3            /* Carry Clear         C=0*/
                bra TEST_FAIL
                   
BCC3:           move #0x01 , %ccr
                bcs.w BCC4            /* Carry Set           C=1*/
                bra TEST_FAIL
                   
BCC4:           move #0x00 , %ccr
                bne.s BCC5            /* Not Equal           Z=0*/
                bra TEST_FAIL
                     
BCC5:           move #0x04 , %ccr
                beq.w BCC6            /* Equal               Z=1*/
                bra TEST_FAIL
                       
BCC6:           move #0x00 , %ccr
                bvc.s BCC7            /* V Clear             V=0*/
                bra TEST_FAIL
                         
BCC7:           move #0x02 , %ccr
                bvs.w BCC8            /* V Set               V=1*/
                bra TEST_FAIL
                          
BCC8:           move #0x00 , %ccr
                bpl.s BCC9            /* Plus                N=0*/
                bra TEST_FAIL
                           
BCC9:           move #0x08 , %ccr
                bmi.w BCC10           /* Minus               N=1*/
                bra TEST_FAIL
                            
BCC10:          move #0x00 , %ccr
                bge.s BCC11           /* Greater or Equal    N=V*/
                bra TEST_FAIL
                             
BCC11:          move #0x02 , %ccr
                blt.w BCC12           /* Less Than           N!=V*/
                bra TEST_FAIL
                               
BCC12:          move #0x0A , %ccr
                bgt.s BCC13           /* Greater Than        N=V  AND Z=0*/
                bra TEST_FAIL
                                
BCC13:          move #0x06 , %ccr
                ble.w BCC14           /* Less Than or Equal  N!=V AND Z=1*/
                bra TEST_FAIL
               

BCC14:          rts
  
  
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
