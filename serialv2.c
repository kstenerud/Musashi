// serial version 2
// this file works with the assumption that we're using bit shifting operations

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
    unsigned char aReceive;
    unsigned char aTransmit;
    unsigned char bReceive;
    unsigned char bTransmit;
};

// Unlike C++ structs in C can't have member functions, so it will be a global variable
// that is called by functions below, also have to specify that serial_chip is struct in
// declaration
struct serial_chip chip;

// setting everything to 0
void struct_init(){
    chip.aReceive = 0;
    chip.aTransmit = 0;
    chip.bReceive = 0;
    chip.bTransmit = 0;
}


// FUNCTION PARAMETERS:
// channel = decide between a and b channels
// val = new val to be written into said index

// data going from processor to serial via xReceive
void serial_write(char channel, char val){
    if(toupper(channel) == 'A'){
        WRITE_8(chip.aReceive, &chip.aReceive, val);
    }
    else if(toupper(channel) == 'B'){
        WRITE_8(chip.bReceive, &chip.bReceive, val);
    }
    else{ // Only allowed to look at A and B channels
        exit_error("Invalid channel name. Use either 'A' or 'B'");
    }
}

// data going from the serial to the processor via xTransmit
char serial_read(char channel){

    if(toupper(channel) == 'A'){
        return READ_8(chip.aTransmit, &chip.aTransmit);
    }
    else if(toupper(channel) == 'B'){
        return READ_8(chip.bTransmit, &chip.bTransmit);
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

// FOR LATER: emulate interrupts


