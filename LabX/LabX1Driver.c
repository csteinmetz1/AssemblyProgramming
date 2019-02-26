/* Begin C Driver */

#include <stdio.h>

int Prime(unsigned int);

int main(void)
{
	unsigned int input;
	int result;

	printf("Enter a number: ");
	scanf("%u",&input);
	/* This is your Assembly function. */
	result = Prime(input);
	
    printf("%d \n", result);
    
    switch(result)
	{
		case 0:
			printf("%u is not prime.\n", input);
			break;
		case 1:
			printf("%u is prime.\n", input);
			break;
		default:
			printf("Function Return Error\n");
	}
	return 0;
}

/* end C driver */
