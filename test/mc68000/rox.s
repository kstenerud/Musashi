.include "entry.s"
/* OPCODE : ROx*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

                bra op_ROx

    /* Subroutine to check and accumulate the flags */
ROx_FLAGS:      move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                rts
    
op_ROx:   
           
    /* Shift a Register LEFT and RIGHT with shift_count ## IN A REGISTER ##*/
    
       /* BYTE LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5  
                mov.l #0x00000011, %d6  
ROx_LOOP1:
                rol.b %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP1
                cmpi.l #0x80018FE3 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000006B, %d5     
                bne TEST_FAIL
    
       /* BYTE RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000012, %d6  
ROx_LOOP2:
                ror.b %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP2
                cmpi.l #0x80018F3E , %d0     
                bne TEST_FAIL
                cmpi.l #0x000000C5, %d5     
                bne TEST_FAIL

    
       /* WORD LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000013, %d6  
ROx_LOOP3:
                rol.w %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP3
                cmpi.l #0x800163FC , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000131, %d5     
                bne TEST_FAIL
    
       /* WORD RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x0000001E, %d6  
ROx_LOOP4:
                ror.w %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP4
                cmpi.l #0x8001C7F8 , %d0     
                bne TEST_FAIL
                cmpi.l #0x000001DB, %d5     
                bne TEST_FAIL

    
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000015, %d6  
ROx_LOOP5:
                rol.l %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP5
                cmpi.l #0x00C7F8C0 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000021A, %d5     
                bne TEST_FAIL
    
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000016, %d6  
ROx_LOOP6:
                ror.l %d6 , %d0       
                jsr ROx_FLAGS
                dbf %d6 , ROx_LOOP6
                cmpi.l #0x000C7F8C , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000250, %d5     
                bne TEST_FAIL

            
    /* Shift a Register LEFT and RIGHT with shift_count ## IN THE OPCODE ##*/
    
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5   

       /* BYTE LEFT*/
                rol.b #1 , %d0       
                jsr ROx_FLAGS
                rol.b #5 , %d0      
                jsr ROx_FLAGS
                rol.b #7 , %d0   
                jsr ROx_FLAGS
                rol.b #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0x80018F3E , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000009, %d5     
                bne TEST_FAIL
     
       /* BYTE RIGHT*/
                ror.b #1 , %d0       
                jsr ROx_FLAGS
                ror.b #5 , %d0      
                jsr ROx_FLAGS
                ror.b #7 , %d0   
                jsr ROx_FLAGS
                ror.b #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0x80018FF1 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000024, %d5     
                bne TEST_FAIL
     
       /* WORD LEFT*/
                rol.w #1 , %d0       
                jsr ROx_FLAGS
                rol.w #5 , %d0      
                jsr ROx_FLAGS
                rol.w #7 , %d0   
                jsr ROx_FLAGS
                rol.w #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0x8001FE31 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000037, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                ror.w #1 , %d0       
                jsr ROx_FLAGS
                ror.w #5 , %d0      
                jsr ROx_FLAGS
                ror.w #7 , %d0   
                jsr ROx_FLAGS
                ror.w #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0x80018FF1 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000005B, %d5     
                bne TEST_FAIL
               
       /* LONG LEFT*/
                rol.l #1 , %d0       
                jsr ROx_FLAGS
                rol.l #5 , %d0      
                jsr ROx_FLAGS
                rol.l #7 , %d0   
                jsr ROx_FLAGS
                rol.l #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0xFE300031 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000065, %d5     
                bne TEST_FAIL
                                
       /* LONG RIGHT*/
                ror.l #1 , %d0       
                jsr ROx_FLAGS
                ror.l #5 , %d0      
                jsr ROx_FLAGS
                ror.l #7 , %d0   
                jsr ROx_FLAGS
                ror.l #8 , %d0   
                jsr ROx_FLAGS
                cmpi.l #0x80018FF1 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000080, %d5     
                bne TEST_FAIL
   
            
    /* Shift a Memory location LEFT and RIGHT with shift_count of 1 - WORD only*/
    
                mov.l #0x00000000, %d5   
                mov.l #0x00000100, %a0 
                mov.w #0x8FF1 , (%a0)
                
       /* WORD LEFT*/
                rol (%a0)       
                jsr ROx_FLAGS
                rol (%a0)       
                jsr ROx_FLAGS
                rol (%a0)       
                jsr ROx_FLAGS
                rol (%a0)       
                jsr ROx_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x8001FF18 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000009, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                ror (%a0)       
                jsr ROx_FLAGS
                ror (%a0)       
                jsr ROx_FLAGS
                ror (%a0)       
                jsr ROx_FLAGS                
                ror (%a0)       
                jsr ROx_FLAGS               
                ror (%a0)       
                jsr ROx_FLAGS
                ror (%a0)       
                jsr ROx_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x800163FC , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001B, %d5     
                bne TEST_FAIL

                rts
      
     
                
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
