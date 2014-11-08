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

#    call    init
    call    init_data
    call    display

    movl    $0, (%esp)
    movl    N, %eax
    subl    $1, %eax
    movl    %eax, 4(%esp)
#    call    partition

    call    quick_sort
    call    display

    movl    $0, %eax 

    leave
    ret

init_data:
    movl    $8, seq
    movl    $3, seq+4
    movl    $6, seq+8
    movl    $7, seq+12
    movl    $2, seq+16
    movl    $9, seq+20
    movl    $1, seq+24
    movl    $0, seq+28
    movl    $5, seq+32
    movl    $4, seq+36
    ret

quick_sort:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $40, %esp

    movl    8(%ebp), %eax  
    movl    %eax, -4(%ebp) # lo
    movl    12(%ebp), %ebx  
    movl    %ebx, -8(%ebp) # hi 

    cmpl    %ebx, %eax
    jge     sort_done

    movl    -4(%ebp), %eax
    movl    %eax, (%esp)
    movl    -8(%ebp), %eax
    movl    %eax, 4(%esp)
    call    partition 

    movl    %eax, -12(%ebp) 

    movl    -12(%ebp), %eax
    subl    $1, %eax
    movl    %eax, 4(%esp)
    movl    -4(%ebp), %eax
    movl    %eax, (%esp)
    call    quick_sort

    movl    -12(%ebp), %eax 
    addl    $1, %eax
    movl    %eax, (%esp)
    movl    -8(%ebp), %eax
    movl    %eax, 4(%esp)
    call    quick_sort 

    leave
    ret 
    
sort_done:
    leave
    ret

partition:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $40, %esp 

    movl    8(%ebp), %eax 
    movl    %eax, -4(%ebp) # lo
    movl    %eax, -12(%ebp) # j = lo

    movl    seq(, %eax, 4), %eax
    movl    %eax, -20(%ebp) # seq[lo]

    movl    12(%ebp), %eax 
    movl    %eax, -8(%ebp) # hi
    addl    $1, %eax
    movl    %eax, -16(%ebp) # k = hi + 1

part_next:
add_left:
    movl    -12(%ebp), %eax
    addl    $1, %eax         
    movl    %eax, -12(%ebp)

    movl    -8(%ebp), %ebx
    cmpl    %eax, %ebx
#    je      swap_left_right
    je      sub_right

    movl    seq(, %eax, 4), %eax 
    movl    -20(%ebp), %ebx
    cmpl    %eax, %ebx
    jg      add_left

#    movl    -12(%ebp), %eax
#    movl    %eax, 4(%esp)
#    movl    $fmt, (%esp)
#    call    printf
#    movl    $line, (%esp)
#    call    printf

sub_right:
    movl    -16(%ebp), %eax
    subl    $1, %eax        # k--

    movl    -4(%ebp), %ebx
    cmpl    %eax, %ebx
    je      swap_left_right 

    movl    %eax, -16(%ebp)
    movl    seq(, %eax, 4), %eax
    movl    -20(%ebp), %ebx
    cmpl    %ebx, %eax
    jg      sub_right 

#    movl    -16(%ebp), %eax
#    movl    %eax, 4(%esp)
#    movl    $fmt, (%esp)
#    call    printf
#    movl    $line, (%esp)
#    call    printf

swap_left_right:
    movl    -12(%ebp), %eax # j
    movl    -16(%ebp), %ebx # k
    cmpl    %ebx, %eax
    jge     part_done   
    jmp     swap_j_k 

swap_j_k:
    movl    %eax, (%esp)
    movl    %ebx, 4(%esp)
    call    swap
    jmp     part_next 

part_done:
    movl    -16(%ebp), %eax 
    movl    %eax, (%esp)
    movl    -4(%ebp), %ebx
    movl    %ebx, 4(%esp)
    call    swap 
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
