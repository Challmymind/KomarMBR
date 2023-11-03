#include "../inc/printb.h"


void printb_t(int line_number, char *buf){

	if(line_number < 0) return;
	if(line_number > 24) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;

	int row = 0;
	while(row < 80 && buf[row] != 0){
		*mem = buf[row];
		mem += 2;

		row++;
	}
	
}

void printb_void(){

    for(int x = 0; x < 25; x++){
        printb_clear(x, 0x1b);
    }

}

void printb_h(int line_number, int64_t num){

	if(line_number < 0) return;
	if(line_number > 24) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;
    mem += 2*15;

	int row = 15;
	while(row >= 0 && (num != 0)){

        int n = num % 16;
        num -= n;
        num /= 16;

        if(n < 10){
		    *mem = '0'+n;
        }
        else {
            *mem = 'A'+n-10;
        }

		mem -= 2;
		row--;
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

