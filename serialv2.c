// serial version 2
// this file works with the assumption that we're using bit shifting operations


/* TO DO ------------------------------------------------

 
1.  make functions that control reads/writes to control + status registers
2.  circular buffer


(maybe: emulate interrupts)

*/




#include <ctype.h> // for toupper
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>


/*--------------------------FROM SIM.C---------------------------------------------*/

// maybe change this later if we don't want the program to end whenver there is an error
// reading/writing to the serial chip
void exit_error(char* fmt, ...){
    va_list args;
    // Start processing variable arguments
    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    fprintf(stderr, "\n");
    va_end(args);
    exit(EXIT_FAILURE);
}

#define READ_8(BASE, ADDR) (BASE)[ADDR]
#define WRITE_8(BASE, ADDR, VAL) (BASE)[ADDR] = (VAL)&0xff

/*-------------------------------------------------------------------------------*/

// circular buffer struct
struct circular_buffer{
    unsigned char buffer[16];
    // read and write pointers point to the index of the buffer
    int readPointer;
    int writePointer;
};

void buffer_init(struct circular_buffer* buffer){
    // initialize read and write pointers point to the index of the buffer
    buffer->readPointer = 0;
    buffer->writePointer = 0;
    // initialize buffer to 0
    for(int i=0; i<16; ++i){
        buffer->buffer[i] = 0;
    }
}

// circular buffer functions
// read from buffer at read pointer
unsigned char buffer_read(struct circular_buffer* buffer){
    // if buffer is empty, return -1
    if(buffer->readPointer == buffer->writePointer){
        return -1;
    }
    // else, read value at read pointer and increment read pointer
    else{
        unsigned char val = buffer->buffer[buffer->readPointer];
        buffer->readPointer = (buffer->readPointer + 1) % 16;
        return val;
    }
}

// write to buffer
void buffer_write(struct circular_buffer* buffer, unsigned char val){
    // if buffer is full, return -1
    if((buffer->writePointer + 1) % 16 == buffer->readPointer){
        return -1;
    }
    // else, write value to write pointer and increment write pointer
    else{
        buffer->buffer[buffer->writePointer] = val;
        buffer->writePointer = (buffer->writePointer + 1) % 16;
    }
}

// print existing items in buffer, empty spaces are represented by 0 so don't print those
void buffer_print(struct circular_buffer* buffer){
    for(int i=0; i<16; ++i){
        if(buffer->buffer[i] != 0){
            printf("%c", buffer->buffer[i]);
        } else {
            break;
        }
    }
}


// struct definition: represents each of the 4 registers that are used for serial communication
// most likely that we'll only be reading to one channel from the microprocessor, but I'm just keeping
// this in there
struct serial_chip{

    /* ---------- SIO BUFFERS
     
    these buffers should be circular buffers
    make sure that reading/writing only happen if there is space within buffer
    if read/write pointers overlap, buffer is full -> don't write anymore to buffer
    if read/write are one apart, buffer is empty

    Note: Waiting to hear back from Goodney to see if we can make A channel and B channel one array, or
    if we keep separate ones for Receive and Transmit <- also look on dataseet

    */

    struct circular_buffer aReceive; 
    struct circular_buffer aTransmit;
    struct circular_buffer bReceive;
    struct circular_buffer bTransmit;

    //---------- CONTROL AND STATUS REGISTERS -------------------------------------

    unsigned char controlRegister[8];
    unsigned char statusRegister[5];
};


// Unlike C++ structs in C can't have member functions, so it will be a global variable
// that is called by functions below, also have to specify that serial_chip is struct in
// declaration
struct serial_chip chip;

// setting everything to 0
void chip_init(){
    // initialize the chip's registers to 0 by calling buffer_init on each of them
    buffer_init(&chip.aReceive);
    buffer_init(&chip.aTransmit);
    buffer_init(&chip.bReceive);
    buffer_init(&chip.bTransmit);
    // initialize control and status registers to 0
    for(int i=0; i<8; ++i){
        chip.statusRegister[i] = 0;
        if(i<5){
            chip.controlRegister[i] = 0;
        }
    }
}


// FUNCTION PARAMETERS:
// channel = decide between a and b channels
// val = new val to be written into said index


// transmit: processor (m68k) -> serial chip's transmit buffer -> other separate devices [one byte at a time]
unsigned char serial_transmit(char channel, char val){
    if(toupper(channel) == 'A'){
        WRITE_8(chip.aTransmit, &chip.aTransmit.writePointer, val);
        return buffer_read(&chip.aTransmit);
    }
    else if(toupper(channel) == 'B'){
        WRITE_8(chip.bTransmit, &chip.bTransmit.writePointer, val);
        return buffer_read(&chip.bTransmit);
    }
    else{ // Only allowed to look at A and B channels
        exit_error("Invalid channel name. Use either 'A' or 'B'");
    }
}

// receive: other separate devices -> serial chip's receive buffer -> processor (m68k) [one byte at a time]
unsigned char serial_read(char channel){

    if(toupper(channel) == 'A'){
        return chip.aReceive[/* buffer read pointer */];
    }
    else if(toupper(channel) == 'B'){
        return chip.bReceive[/* buffer read pointer */];
    }
    else{ // Only allowed to look at A and B channels
        exit_error("Invalid channel name. Use either 'A' or 'B'");
    }
}

// for output purposes
void print_register(char channel, char type){
    if(toupper(channel) == 'A'){
        if(type == 't'){
            buffer_print(&chip.aTransmit);
        }
        else if(type == 'r'){
            buffer_print(&chip.aReceive);
        }
        else{
            exit_error("Invalid channel type");
        }
    }
    else if(toupper(channel) == 'B'){
        if(type == 't'){
            buffer_print(&chip.bTransmit);
        }
        else if(type == 'r'){
            buffer_print(&chip.bReceive);
        }
        else{
            exit_error("Invalid channel type. Use either 't' (transmit) or 'r' (receive)");
        }
    }  
    else{
        printf("Invalid channel name. Use either A or B");
    }
}
