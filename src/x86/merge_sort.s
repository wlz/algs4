    .comm   seq,    40
N:
    .long   10

fmt:
    .string "%d "

    .globl main
main:
    call    init
    movl    $0, %eax 
    ret

init:
    movl    $0, %eax 
    movl    N, %ebx 
init_next:
    movl    %eax, seq(, %eax, 4)
    addl    $1, %eax 
    cmpl    %eax, %ebx 
    jg      init_next 
    ret 
