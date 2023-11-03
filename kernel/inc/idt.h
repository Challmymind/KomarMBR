#ifndef __IDT__
#define __IDT__

#define IDT_LOCATION 0x0

void IDT_initialize();
void IDT_sint(int n, char * handler);

#endif
