    .comm   nodes,  80

    .data
loc:
    .long   0
fmt:
    .string "%s "
s1:
    .string "to"
s2:
    .string "be"
s3:
    .string "or"
s4:
    .string "not"
s5:
    .string "to"
s6:
    .string "be"
s7:
    .string "that"
    
    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 

    movl    $s1, (%esp)
    call    push

    movl    $s2, (%esp) 
    call    push

    movl    $s3, (%esp) 
    call    push

    call    pop
    movl    $fmt, (%esp) 
    movl    %eax, 4(%esp)
    call    printf 

    movl    $s4, (%esp) 
    call    push

    movl    $s5, (%esp) 
    call    push

    movl    $s6, (%esp) 
    call    push

    call    pop
    movl    $fmt, (%esp) 
    movl    %eax, 4(%esp)
    call    printf 

    call    pop
    movl    $fmt, (%esp) 
    movl    %eax, 4(%esp)
    call    printf 

    movl    $s7, (%esp) 
    call    push

    call    pop
    movl    $fmt, (%esp) 
    movl    %eax, 4(%esp)
    call    printf 

    movl    $0, %eax 

    leave
    ret

pop:    
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    
    movl    loc, %ebx 
    subl    $1, %ebx 
    movl    nodes(, %ebx, 8), %eax 
    
    movl    %ebx, loc 

    leave
    ret

push: 
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp 

    movl    loc, %edx 
    movl    8(%ebp), %eax 
    
    movl    %eax, nodes(, %edx, 8)
    movl    %ebx, nodes+4(, %edx, 8)
    
    addl    $1, %edx 
    movl    %edx, loc 

    leave
    ret 
