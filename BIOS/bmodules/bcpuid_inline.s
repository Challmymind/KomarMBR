; Used to detect CPUID.
; Will be used only once so use it as inline via %include.

; To check CPUID we need to check 0x200000 flag in eflags.

; Save current flags.
pushfd
xor dword 
