#include "inc/printb.h"
#include "inc/idt.h"
#include "inc/mcpy.h"
#include "inc/int_handlers.h"
#include "inc/tr.h"

Tbuffer WelcomeMSG = "WE ARE FINALLY IN LONG MODE!";
unsigned int buffer;

int _kernel(){

    TR_Initialize();

    //// We need to set at least ints 0-20
    for(int x = 0; x < 31; x++){
        IDT_sint(x, (char*)INT_printr);
    }
    for(int x = 31; x < 256; x++){
        IDT_sint(x, (char*)INT_trap);
    }

    //// Timer interrupt
    IDT_sint(31, (char*)INT_timer);
    IDT_initialize();

    printb_void();

	printb_t(0, WelcomeMSG);

    buffer = 0b1010;
    rmcpy_4(buffer, 0x2003e0);

    buffer = 31;
    buffer |= (1<<17);
    rmcpy_4(buffer, 0x200320);

    buffer = 0x0a000;
    rmcpy_4(buffer, 0x200380);

    mcpy_4(0x2003e0, &buffer);
	printb_h(2, buffer);
    mcpy_4(0x200320, &buffer);
	printb_h(3, buffer);
    mcpy_4(0x200380, &buffer);
	printb_h(4, buffer);
    mcpy_4(0x200030, &buffer);
	printb_h(5, buffer);
    mcpy_4(0x200280, &buffer);
	printb_h(6, buffer);
	
	while(1){

    }

    return 1;

}
