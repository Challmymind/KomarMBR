section .boot
bits 32

extern _kernel
call _kernel
jmp $

; For debbuging.
dw 0xBEEF
