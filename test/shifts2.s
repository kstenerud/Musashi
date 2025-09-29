.include "entry.s"
/* OPCODE : SHIFTS2*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

                bra op_SHIFTS2

    /* Subroutine to check and accumulate the flags */
SHIFTS2_FLAGS:  move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                rts
    
op_SHIFTS2:   
           
    /* Shift a Register LEFT and RIGHT with shift_count ## IN A REGISTER ##*/
    
       /* BYTE LEFT*/
                mov.l #0x80018F81, %d0   
                mov.l #0x00000000, %d5  
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP1:
                lsl.b %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP1
                cmpi.l #0x80018F08 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL
    
       /* BYTE RIGHT*/
                mov.l #0x80018F81, %d0   
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP2:
                lsr.b %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP2
                cmpi.l #0x80018F10 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL

    
       /* WORD LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP3:
                lsl.w %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP3
                cmpi.l #0x80017F88 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL
    
       /* WORD RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP4:
                lsr.w %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP4
                cmpi.l #0x800111FE , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL

    
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP5:
                lsl.l %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP5
                cmpi.l #0x000C7F88 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL
    
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS2_LOOP6:
                lsr.l %d6 , %d0       
                jsr SHIFTS2_FLAGS
                dbf %d6 , SHIFTS2_LOOP6
                cmpi.l #0x100031FE , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000000, %d5     
                bne TEST_FAIL

            
    /* Shift a Register LEFT and RIGHT with shift_count ## IN THE OPCODE ##*/
    
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5   

       /* BYTE LEFT*/
                lsl.b #1 , %d0       
                jsr SHIFTS2_FLAGS
                lsl.b #2 , %d0      
                jsr SHIFTS2_FLAGS
                lsl.b #1 , %d0   
                jsr SHIFTS2_FLAGS
                lsl.b #3 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x80018F80 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001B, %d5     
                bne TEST_FAIL
     
       /* BYTE RIGHT*/
                lsr.b #1 , %d0       
                jsr SHIFTS2_FLAGS
                lsr.b #2 , %d0      
                jsr SHIFTS2_FLAGS
                lsr.b #3 , %d0   
                jsr SHIFTS2_FLAGS
                lsr.b #1 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x80018F01 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001B, %d5     
                bne TEST_FAIL
     
       /* WORD LEFT*/
                lsl.w #1 , %d0       
                jsr SHIFTS2_FLAGS
                lsl.w #2 , %d0      
                jsr SHIFTS2_FLAGS
                lsl.w #3 , %d0   
                jsr SHIFTS2_FLAGS
                lsl.w #5 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x80010800 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000025, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                lsr.w #5 , %d0       
                jsr SHIFTS2_FLAGS
                lsr.w #1 , %d0      
                jsr SHIFTS2_FLAGS
                lsr.w #2 , %d0   
                jsr SHIFTS2_FLAGS
                lsr.w #4 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x80010000 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000002A, %d5     
                bne TEST_FAIL
               
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                lsl.l #1 , %d0       
                jsr SHIFTS2_FLAGS
                lsl.l #2 , %d0      
                jsr SHIFTS2_FLAGS
                lsl.l #7 , %d0   
                jsr SHIFTS2_FLAGS
                lsl.l #4 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x63FC4000  , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000002B, %d5     
                bne TEST_FAIL
                                
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                lsr.l #1 , %d0       
                jsr SHIFTS2_FLAGS
                lsr.l #5 , %d0      
                jsr SHIFTS2_FLAGS
                lsr.l #7 , %d0   
                jsr SHIFTS2_FLAGS
                lsr.l #8 , %d0   
                jsr SHIFTS2_FLAGS
                cmpi.l #0x00000400 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000002D, %d5     
                bne TEST_FAIL
   
            
    /* Shift a Memory location LEFT and RIGHT with shift_count of 1 - WORD only*/
    
                mov.l #0x00000000, %d5   
                mov.l #0x00000100, %a0 
                mov.w #0x8FF1 , (%a0)
                
       /* WORD LEFT*/
                lsl  (%a0)       
                jsr SHIFTS2_FLAGS
                lsl  (%a0)       
                jsr SHIFTS2_FLAGS
                lsl  (%a0)       
                jsr SHIFTS2_FLAGS
                lsl  (%a0)       
                jsr SHIFTS2_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x0000FF10 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000009, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                lsr (%a0)       
                jsr SHIFTS2_FLAGS
                lsr (%a0)       
                jsr SHIFTS2_FLAGS
                lsr (%a0)       
                jsr SHIFTS2_FLAGS                
                lsr (%a0)       
                jsr SHIFTS2_FLAGS               
                lsr (%a0)       
                jsr SHIFTS2_FLAGS
                lsr (%a0)       
                jsr SHIFTS2_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0x000003FC , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000000A, %d5     
                bne TEST_FAIL

                rts      
        

/*------------------------------------------------------   */
/*------------------------------------------------------   */
