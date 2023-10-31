#include "../inc/mcpy.h"

void mcpy(char *src, char *dest, int n){

    int counter = 0;

    while(counter < n){

        *(dest + counter) = *(src + counter);
       
        counter++;
    }

}
