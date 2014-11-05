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

    movl    $0, (%esp)
    call    time
    movl    %eax, (%esp)
    call    srand 

    call    rand
    movl    %eax, 4(%esp) 
    movl    $fmt, (%esp)
    call    printf 

    leave
    ret

mod:
    ret
