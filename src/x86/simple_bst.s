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
    call    node_init
    movl    %eax, root

    movl    $3, (%esp)
    call    node_init
    movl    root, %ebx
    movl    $1, %ecx
    movl    %eax, 4(%ebx)

    movl    $2, (%esp)
    call    node_init
    movl    root, %ebx
    movl    %eax, 8(%ebx)

	movl	root, %eax
	movl	4(%eax), %eax
	movl	(%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, %eax
    movl    %eax, (%esp)
	call	printf

    movl    root, %eax
    movl    8(%eax), %eax
    movl    (%eax), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, %eax
    movl    %eax, (%esp)
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

#    movl    %eax, -4(%ebp)

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
