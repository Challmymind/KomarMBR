.globl INT_printr
.extern printb_t
.extern printb_h

.text

    INT_printr:
        # According to System V ABI 
        # all integers (ex. int, long, long long)
        # are classified as INTEGER class which are
        # passed be registers.
        # First used register is %rdi and then %rsi.

        # Also from A,B,C,D registers only B is callee saved
        # so we need to preserve them.
        # It is done in reverse order so we can easily access them back.
        push %rdx
        push %rcx
        push %rax

        # lets clear screen
        call printb_void

        # We will use this to print A,B,C,D registers on screen.
        # Pointers are calssiefied also as INTEGER.
        movq $0    ,%rdi
        movq $MSG_A,%rsi
        call printb_t

        movq $2    ,%rdi
        movq $MSG_B,%rsi
        call printb_t

        movq $4    ,%rdi
        movq $MSG_C,%rsi
        call printb_t

        movq $6    ,%rdi
        movq $MSG_D,%rsi
        call printb_t

        # Here printing function

        pop %rax
        movq $1    ,%rdi
        movq %rax  ,%rsi
        call printb_h

        # RBX is callee saved.
        movq $3    ,%rdi
        movq %rbx  ,%rsi
        call printb_h

        pop %rcx
        movq $5    ,%rdi
        movq %rcx  ,%rsi
        call printb_h

        pop %rdx
        movq $7    ,%rdi
        movq %rdx  ,%rsi
        call printb_h

        jmp .

.data
    MSG_A:
        .asciz "Register A"
    MSG_B:
        .asciz "Register B"
    MSG_C:
        .asciz "Register C"
    MSG_D:
        .asciz "Register D"
