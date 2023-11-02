#ifndef __PRINTB__
#define __PRINTB__

#include <stdint.h>

/* printb is basic command for printing on screen.
 * */

typedef char Tbuffer[80];

/* printb_t can print text up to 80 chars.
 */
void printb_t(int ln, char *buf);

/* printb_h can print hex number.
 */
void printb_h(int ln, int64_t num);

/* printb_clear cleans ln-th row on the screen.
 */
void printb_clear(int ln, char bg);

/* printb_void cleans whole screen.
 */
void printb_void();

#endif
