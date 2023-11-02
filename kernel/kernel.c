#include "inc/printb.h"
#include "inc/idt.h"
#include "inc/mcpy.h"
#include "inc/int_handlers.h"

Tbuffer WelcomeMSG = "WE ARE FINALLY IN LONG MODE!";

int _kernel(){

    // We need to set at least ints 0-20
    for(int x = 0; x < 21; x++){
        IDT_sint(x, (char*)INT_printr);
    }
    IDT_initialize();

    printb_void();

	printb_t(0, WelcomeMSG);
	
	while(1);

}
