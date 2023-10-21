void create_table(){

    char * start = (char*)0x10000;

    // Set PML4
    // We set only one entry.
    
    *start |= (1<<7); // bit present
    *start |= (1<<6); // read/write
    *start |= (1<<5); // user allowed
    *start |= (0<<4); // PWT no idea
    *start |= (0<<3); // PCD no idea
    *start |= (0<<2); // A dont touch?
    *start |= (0<<1); // Ignored
    *start |= (0<<0); // reserved
                      
    start++;
    

}

void clear_line(int line_number, char background){

	if(line_number < 0) return;
	if(line_number >= 25) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;

	int row = 0;
	while(row < 80){
		*(mem++) = ' ';
		*(mem++) = background;

		row++;
	}

}

typedef char Tbuffer[80];

void print_text(int line_number, Tbuffer buf){

	if(line_number < 0) return;
	if(line_number >= 25) return;

	char * mem = (char*)0xb8000;
	mem += line_number * 80 * 2;

	int row = 0;
	while(row < 80){
		*mem = buf[row];
		mem += 2;

		row++;
	}

	
}

Tbuffer WelcomeMSG = "Welcome to this OS, you can stare at this screen forever";
int _kernel(){

    create_table();
    clear_line(0, 0x1b);
	print_text(0, WelcomeMSG);
	
	while (1) {

	}
}
