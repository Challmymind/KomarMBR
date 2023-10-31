.section .boot , "ax"
.code64

call _kernel
jmp .
