//  NAME     Christian Steinmetz
//  COURSE   ECE 2730
//  SECTION  008
//  DATE     01.29.2016
//  FILE     Steinmetz_2730_008_1.s
//  PURPOSE  This program is used to find the ascii sum of the string that is
//           entered in the C driver program. It must determine the ascii values
//           for each character and then sum them, returning that value.

/* begin assembly code */

.global asum
.type asum,@function
asum:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp
    movl $0, -4(%ebp)
.L2:
    movl 8(%ebp), %eax
    cmpb $0, (%eax)
    jne .L4
    jmp .L3

.L4:
    movl 8(%ebp), %eax
    movb (%eax), %dl
    addl %edx, -4(%ebp)
    incl 8(%ebp)
    jmp .L2
.L3:
    movl -4(%ebp), %eax
    jmp .L1
.L1:
    movl %ebp, %esp
    popl %ebp
    ret

/* end essembly */
/* Do not forget the required blank line here! */

