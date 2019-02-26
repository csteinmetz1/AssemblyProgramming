//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      03.25.2016                                                //
// FILE:      Steinmetz_2730_008_5.s                                    //
// PURPOSE:   The purpose of code is to create a function which will    //
//            take the value input by the user and calculate the        //
//            Fibonacci sequence up to this number. The function will   //
//            use recusion to call itself within itself to complete     //
//            the calculations. This lab serves to establish a working  //
//            understanding of how to use the stack efficently and      //
//            effectively to both store and remove values as well as    //
//            as define local variables and also handle caller and      //
//            callee tasks                                              //
//////////////////////////////////////////////////////////////////////////

/*  FUNCTION: Fib
    ARGUMENTS: N/A
    RETURNS: N/A
    PURPOSE: To take the value inputed by the user and calculate 
    the fibonacci sequence up to that value using recursion.
*/

.global Fib
.type Fib,@function
Fib:
    /* prolog */
    pushl %ebx          # put the previous value of B register onto the stack
    pushl %ebp          # put the previous value of Base pointer register on the stack

    movl %esp, %ebp     # set the base pointer to establish space for temp variables
    subl $8, %esp       # make space for two int's in the stack

    movl global_var, %ebx # grab local var and place it into the B register
    movl %ebx, -8(%ebp)   # set the value of local_var equal to global_var in the stack

IsLocal0:
    cmpl $0, -8(%ebp)   # check if local_var is equal to zero
    jne IsLocal1        # Jump down if not equal
    jmp return          # return if equal to 0

IsLocal1:
    cmpl $1, -8(%ebp)   # check is local_var is equal to one
    jne Else            # jump down if not equal
    jmp return          # return if equal to 1

Else:
    movl -8(%ebp), %eax     # move the value of local_var into A register
    addl $-1, %eax          # subtract one from the value of local_var
    movl %eax, global_var   # write this result back out to global_var
    call Fib                # call the Fib function to be recursion
    movl global_var, %ebx   # move global_var into B register
    movl %ebx, -4(%ebp)     # set the value of temp_var on the stack to global_var
    movl -8(%ebp), %eax     # get the value of local_var from the stack
    addl $-2, %eax          # subtract two from local_var
    movl %eax, global_var   # write this result to global_var
    call Fib                # call Fib once again
    movl -4(%ebp), %ecx     # move the value of temp_var into C register
    addl global_var, %ecx   # sum temp_var and global_var
    movl %ecx, global_var   # write this result back to global_var

return:
    /* epilog */
    movl %ebp, %esp     # set stack pointer to point to the base of stack frame
    popl %ebp           # remove the value of base pointer from the stack
    popl %ebx           # remove the value of the B register from the stack
    ret                 # return to the spot after the function call (after the above
                        # intstructions tore down the stack frame


/* NOTE: The way this program, along with the C driver, has been contructed, the
          largest value n of the Fibonacci sequence that can be calculated 
          accurately is 46. This is due to the limiting size of the signed int 
          data type. By using a larger data type like an usnigned int of another
          64-bit data type, higher values in the sequence could be calculated.

/* end assebmly stub */
