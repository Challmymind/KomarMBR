#ifndef __PRINTB__
#define __PRINTB__

/* printb is basic command for printing on screen.
 * */

typedef char Tbuffer[80];

void printb(int ln, Tbuffer buf);

void printb_clear(int ln, char bg);

#endif
