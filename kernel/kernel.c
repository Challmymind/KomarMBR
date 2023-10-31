#include "inc/printb.h"
#include "inc/idt.h"
#include "inc/mcpy.h"

Tbuffer WelcomeMSG = "WE ARE FINALLY IN LONG MODE!";
Tbuffer InterruptMSG = "INTERRUPT CALLED!";

void handler31(){
    printb(1, InterruptMSG);
}

int _kernel(){

    IDT_initialize();

    int line = 25;

    do {
        line--;
        printb_clear(line, 0x1b);
    } while(line);

	printb(0, WelcomeMSG);

    //mcpy((char*)InterruptMSG, (char*)0xaa00, 20);
    cint_31();
	
	while(1){

	}

}
