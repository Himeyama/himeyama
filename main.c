#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

struct rand{
};

float frand(struct rand self){
    return (float)drand48();
}


void Init_rand(struct rand self){
    srand48(time(NULL));
}

int main(void){
    struct rand r;
    Init_rand(r);
    printf("%f\n", frand(r));
    return 0;
}