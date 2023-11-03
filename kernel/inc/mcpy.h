#ifndef __MCPY__
#define __MCPY__

#include <stdint.h>

/* Copy n bytes from src to the dest.
 */
void mcpy(char * src, char * dest, int n);

/* Reads exactly 4bytes from address and stores in dest.
 */
void mcpy_4(uint64_t addr, uint32_t *dest);

/* Writes (r means reverse) exactly 4bytes from address and stores in dest.
 */
void rmcpy_4(uint32_t src, uint64_t dest);

#endif
