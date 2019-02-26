//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      04.08.2016                                                //
// FILE:      Steinmetz_2730_008_X1.s                                   //
// PURPOSE:   The purpose of code is to create a function which will    //
//            take the users input number and then determine whether    //
//            or not that number is prime. This program will help       //
//            establish an understanding of using the stack to pass     //
//            parameters to functions as well as return values.         //
//////////////////////////////////////////////////////////////////////////

/*  FUNCTION: Prime
    RGUMENTS: an int of the number entered by the user
    RETURNS: and int that is 0 when the number is not prime and 1 when it is prime
    PURPOSE: To take the value inputed by the user and determine 
    whether or not that value is a prime number
 */


.global Prime
.type Prime,@function
Prime:
    /* prolog */
    pushl %ebp              # save the value of base pointer on the stack
    pushl %ebx              # save the value of B on the stack
    movl %esp, %ebp         # establish the base pointer frame

    /* begin prime calaculation */
    movl $2, %ecx           # move starting divisor 2 into C register
    movl 12(%ebp), %edx     # get the user input from the stack
    cmpl $1, %edx           # check to see if the input is 1
    je SetNotPrime          # if the number is 1 then set to not prime
    cmpl $2, %edx           # check to see if the input is 2
    je SetPrime             # if the number is 2 then set to prime

PrimeCheck:
    movl 12(%ebp), %eax     # move the input argument from the stack into A
    movl $0, %edx           # clear the D register
    divl %ecx               # divide by the divisor
    cmpl $0, %edx           # check if the remainder is 0
    je SetNotPrime          # if the number is evenly divisible then set to not prime
                            # since the number could be divided without a remainder

    cmpl %eax, %ecx         # compare the quotient to the divisor
    jnl SetPrime            # if the divisor is greater than the quotient then
                            # we know we have passed the square root of the number
                            # ex: 36/7 = 5 -> 5*7 < 36 = 6^2 where sqrt(36) = 6
                            # if the quotient is not less than the divisor, and
                            # the remainder is not equal to zero than the number
                            # must be prime and the result will be set 1

    addl $1, %ecx           # increment the divisor for the next division
                            # (we could make this more efficent by testing only odds after 2)
    jmp PrimeCheck          # jump back to the top and test the next number

SetPrime:
    movl $1, %eax           # set the result to 1 if prime and then return
    jmp Return

SetNotPrime:                # set the result to 0 is not prime then return
    movl $0, %eax

Return:
    /* epilog */
    movl %ebp, %esp         # reset the stack pointer and remove the stack frame
    popl %ebx               # remove B register from the stack and place it back
    popl %ebp               # remove base pointer and place it back
    ret                     # return the result of whether input is prime or not
