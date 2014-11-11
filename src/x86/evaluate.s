    .data
    .comm   val_stack,    40
    .comm   op_stack,     10
val_loc:
    .long   0
op_loc:
    .long   0 
fmt_c:
    .string "%c"
fmt_d:
    .string "%d" 
exp:
    .string "(1+((2 + 3)*(4*5)))"

    .globl  main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    call    calculate

    movl    val_stack, %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

    call    calculate
    movl    $0, %eax    
    leave
    ret

calculate:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $exp, %edi 
calc_next:
    movb    (%edi), %al 
    cmpb    $0, %al
    je      calc_exit

    cmpb    $40, %al    # (
    je      move_next

    cmpb    $32, %al    # ' '
    je      move_next

    cmpb    $42, %al    # *
    je      add_op

    cmpb    $43, %al    # +
    je      add_op

    cmpb    $41, %al
    je      calc

    subb    $48, %al
    movsbl  %al, %eax
    movl    %eax, (%esp)
    call    push_val
    jmp     move_next

calc:
    call    pop_val
    movl    %eax, -4(%ebp)
    call    pop_val
    movl    %eax, -8(%ebp)
    call    pop_op 

    cmpb    $43, %al    # +
    je      calc_add

    cmpb    $42, %al    # *
    je      calc_multi

calc_add:
    movl    -4(%ebp), %ebx
    movl    -8(%ebp), %eax
    addl    %ebx, %eax
    movl    %eax, (%esp)
    call    push_val 
    jmp     move_next

calc_multi:
    movl    -4(%ebp), %ebx
    movl    -8(%ebp), %eax
    imull   %ebx, %eax
    movl    %eax, (%esp)
    call    push_val 
    jmp     move_next

add_op:
    movsbl  %al, %eax
    movl    %eax, (%esp)
    call    push_op

    jmp     move_next 

move_next: 
    addl    $1, %edi
    jmp     calc_next

calc_exit:
    leave
    ret

push_op:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movb    8(%ebp), %al

#    movsbl  %al, %eax
#    movl    %eax, 4(%esp)
#    movl    $fmt_c, (%esp)
#    call    printf 

    movl    op_loc, %ebx
    movb    %al, op_stack(, %ebx, 1)
    addl    $1, %ebx
    movl    %ebx, op_loc 
    
    leave
    ret

pop_op:
    movl    op_loc, %eax
    subl    $1, %eax
    movl    %eax, op_loc
    movb    op_stack(, %eax, 1), %al
    movsbl  %al, %eax   
    ret

push_val:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    
    movl    8(%ebp), %eax    
    movl    val_loc, %ebx
    movl    %eax, val_stack(, %ebx, 4)
    addl    $1, %ebx
    movl    %ebx, val_loc
    leave
    ret

pop_val:
    movl    val_loc, %eax
    subl    $1, %eax
    movl    %eax, val_loc
    movl    val_stack(, %eax, 4), %eax
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    movl    $0, %edi

display_next:
    movl    $0, %eax 
    movb    exp(, %edi, 1), %al
    cmpb    $0, %al
    je      display_exit 

    movsbl    %al, %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf
    addl    $1, %edi
    jmp     display_next

display_exit:
    leave
    ret
