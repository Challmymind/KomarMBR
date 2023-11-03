.globl mcpy_4
.globl rmcpy_4
.text

    mcpy_4:
        movl (%rdi)     ,%eax
        movl %eax       ,(%rsi)
        ret

    rmcpy_4:
        movl %edi       ,(%rsi)
        ret
