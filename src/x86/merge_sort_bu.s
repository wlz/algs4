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

#    call    init
    call    set_test
#    call    display

    movl    $0, 8(%esp)
    movl    $4, 4(%esp)
    movl    $9, (%esp)

    call    merge
    call    display

    movl    $0, %eax
    leave
    ret

set_test:
    movl    $1, seq
    movl    $3, seq+4
    movl    $5, seq+8
    movl    $6, seq+12
    movl    $7, seq+16
    movl    $0, seq+20
    movl    $2, seq+24
    movl    $4, seq+28
    movl    $8, seq+32
    movl    $9, seq+36
    ret

merge:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $40, %esp

    movl    16(%ebp), %eax
    movl    %eax, -4(%ebp)  # lo
    movl    %eax, -16(%ebp) # i 
    movl    %eax, -20(%ebp) # j 

    movl    12(%ebp), %eax
    movl    %eax, -8(%ebp)  # mid
    addl    $1, %eax
    movl    %eax, -24(%ebp) # k

    movl    8(%ebp), %eax
    movl    %eax, -12(%ebp) # hi

    movl    -12(%ebp), %eax
    movl    %eax, (%esp)

    movl    -4(%ebp), %eax
    movl    %eax, 4(%esp)

    call    copy

merge_next:
    movl    -20(%ebp), %eax
    movl    -8(%ebp), %ebx
    cmpl    %ebx, %eax
    jg      add_right

    movl    -24(%ebp), %eax
    movl    -12(%ebp), %ebx
    cmpl    %ebx, %eax
    jg      add_left

    movl    -20(%ebp), %eax
    movl    -24(%ebp), %ebx
    movl    aux(, %eax, 4), %eax
    movl    aux(, %ebx, 4), %ebx
    
    cmpl    %ebx, %eax
    jg      add_right

    jmp     add_left

add_left:

    movl    -20(%ebp), %eax
    movl    aux(, %eax, 4), %ebx
    addl    $1, %eax
    movl    %eax, -20(%ebp)
    movl    -16(%ebp), %eax
    movl    %ebx, seq(, %eax, 4)

    jmp     move_next

add_right:

    movl    -24(%ebp), %eax
    movl    aux(, %eax, 4), %ebx
    addl    $1, %eax
    movl    %eax, -24(%ebp)
    movl    -16(%ebp), %eax
    movl    %ebx, seq(, %eax, 4)

    jmp     move_next

move_next:

    movl    -16(%ebp), %eax
    addl    $1, %eax
    movl    %eax, -16(%ebp)
    movl    -12(%ebp), %ebx
    cmpl    %eax, %ebx
    jge     merge_next
    
merge_done:
    leave
    ret 

copy:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    12(%ebp), %edi
    movl    8(%ebp), %esi

copy_next:
    movl    seq(, %edi, 4), %eax
    movl    %eax, aux(, %edi, 4)
    addl    $1, %edi

    cmpl    %edi, %esi
    jge      copy_next 
    
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
    
    movl    $line, %eax
    movl    %eax, (%esp)
    call    printf
    
    leave
    ret

display_aux:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    N, %esi
    movl    $0, %edi 

display_aux_next:
    movl    aux(, %edi, 4), %eax
    movl    %eax, 4(%esp)
    movl    $fmt_d, (%esp)
    call    printf

    addl    $1, %edi
    cmpl    %edi, %esi
    jg      display_aux_next 
    
    movl    $line, %eax
    movl    %eax, (%esp)
    call    printf
    
    leave
    ret
