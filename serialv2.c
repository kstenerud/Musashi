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

    unsigned char aReceive[16]; 
    unsigned char aTransmit[16];
    unsigned char bReceive[16];
    unsigned char bTransmit[16];

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

    for(int i=0; i<16; ++i){
        if(i<5){
            chip.controlRegister[i] = 0;
        }
        if(i<8){
            chip.statusRegister[i] = 0;
        }
        chip.aReceive[i] = 0;
        chip.aTransmit[i] = 0;
        chip.bReceive[i] = 0;
        chip.bTransmit[i] = 0;
    }

}


// FUNCTION PARAMETERS:
// channel = decide between a and b channels
// val = new val to be written into said index


// transmit: processor (m68k) -> serial chip's transmit buffer -> other separate devices [one byte at a time]
unsigned char serial_transmit(char channel, char val){
    if(toupper(channel) == 'A'){
        WRITE_8(chip.aTransmit, /* buffer write pointer */, val);
        return chip.aTransmit[/* */];
    }
    else if(toupper(channel) == 'B'){
        WRITE_8(chip.bTransmit, /* buffer write pointer */, val);
        return chip.bTransmit[/* */];
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
            printf(chip.aTransmit);
        }
        else if(type == 'r'){
            printf(chip.aReceive);
        }
        else{
            exit_error("Invalid channel type");
        }
    }
    else if(toupper(channel) == 'B'){
        if(type == 't'){
            printf(chip.aTransmit);
        }
        else if(type == 'r'){
            printf(chip.aReceive);
        }
        else{
            exit_error("Invalid channel type. Use either 't' (transmit) or 'r' (receive)");
        }
    }  
    else{
        printf("Invalid channel name. Use either A or B");
    }
}
