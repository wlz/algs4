    .data   
seq:
	.long	2
	.long	8
	.long	1
	.long	4
	.long	9
	.long	6
size:
    .long   6

fmt:
    .string "%d "
newline:
    .string ""

.globl main
main:
    pushl   %ebp
    movl    %esp, %ebp 
    andl    $-16, %esp 
    
    call    display
    call    println 

    movl    $1, (%esp)
    movl    $3, 4(%esp) 

    call    swap 

    call    display 

    leave
    ret 

swap:
    pushl   %ebp
    movl    %esp, %ebp
    
    movl    8(%ebp), %edi 
    movl    12(%ebp), %esi 
    
    movl    seq(, %edi, 4), %eax 
    movl    seq(, %esi, 4), %ebx 

    movl    %eax, seq(, %esi, 4)
    movl    %ebx, seq(, %edi, 4)
    
    leave
    ret
    
println:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 
    movl    $newline, (%esp) 
    call    puts
    leave
    ret

insertion_sort:
    pushl   %ebp
    movl    %esp, %ebp 

    leave 
    ret

display:
    pushl   %ebp 
    movl    %esp, %ebp 
    subl    $16, %esp 

    movl    $fmt, (%esp) 
    movl    size, %edi 
    movl    $0, %ebx 

print:
    movl    seq(, %ebx, 4), %eax 
    movl    %eax, 4(%esp) 
    call    printf
    
    addl    $1, %ebx 
    cmpl    %edi, %ebx 

    jl      print 

    movl    $0, %eax 
    leave
    ret 
