    .comm   seq,    40
N:
    .long   10
fmt:
    .string "%d "
line:
    .string "\n"

    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 
    
    movl    $0, %eax 

    call    init
    call    print 

    leave
    ret

print:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 

    movl    $0, %eax 
    movl    %eax, -4(%ebp)

loop_print:
    movl    -4(%ebp), %eax 
    movl    seq(, %eax, 4), %ebx 
    movl    %ebx, 4(%esp)
    movl    $fmt, (%esp)
    call    printf
    
    movl    -4(%ebp), %eax 
    addl    $1, %eax 
    movl    %eax, -4(%ebp)
    
    movl    N, %ebx     
    cmpl    %eax, %ebx
    jg      loop_print 

    movl    $line, (%esp)
    call    printf
    leave 
    ret

init:
    movl    $0, %eax 
    movl    N, %ebx 

op:
    movl    %eax, seq(, %eax, 4)
    addl    $1, %eax 
    cmpl    %eax, %ebx 
    jg      op

    call    shuffle 
    ret

shuffle:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    movl    N, %edi   

    movl    $0, (%esp)
    call    time
    movl    %eax, (%esp)
    call    srand

    movl    $1, -4(%ebp)

sh_swap:
    call    rand
    movl    %eax, (%esp)
    movl    -4(%ebp), %eax 
    movl    %eax, 4(%esp)
    call    mod 

    movl    %eax, (%esp)
    movl    -4(%ebp), %eax 
    movl    %eax, 4(%esp) 

    call    swap

    movl    -4(%ebp), %eax
    addl    $1, %eax 
    movl    %eax, -4(%ebp)
    cmpl    %eax, %edi 

    jg      sh_swap

    leave
    ret

swap:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    
    movl    8(%ebp), %eax   
    movl    12(%ebp), %ebx
    
    movl    seq(, %eax, 4), %ecx 
    movl    seq(, %ebx, 4), %edx 
    
    movl    %ecx, seq(, %ebx, 4)
    movl    %edx, seq(, %eax, 4)
    
    leave
    ret

mod:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 
    
    movl    8(%ebp), %eax 
    movl    12(%ebp), %ecx 
    movl    $0, %edx 
    divl    %ecx 
    
    movl    %edx, %eax 
    leave
    ret 
