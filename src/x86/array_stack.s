    .data
    .comm stack, 40 
stack_size:
     .long 0 
fmt_size:
     .string "%d\n"
fmt_str:
     .string "%s\n"

str1:
    .string "to"
str2:
    .string "be"
str3:
    .string "or"
str4:
    .string "not"
str5:
    .string "to"
str6:
    .string "be"
str7:
    .string "that"
str8:
    .string "is"

    .globl main
main:
    pushl   %ebp
    movl    %esp, %ebp
    andl    $-16, %esp
    subl    $16, %esp 
    
    movl    $str1, (%esp) 
    call    push
    movl    $str2, (%esp) 
    call    push
    movl    $str3, (%esp) 
    call    push
    movl    $str4, (%esp) 
    call    push

    call    print_size

    call    pop
    movl    %eax, 4(%esp)
    movl    $fmt_str, (%esp) 
    call    printf 

    call    pop
    movl    %eax, 4(%esp)
    movl    $fmt_str, (%esp) 
    call    printf 

    call    print_size
    
    movl    $0, %eax 
    leave
    ret

push:
    pushl   %ebp
    movl    %esp, %ebp
    movl    stack_size, %eax 
    movl    8(%ebp), %edx 
    movl    %edx, stack(, %eax, 4)
    addl    $1, %eax 
    movl    %eax, stack_size 
    leave
    ret

pop:
    pushl   %ebp
    movl    %esp, %ebp
    movl    stack_size, %eax 
    subl    $1, %eax
    movl    %eax, stack_size
    movl    stack_size, %eax 
    movl    stack(, %eax, 4), %eax
    leave
    ret

is_empty:
    movl    $0, %eax 
    movl    stack_size, %ebx 
    cmpl    %eax, %ebx 
    jne     done
    movl    $1, %eax 
done:
    ret 

print_size:
    pushl   %ebp 
    movl    %esp, %ebp 
    andl    $-16, %esp 
    movl    stack_size, %eax 
    movl    %eax, 4(%esp)
    movl    $fmt_size, (%esp) 
    call    printf 
    leave
    ret
