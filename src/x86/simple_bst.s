    .data
    .comm   root,   4
fmt_d:
    .string "%d"
line:
    .string "\n"

    .globl  main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $1, (%esp)
    call    put

    movl    %eax, root
    movl    root, %eax
    movl    (%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

    movl    $0, %eax 
    leave
    ret 

put:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    root, %eax
    movl    %eax, 4(%esp)       
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    call    put_node
    movl    %eax, root
    
    leave
    ret

put_node:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    12(%ebp), %eax 
    cmpl    $0, %eax
    je      init_root

init_root:
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    call    node_init 
    jmp     put_node_exit
    
put_node_exit:
    leave
    ret

put_exit:
    leave
    ret

node_init:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $12, (%esp)
    call    malloc

    movl    8(%ebp), %ebx
    movl    %ebx, (%eax)
    movl    $0, 4(%eax)
    movl    $0, 8(%eax) 

    leave
    ret
