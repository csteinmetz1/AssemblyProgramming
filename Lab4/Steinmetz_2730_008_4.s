//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      03.25.2016                                                //
// FILE:      Steinmetz_2730_008_4.s                                    //
// PURPOSE:   The purpose of code is to create a function which will    //
//            take the number input by the user and then convert the    //
//            acsii code in which the number is stored to an integer    //
//            value. In order to achieve different types of addressing  //
//            modes will be used such as Register Indirect and Base     //
//            Indexed Addressing. Along with this, conditional jumps    //
//            will be used to mimic c conditional statments and loops.  //
//////////////////////////////////////////////////////////////////////////


// NOTE: for some unkown reason my compiled code always results in a
//       segmentation fault after completely executing the assembly code.
//       This does not effect its ability to perform the conversation.


/*  FUNCTION    AtoI
    ARGUMENTS   none
    RETURNS     none
    PURPOSE     The purpose of this function is to carry about the conditional
                logic nessecary to convert the stored ascii value into the integer 
                number it represents. To do this conditional loops will be used 
                along with the aforementioned addressing modes.
*/
.global AtoI
.type AtoI, @function
AtoI:
    /* prolog */
    pushl %esp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi

    /* put code here */

    movl $1, sign       # initialize sign to a positive value

/* skip over leading spaces and tabs */
SpaceTab:
    movl ascii, %ebx    # grab the addres of the ararry containing the number
    cmpb $32, (%ebx)    # chcek to see if the value at ascii is a space
    jne Tab             # check for tab if not equal
    addl $1, ascii      # if space is found then move to next value
    jmp SpaceTab        # continue in while loop

Tab:
    movl ascii, %ebx    # move in the new value of ascii
    cmpb $9, (%ebx)     # check to see if value at ascii is a tab
    jne PlusSign        # jump out of while is not equal
    addl $1, ascii      # if tab is found then move to the next value
    jmp SpaceTab        # go back to the top of the while loop

/* Check for plus or minus */
PlusSign:
    movl ascii, %ebx    # move in the new value of ascii
    cmpb $43, (%ebx)    # check to see if value is a plus sign ('+')
    jne MinusSign       # if not then check for minus sign 
    addl $1, ascii      # if plus sign found then move to next value

MinusSign:
    movl ascii, %ebx    # move in the new value of ascii
    cmpb $45, (%ebx)    # check to see if value is a minus sign ('-')
    jne Initintptr      # if not a minus sign then leave sign at 1
    movl $-1, sign      # if minus sign is found then set sing to -1
    addl $1, ascii      # then move to the next value from ascii

/* Initialize calculated int */
Initintptr:
    movl intptr, %ecx   # move address of int into register
    movl $0, (%ecx)     # move 0 into the value at intptr
    movl $0, i          # start for loop, initialize i to 0


/* skip to the one's place */
OnesPlace:
    movl i, %edi        # move index value into the index register
    movl ascii, %ebx    # move the address of first number into register
    cmpb $48, (%ebx, %edi, 1)   # compare the ith value at ascii to '0'
    jl MoveBack         # if the value is greater than or equal check the next condition
    cmpb $57, (%ebx, %edi, 1)   # compare the ith value at ascii to '9'
    jg MoveBack         # if less than or equal upper range of ascii numbers this is the first number
    addl $1, i          # if not in the range move to the next value
    jmp OnesPlace       # jump back to the top of the for loop

MoveBack:
    addl $-1, ascii     # move back to the one's place of the number at ascii
    movl $1, multiplier # set multiplier to 1

Mult:
    movl i, %edi        # grab the value of i
    cmpl $0, i          # check value of i
    jle SignMult        # if value of i is less than or equal to 0 then end for loop
    movl ascii, %ebx    # get the address of the first digit
    movl $0, %eax       # clear the a register
    movb (%ebx, %edi, 1), %al   # grab the ith value of ascii
    subb $48, %al       # subtract the ASCII value for '0'
    mull multiplier     # multiply the digit by the multiplier value
    movl $0, %edx       # clear the d register after mull
    movl intptr, %edx   # get the address of int
    addl %eax, (%edx)   # sum with the value of int and the multiplication
    movl multiplier, %ecx   # get the multiplier
    movl $10, %eax      # move 10 into a for multiplication
    mull %ecx           # multiply the multiplier value by 10
    movl %eax, multiplier   # store
    addl $-1, i         # decrement i by 1 as per the for loop
    jmp Mult            # go back to the top of the loop

SignMult:
    movl sign, %eax     # get the value of sign
    movl intptr, %ebx   # get address of int
    mull (%ebx)         # multiply value of int by sign
    movl %eax, (%ebx)   # store final value of int

return:
    /* epilog */
    popl %edi
    popl %esi
    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret

/* end assembly stub */
