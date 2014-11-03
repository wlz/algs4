    .data   
seq:
	.long	2
	.long	8
	.long	1
	.long	4
	.long	9
	.long   6	
	.long   7	
	.long   3	
	.long   5	
size:
    .long   8

fmt:
    .string "%d "
newline:
    .string "\n---------------"

.globl main
main:
    pushl   %ebp
    movl    %esp, %ebp 
    andl    $-16, %esp 
    
    call    display
    call    println

    call    insertion_sort 
    call    display

    leave
    ret 

insertion_sort:
    pushl   %ebp
    movl    %esp, %ebp 
    subl    $16, %esp 

    movl    $0, %edi 
outer_loop:
    movl    %edi, %esi
    addl    $1, %esi 

inner_loop: 
    movl    %esi, %eax 
    movl    %esi, %ebx 
    subl    $1, %ebx 
    
    movl    seq(, %eax, 4), %ecx 
    movl    seq(, %ebx, 4), %edx 

    cmpl    %ecx, %edx 
    jl      done

    movl    %eax, (%esp)
    movl    %ebx, 4(%esp)

    call    swap

done: 
    subl    $1, %esi
    cmpl    $0, %esi
    jg      inner_loop
    
    addl    $1, %edi 
    cmpl    %edi, (size)
    jg      outer_loop

    leave
    ret

swap: 
    pushl   %ebp
    movl    %esp, %ebp 
    
    movl    8(%ebp), %eax 
    movl    12(%ebp), %ebx 
    
    movl    seq(, %eax, 4), %ecx 
    movl    seq(, %ebx, 4), %edx 

    movl    %ecx, seq(, %ebx, 4)
    movl    %edx, seq(, %eax, 4)
    
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

display:
    pushl   %ebp 
    movl    %esp, %ebp 
    subl    $16, %esp 

    movl    $fmt, (%esp) 
    movl    $0, %ebx 

print:
    movl    seq(, %ebx, 4), %eax 
    movl    %eax, 4(%esp) 
    call    printf
    
    addl    $1, %ebx 
    cmpl    size, %ebx 

    jl      print 

    movl    $0, %eax 
    leave
    ret 
