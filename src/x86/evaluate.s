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
    .string "%c "
fmt_x:
    .string "%x "
line:
    .string "\n"
exp:
    .string "(1 + (2 * 3))"

    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp 

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
    movl    $fmt_x, (%esp)
    call    printf
    
    addl    $1, %edi
    cmpl    $15, %edi
    jl      show_next

    leave
    ret
