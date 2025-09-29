.include "entry.s"
/* OPCODE : MOVEM*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_MOVEM: 

    /* WORD  Registers --> Memory*/
            mov.l #0x0000d0d0, %d0
            mov.l #0x0000d1d1, %d1
            mov.l #0x0000d2d2, %d2
            mov.l #0x0000d3d3, %d3
            mov.l #0x0000d4d4, %d4
            mov.l #0x0000d5d5, %d5
            mov.l #0x0000d6d6, %d6
            mov.l #0x0000d7d7, %d7
            mov.l #0x00000a0a, %a0
            mov.l #0x00001a1a, %a1
            mov.l #0x00002a2a, %a2
            mov.l #0x00003a3a, %a3
            mov.l #0x00004a4a, %a4
            mov.l #0x00005a5a, %a5
            mov.l #0x00006a6a, %a6
           /*mov.l #0x00007a7a, %a7  * Dont change the Stack Pointer*/
            
            movem.w %d0-%d7/%a0-%a7 , (0x00000100)  
            
            mov.l #0x00000100, %a0
            
            cmp.w (%a0)+ , %d0            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d1            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d2            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d3            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d4            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d5            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d6            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %d7            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/

            cmp.w #0x0A0A , (%a0)+    /* Because we are using %a0 as a pointer*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
 
            cmp.w (%a0)+ , %a1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %a2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %a3
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %a4
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %a5
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w (%a0)+ , %a6
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
          



    /* LONG  Registers --> Memory*/
            mov.l #0xd0d0d0d0, %d0
            mov.l #0xd1d1d1d1, %d1
            mov.l #0xd2d2d2d2, %d2
            mov.l #0xd3d3d3d3, %d3
            mov.l #0xd4d4d4d4, %d4
            mov.l #0xd5d5d5d5, %d5
            mov.l #0xd6d6d6d6, %d6
            mov.l #0xd7d7d7d7, %d7
            mov.l #0x0a0a0a0a, %a0
            mov.l #0x1a1a1a1a, %a1
            mov.l #0x2a2a2a2a, %a2
            mov.l #0x3a3a3a3a, %a3
            mov.l #0x4a4a4a4a, %a4
            mov.l #0x5a5a5a5a, %a5
            mov.l #0x6a6a6a6a, %a6
           /*mov.l #0x7a7a7a7a, %a7  * Dont change the Stack Pointer*/
            
            
            movem.l %d0-%d7/%a0-%a7 , (0x00000120)  
            
            mov.l #0x00000120, %a0
            
            cmp.l (%a0)+ , %d0            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d1            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d2            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d3            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d4            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d5            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d6            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %d7            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/

            cmp.l #0x0A0A0A0A , (%a0)+    /* Because we are using %a0 as a pointer*/
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
 
            cmp.l (%a0)+ , %a1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %a2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %a3
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %a4
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %a5
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l (%a0)+ , %a6
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
     /* ----*/


    /* WORD  Registers --> Memory  -(An) EA Mode*/
            mov.l #0x0000d0d0, %d0
            mov.l #0x0000d1d1, %d1
            mov.l #0x0000d2d2, %d2
            mov.l #0x0000d3d3, %d3
            mov.l #0x0000d4d4, %d4
            mov.l #0x0000d5d5, %d5
            mov.l #0x0000d6d6, %d6
            mov.l #0x0000d7d7, %d7
            mov.l #0x00000a0a, %a0
            mov.l #0x00001a1a, %a1
            mov.l #0x00002a2a, %a2
            mov.l #0x00003a3a, %a3
            mov.l #0x00004a4a, %a4
            mov.l #0x00005a5a, %a5
            mov.l #0x00006a6a, %a6
           /*mov.l #0x00007a7a, %a7  * Dont change the Stack Pointer*/
           
            mov.l #0x000001A0, %a0
            movem.w %d0-%d7/%a0-%a7 , -(%a0)  
            
            mov.l #0x0000019E, %a0
            
            cmp.w -(%a0) , %a6            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a5            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a4            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a3            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a2            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a1            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %a0            
           /* bne TEST_FAIL                   * Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d7            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d6
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d5
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d4
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d3
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.w -(%a0) , %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
          



    /* LONG  Registers --> Memory   -(An) EA Mode*/
            mov.l #0xd0d0d0d0, %d0
            mov.l #0xd1d1d1d1, %d1
            mov.l #0xd2d2d2d2, %d2
            mov.l #0xd3d3d3d3, %d3
            mov.l #0xd4d4d4d4, %d4
            mov.l #0xd5d5d5d5, %d5
            mov.l #0xd6d6d6d6, %d6
            mov.l #0xd7d7d7d7, %d7
            mov.l #0x0a0a0a0a, %a0
            mov.l #0x1a1a1a1a, %a1
            mov.l #0x2a2a2a2a, %a2
            mov.l #0x3a3a3a3a, %a3
            mov.l #0x4a4a4a4a, %a4
            mov.l #0x5a5a5a5a, %a5
            mov.l #0x6a6a6a6a, %a6
           /*mov.l #0x7a7a7a7a, %a7  * Dont change the Stack Pointer*/
            
         
            mov.l #0x000001A0, %a0
            movem.l %d0-%d7/%a0-%a7 , -(%a0)  
            
            mov.l #0x0000019C, %a0
            
            cmp.l -(%a0) , %a6            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a5            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a4            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a3            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a2            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a1            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %a0            
           /* bne TEST_FAIL                   * Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d7            
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d6
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d5
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d4
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d3
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d2
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d1
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l -(%a0) , %d0
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
          


     /*----     */
          
    /* WORD - Memory --> Registers*/
            mov.l #0x00000000, %d0
            mov.l #0x00000000, %d1
            mov.l #0x00000000, %d2
            mov.l #0x00000000, %d3
            mov.l #0x00000000, %d4
            mov.l #0x00000000, %d5
            mov.l #0x00000000, %d6
            mov.l #0x00000000, %d7
            mov.l #0x00000000, %a0
            mov.l #0x00000000, %a1
            mov.l #0x00000000, %a2
            mov.l #0x00000000, %a3
            mov.l #0x00000000, %a4
            mov.l #0x00000000, %a5
            mov.l #0x00000000, %a6
           /*mov.l #0x00000000, %a7  * Dont change the Stack Pointer*/
            
            movem.w (0x00000100) , %d0/%d2/%d4/%d6/%a1/%a3/%a5   
            
            cmp.l #0xFFFFD0D0 , %d0           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD1D1 , %d2           
            bne TEST_FAIL                  /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD2D2 , %d4           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD3D3 , %d6           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD4D4 , %a1           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD5D5 , %a3           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xFFFFD6D6 , %a5           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            
 
    /* LONG - Memory --> Registers*/
            mov.l #0x00000000, %d0
            mov.l #0x00000000, %d1
            mov.l #0x00000000, %d2
            mov.l #0x00000000, %d3
            mov.l #0x00000000, %d4
            mov.l #0x00000000, %d5
            mov.l #0x00000000, %d6
            mov.l #0x00000000, %d7
            mov.l #0x00000000, %a0
            mov.l #0x00000000, %a1
            mov.l #0x00000000, %a2
            mov.l #0x00000000, %a3
            mov.l #0x00000000, %a4
            mov.l #0x00000000, %a5
            mov.l #0x00000000, %a6
           /*mov.l #0x00000000, %a7  * Dont change the Stack Pointer*/
            
            movem.l (0x00000120) , %d0/%d2/%d4/%d6/%a1/%a3/%a5   
            
            cmp.l #0xD0D0D0D0 , %d0           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD1D1D1D1 , %d2           
            bne TEST_FAIL                  /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD2D2D2D2 , %d4           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD3D3D3D3 , %d6           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD4D4D4D4 , %a1           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD5D5D5D5 , %a3           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            cmp.l #0xD6D6D6D6 , %a5           
            bne TEST_FAIL                   /* Check Z Flag  beq/bne 0*/
            
            rts     

                          
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
