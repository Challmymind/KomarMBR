.section .boot , "ax"
.code64

#enable interrupts

call _kernel
jmp .
