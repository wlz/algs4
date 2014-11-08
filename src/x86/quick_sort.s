    .comm   seq,    40
N:
    .long   10
fmt:    
    .string "%d "
line:
    .string "\n"

    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    call    init
    call    display
    movl    $0, %eax 

    leave
    ret

init:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    
    movl    $0, %edi
    movl    N, %esi
    
init_next:
    movl    %edi, seq(, %edi, 4)
    addl    $1, %edi

    cmpl    %edi, %esi
    jg      init_next 
    
    call    shuffle
    leave
    ret

shuffle:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, %eax
    movl    %eax, (%esp)
    call    time
    movl    %eax, (%esp)
    call    srand 

    movl    $1, %edi 
    movl    N, %esi 

shuffle_next:
    call    rand
    movl    %eax, 4(%esp)
    movl    %edi, (%esp)
    call    mod 

    movl    %eax, (%esp)
    movl    %edi, 4(%esp)
    call    swap

    addl    $1, %edi
    cmpl    %edi, %esi
    jg      shuffle_next

    leave
    ret

swap: 
    movl    4(%esp), %eax
    movl    8(%esp), %ebx

    movl    seq(, %eax, 4), %ecx
    movl    seq(, %ebx, 4), %edx
    movl    %edx, seq(, %eax, 4)
    movl    %ecx, seq(, %ebx, 4) 

    ret

mod:
    movl    4(%esp), %ecx   
    movl    8(%esp), %eax 
    movl    $0, %edx
    divl    %ecx 

    movl    %edx, %eax 
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, %edi 
    movl    N, %esi  

display_next:
    movl    seq(, %edi, 4), %eax
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf

    addl    $1, %edi 
    cmpl    %edi, %esi 
    jg      display_next

    movl    $line, (%esp)   
    call    printf
    leave
    ret
