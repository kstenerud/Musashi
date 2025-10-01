.include "entry.s"


/* Note, we are running in an interrupt context already! M bit = 0 */

mov.l #0, %a0
mov.l #25, %d0 | Level 1 interrupt slot
mov.l #INT1_HANDLER, (%a0, %d0.w*4)
mov.l #32, %d0 | Trap 0 slot
mov.l #SUP_HANDLER, (%a0, %d0.w*4)  | To return in supervisor-interrupt mode

/* Switch to user mode */
move #0x10, %sr
nop

/* Trigger interrupt */
mov.l #1, INTERRUPT_REG

/* At this point:
    X=1
    N=0
    Z=0
    V=0
    C=0
    SR = 0x10
*/

/* On return, a0 is the SP from int handler */
INT1_RET:

mov.w (%a0)+,  %d0
mov.l (%a0)+,  %d1

/** Get back in supervisor mode **/
trap #0  | To get back into supervisor mode.

move %sr, %d2 | Will die if not in supervisor mode
cmp.w #0x2000, %d2
bne TEST_FAIL

/** Check SR at the point of interrupt (see above) **/
cmp.w #0x10, %d0
bne TEST_FAIL

cmp.l #INT1_RET, %d1
bne TEST_FAIL
bra THROWAWAY_FRAME

INT1_HANDLER:
    mov.l %a7, %a0
    mov.l #0, INTERRUPT_REG
    rte

SUP_HANDLER:
    mov.w #0x2000, (%sp)  | Override sr
    rte


/** Not for the faint hearted.
MC68040UM - pag 8-15
**/
THROWAWAY_FRAME:

/* Save the SP. Do it here because gnu-as does not like move to/from ISP */
mov.l %a7, %a6
/* Set the M bit in the SR */
ori #0x1000, %sr
/* Initialize the SP to some place usable - this is the supervisor stack pointer */
mov.l #STACK2_BASE, %a7
/* We want to RTS from here. So load up the ISP, and get the return address */
mov.l (%a6), -(%a7)
/* Raise the interrupt */
mov.l #1, INTERRUPT_REG

INT2_RET:

/* Check the frame created on the interrupt stack */
cmp.w #0x1064, -(%a6)  | Frame format=1 (throwaway), Vector offset = 25*4=100=0x64
bne TEST_FAIL
cmp.l #INT2_RET, -(%a6) | Return address
bne TEST_FAIL
cmp.w #0x3000, -(%a6) | SR. S bit set, M bit was set with ori a few lines above
bne TEST_FAIL
add #8, %a6 | Restore it

/* Check the frame created on the supervisor stack */
cmp.w #0x64, -(%a7) | Frame format=0, Vector offset = 25*4=100=0x64
bne TEST_FAIL
cmp.l #INT2_RET, -(%a7) | Return address
bne TEST_FAIL
cmp.w #0x3000, -(%a7) | SR. S bit set, M bit was set with ori a few lines above
bne TEST_FAIL
add #8, %a7 | Restore it

rts
