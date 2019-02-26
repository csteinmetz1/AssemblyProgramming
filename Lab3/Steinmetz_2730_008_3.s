//////////////////////////////////////////////////////////////////////////
// NAME:      Christian Steinmetz                                       //
// COURSE:    ECE 2730                                                  //
// SECTION:   008                                                       //
// DATE:      02.19.2016                                                //
// FILE:      Steinmetz_2730_008_3.s                                    //
// PURPOSE:   The purpose of code is to create a function which will    //
//            take as input the sides of a triangle and then output     //
//            what kind of triangle was entered based on the side       //
//            lengths. In this lab we will explore the use of jump and  //
//            conditional jump statements in order to mimic the         //
//            control statements we are familiar with in C.             //
//////////////////////////////////////////////////////////////////////////

/*  FUNCTION    classify
    ARGUMENTS   none
    RETURNS     none
    PURPOSE     The purpose of this function is to carry about the conditional
                logic nessecary to set the triangle type of the entered triangle
                side lengths. It cloesly follows the given C psuedo code and uses
                a number of nested, conditional jumps to set the triangle type,
                which will be sent back out to the driver to be printed.
 */

.global classify
.type classify, @function
classify:
    /* prolog */
    pushl %ebp
    pushl %ebx
    movl %esp, %ebp

    /* put code here */

    /* Check if i is 0 */
    movl i, %eax
    cmpl $0, %eax
    je isNotTriangle

    /* Check if j is 0 */
    movl j, %eax
    cmpl $0, %eax
    je isNotTriangle

    /* Check if k is 0 */
    movl k, %eax
    cmpl $0, %eax
    je isNotTriangle

    jmp isTriangle  # jump if none of these are true


/* If all sides are zero */
isNotTriangle:
    movl $0, tri_type   # set to triangle type zero
    jmp return          # end progrm

/* Count matching sides */
isTriangle:
    movl $0, match      # set match to 0

MatchPlusOne:
    movl i, %eax
    cmpl j, %eax         # check if i == j
    jne MatchPlusTwo     # jump to next if not equal
    addl $1, match       # if equal then add 1 to match

MatchPlusTwo:
    cmpl k, %eax         # check if i == k
    jne MatchPlusThree   # jump to next if not equal
    addl $2, match       # if equal then add 2 to match

MatchPlusThree:
    movl j, %eax 
    cmpl k, %eax         # check if j == k
    jne CheckMatch       # jump to next if not equal
    addl $3, match       # if equal then add 3 to match

/* Select possible scalene triagles */
CheckMatch:
    cmpl $0, match       # Check if match is zero // no sides are equal
    je FinalTriCheck     # jump to else if is Zero

CheckScalene:
    cmpl $1, match       # Check if match is 1
    jne MatchNotOne      # jump to else if not 1

    movl i, %eax
    addl j, %eax         # sum i and j
    cmpl k, %eax         # check if k is great than or equal to sum
    jg MatchNotOne       # jump to else if not true
    movl $0, tri_type    # set to Not a triangle
    jmp return           # end program

MatchNotOne:
    cmpl $2, match       # Check is match is not 2
    je MatchIsTwo        # If match is 2 jump to else
    cmpl $6, match       # check if match is 6
    jne MatchIsNotSix    # if match is not 6 go to else
    movl $1, tri_type    # otherwise if match is 6, equilaterial
    jmp return

MatchIsNotSix:
    movl j, %eax
    addl k, %eax         # sum of j and k
    cmpl i, %eax         
    jnle Isosceles       # jump out if sum not greater than i
    movl $0, tri_type    # set to not a triangle
    jmp return           # end program

MatchIsTwo:
    movl i, %eax
    addl k, %eax         # grab i and k then sum them
    cmpl j, %eax         # compare them then
    jnle Isosceles       # jump out if sum is greater than j
    movl $0, tri_type    # set to not a triangle
    jmp return           # end program

Isosceles:
    movl $2, tri_type    # if exec reaches here set to isoscles then
    jmp return           # end prog

FinalTriCheck:
    movl i, %eax         # grab i
    addl j, %eax         # add i and j
    cmpl k, %eax         # set flags with sum and k
    jle NotTri           # set to not trianle if sum is less than or equal

    movl j, %eax
    addl k, %eax
    cmpl i, %eax         # check the next condition
    jle NotTri           # set to not trianle if sum is less than or equal

    movl i, %eax
    addl k, %eax
    cmpl j, %eax         # check the final condition
    jle NotTri           # set to not trianle if sum is less than or equal

    jmp Scalene          # if reaches end and none are true must be scalene

NotTri:
    movl $0, tri_type    # set to not a triangle and
    jmp return           # end

Scalene:
    movl $3, tri_type    # set to scalene triangle if exec reaches here

return:
    /* epilog */
    movl %ebp, %esp
    popl %ebx
    popl %ebp
    ret


/* declare variables here */
.comm match, 4           # declare match as an int which will be used in the classify 

/* end assembly stub */
