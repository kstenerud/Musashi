#include "sim.h"
#include <ctype.h> // for toupper


// struct represents each of the 4 addresses that are used for serial communication 
struct serial_chip{
    char aReceive[8];
    char aTransmit[8];
    char bReceive[8];
    char bTransmit[8];
};

// Unlike C++ structs in C can't have member functions, so it will be a global variable
// that is called by functions below

// FUNCTION PARAMETERS:
// chip = the serial_chip object
// channel = decide between a and b channels
// index = which index you want to write into
// val = new val to be written into said index

// C++ vs C difference: In C, have to specify that serial chip is struct type
void serial_write(struct serial_chip chip, char channel, unsigned int index, char val){
    if(index < 0 || index >= 8){
        exit_error("writing to invalid index");
    }
    
    if(toupper(channel) == 'A'){
        chip.aTransmit[index] = val;
    }
    else if(toupper(channel) == 'B'){
        chip.bTransmit[index] = val;
    }
    else{ // Only allowed to look at A and B channels
        exit_error("Invalid channel name");
    }
}

char serial_read(struct serial_chip chip, char channel, unsigned int index){
    if(index < 0 || index >= 8){
        exit_error("Attempting to read at an invalid index");
    }
    
    if(toupper(channel) == 'A'){
        return chip.aReceive[index];
    }
    else if(toupper(channel) == 'B'){
        return chip.bReceive[index];
    }
    else{ // Only allowed to look at A and B channels
        exit_error("Invalid channel name");
    }
}

// TODO emulate interrupts


