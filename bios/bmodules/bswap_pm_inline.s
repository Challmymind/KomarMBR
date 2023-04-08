; Enter PM mode.

; Aproach is taken from intel manual vol3 A.
jmp pm_internal_jump

; PM gdt
pm_gdt_start:

pm_gdt_null:
	dd 0x0
	dd 0x0

pm_gdt_code:
	; First double word.
	dw 0xFFFF
	dw 0x0000

	; Second double word.
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00

pm_gdt_data:
	; First double word.
	dw 0xFFFF
	dw 0x0000

	; Second double word.
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00
	


pm_gdt_end:

pm_gdt_desc:
dw pm_gdt_end - pm_gdt_start - 1
dd pm_gdt_start

pm_internal_jump:
; 1. Disable interrupts.
cli

; 2. Load GDT
lgdt [pm_gdt_desc]

; 3. Set CR0 flag.
mov eax , cr0
or eax, 0x1
mov cr0 , eax



