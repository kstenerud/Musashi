
.TESTS_68040 = bfchg.s bfclr.s bfext.s bfffo.s bfins.s bfset.s bftst.s divs_long.s divu_long.s mul_long.s \
	shifts3.s trapcc.s


.TESTS_68040_O = $(.TESTS_68040:%.s=%.o)
$(.TESTS_68040_O): %.o: %.s
	$(M68K_AS) $(M68K_ASFLAGS) -o $@ $<

.TESTS_68040_BIN = $(.TESTS_68040_O:%.o=%.bin)
$(.TESTS_68040_BIN): %.bin: %.o
	$(M68K_LD) $(M68K_LDFLAGS) -o $@ $<

all: $(.TESTS_68040_BIN)

.PHONY: clean
clean:
	rm -f $(.TESTS_68040_O)
	rm -f $(.TESTS_68040_BIN)
