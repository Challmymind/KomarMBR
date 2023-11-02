#include "../inc/idt.h"
#include <stdint.h>

extern void __IDT_setregister();

void IDT_sint(int n, char *handler){
    
    // Offset to correct IDT desc.
    char *mem = (char*)0x0;
    mem += 16 * n;

    // If address of handler is bigger than 0xFFFF then
    // it will cause undefined behaviour.
    // To be repaired later.
    *((int16_t*)mem) = (int64_t)handler;

    // Set correct segment sel.
    *((int16_t*)(mem+2)) = 0x18; 

    // Set IST, DPL, P and TYPE
    *((int16_t*)(mem+4)) = 0b1000111000000000;

    // Zero rest
    *((int16_t*)(mem+6)) = 0x0; 
    *((int64_t*)(mem+8)) = 0x0; 

}

void IDT_initialize(){

    __IDT_setregister();

    return;
}
