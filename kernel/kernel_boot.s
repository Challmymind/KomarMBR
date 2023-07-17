.section .boot , "ax"
.code32

.extern _kernel
call _kernel
jmp .

# For debbuging.
.word 0xBEEF
