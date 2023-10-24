.section .boot , "ax"
.code64

call _kernel
jmp .

# For debbuging.
.word 0xBEEF
