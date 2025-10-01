# Just a basic makefile to quickly test that everyting is working, it just
# compiles the .o and the generator

MUSASHIFILES     = m68kcpu.c m68kdasm.c softfloat/softfloat.c
MUSASHIGENCFILES = m68kops.c
MUSASHIGENHFILES = m68kops.h
MUSASHIGENERATOR = m68kmake

EXE =
EXEPATH = ./

.CFILES   = $(MAINFILES) $(OSDFILES) $(MUSASHIFILES) $(MUSASHIGENCFILES)
.OFILES   = $(.CFILES:%.c=%.o)

CC        = gcc
WARNINGS  = -Wall -Wextra -pedantic -g
CFLAGS    = $(WARNINGS)
LFLAGS    = $(WARNINGS)

DELETEFILES = $(MUSASHIGENCFILES) $(MUSASHIGENHFILES) $(.OFILES) $(TARGET) $(MUSASHIGENERATOR)$(EXE)


all: $(.OFILES)

clean:
	rm -f $(DELETEFILES)

m68kcpu.o: $(MUSASHIGENHFILES) m68kfpu.c m68kmmu.h softfloat/softfloat.c softfloat/softfloat.h

$(MUSASHIGENCFILES) $(MUSASHIGENHFILES): $(MUSASHIGENERATOR)$(EXE)
	$(EXEPATH)$(MUSASHIGENERATOR)$(EXE)

$(MUSASHIGENERATOR)$(EXE):  $(MUSASHIGENERATOR).c
	$(CC) -o  $(MUSASHIGENERATOR)$(EXE)  $(MUSASHIGENERATOR).c

test_driver$(EXE): test/test_driver.c $(.OFILES)
	$(CC) $(CFLAGS) -o test_driver$(EXE) test/test_driver.c $(.OFILES) -I. -lm


TESTS_68000 = abcd adda add_i addq add addx andi_to_ccr andi_to_sr and \
               bcc bchg bclr bool_i bset bsr btst \
               chk cmpa cmpm cmp dbcc divs divu eori_to_ccr eori_to_sr eor exg ext \
               lea_pea lea_tas lea_tst links \
               movem movep moveq move move_usp move_xxx_flags muls mulu \
               nbcd negs op_cmp_i ori_to_ccr ori_to_sr or \
               rox roxx rtr sbcd scc shifts2 shifts suba sub_i subq sub subx swap trapv

TESTS_68000_RUN = $(TESTS_68000:%=%.bin)
$(TESTS_68000_RUN): %.bin: test_driver$(EXE)
	./test_driver$(EXE) test/$@


tests: $(TESTS_68000_RUN)
