    .data
    .comm   first,  4
    .comm   last,   4

str1:
    .string "to"
str2:
    .string "be"
str3:
    .string "or"

fmt:
    .string "%s "
    
    .globl main
main:
    pushl   %ebp    
    movl    %esp, %ebp
    andl    $-16, %esp 
    subl    $16, %esp

    movl    $str1, (%esp)
    call    enqueue

    movl    $str2, (%esp)
    call    enqueue

    movl    $str3, (%esp)
    call    enqueue

    movl    first, %eax 
    movl    (%eax), %edx 
    movl    $fmt, %eax 
    movl    %edx, 4(%esp)
    movl    %eax, (%esp)
    call    printf

    call    dequeue
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf 

    call    dequeue
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf 

    leave
    ret

dequeue:
    pushl   %ebp
    movl    %esp, %ebp

    subl    $40, %esp
    movl    first, %eax     
    movl    %eax, -16(%ebp)
    movl    first, %eax 
    movl    (%eax), %eax 
    movl    %eax, -12(%ebp)
    movl    first, %eax 
    movl    4(%eax), %eax 
    movl    %eax, first
    movl    -16(%ebx), %eax
    movl    %eax, (%esp)
    call    free
    movl    -12(%ebp), %eax 
    
    leave
    ret

enqueue:
    pushl   %ebp
    movl    %esp, %ebp
    
    subl    $16, %esp
    movl    $8, (%esp)
    call    malloc
    movl    %eax, -4(%ebp)
    movl    8(%ebp), %edx 
    movl    %edx, (%eax)

    movl    first, %eax 
    testl   %eax, %eax 
    je      init_first

    movl    last, %eax
    testl   %eax, %eax 
    je      init_last

    movl    last, %eax
    movl    -4(%ebp), %edx
    movl    %edx, 4(%eax)
    movl    -4(%ebx), %eax
    movl    %eax, last
    jmp     en_exit
    
init_first:
    movl    -4(%ebp), %eax 
    movl    %eax, first 
    jmp     en_exit

init_last:
    movl    -4(%ebp), %eax 
    movl    %eax, last
    movl    first, %eax 
    movl    last, %edx 
    movl    %edx, 4(%eax)
    jmp     en_exit

en_exit:
    leave
    ret
