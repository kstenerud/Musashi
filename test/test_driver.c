
#include "m68k.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

unsigned int m68k_read_disassembler_16 (unsigned int /*address*/) {
    exit(EXIT_FAILURE);
}
unsigned int m68k_read_disassembler_32 (unsigned int /*address*/) {
    exit(EXIT_FAILURE);
}

typedef struct memory_device_tag_t {
    uint32_t mask;

    uint8_t (*read8)(struct memory_device_tag_t*, uint32_t);
    uint16_t (*read16)(struct memory_device_tag_t*, uint32_t);
    uint32_t (*read32)(struct memory_device_tag_t*, uint32_t);
    void (*write8)(struct memory_device_tag_t*, uint32_t, uint8_t);
    void (*write16)(struct memory_device_tag_t*, uint32_t, uint16_t);
    void (*write32)(struct memory_device_tag_t*, uint32_t, uint32_t);
} memory_device_t;

#define BLOCK_SIZE 0x10000
#define MMAP_SIZE 0x10000

memory_device_t* memory_map[MMAP_SIZE];

uint8_t read8_fail(memory_device_t*, uint32_t) {
    m68k_pulse_bus_error();
    return 0;
}
uint16_t read16_fail(memory_device_t*, uint32_t) {
    m68k_pulse_bus_error();
    return 0;
}
uint32_t read32_fail(memory_device_t*, uint32_t) {
    m68k_pulse_bus_error();
    return 0;
}
void write8_fail(memory_device_t*, uint32_t, uint8_t) {
    m68k_pulse_bus_error();
}
void write16_fail(memory_device_t*, uint32_t, uint16_t) {
    m68k_pulse_bus_error();
}
void write32_fail(memory_device_t*, uint32_t, uint32_t) {
    m68k_pulse_bus_error();
}

static memory_device_t mdev_not_mapped = {
    0,
    read8_fail, read16_fail, read32_fail,
    write8_fail, write16_fail, write32_fail
};

void memory_map_init() {
    for (size_t i = 0; i < MMAP_SIZE; ++i) {
        memory_map[i] = &mdev_not_mapped;
    }
}

void memory_map_add(memory_device_t* dev, uint32_t start_addr, uint32_t size) {
    assert(start_addr % BLOCK_SIZE == 0);
    assert(size % BLOCK_SIZE == 0);

    unsigned count = size / BLOCK_SIZE;
    unsigned off = start_addr / BLOCK_SIZE;
    for (unsigned i = 0; i < count; ++i) {
        memory_map[off + i] = dev;
    }
}

unsigned int m68k_read_memory_8(unsigned int address) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    return dev->read8(dev, dev->mask & address);
}

unsigned int m68k_read_memory_16(unsigned int address) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    return dev->read16(dev, dev->mask & address);
}
unsigned int m68k_read_memory_32(unsigned int address) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    return dev->read32(dev, dev->mask & address);
}

void m68k_write_memory_8(unsigned int address, unsigned int value) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    dev->write8(dev, dev->mask & address, value);
}
void m68k_write_memory_16(unsigned int address, unsigned int value) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    dev->write16(dev, dev->mask & address, value);
}

void m68k_write_memory_32(unsigned int address, unsigned int value) {
    unsigned slot = address / BLOCK_SIZE;
    memory_device_t * dev = memory_map[slot];
    dev->write32(dev, dev->mask & address, value);
}


///
/// Test device
typedef struct test_device_tag_t {
    memory_device_t dev;
    uint32_t test_pass_count;
    uint32_t test_fail_count;
} test_device_t;

uint8_t test_read8(memory_device_t*, uint32_t) { return 0; }
uint16_t test_read16(memory_device_t*, uint32_t) { return 0; }
uint32_t test_read32(memory_device_t*, uint32_t) { return 0; }

void test_write8(memory_device_t*, uint32_t addr, uint8_t val) {
    if (addr == 0x14) {
        char ss[2] = {val, 0};
        puts(ss);
    }
}

void test_write16(memory_device_t*, uint32_t /*addr*/, uint16_t /*val*/) {}

void test_write32(memory_device_t* dev, uint32_t addr, uint32_t /*val*/) {
    test_device_t* td = (test_device_t*)dev;
    if (addr == 0x0)
        ++td->test_fail_count;
    if (addr == 0x4)
        ++td->test_pass_count;
    // if (addr == 0x8)
    //     print_registers(*machine);
    // if (addr == 0xc) {
    //     am68k::set_irq(*machine, value & 0x7);
    // }
    // if (addr == 0x20)
    //     print_fp(*machine, value);
}
void test_device_init(test_device_t* dev) {
    dev->test_pass_count = 0;
    dev->test_fail_count = 0;
    dev->dev.mask = 0x10000 - 1;
    dev->dev.read8 = test_read8;
    dev->dev.read16 = test_read16;
    dev->dev.read32 = test_read32;
    dev->dev.write8 = test_write8;
    dev->dev.write16 = test_write16;
    dev->dev.write32 = test_write32;
}

//
// Ram slot
#define RAM_SLOT_SIZE 0x10000

typedef struct ram_slot_tag_t {
    memory_device_t dev;
    uint8_t memory[RAM_SLOT_SIZE];
} ram_slot_t;

uint8_t ram_slot_read8(memory_device_t* dev, uint32_t addr) {
    assert(addr < RAM_SLOT_SIZE);
    return ((ram_slot_t*)dev)->memory[addr];
}
uint16_t ram_slot_read16(memory_device_t* dev, uint32_t addr) {
    if (addr + 1 >= RAM_SLOT_SIZE) {
        m68k_pulse_bus_error();
        return 0;
    }
    return
        (((uint16_t)ram_slot_read8(dev, addr + 0)) << 8) |
        (((uint16_t)ram_slot_read8(dev, addr + 1)) << 0);
}
uint32_t ram_slot_read32(memory_device_t* dev, uint32_t addr) {
    return
        (((uint32_t)ram_slot_read16(dev, addr + 0)) << 16) |
        (((uint32_t)ram_slot_read16(dev, addr + 2)) << 0);
}
void ram_slot_write8(memory_device_t* dev, uint32_t addr, uint8_t val) {
    assert(addr < RAM_SLOT_SIZE);
    ((ram_slot_t*)dev)->memory[addr] = val;
}
void ram_slot_write16(memory_device_t* dev, uint32_t addr, uint16_t val) {
    if (addr + 1 >= RAM_SLOT_SIZE) {
        m68k_pulse_bus_error();
        return;
    }
    ram_slot_write8(dev, addr + 0, (val >> 8) & 0xFF);
    ram_slot_write8(dev, addr + 1, (val >> 0) & 0xFF);
}
void ram_slot_write32(memory_device_t* dev, uint32_t addr, uint32_t val) {
    ram_slot_write16(dev, addr + 0, (val >> 16) & 0xFFFF);
    ram_slot_write16(dev, addr + 2, (val >> 0) & 0xFFFF);
}

void ram_slot_init(ram_slot_t* dev) {
    dev->dev.mask = RAM_SLOT_SIZE - 1;
    dev->dev.read8 = ram_slot_read8;
    dev->dev.read16 = ram_slot_read16;
    dev->dev.read32 = ram_slot_read32;
    dev->dev.write8 = ram_slot_write8;
    dev->dev.write16 = ram_slot_write16;
    dev->dev.write32 = ram_slot_write32;
}

//
// Rom slot
#define ROM_SLOT_SIZE 0x10000

typedef struct rom_slot_tag_t {
    memory_device_t dev;
    uint8_t memory[ROM_SLOT_SIZE];
} rom_slot_t;

uint8_t rom_slot_read8(memory_device_t* dev, uint32_t addr) {
    assert(addr < ROM_SLOT_SIZE);
    return ((rom_slot_t*)dev)->memory[addr];
}
uint16_t rom_slot_read16(memory_device_t* dev, uint32_t addr) {
    if (addr + 1 >= ROM_SLOT_SIZE) {
        m68k_pulse_bus_error();
        return 0;
    }
    return
    (((uint16_t)rom_slot_read8(dev, addr + 0)) << 8) |
    (((uint16_t)rom_slot_read8(dev, addr + 1)) << 0);
}
uint32_t rom_slot_read32(memory_device_t* dev, uint32_t addr) {
    return
    (((uint32_t)rom_slot_read16(dev, addr + 0)) << 16) |
    (((uint32_t)rom_slot_read16(dev, addr + 2)) << 0);
}
void rom_slot_write8(memory_device_t* /*dev*/, uint32_t /*addr*/, uint8_t /*val*/) {
    m68k_pulse_bus_error();
}
void rom_slot_write16(memory_device_t* /*dev*/, uint32_t /*addr*/, uint16_t /*val*/) {
    m68k_pulse_bus_error();
}
void rom_slot_write32(memory_device_t* /*dev*/, uint32_t /*addr*/, uint32_t /*val*/) {
    m68k_pulse_bus_error();
}

size_t rom_slot_init(rom_slot_t* dev, FILE* file) {
    dev->dev.mask = ROM_SLOT_SIZE - 1;
    dev->dev.read8 = rom_slot_read8;
    dev->dev.read16 = rom_slot_read16;
    dev->dev.read32 = rom_slot_read32;
    dev->dev.write8 = rom_slot_write8;
    dev->dev.write16 = rom_slot_write16;
    dev->dev.write32 = rom_slot_write32;
    if (file)
        return fread(dev->memory, 1, ROM_SLOT_SIZE, file);
    return 0;
}


/// Devices
ram_slot_t g_stack;
ram_slot_t g_extra_ram1;

#define N_ROMS 4
rom_slot_t g_roms[N_ROMS];

test_device_t g_test_device;

void setup_memory() {
    memory_map_init();

    memory_map_add(&g_stack.dev, 0x0, RAM_SLOT_SIZE);
    for (unsigned i = 0; i < N_ROMS; ++i)
        memory_map_add(&g_roms[i].dev, RAM_SLOT_SIZE + ROM_SLOT_SIZE * i, ROM_SLOT_SIZE);
    memory_map_add(&g_extra_ram1.dev, 0x300000, RAM_SLOT_SIZE);

    memory_map_add(&g_test_device.dev, 0x100000, 0x10000);
}

void setup_bootsec() {
    // Deadbeef them all
    for (int i = 0; i < 64; ++i)
        m68k_write_memory_32(i * 4, 0xdeadbeef);

    // Write the boot vectors
    m68k_write_memory_32(0, 0x3F0);    // SP
    m68k_write_memory_32(4, 0x10000);  // Entry
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: test_driver filename.bin\n");
        return EXIT_FAILURE;
    }

    int arg = 1;
    FILE * infile = fopen(argv[arg], "rb");
    if (!infile) {
        printf("Cannot open: %s\n", argv[arg]);
        return EXIT_FAILURE;
    }
    arg++;

    while (arg < argc) {
        const char* a = argv[arg];

        if (strncmp(a, "--", 2) != 0)
            break;

        // Other opts here

        printf("Unknown option: %s\n", a);
        return EXIT_FAILURE;
        ++arg;
    }

    // Parse FP test data - if requested
    if (arg < argc) {
        printf("FP data not implemented\n");
        return EXIT_FAILURE;
        // if (arg + 3 > argc) {
        //     std::cerr
        //     << "Usage: test_driver filename.bin fpfile operand_num fpcr"
        //     << std::endl;
        //     return EXIT_FAILURE;
        // }
        //
        // const char* fpfile = argv[arg++];
        // unsigned opnum = std::strtoul(argv[arg++], nullptr, 10);
        // uint32_t fpcr = std::strtoul(argv[arg++], nullptr, 16);
        // fp_support.emplace(load_fp_support(fpfile, opnum, fpcr));
    }

    ram_slot_init(&g_stack);
    ram_slot_init(&g_extra_ram1);
    for (int i = 0; i < N_ROMS; ++i) {
        rom_slot_init(&g_roms[i], infile);
    }

    test_device_init(&g_test_device);

    setup_memory();
    setup_bootsec();

    m68k_init();
    m68k_set_cpu_type(M68K_CPU_TYPE_68040);
    m68k_pulse_reset();

    for (int i = 0; i < 100; ++i) {
        const int n_cycles = 0x1000000;

        m68k_execute(n_cycles);
    }

    printf("test_pass_count = %d\n", g_test_device.test_pass_count);
    printf("test_fail_count = %d\n", g_test_device.test_fail_count);

    const bool pass =
        (g_test_device.test_fail_count == 0 && g_test_device.test_pass_count > 0);
    return pass ? 0 : EXIT_FAILURE;
}
