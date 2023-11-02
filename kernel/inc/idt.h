#ifndef __IDT__
#define __IDT__

void IDT_initialize();
void IDT_sint(int n, char * handler);

void cint_31();

#endif
