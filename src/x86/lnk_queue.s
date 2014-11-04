    .data
    .comm first, 4
    .comm last, 4
fmt:
    .string "%s "
s1:
    .string "to"
s2:
    .string "be"

    .globl  main
main:   
    pushl   %ebp 
    movl    %esp, %ebp 
    subl    $16, %esp

    movl    $s1, (%esp)
    call    enqueue

    movl    first, %eax
    movl    (%eax), %eax 
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf
    
    movl    $0, %eax 
    leave
    ret

enqueue:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax  
    movl    %eax, (%esp)
    call    node_init
    movl    %eax, -4(%esp)
    
    movl    first, %ebx 
    testl   %ebx, %ebx 
    je      init_first
    
init_first: 
    movl    %eax, first 

enqueue_exit:
    leave
    ret

node_init:
    pushl   %ebp
    movl    %esp, %ebp
    
    subl    $16, %esp
    movl    $8, (%esp)
    call    malloc
    movl    8(%ebp), %ebx 
    movl    %ebx, (%eax)
    movl    $0, 4(%eax) 
    
    leave
    ret
