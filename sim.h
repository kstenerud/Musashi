//
// Created by SidQian on 8/31/23.
//

#ifndef README_MD_MAIN_H
#define README_MD_MAIN_H
unsigned int cpu_read_byte(unsigned int address);
unsigned int cpu_read_word(unsigned int address);
unsigned int cpu_read_long(unsigned int address);
void cpu_write_byte(unsigned int address, unsigned int value);
void cpu_write_word(unsigned int address, unsigned int value);
void cpu_write_long(unsigned int address, unsigned int value);

#endif //README_MD_MAIN_H
