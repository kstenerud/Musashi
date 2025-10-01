.include "entry.s"
/* OPCODE : MOVE_xxx_FLAGS*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
op_MOVE_xxx_FLAGS: 
    .set WORK_LOC,  STACK2_BASE-0x1000
    .set WORK_LOCB, 0x100

    /* Move_To_SR*/
    
    /* Dn*/
    
            mov.w #0x2FFF, %d0
            move %d0 , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
            mov.w #0x2F00, %d0
            move %d0 , %ccr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
    
            mov.w #0x2000, %d0
            move %d0 , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
       
    /* (An)*/
            mov.l #WORK_LOC, %a0
            mov.w #0x2FFF, (%a0)
            move (%a0) , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000,(%a0)
            move (%a0) , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
            
    /* (An)+*/
            mov.l #WORK_LOC, %a0
            mov.w #0x2FFF, (%a0)
            move (%a0)+ , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000,(%a0)
            move (%a0)+ , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                 
    /* -(An)*/
            mov.l #WORK_LOC+2, %a0
            mov.w #0x2FFF, (%a0)
            move (%a0)+ , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000,(%a0)
            move (%a0)+ , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                            
    /* n(An)*/
            mov.l #WORK_LOC+2, %a0
            mov.w #0x2FFF, 2(%a0)
            move 2(%a0) , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000,2(%a0)
            move 2(%a0) , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                    
    /* n(An,Rn.l)*/
            mov.l #WORK_LOC, %a0
            mov.l #0x00000002, %d0
            mov.w #0x2FFF, 2(%a0,%d0.l)
            move 2(%a0,%d0.l) , %sr 
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000, 2(%a0,%d0.l)
            move 2(%a0,%d0.l) , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                               
    /* x.W*/
            mov.w #0x2FFF, (WORK_LOCB)
            move (WORK_LOCB) , %sr
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
            mov.w #0x2000, (WORK_LOCB)
            move (WORK_LOCB) , %sr
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                                         
    /* x.L*/
            mov.w #0x2FFF, (WORK_LOC)
            move (WORK_LOC) , %sr
            bpl TEST_FAIL           /* branch if Z clear*/
            bne TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
    
MOVE4:      mov.w #0x2000, (WORK_LOC)
            move (WORK_LOC) , %sr
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                                                   
    /* x(%pc)*/
            move MOVE4+2(%pc) , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                                                   
    /* x(%pc,%d0.l)*/
            mov.l #0x00000000, %d0
            move MOVE4+2(%pc,%d0.l) , %sr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
            move MOVE4+2(%pc,%d0.l) , %ccr 
            beq TEST_FAIL           /* branch if Z set*/
            bmi TEST_FAIL           /* branch if N set*/
            bvs TEST_FAIL           /* branch if V set*/
            bcs TEST_FAIL           /* branch if C set*/
                                                                   
    /* #x*/
            move #0x2FFF, %sr 
            bne TEST_FAIL           /* branch if Z clear*/
            bpl TEST_FAIL           /* branch if N clear*/
            bvc TEST_FAIL           /* branch if V clear*/
            bcc TEST_FAIL           /* branch if C clear*/
            
            
            
 /* MOVE_From_SR*/

            
            
    /* Dn*/
            move #0x275A, %sr        /* Initial value*/
            move %sr , %d0
            cmpi.w #0x271A , %d0              /* Bits 5,6,7 and 11 of %sr are always forced 0*/
            bne TEST_FAIL                   /* branch if Z set*/
                 
    /* (An)*/
            mov.l #WORK_LOCB, %a0
            move #0x275A, %sr        /* Initial value*/
            move %sr , (%a0)
            cmpi.w #0x271A , (%a0)
            bne TEST_FAIL                   /* branch if Z set*/
                       
    /* (An)+*/
            mov.l #WORK_LOCB, %a0
            move #0x257A, %sr        /* Initial value*/
            move %sr , (%a0)+
            mov.l #WORK_LOCB, %a0
            cmpi.w #0x251A , (%a0)+
            bne TEST_FAIL                   /* branch if Z set*/
                                   
    /* -(An)*/
            mov.l #WORK_LOCB+2, %a0
            move #0x2766, %sr        /* Initial value*/
            move %sr , -(%a0)
            mov.l #WORK_LOCB, %a0
            cmpi.w #0x2706 , (%a0)
            bne TEST_FAIL                   /* branch if Z set*/
                                         
    /* x(An)*/
            mov.l #WORK_LOCB+2, %a0
            move #0x2733, %sr        /* Initial value*/
            move %sr , 4(%a0)
            cmpi.w #0x2713 , 4(%a0)
            bne TEST_FAIL                   /* branch if Z set*/
                                             
    /* x(An,rn)*/
            mov.l #WORK_LOCB+2, %a0
            mov.l #0x00000004, %d0
            move #0x275a, %sr        /* Initial value*/
            move %sr , 4(%a0,%d0.l)
            cmpi.w #0x271a , 4(%a0,%d0.l)
            bne TEST_FAIL                   /* branch if Z set*/
                                                        
    /* x.W*/
            move #0x2777, %sr        /* Initial value*/
            move %sr , (WORK_LOCB+2)
            cmpi.w #0x2717 , (WORK_LOCB+2)
            bne TEST_FAIL                   /* branch if Z set*/
                                                             
    /* x.L*/
            move #0x2777, %sr        /* Initial value*/
            move %sr , (WORK_LOC+2)
            cmpi.w #0x2717 , (WORK_LOC+2)
            bne TEST_FAIL                   /* branch if Z set*/
            
            
            
            move #0x2700, %sr        /* Put flags back to initial value*/

            rts

             
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/
