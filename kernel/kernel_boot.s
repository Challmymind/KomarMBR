.section .boot , "ax"
.code32

.extern _pm_kernel
call _pm_kernel
jmp .

# For debbuging.
.word 0xBEEF
