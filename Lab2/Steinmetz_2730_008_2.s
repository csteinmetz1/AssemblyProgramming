//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      01.31.2016                                                //
// FILE:      Steinmetz_2730_008_2.s                                    //
// PURPOSE:   This program does the arithmetic as per the program       //
//            specification. Along with the C driver it then outputs    //
//            these calculations to the terminal. In doing this lab we  //
//            are focusing on learning how to use the general purpose   //
//            registers to store values from memory and then do basic   //
//            arithmetic on them with the standard opcodes              //
//////////////////////////////////////////////////////////////////////////

/*  FUNCTION    dodiff
    ARGUMENTS   none
    RETURNS     none
    PURPOSE     The purpose of this function is complete the arithemetic
                shown in the first part of the program specification.
                It finds the square of digit1, digit2, and digit3, and
                then adds the squares of digit1 and digit2 together and
                subtracts from that sum the square of digit3.
*/
.global dodiff
.type dodiff, @function
dodiff:

	/* prolog */
	pushl %ebp
	pushl %ebx
	movl %esp, %ebp

	/* This code will carry out the arithmetic */

	/* First set of parethenesis */

    movl digit1, %eax   
    mull %eax           # find the sqaure of digit1
    movl %eax, %ebx     # move the square out

	/* Second set of parenthesis */

    movl digit2, %eax   # grab digit2
    mull %eax           # find the square of digit2

    addl %eax, %ebx     # sum the square of digit1 and digit2

	/* Third set of parenthensis */

    movl digit3, %eax   # grab digit3
    mull %eax           # find the square of digit3

	/* subtract square of digit3 from the sum of the first two squares */

    subl %eax, %ebx     # perform the subtraction
    movl %ebx, diff     # store result into diff

	/* epilog */
	movl %ebp, %esp
	popl %ebx
	popl %ebp
	ret


/*  FUNCTION    dosumprod
    ARGUMENTS   none
    RETURNS     none
    PURPOSE     The purpose of this function is complete the arithemetic
                shown in the second part of the program specification.
                It finds the sum of digit1, digit2, and digit3, storing it into sum.
                Then is finds the product of digit1, digit2, and digit3, storing
                the result into product. 
 */
.global dosumprod
.type dosumprod, @function
dosumprod:

	/* prolog */
	pushl %ebp
	pushl %ebx
	movl %esp, %ebp

	/* This code will carry out the next set of arithmetic */


	/* Find sum of digit1, digit2, and digit3 */

    movl digit1, %eax       # grab digit1
    addl digit2, %eax       # perform the sum of digit1 and digit2
    addl digit3, %eax       # add digit3 to the sum of digit1 and digit2
    movl %eax, sum          # store this sum into sum

	/* Find product of digit1, digit2, and digit3 */

    movl digit1, %eax       # grab digit1
    mull digit2             # multiply digit1 by digit2
    mull digit3             # no multiply previous product by digit3
    movl %eax, product      # store final into product

	/* epilog */
	movl %ebp, %esp
	popl %ebx
	popl %ebp
	ret

/*  FUNCTION    doremainder
    ARGUMENTS   none
    RETURNS     none
    PURPOSE     The purpose of this function is complete the arithemetic
                shown in the third part of the program specification. 
                Here the remainder of the division of the product and sum 
                from memory (the previous calculations) will be stored into
                remainder. This replicated the mod operator in C. 
 
*/
.global doremainder
.type doremainder, @function
doremainder:

	/* prolog */
	pushl %ebp
	pushl %ebx
	movl %esp, %ebp

	/* find the remainder of prod mod sum */

    movl $0, %edx           # first clear D register
    movl product, %eax      # initalize the dividend (product)
    divl sum                # perform the division
    movl %edx, remainder    # store the remainder of division

	/* epilog */
	movl %ebp, %esp
	popl %ebx
	popl %ebp
	ret

/* declare variables here */
.comm digit1, 4
.comm digit2, 4
.comm digit3, 4
.comm diff, 4
.comm sum, 4
.comm product, 4
.comm remainder, 4

/* Do not forget the required blank line here! */
