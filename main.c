#include "m68k.h"
#include <stdio.h>
#include <stdint.h>

void load_section(uint8_t* memory, uint32_t address, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        perror("Failed to open file");
        return;
    }

    fseek(file, 0, SEEK_END);
    size_t size = ftell(file);
    rewind(file);

    fread(memory + address, 1, size, file);

    fclose(file);
}

int main(int argc, char** argv) {
    // Initialize the CPU
    m68k_init();
    m68k_set_cpu_type(M68K_CPU_TYPE_68000);
    m68k_pulse_reset();

    // Create an array to represent the memory of the machine.
    uint8_t memory[0x400000] = {0};  // 4 MB of memory

    // Load sections
    load_section(memory, 0x0000c000, "../bins/text.bin");
    load_section(memory, 0x00201c00, "../bins/rodata.bin");
    load_section(memory, 0x00231488, "../bins/link_set_sysctl_funcs.bin");
    load_section(memory, 0x00231550, "../bins/link_set_modules.bin");
    load_section(memory, 0x00231658, "../bins/link_set_domains.bin");
    load_section(memory, 0x00231678, "../bins/link_set_evcnts.bin");
    load_section(memory, 0x002316c0, "../bins/link_set_dkwedge_methods.bin");
    load_section(memory, 0x002316c4, "../bins/link_set_prop_linkpools.bin");
    load_section(memory, 0x002316e4, "../bins/eh_frame.bin");
    load_section(memory, 0x00231740, "../bins/data.bin");
    load_section(memory, 0x00248300, "../bins/bss.bin");

    m68k_set_reg(M68K_REG_PC, 0x0000c000);

    // Begin execution
    while (1) {
        m68k_execute(1);
    }

    return 0;
}
