    .data
    .comm   root,   4
fmt_d:
    .string "%d\n"
line:
    .string "\n"

    .globl  main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $2, (%esp)
    call    put

    movl    $1, (%esp)
    call    put

    movl    $3, (%esp)
    call    put

#   printf("%d\n", root->data);
    movl    root, %eax
    movl    (%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

#   printf("%d\n", root->left->data);
    movl    root, %eax
    movl    4(%eax), %eax
    movl    (%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

#   printf("%d\n", root->right->data);
    movl    root, %eax
    movl    8(%eax), %eax
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
    
    movl    8(%ebp), %eax
    movl    %eax, (%esp) 
    movl    root, %eax
    movl    %eax, 4(%esp)
    call    put_node
    movl    %eax, root

    leave
    ret

put_node:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $40, %esp
    
#    movl    8(%ebp), %eax   #   data
#    movl    %eax, 4(%esp)
#    movl    $fmt_d, (%esp)
#    call    printf

    movl    12(%ebp), %eax
    cmpl    $0, %eax
    je      init_new      

    movl    (%eax), %ebx    #   n->data      
    movl    8(%ebp), %eax   #   data
    cmpl    %eax, %ebx
    jg      add_left
    jmp     add_right

add_left:
    movl    12(%ebp), %eax  #   n
    movl    4(%eax), %eax
    movl    %eax, 4(%esp)
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    call    put_node 
    movl    %eax, %ebx
    movl    12(%ebp), %eax
    movl    %ebx, 4(%eax)
    
    jmp     return_node

add_right:
    movl    12(%ebp), %eax
    movl    8(%eax), %eax
    movl    %eax, 4(%esp)
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    call    put_node
    movl    %eax, %ebx
    movl    12(%ebp), %eax
    movl    %ebx, 8(%eax)
    
    jmp     return_node

init_new:
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    call    node_init
    jmp     put_node_exit

return_node:
    movl    12(%ebp), %eax 
    jmp     put_node_exit 

put_node_exit:
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
