#include "m68k.h"
#include "sim.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>


#define MAX_ROM 0xfff                           /* Memory size for rom */
#define MAX_RAM 0xff                            /* Memory size for ram */
#define MAX_MEM (MAX_ROM+MAX_RAM)               /* ROM and RAM sizes */

/* Read/write macros */
#define READ_8(BASE, ADDR) (BASE)[ADDR]
#define READ_16(BASE, ADDR) (((BASE)[ADDR] << 8) | (BASE)[(ADDR) + 1])
#define READ_32(BASE, ADDR) (                            \
    ((BASE)[ADDR] << 24) |                               \
    ((BASE)[(ADDR) + 1] << 16) |                         \
    ((BASE)[(ADDR) + 2] << 8) |                          \
    (BASE)[(ADDR) + 3]                                   \
)

#define WRITE_8(BASE, ADDR, VAL) (BASE)[ADDR] = (VAL)&0xff
#define WRITE_16(BASE, ADDR, VAL) do {                   \
    (BASE)[ADDR] = ((VAL) >> 8) & 0xff;                  \
    (BASE)[(ADDR) + 1] = (VAL) & 0xff;                   \
} while(0)
#define WRITE_32(BASE, ADDR, VAL) do {                   \
    (BASE)[ADDR] = ((VAL) >> 24) & 0xff;                 \
    (BASE)[(ADDR) + 1] = ((VAL) >> 16) & 0xff;           \
    (BASE)[(ADDR) + 2] = ((VAL) >> 8) & 0xff;            \
    (BASE)[(ADDR) + 3] = (VAL) & 0xff;                   \
} while(0)


/* Prototypes */
void exit_error(char* fmt, ...);
unsigned int  m68k_read_memory_8(unsigned int address);
unsigned int  m68k_read_memory_16(unsigned int address);
unsigned int  m68k_read_memory_32(unsigned int address);
void m68k_write_memory_8(unsigned int address, unsigned int value);
void m68k_write_memory_16(unsigned int address, unsigned int value);
void m68k_write_memory_32(unsigned int address, unsigned int value);


unsigned char g_mem[MAX_MEM+1];                 /* Memory in one array */

/* struct definition */
struct section {
    const char* name;
    unsigned int address;
    unsigned int size;
};


/* Exit with an error message.  Use printf syntax. */
void exit_error(char* fmt, ...) {
    va_list args;
    // Start processing variable arguments
    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    fprintf(stderr, "\n");
    va_end(args);
    exit(EXIT_FAILURE);
}

/* reads in 8 bits from memory array */
unsigned int m68k_read_memory_8(unsigned int address) {
    if (address >= MAX_MEM) {
        exit_error("Attempted to read byte from address %08x beyond memory size", address);
    }
    return READ_8(g_mem, address);
}

/* reads in 16 bits from memory array */
unsigned int m68k_read_memory_16(unsigned int address) {
    if (address >= MAX_MEM) {
        exit_error("Attempted to read byte from address %08x beyond memory size", address);
    }
    return READ_16(g_mem, address);
}

/* reads in 32 bits from memory array */
unsigned int m68k_read_memory_32(unsigned int address) {
    if (address >= MAX_MEM) {
        exit_error("Attempted to read byte from address %08x beyond memory size", address);
    }
    return READ_32(g_mem, address);
}

/* write in 8 bits to memory array */
void m68k_write_memory_8(unsigned int address, unsigned int value) {
    if (address > MAX_MEM) {
        exit_error("Attempted to write byte to address %08x beyond memory size", address);
    }
    // Check if the address is within the ROM range
    if (address <= MAX_ROM) {
        exit_error("Attempted to write byte to ROM address %08x", address);
    }
    WRITE_8(g_mem, address, value);
}

/* write in 16 bits to memory array */
void m68k_write_memory_16(unsigned int address, unsigned int value) {
    if (address > MAX_MEM) {
        exit_error("Attempted to write byte to address %08x beyond memory size", address);
    }
    // Check if the address is within the ROM range
    if (address <= MAX_ROM) {
        exit_error("Attempted to write byte to ROM address %08x", address);
    }
    WRITE_16(g_mem, address, value);
}

/* write in 32 bits to memory array */
void m68k_write_memory_32(unsigned int address, unsigned int value) {
    if (address > MAX_MEM) {
        exit_error("Attempted to write byte to address %08x beyond memory size", address);
    }
    // Check if the address is within the ROM range
    if (address <= MAX_ROM) {
        exit_error("Attempted to write byte to ROM address %08x", address);
    }
    WRITE_32(g_mem, address, value);
}

unsigned int m68k_read_disassembler_16(unsigned int address)
{
    if(address > MAX_ROM)
        exit_error("Disassembler attempted to read word from ROM address %08x", address);
    return READ_16(g_mem, address);
}

unsigned int m68k_read_disassembler_32(unsigned int address)
{
    if(address > MAX_ROM)
        exit_error("Dasm attempted to read long from ROM address %08x", address);
    return READ_32(g_mem, address);
}

/* The sections to load */
struct section sections[] = {
        {"text", 0x0000c000, 0x001f5bfc},
        {"rodata", 0x00201c00, 0x0002f885},
        {"link_set_sysctl_funcs", 0x00231488, 0x000000c8},
        {"link_set_modules", 0x00231550, 0x00000108},
        {"link_set_domains", 0x00231658, 0x00000020},
        {"link_set_evcnts", 0x00231678, 0x00000048},
        {"link_set_dkwedge_methods", 0x002316c0, 0x00000004},
        {"link_set_prop_linkpools", 0x002316c4, 0x00000020},
        {"data", 0x00231740, 0x00016b8c},
        {"bss", 0x00248300, 0x00018858},
};

/* Load a section from a file into memory */
void load_section(const struct section* sec) {
    char filepath[128];
    snprintf(filepath, sizeof(filepath), "./bins/%s.bin", sec->name);

    FILE *fhandle = fopen(filepath, "rb");
    if (!fhandle) {
        exit_error("Unable to open %s", filepath);
    }

    fread(&g_mem[sec->address], 1, sec->size, fhandle);
    fclose(fhandle);
}

int main(int argc, char** argv) {
    for (int i = 0; i < sizeof(sections) / sizeof(sections[0]); i++) {
        load_section(&sections[i]);
    }
    m68k_init();
    m68k_set_cpu_type(M68K_CPU_TYPE_68000);
    m68k_pulse_reset();

}
