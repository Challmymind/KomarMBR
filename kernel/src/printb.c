#include "../inc/printb.h"


void printb(int line_number, Tbuffer buf){

	if(line_number < 0) return;
	if(line_number > 24) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;

	int row = 0;
	while(row < 80){
		*mem = buf[row];
		mem += 2;

		row++;
	}
	
}

void printb_clear(int line_number, char background){

	if(line_number < 0) return;
	if(line_number > 24) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;

	int row = 0;
	while(row < 80){
		*(mem++) = ' ';
		*(mem++) = background;

		row++;
	}

}

