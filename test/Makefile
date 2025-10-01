M68K_AS = m68k-elf-as
M68K_ASFLAGS = -march=68040 -g --gdwarf-sections -I$(CURDIR)
M68K_LD = m68k-elf-ld
M68K_LDFLAGS = -Ttext 0x10000 --oformat binary

export

default: all

all:
	@$(MAKE) -C mc68000 all

clean:
	@$(MAKE) -C mc68000 clean

.PHONY: clean all
