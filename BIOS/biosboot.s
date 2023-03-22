; Quick summary:
; Legacy bios boots us into Real Mode (16-bit).
; We don't have properly set stack and GDT.
; We have only 510 bytes to use here.
; So to go further we need to set stack, GDT and laod more segments from memory.
; What we have is BIOS interrupts that we can use.

section .bios1
; We are in real mode.
bits 16

; Print test message
mov BX , TEST_MSG
call bprint

; Infinity loop.
jmp $


TEST_MSG:
	db "Initial code loaded" , 0x0

; This copies code from files here.
%include "bmodules/bprint.s"

times 510 - ($-$$) db 0x0

; This is magic word that tells BIOS that this is bootable sector.
dw 0xAA55
