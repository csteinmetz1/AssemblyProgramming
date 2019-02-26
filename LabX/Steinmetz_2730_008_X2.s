//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      04.08.2016                                                //
// FILE:      Steinmetz_2730_008_X2.s                                   //
// PURPOSE:   The purpose of code is to create a function which will    //
//            take the user's input number and then determine whether   //
//            or not that number is prime. This program will help       //
//            establish an understanding of using the stack to pass     //
//            parameters to functions as well as return values.         //
//////////////////////////////////////////////////////////////////////////

/*  FUNCTION: Prime
    RGUMENTS: an int of the number entered by the user
    RETURNS: an int that is 0 when the number is not prime and 1 when it is prime
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


/*  FUNCTION:  NumberOfPrimes
    ARGUMENTS: N/A
    RETURNS: an int of the number of primes found 
    PURPOSE: To find the total number of primes that can be
             be represented in 16bit numbers
 */

.global NumberOfPrimes
.type NumberOfPrimes,@function
NumberOfPrimes:
    /* prolog */
    pushl %ebp              # push base pointer register onto the stack
    pushl %ebx              # push B register onto the stack

    movl $1, %eax           # number to be tested - start at 3
    movl $1, %ecx           # number of primes found - start at 1 since we skipped 2 which is prime

GenPrimes:
    pushl %ecx              # push C register onto the stack (which holds the number of primes)
    pushl %eax              # push A register onto the stack (which holds number to be tested)

    call Prime              # once the caller respon. are done call the function to calculate
                            # wether or not the value in question is a prime number

    movl %eax, %edi         # move the return value (1 if prime, 0 is not prime) to safe register

    popl %eax               # pop off A register from the stack (restore the number that was tested)
    popl %ecx               # pop off C register from the stack (restore the number of primes found)

    cmpl $1, %edi           # compare the result to 1 to check if the result was prime
    jne Continue            # if it was not 1 then it was not prime and we do not inc. so jump past add
    addl $1, %ecx           # if equal to 1 then a prime was found and we inc. the counter

Continue:
    addl $2, %eax           # inc. the number to be tested by 2 (since we know evens are never prime)
    cmpl $65536, %eax       # check to see if the tested value is below the largest 16 bit number
    jle GenPrimes           # if less than the max continue testing - otherwise finish and return result
    movl %ecx, %eax         # move the final counter number of primes into A register to be returned

    /* epilog */
    popl %ebx               # pop off B register back into place
    popl %ebp               # pop base pointer register back into places
    ret                     # return the value of primes found and go back to C execution
