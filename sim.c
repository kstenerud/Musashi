#include "m68k.h"
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

/* reads in 8 bytes from memory array */
unsigned int m68k_read_memory_8(unsigned int address) {
    if (address >= MAX_MEM) {
        exit_error("Attempted to read byte from address %08x beyond memory size", address);
    }
    return READ_8(g_mem, address);
}

//todo: m68k_read_memory_16
unsigned int m68k_read_memory_16(unsigned int address) {

}

//todo: m68k_read_memory_32
unsigned int m68k_read_memory_32(unsigned int address) {
}

/* write in 8 bytes to memory array */
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

/* write in 16 bytes to memory array */
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

//todo: m68k_write_memory_32
void m68k_write_memory_32(unsigned int address, unsigned int value) {
}



int main(int argc, char** argv) {

    // Begin execution
    while (1) {
        m68k_execute(1);
    }

    return 0;
}
