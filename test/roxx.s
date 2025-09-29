.include "entry.s"
/* OPCODE : ROXx*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

                bra op_ROXx

    /* Subroutine to check and accumulate the flags */
ROXx_FLAGS:     move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                rts
    
op_ROXx:   
           
    /* Shift a Register LEFT and RIGHT with shift_count ## IN A REGISTER ##*/
    
       /* BYTE LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5  
                mov.l #0x00000011, %d6  
ROXx_LOOP1:
                roxl.b %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP1
                cmpi.l #0x80018FD0 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000042, %d5     
                bne TEST_FAIL
    
       /* BYTE RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000012, %d6  
ROXx_LOOP2:
                roxr.b %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP2
                cmpi.l #0x80018F51 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000009C, %d5     
                bne TEST_FAIL

    
       /* WORD LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000013, %d6  
ROXx_LOOP3:
                roxl.w %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP3
                cmpi.l #0x80013980 , %d0     
                bne TEST_FAIL
                cmpi.l #0x000000C9, %d5     
                bne TEST_FAIL
    
       /* WORD RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x0000001E, %d6  
ROXx_LOOP4:
                roxr.w %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP4
                cmpi.l #0x80010A1D , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000014D, %d5     
                bne TEST_FAIL

    
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000015, %d6  
ROXx_LOOP5:
                roxl.l %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP5
                cmpi.l #0x800185D0 , %d0     
                bne TEST_FAIL
                cmpi.l #0x000001A1, %d5     
                bne TEST_FAIL
    
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000016, %d6  
ROXx_LOOP6:
                roxr.l %d6 , %d0       
                jsr ROXx_FLAGS
                dbf %d6 , ROXx_LOOP6
                cmpi.l #0x082D8200 , %d0     
                bne TEST_FAIL
                cmpi.l #0x000001DE, %d5     
                bne TEST_FAIL

            
    /* Shift a Register LEFT and RIGHT with shift_count ## IN THE OPCODE ##*/
    
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5   

       /* BYTE LEFT*/
                roxl.b #1 , %d0       
                jsr ROXx_FLAGS
                roxl.b #5 , %d0      
                jsr ROXx_FLAGS
                roxl.b #7 , %d0   
                jsr ROXx_FLAGS
                roxl.b #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x80018F09 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000000B, %d5     
                bne TEST_FAIL
     
       /* BYTE RIGHT*/
                roxr.b #1 , %d0       
                jsr ROXx_FLAGS
                roxr.b #5 , %d0      
                jsr ROXx_FLAGS
                roxr.b #7 , %d0   
                jsr ROXx_FLAGS
                roxr.b #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x80018F00 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000015, %d5     
                bne TEST_FAIL
     
       /* WORD LEFT*/
                roxl.w #1 , %d0       
                jsr ROXx_FLAGS
                roxl.w #5 , %d0      
                jsr ROXx_FLAGS
                roxl.w #7 , %d0   
                jsr ROXx_FLAGS
                roxl.w #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x8001B000 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000027, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                roxr.w #1 , %d0       
                jsr ROXx_FLAGS
                roxr.w #5 , %d0      
                jsr ROXx_FLAGS
                roxr.w #7 , %d0   
                jsr ROXx_FLAGS
                roxr.w #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x80010A00 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000028, %d5     
                bne TEST_FAIL
               
       /* LONG LEFT*/
                roxl.l #1 , %d0       
                jsr ROXx_FLAGS
                roxl.l #5 , %d0      
                jsr ROXx_FLAGS
                roxl.l #7 , %d0   
                jsr ROXx_FLAGS
                roxl.l #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x40000010 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000002A, %d5     
                bne TEST_FAIL
                                
       /* LONG RIGHT*/
                roxr.l #1 , %d0       
                jsr ROXx_FLAGS
                roxr.l #5 , %d0      
                jsr ROXx_FLAGS
                roxr.l #7 , %d0   
                jsr ROXx_FLAGS
                roxr.l #8 , %d0   
                jsr ROXx_FLAGS
                cmpi.l #0x00010200 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000032, %d5     
                bne TEST_FAIL
   
            
    /* Shift a Memory location LEFT and RIGHT with shift_count of 1 - WORD only*/
    
                mov.l #0x00000000, %d5   
                mov.l #0x00000100, %a0 
                mov.w #0x8FF1 , (%a0)
                
       /* WORD LEFT*/
                roxl (%a0)       
                jsr ROXx_FLAGS
                roxl (%a0)       
                jsr ROXx_FLAGS
                roxl (%a0)       
                jsr ROXx_FLAGS
                roxl (%a0)       
                jsr ROXx_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x0001FF10 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000009, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                roxr (%a0)       
                jsr ROXx_FLAGS
                roxr (%a0)       
                jsr ROXx_FLAGS
                roxr (%a0)       
                jsr ROXx_FLAGS                
                roxr (%a0)       
                jsr ROXx_FLAGS               
                roxr (%a0)       
                jsr ROXx_FLAGS
                roxr (%a0)       
                jsr ROXx_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x000103FC , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000000A, %d5     
                bne TEST_FAIL

                rts        


 
                
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
