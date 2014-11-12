    .data
    .comm   seq,    40
    .comm   aux,    40
N:
    .long   10 
fmt_d:
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
    
    movl    N, %esi
    movl    $0, %edi 

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

    movl    $0, (%esp)
    call    time
    movl    %eax, (%esp)
    call    srand

    movl    $1, %eax
    movl    %eax, -4(%ebp)
    movl    N, %esi
    
shuffle_next:
    call    rand
    movl    %eax, 4(%esp)
    movl    -4(%ebp), %eax
    movl    %eax, (%esp)
    call    mod

    movl    %eax, 4(%esp)
    movl    -4(%ebp), %eax
    movl    %eax, (%esp)
    call    swap

    movl    -4(%ebp), %eax
    addl    $1, %eax
    movl    %eax, -4(%ebp)
    cmpl    %eax, %esi
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
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    12(%ebp), %eax
    movl    8(%ebp), %ecx
    movl    $0, %edx
    divl    %ecx
    movl    %edx, %eax 
    leave
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    N, %esi
    movl    $0, %edi 

display_next:
    movl    seq(, %edi, 4), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

    addl    $1, %edi
    cmpl    %edi, %esi
    jg      display_next 
    
    leave
    ret
