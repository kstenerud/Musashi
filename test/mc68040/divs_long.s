.include "entry.s"
/* OPCODE : DIVSL, DIVSLL*/
/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

op_DIVS_L:
    /** Install an handler for div by 0 **/
    mov.l #0, %a0
    mov.l #5, %d0 | Div by zero slot
    mov.l #DIV0_HANDLER, (%a0, %d0.w*4)


    /** Some sanity checks **/

    /** Basic 32/32 -> 32 **/
    mov.l #0x12345, %d0
    divs.l #-0x7, %d0
    beq TEST_FAIL
    bpl TEST_FAIL
    bvs TEST_FAIL
    cmp.l #-0x299C, %d0
    bne TEST_FAIL

    /** Same with remainder 32/32 -> 32, 32 **/
    mov.l #0x12345, %d0
    mov.l #1, %d1 | Makes sure that we actually execute divsl.l and not divs.l
    divsl.l #-0x7, %d1, %d0
    beq TEST_FAIL
    bpl TEST_FAIL
    bvs TEST_FAIL
    cmp.l #-0x299C, %d0
    bne TEST_FAIL
    cmp.l #1, %d1
    bne TEST_FAIL

    /** Same with remainder 64/32 -> 32, 32
     * -0x100012345 = -0x249272C0 * 7 - 5
     **/
    mov.l #-0x12345, %d0
    mov.l #-2, %d1
    divs.l #0x7, %d1, %d0
    beq TEST_FAIL
    bpl TEST_FAIL
    bvs TEST_FAIL
    cmp.l #-0x249272C0, %d0
    bne TEST_FAIL
    cmp.l #-5, %d1
    bne TEST_FAIL

    /** Zero divide **/
    mov.l #0x12345, %d0
    mov.l #0, %d1
    mov.w #0, %ccr
    divs.l #0x0, %d1, %d0
    beq TEST_FAIL
    bmi TEST_FAIL
    bvs TEST_FAIL
    cmp.l #0x12345, %d0
    bne TEST_FAIL
    cmp.l #0xABCDEF01, %d4
    bne TEST_FAIL

    /* Uninstall div by zero handler */
    mov.l #0, %a0
    mov.l #5, %d0 | Level 1 interrupt slot
    mov.l #0, (%a0, %d0.w*4)


    /**
     * LOOP TEST DIVSL.L
     */

    /* Setup counters */
    mov.l #0, -(%sp) | Rem accu
    mov.l #0, -(%sp) | Quot accu

    mov.l #0xF1AC021A, %d4 | Outer var
    mov.l #0x10, %d2 | Outer counter
divsll_outer:
    mov.l #0x0001A10A, %d3 | Inner var
    mov.l #0x10, %d1 | Inner counter
divsll_inner:

    mov.l %d4, %d5
    mov.w #0, %ccr
    divsl.l %d3, %d0, %d5 | Div %%d5 / %d3, result in %d5, rem in %d0
    bvs TEST_FAIL
/*     mov.l #0, PRINT_REG_REG */

    /* Add the quotient */
    add.l %d5, (%sp)
    /* Add the remainder */
    add.l %d0, (%sp, 4)

    /* Update inner var */
    lsr.l #1, %d3
    dbf %d1, divsll_inner

    /* Update outer var */
    rol.l #1, %d4
    dbf %d2, divsll_outer

    /* Get the counters back */
    mov.l (%sp)+, %d0 | Quot
    mov.l (%sp)+, %d1 | Rem

    /* Results xchecked in python */
    cmp.l #0x7747c3a1, %d0
    bne TEST_FAIL
    cmp.l #0xffffbd1b, %d1
    bne TEST_FAIL


    /**
     * LOOP TEST DIVS.L
     */

    /* Setup counters */
    mov.l #0, -(%sp) | Flags accu
    mov.l #0, -(%sp) | Rem accu
    mov.l #0, -(%sp) | Quot accu

    mov.l #0x8A221593, %d5 | Outer var hi part
    mov.l #0x7FAFCDE8, %d4 | Outer var low part
    mov.l #0x10, %d2 | Outer counter
divsl_outer:
    mov.l #0xF57BA10A, %d3 | Inner var
    mov.l #0x10, %d1 | Inner counter
divsl_inner:

    mov.l %d4, %d6
    mov.l %d5, %d0
    mov.l #0, %d7
    mov.w #0, %ccr
    divs.l %d3, %d0, %d6 | Div %d0-%d6 / %d3, result in %d6, rem in %d0
    mov.w %ccr, %d7

    /* Add the quotient */
    add.l %d6, (%sp)
    /* Add the remainder */
    add.l %d0, (%sp, 4)
    /* Add the flags */
    add.l %d7, (%sp, 8)

    /* Update inner var */
    lsr.l #1, %d3
    dbf %d1, divsl_inner

    /* Update outer var */
    jsr rot64
    dbf %d2, divsl_outer

    /* Get the counters back */
    mov.l (%sp)+, %d0 | Quot
    mov.l (%sp)+, %d1 | Rem
    mov.l (%sp)+, %d2 | Flags

    /* Results xchecked in python */
    cmp.l #0x8e268eb2, %d0
    bne TEST_FAIL
    cmp.l #0x8bfc599d, %d1
    bne TEST_FAIL
    cmp.l #0x226, %d2
    bne TEST_FAIL

    rts

rot64:
    /** Rotates the 64 bit %d5-%d4 left by one. Smashes %d7 */

    /* Ensure X is clear */
    mov.w #0, %ccr

    roxl.l #1, %d4
    roxl.l #1, %d5
    /* Probably a smarter way to do this.. */
    mov.w %ccr, %d7
    andi.w #1, %d7 | C bit was set by last roxl
    or.w %d7, %d4
    rts


DIV0_HANDLER:
    mov.l #0xABCDEF01, %d4
    rte

