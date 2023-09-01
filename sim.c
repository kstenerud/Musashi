#include "m68k.h"
#include <stdio.h>
#include <stdint.h>

unsigned int cpu_read_byte(unsigned int address);
unsigned int cpu_read_word(unsigned int address);
unsigned int cpu_read_long(unsigned int address);
void cpu_write_byte(unsigned int address, unsigned int value);
void cpu_write_word(unsigned int address, unsigned int value);
void cpu_write_long(unsigned int address, unsigned int value);

int main(int argc, char** argv) {

    // Begin execution
    while (1) {
        m68k_execute(1);
    }

    return 0;
}
