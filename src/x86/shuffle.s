    .data
    .comm   seq,    40
    .globl  main
    
fmt:
    .string "%d "

main:
    pushl   %ebp
    movl    %esp, %ebp

    call    init 
    call    display

    movl    $0, %eax 
    leave
    ret

init:
    movl    $0, %eax
    
fill:
    cmpl    $10, %eax
    je      init_exit

    movl    %eax, seq(, %eax, 4)
    addl    $1, %eax 
    jmp     fill

init_exit: 
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    
    movl    $0, %edi 
    
show:
    cmpl    $10, %edi
    je      ex_display
    movl    seq(, %edi, 4), %ebx
    movl    %ebx, 4(%esp)
    movl    $fmt, (%esp)
    call    printf 
    addl    $1, %edi 
    jmp     show

ex_display:
    leave
    ret
