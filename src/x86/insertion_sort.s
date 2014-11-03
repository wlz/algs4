    .data   
seq:
	.long	2
	.long	8
	.long	1
	.long	4
	.long	9
	.long   6	
size:
    .long   6
#    .long   5

fmt:
    .string "%d "
newline:
    .string "\n-----------"

.globl main
main:
    pushl   %ebp
    movl    %esp, %ebp 
    andl    $-16, %esp 
    
    call    insertion_sort 
    call    display

    leave
    ret 

insertion_sort:
    pushl   %ebp
    movl    %esp, %ebp 
    subl    $16, %esp 

    movl    $0, %edi 
L1:
    movl    %edi, %esi
    addl    $1, %esi 
L2: 
    movl    %esi, %eax 
    movl    %esi, %ebx 
    subl    $1, %ebx 
    
    movl    seq(, %eax, 4), %ecx 
    movl    seq(, %ebx, 4), %edx 

    cmpl    %ecx, %edx 
    jl      done

    subl    $16, %esp
    movl    %eax, (%esp)
    movl    %ebx, 4(%esp)
    call    swap
    addl    $16, %esp 

done:
    subl    $1, %esi
    cmpl    $0, %esi
    jg      L2
    
    addl    $1, %edi 
    cmpl    %edi, (size)
    jg      L1 

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
    movl    $0, %eax 
    leave
    ret

#insertion_sort:
#    pushl   %ebp
#    movl    %esp, %ebp 
#
#    leave 
#    ret

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

tick:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp
    movl    $42, (%esp)
    call    putchar
    leave 
    ret
