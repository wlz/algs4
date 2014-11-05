    .data
    .comm   seq,    40 
length:
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

    call    init_data
    call    display

    movl    $4, (%esp)
    movl    $3, 4(%esp) 
    call    set_union

    movl    $3, (%esp)
    movl    $8, 4(%esp) 
    call    set_union

    movl    $6, (%esp)
    movl    $5, 4(%esp) 
    call    set_union
    
    movl    $9, (%esp)
    movl    $4, 4(%esp) 
    call    set_union

    call    display

    movl    $8, (%esp)
    movl    $9, 4(%esp)
    call    connected   

    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf

    movl    $5, (%esp)
    movl    $4, 4(%esp)
    call    connected   

    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf

    movl    $0, %eax 
    leave
    ret

set_union:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax 
    movl    %eax, (%esp)
    call    root
    movl    %eax, -4(%ebp)

    movl    12(%ebp), %eax 
    movl    %eax, (%esp)
    call    root
    movl    %eax, -8(%ebp)

    movl    -4(%ebp), %eax
    movl    -8(%ebp), %ebx
    movl    %eax, seq(, %ebx, 4)

    leave
    ret

connected:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax 
    movl    %eax, (%esp)
    call    root
    movl    %eax, -4(%ebp)

    movl    12(%ebp), %eax
    movl    %eax, (%esp)
    call    root    
    movl    %eax, -8(%ebp) 

    movl    -4(%ebp), %eax
    movl    -8(%ebp), %ebx
    cmpl    %eax, %ebx 
    je      eq 
    movl    $0, %eax
    jmp     exit
eq: 
    movl    $1, %eax 
exit:
    leave
    ret

root:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %ebx 
    movl    seq(, %ebx, 4), %eax 

    cmpl    %ebx, %eax 
    je      done
    movl    %eax, (%esp)
    call    root 

done:
    leave
    ret

init_data: 
    movl    $0, %eax 
    movl    length, %edi
fill:
    movl    %eax, seq(, %eax, 4)
    addl    $1, %eax 
    cmpl    %eax, %edi
    jg      fill
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, %eax 
    movl    %eax, -4(%ebp)

show:
    movl    seq(, %eax, 4), %eax 
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf

    movl    -4(%ebp), %eax
    addl    $1, %eax    
    movl    %eax, -4(%ebp)
    movl    length, %ebx 
    cmpl    %eax, %ebx 
    jg      show

    movl    $line, (%esp)
    call    printf

    leave 
    ret
