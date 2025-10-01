.include "entry.s"
/* OPCODE : MOVEP*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_MOVEP: 

/* Dn --> x(An)*/
            mov.l #0x00000100 , %a0  
            mov.l #0x12345678 , %d0  
            mov.l #0xAABBCCDD , %d1  
            mov.l #0 , (%a0)
            mov.l #0 , 4(%a0)
            
            movep.w %d0 , 0(%a0)      /* even offset   */
            movep.w %d1 , 1(%a0)      /* odd offset*/
            
            movep.l %d0 , 4(%a0)      /* even offset   */
            movep.l %d1 , 5(%a0)      /* odd offset*/
            
            cmpi.l #0x56CC78DD , (%a0)
            bne TEST_FAIL
            cmpi.l #0x12AA34BB , 4(%a0)
            bne TEST_FAIL
            cmpi.l #0x56CC78DD , 8(%a0)
            bne TEST_FAIL
            
            
/* x(An)--> Dn*/
            mov.l #0x5a5a5a5a , %d0  
            mov.l #0x5a5a5a5a , %d1  
            mov.l #0x5a5a5a5a , %d2  
            mov.l #0x5a5a5a5a , %d3  
            
            movep.w 0(%a0) , %d0      /* even offset   */
            movep.w 1(%a0) , %d1      /* odd offset*/
            
            movep.l 4(%a0) , %d2      /* even offset   */
            movep.l 5(%a0) , %d3      /* odd offset*/
            
            cmpi.l #0x5a5a5678 , %d0
            bne TEST_FAIL
            cmpi.l #0x5a5aCCDD , %d1
            bne TEST_FAIL
            cmpi.l #0x12345678 , %d2
            bne TEST_FAIL
            cmpi.l #0xAABBCCDD , %d3
            bne TEST_FAIL
    
            rts
     
    

/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
