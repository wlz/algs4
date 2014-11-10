    .data   
    .comm   value_stack,    40
    .comm   operator_stack, 10
val_loc:
    .long   0
op_loc:
    .long   0
fmt_d:
    .string "%d "
fmt_c:
    .string "%c"
fmt_x:
    .string "%x "
line:
    .string "\n"
exp:
    .string "(1 + 2)"
#    .string "(1 + (2 * 3))"

    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp 

    call    calculate

    leave
    ret

#    printf("%d\n", '+'); //43
#    printf("%d\n", '*'); //42
#    printf("%d\n", ' '); //32
#    printf("%d\n", '('); //40
#    printf("%d\n", ')'); //41

calculate:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, %eax
    movl    %eax, -12(%ebp)

move_next:   
    movl    -12(%ebp), %ebx 
    movb    exp(, %ebx, 1), %al    

#    cmpb    $0, %al     # '\0'
#    cmpl    $0, %eax     # '\0'
    cmpb    $0, %al
    je      calc_done

    movb    %al, 4(%esp)
    movl    $fmt_c, (%esp)
    call    printf
    jmp     next

#    cmpb    $40, %al    # '('
    cmpl    $40, %eax    # '('
    je      next

#    cmpb    $32, %al    # ' '
    cmpl    $32, %eax    # ' '
    je      next

#    cmpb    $43, %al    # '+'
    cmpl    $43, %eax    # '+'
    je      push_add

#    cmpb    $42, %al    # '*'
    cmpl    $42, %eax    # '*'
    je      push_multi 

#    cmpb    $41, %al    # ')'
    cmpl    $41, %eax    # ')'
    je      calc

    subl    $48, %eax
    movl    %eax, (%esp)

    call    push_val
    jmp     next

calc:
    call    pop_val
    movl    %eax, -4(%ebp)
    call    pop_val
    movl    %eax, -8(%ebp)
    call    pop_op

    cmpb    $43, %al    # '+'
    je      calc_add

    cmpb    $42, %al    # '*'
    je      calc_multi

calc_add:
    movl    -4(%ebp), %eax
    movl    -8(%ebp), %ebx
    addl    %eax, %ebx
    movl    %ebx, (%esp)
    call    push_val

#    movl    %ebx, 4(%esp)
#    movl    $fmt_d, (%esp)
#    call    printf

    jmp     next

calc_multi:
    movl    -4(%ebp), %eax
    movl    -8(%ebp), %ebx
    imull   %eax, %ebx
    movl    %ebx, (%esp)
    call    push_val
    jmp     next
    
push_add:
    movb    $43, (%esp)
    call    push_op
    jmp     next

push_multi:
    movb    $42, (%esp)
    call    push_op
    jmp     next

next:
    movl    -12(%ebp), %eax
    addl    $1, %eax 
    movl    %eax, -12(%ebp)

    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

    jmp     move_next

calc_done:
    leave
    ret

push_val:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax 
    movl    val_loc, %edi
    movl    %eax, value_stack(, %edi, 4)
    addl    $1, %edi
    movl    %edi, (val_loc)
    leave
    ret

pop_val:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    val_loc, %edi
    subl    $1, %edi
    movl    %edi, (val_loc)

    movl    value_stack(, %edi, 4), %eax 
    leave
    ret

push_op:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movb    8(%ebp), %al
    movl    op_loc, %edi
    movb    %al, operator_stack(, %edi, 1)
    addl    $1, %edi
    movl    %edi, (op_loc) 
    leave
    ret 

pop_op:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    op_loc, %edi
    subl    $1, %edi
    movl    %edi, (op_loc)

    movb    operator_stack(, %edi, 1), %al    
    leave
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, %edi
show_next:
    movl    exp(, %edi, 1), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_c, (%esp)
    call    printf
    
    addl    $1, %edi
    movb    exp(, %edi, 1), %al
    testb   %al, %al
    jne     show_next

    leave
    ret
