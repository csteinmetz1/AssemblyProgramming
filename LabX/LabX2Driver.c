/* Begin C Driver */

#include <stdio.h>

int NumberOfPrimes(void);

int main(void)
{
    int answer;
    /* This is your Assembly function. */
    answer = NumberOfPrimes();
    printf("There are %u unsigned 16-bit prime values.\n", answer);
    
    return 0;
}

/* end C driver */
