#include "../inc/idt.h"

extern void __IDT_handler31();
extern void __IDT_setregister();

void IDT_initialize(){
    char * mem = (char*)0x0;

    // We need to skip 31 entries.
    int size = 31 * 16;

    for(int x = 0; x < size; x++){
       *mem = 0; 
       mem++;
    }

    // This offset is only 2bytes long so we don't care that some
    // will be overwritten.
    *(long int*)mem = (long int)__IDT_handler31;

    mem+=2;

    *mem = 0x18;
    mem++;
    *mem = 0;
    mem++;

    // Zero IST and reserved
    *mem = 0;
    mem++;

    *mem = 0b10001110; // Set type and DPL
    mem++;
    
    for(int x = 0; x < 10; x++){
        *mem = 0;
        mem++;
    }

    __IDT_setregister();

    //__IDT_testint31();

    return;
}
