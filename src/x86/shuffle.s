    .data
    .comm   seq,    40
    .globl  main
    
fmt:
    .string "%d "
newline:
    .string "\n"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp   

    call    init 
    call    display

    movl    $newline, (%esp)
    call    printf 
    
    call    shuffle
    call    display
    
    movl    $0, %eax 
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

    movl    $1, %edi 
loop:
    call    rand
    movl    %eax, (%esp)
    movl    %edi, 4(%esp)
    call    mod

    movl    %eax, 4(%esp)
    movl    %edi, (%esp)
    call    swap
    
    addl    $1, %edi
    cmpl    $10, %edi
    jl      loop 

    leave
    ret

swap:
    pushl   %ebp
    movl    %esp, %ebp
    
    movl    8(%ebp), %eax 
    movl    12(%ebp), %ebx  

    movl    seq(, %eax, 4), %ecx 
    movl    seq(, %ebx, 4), %edx 

    movl    %ecx, seq(, %ebx, 4)
    movl    %edx, seq(, %eax, 4)

    leave
    ret

mod:
    pushl   %ebp
    movl    %esp, %ebp  
    subl    $16, %esp
    
    movl    8(%ebp), %eax 
    movl    12(%ebp), %ecx 
    movl    $0, %edx 
    divl    %ecx 
    movl    %edx, %eax 
    
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
