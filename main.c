#include <stdio.h>
#include <stdlib.h>
#include <time.h>

float frand(void){
    return (float)drand48();
}

int main(void){
    srand48(time(NULL));
    printf("%f\n", frand());
    return 0;
}