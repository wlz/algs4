    .comm   seq,    40
    .comm   aux,    40
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
    call    display_seq

    movl    $0, %eax 
    leave
    ret

merge:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $40, %esp

    movl    8(%ebp), %eax 
    movl    %eax, -4(%ebp) # lo
    movl    12(%ebp), %eax 
    movl    %eax, -8(%ebp) # mid
    movl    16(%ebp), %eax
    movl    %eax, -12(%ebp) # hi
    
    movl    -4(%ebp), %eax      
    movl    %eax, (%esp)
    movl    -12(%ebp), %eax     
    movl    %eax, 4(%esp)
    call    copy

    movl    -4(%ebp), %eax
    movl    %eax, -16(%ebp) # j = lo
    
    movl    %eax, -24(%ebp) # i = lo

    movl    -8(%ebp), %eax
    addl    $1, %eax 
    movl    %eax, -20(%ebp) # k = mid + 1

move_next:

    movl    -16(%ebp), %eax  # j
    movl    -8(%ebp), %ebx # mid 
    cmpl    %ebx, %eax 
    jg      add_right 

    movl    -20(%ebp), %eax # k
    movl    -12(%ebp), %ebx # hi
    cmpl    %ebx, %eax 
    jg      add_left 

    movl    -16(%ebp), %eax  # j
    movl    -20(%ebp), %ebx # k

    movl    aux(, %eax, 4), %eax    # 1
    movl    aux(, %ebx, 4), %ebx    # 0

#    movl    $fmt, (%esp)
#    movl    %eax, 4(%esp)
#    call    printf
#
#    movl    $fmt, (%esp)
#    movl    %ebx, 4(%esp)
#    call    printf

    cmpl    %eax, %ebx
    jg      add_left
    
    jmp     add_right

add_right:
    movl    -20(%ebp), %eax
    movl    aux(, %eax, 4), %ebx
    
    movl    -24(%ebp), %ecx
    movl    %ebx, seq(, %ecx, 4)

    addl    $1, %eax 
    movl    %eax, -20(%ebp)
    addl    $1, %ecx 
    movl    %ecx, -24(%ebp)

    movl    -12(%ebp), %edx
    cmpl    %ecx, %edx 
    jg      move_next
    jmp     merge_done

add_left:
    movl    -16(%ebp), %eax
    movl    aux(, %eax, 4), %ebx
    
    movl    -24(%ebp), %ecx
    movl    %ebx, seq(, %ecx, 4)

    addl    $1, %eax 
    movl    %eax, -16(%ebp)
    addl    $1, %ecx 
    movl    %ecx, -24(%ebp)

    movl    -12(%ebp), %edx
    cmpl    %ecx, %edx 
    jg      move_next
    jmp     merge_done
    
merge_done:
    leave
    ret 

copy:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    8(%ebp), %eax
    movl    %eax, -4(%ebp)
    movl    12(%ebp), %eax
    movl    %eax, -8(%ebp)

loop_copy:
    movl    -4(%ebp), %eax
    movl    seq(, %eax, 4), %ebx    
    movl    %ebx, aux(, %eax, 4)

    addl    $1, %eax    
    movl    %eax, -4(%ebp)
    movl    -8(%ebp), %ebx 
    cmpl    %eax, %ebx
    jge      loop_copy

    leave
    ret

init:
    movl    $0, %eax 
    movl    N, %ebx 
init_next:
    movl    %eax, seq(, %eax, 4)
    addl    $1, %eax 
    cmpl    %eax, %ebx 
    jg      init_next 

    call    shuffle
    ret 

shuffle:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $0, (%esp)
    call    time
    movl    %eax, (%esp)
    call    srand

    movl    $1, -4(%ebp)

loop_sh:
    call    rand    
    movl    %eax, 4(%esp)

    movl    -4(%ebp), %eax
    movl    %eax, (%esp)
    call    mod
    
    movl    %eax, (%esp)
    movl    -4(%ebp), %eax
    movl    %eax, 4(%esp)
    call    swap

    movl    -4(%ebp), %eax
    addl    $1, %eax
    movl    %eax, -4(%ebp)
    movl    N, %ebx
    cmpl    %eax, %ebx
    jg      loop_sh

    leave 
    ret

mod:
    pushl   %ebp
    movl    %esp, %ebp
    
    movl    8(%ebp), %ecx 
    movl    12(%ebp), %eax 
    movl    $0, %edx 
    divl   %ecx 
    movl    %edx, %eax 

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

display_seq:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $seq, %eax 
    movl    %eax, (%esp)        
    call    display
    leave 
    ret

display_aux:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp

    movl    $aux, %eax 
    movl    %eax, (%esp)        
    call    display
    leave 
    ret

display:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    movl    8(%ebp), %eax
    movl    %eax, -8(%ebp)

    movl    $0, -4(%ebp) 
loop_show:
    movl    -4(%ebp), %eax
    movl    -8(%ebp), %ebx
    movl    (%ebx, %eax, 4), %eax 
    movl    %eax, 4(%esp)
    movl    $fmt, (%esp)
    call    printf
    
    movl    -4(%ebp), %eax
    addl    $1, %eax
    movl    %eax, -4(%ebp)
    movl    N, %ebx
    cmpl    %eax, %ebx
    jg      loop_show    

    movl    $line, (%esp)
    call    printf
    leave
    ret
