.include "entry.s"
/* OPCODE : EXG*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_EXG:     
                mov.l #0xd1d1d1d1, %d1      
                mov.l #0xd2d2d2d2, %d2      
                mov.l #0xd3d3d3d3, %d3      
                mov.l #0xa1a1a1a1, %a1      
                mov.l #0xa2a2a2a2, %a2  
                mov.l #0xa3a3a3a3, %a3  
                
                exg %d1 , %d2    
                exg %a1 , %a2    
                exg %d3 , %a3  

                cmpi.l #0xd2d2d2d2 , %d1      /* Check the results*/
                bne TEST_FAIL
                cmpi.l #0xd1d1d1d1 , %d2    
                bne TEST_FAIL
                cmpi.l #0xa3a3a3a3 , %d3    
                bne TEST_FAIL
                
                mov.l %a1 , %d1
                mov.l %a2 , %d2
                mov.l %a3 , %d3
 
                cmpi.l #0xa2a2a2a2 , %d1    
                bne TEST_FAIL
                cmpi.l #0xa1a1a1a1 , %d2     
                bne TEST_FAIL
                cmpi.l #0xd3d3d3d3 , %d3     
                bne TEST_FAIL
 
                rts
      
                
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
