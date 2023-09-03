//
// Created by SidQian on 8/31/23.
//

#ifndef README_MD_MAIN_H
#define README_MD_MAIN_H
unsigned int  m68k_read_memory_8(unsigned int address);
unsigned int  m68k_read_memory_16(unsigned int address);
unsigned int  m68k_read_memory_32(unsigned int address);
void m68k_write_memory_8(unsigned int address, unsigned int value);
void m68k_write_memory_16(unsigned int address, unsigned int value);
void m68k_write_memory_32(unsigned int address, unsigned int value);


#endif //README_MD_MAIN_H
