.include "entry.s"
/* OPCODE : SHIFTS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

                bra op_SHIFTS

    /* Subroutine to check and accumulate the flags */
SHIFTS_FLAGS:   move %sr , %d3      
                andi.l #0x0F , %d3            /* Isolate flags */
                add.l %d3 , %d5               /* Copy flag results into accumulator*/
                rts
    
op_SHIFTS:   
           
    /* Shift a Register LEFT and RIGHT with shift_count ## IN A REGISTER ##*/
    
       /* BYTE LEFT*/
                mov.l #0x80018F81, %d0   
                mov.l #0x00000000, %d5  
                mov.l #0x00000002, %d6  
SHIFTS_LOOP1:
                asl.b %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP1
                cmpi.l #0x80018F08 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000002, %d5     
                bne TEST_FAIL
    
       /* BYTE RIGHT*/
                mov.l #0x80018F81, %d0   
                mov.l #0x00000002, %d6  
SHIFTS_LOOP2:
                asr.b %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP2
                cmpi.l #0x80018FF0 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001A, %d5     
                bne TEST_FAIL

    
       /* WORD LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS_LOOP3:
                asl.w %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP3
                cmpi.l #0x80017F88 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001C, %d5     
                bne TEST_FAIL
    
       /* WORD RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS_LOOP4:
                asr.w %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP4
                cmpi.l #0x8001F1FE , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000034, %d5     
                bne TEST_FAIL

    
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS_LOOP5:
                asl.l %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP5
                cmpi.l #0x000C7F88 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000036, %d5     
                bne TEST_FAIL
    
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000002, %d6  
SHIFTS_LOOP6:
                asr.l %d6 , %d0       
                jsr SHIFTS_FLAGS
                dbf %d6 , SHIFTS_LOOP6
                cmpi.l #0xF00031FE , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000004E, %d5     
                bne TEST_FAIL

            
    /* Shift a Register LEFT and RIGHT with shift_count ## IN THE OPCODE ##*/
    
                mov.l #0x80018FF1, %d0   
                mov.l #0x00000000, %d5   

       /* BYTE LEFT*/
                asl.b #1 , %d0       
                jsr SHIFTS_FLAGS
                asl.b #2 , %d0      
                jsr SHIFTS_FLAGS
                asl.b #1 , %d0   
                jsr SHIFTS_FLAGS
                asl.b #3 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0x80018F80 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000001F, %d5     
                bne TEST_FAIL
     
       /* BYTE RIGHT*/
                asr.b #1 , %d0       
                jsr SHIFTS_FLAGS
                asr.b #2 , %d0      
                jsr SHIFTS_FLAGS
                asr.b #3 , %d0   
                jsr SHIFTS_FLAGS
                asr.b #1 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0x80018FFF , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000003F, %d5     
                bne TEST_FAIL
     
       /* WORD LEFT*/
                asl.w #1 , %d0       
                jsr SHIFTS_FLAGS
                asl.w #2 , %d0      
                jsr SHIFTS_FLAGS
                asl.w #3 , %d0   
                jsr SHIFTS_FLAGS
                asl.w #5 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0x8001F800 , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000056, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                asr.w #5 , %d0       
                jsr SHIFTS_FLAGS
                asr.w #1 , %d0      
                jsr SHIFTS_FLAGS
                asr.w #2 , %d0   
                jsr SHIFTS_FLAGS
                asr.w #4 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0x8001FFFF , %d0     
                bne TEST_FAIL
                cmpi.l #0x00000077, %d5     
                bne TEST_FAIL
               
       /* LONG LEFT*/
                mov.l #0x80018FF1, %d0   
                asl.l #1 , %d0       
                jsr SHIFTS_FLAGS
                asl.l #2 , %d0      
                jsr SHIFTS_FLAGS
                asl.l #7 , %d0   
                jsr SHIFTS_FLAGS
                asl.l #4 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0x63FC4000  , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000007A, %d5     
                bne TEST_FAIL
                                
       /* LONG RIGHT*/
                mov.l #0x80018FF1, %d0   
                asr.l #1 , %d0       
                jsr SHIFTS_FLAGS
                asr.l #5 , %d0      
                jsr SHIFTS_FLAGS
                asr.l #7 , %d0   
                jsr SHIFTS_FLAGS
                asr.l #8 , %d0   
                jsr SHIFTS_FLAGS
                cmpi.l #0xFFFFFC00 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000009C, %d5     
                bne TEST_FAIL
   
            
    /* Shift a Memory location LEFT and RIGHT with shift_count of 1 - WORD only*/
    
                mov.l #0x00000000, %d5   
                mov.l #0x00000100, %a0 
                mov.w #0x8FF1 , (%a0)
                
       /* WORD LEFT*/
                asl  (%a0)       
                jsr SHIFTS_FLAGS
                asl  (%a0)       
                jsr SHIFTS_FLAGS
                asl  (%a0)       
                jsr SHIFTS_FLAGS
                asl  (%a0)       
                jsr SHIFTS_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0xFFFFFF10 , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000000D, %d5     
                bne TEST_FAIL
                  
       /* WORD RIGHT*/
                asr (%a0)       
                jsr SHIFTS_FLAGS
                asr (%a0)       
                jsr SHIFTS_FLAGS
                asr (%a0)       
                jsr SHIFTS_FLAGS                
                asr (%a0)       
                jsr SHIFTS_FLAGS               
                asr (%a0)       
                jsr SHIFTS_FLAGS
                asr (%a0)       
                jsr SHIFTS_FLAGS
                mov.w (%a0) , %d0
                cmpi.l #0xFFFFFFFC , %d0     
                bne TEST_FAIL
                cmpi.l #0x0000003E, %d5     
                bne TEST_FAIL

                rts      
        

                
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
