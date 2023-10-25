#include "inc/hello.h"

Tbuffer WelcomeMSG = "WE ARE FINALLY IN LONG MODE!";
int _kernel(){

    clear_line(0, 0x1b);
	print_text(0, WelcomeMSG);
	
	while (1) {

	}

}
