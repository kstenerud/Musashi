M68K_AS = m68k-elf-as
M68K_ASFLAGS = -march=68040 -g --gdwarf-sections
M68K_LD = m68k-elf-ld
M68K_LDFLAGS = -Ttext 0x10000 --oformat binary
EXE =

default: all

.TESTS_68000 = abcd.s adda.s add_i.s addq.s add.s addx.s andi_to_ccr.s andi_to_sr.s and.s \
               bcc.s bchg.s bclr.s bool_i.s bset.s bsr.s btst.s \
               chk.s cmpa.s cmpm.s cmp.s dbcc.s divs.s divu.s eori_to_ccr.s eori_to_sr.s eor.s exg.s ext.s \
               lea_pea.s lea_tas.s lea_tst.s links.s \
               movem.s movep.s moveq.s move.s move_usp.s move_xxx_flags.s muls.s mulu.s \
               nbcd.s negs.s op_cmp_i.s ori_to_ccr.s ori_to_sr.s or.s \
               rox.s roxx.s rtr.s sbcd.s scc.s shifts2.s shifts.s suba.s sub_i.s subq.s sub.s subx.s swap.s trapv.s

.OFILES =  $(.TESTS_68000:%.s=%.o)
.BINFILES = $(.TESTS_68000_O:%.o=%.bin)

.TESTS_68000_O = $(.TESTS_68000:%.s=%.o)
$(.TESTS_68000_O): %.o: %.s
	$(M68K_AS) $(M68K_ASFLAGS) -o $@ $<

.TESTS_68000_BIN = $(.TESTS_68000_O:%.o=%.bin)
$(.TESTS_68000_BIN): %.bin: %.o
	$(M68K_LD) $(M68K_LDFLAGS) -o $@ $<

all: $(.TESTS_68000_BIN)

.PHONY: clean all
clean:
	rm -f $(.OFILES)
	rm -f $(.BINFILES)
