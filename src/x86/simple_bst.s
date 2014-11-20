    .data
    .comm   root,   4
fmt_d:
    .string "%d\n"
line:
    .string "----------------\n"

    .globl  main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $5, (%esp)
    call    put
    movl    $3, (%esp)
    call    put
    movl    $7, (%esp)
    call    put
    movl    $1, (%esp)
    call    put
    movl    $4, (%esp)
    call    put
    movl    $6, (%esp)
    call    put
    movl    $9, (%esp)
    call    put

    movl    root, %eax
    movl    %eax, (%esp)
    call    display
    
    movl    $line, (%esp)
    call    printf

    movl    root, %eax
    movl    %eax, 4(%esp)
    movl    $3, (%esp)
    call    delete

    movl    root, %eax
    movl    %eax, 4(%esp)
    movl    $7, (%esp)
    call    delete

    movl    %eax, root

    movl    root, %eax
    movl    %eax, (%esp)
    call    display

    movl    $0, %eax 
    leave
    ret 

delete:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    12(%ebp), %eax
    cmpl    $0, %eax
    je     delete_exit 
    
    movl    (%eax), %eax

    movl    8(%ebp), %ebx
    cmpl    %eax, %ebx
    
    je      del_itself
    jg      del_right
    jl      del_left

del_itself:
    movl    12(%ebp), %eax
    movl    4(%eax), %ebx
    cmpl    $0, %ebx
    je      return_right

    movl    8(%eax), %ebx
    cmpl    $0, %ebx 
    je      return_left

    movl    12(%ebp), %eax
    movl    %eax, -4(%ebp)
    movl    8(%eax), %eax
    movl    %eax, (%esp)
    call    get_min
    movl    %eax, -4(%ebp)

    movl    12(%ebp), %ebx
    movl    4(%ebx), %eax
    movl    -4(%ebp), %ebx
    movl    %eax, 4(%ebx)

    movl    -4(%ebp), %eax
    movl    8(%eax), %eax
    movl    %eax, (%esp)
    call    del_min
    movl    -4(%ebp), %ebx
    movl    %eax, 8(%ebx)

    movl    -4(%ebp), %eax
    jmp     delete_exit 

return_left:
    movl    4(%eax), %eax
    jmp     delete_exit
return_right:
    movl    8(%eax), %eax 
    jmp     delete_exit

del_right:
    #   n->right = del(n->right, data)
    movl    12(%ebp), %eax
    movl    8(%eax), %eax
    movl    %eax, 4(%esp)
    movl    8(%ebp), %eax
    movl    %eax, (%esp)
    
    call    delete 
    movl    12(%ebp), %ebx
    movl    %eax, 8(%ebx)

    movl    12(%ebp), %eax 
    jmp     delete_exit

del_left:
    #   n->left = del(n->left, data)
    movl    12(%ebp), %eax
    movl    4(%eax), %eax
    movl    %eax, 4(%esp)
    movl    8(%ebp), %eax
    movl    %eax, (%esp)

    call    delete
    movl    12(%ebp), %ebx
    movl    %eax, 4(%ebx)
    
    movl    12(%ebp), %eax 
    jmp     delete_exit
    
delete_exit:
    leave
    ret 

del_min:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax 
    cmpl    $0, %eax
    je      del_exit

    movl    4(%eax), %eax
    cmpl    $0, %eax
    je      ret_right

    movl    8(%ebp), %eax 
    movl    4(%eax), %eax
    movl    %eax, (%esp)
    call    del_min
    movl    8(%ebp), %ebx
    movl    %eax, 4(%ebx)
    movl    8(%ebp), %eax 
    jmp     del_exit
    
ret_right:
    movl    8(%ebp), %eax 
    movl    8(%eax), %eax 

    jmp     del_exit

del_exit:   
    leave
    ret

get_min:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax
    cmpl    $0, %eax        #   n == NULL;
    je      get_min_exit 

    movl    8(%ebp), %eax
    movl    4(%eax), %eax   
    cmpl    $0, %eax        #   n->left == NULL;
    je      return_itself

    movl    %eax, (%esp)
    call    get_min
    jmp     get_min_exit

return_itself:
    movl    8(%ebp), %eax 
    jmp     get_min_exit

get_min_exit:
    leave
    ret 

display:
    pushl   %ebp    
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax
    cmpl    $0, %eax
    je      display_exit

    movl    (%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf 

    movl    8(%ebp), %eax
    movl    4(%eax), %eax
    movl    %eax, (%esp)
    call    display

    movl    8(%ebp), %eax
    movl    8(%eax), %eax
    movl    %eax, (%esp)
    call    display
    
display_exit:   
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
