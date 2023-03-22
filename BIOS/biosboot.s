; Quick summary:
; Legacy bios boots us into Real Mode (16-bit).
; We don't have properly set stack and GDT.
; We have only 510 bytes to use here.
; So to go further we need to set stack, GDT and laod more segments from memory.
; What we have is BIOS interrupts that we can use.

SECOND_LOAD_ADDR equ 0x9000

section .bios1
; We are in real mode.
bits 16

; BIOS stores in DL drive that it was booted from.
mov [DRIVE] , DL

; Print test message
mov BX , TEST_INIT_MSG
call bprint

mov AH , 0x2 ; Read from disk.
mov AL , 0x1 ; Read one sector.
mov CH , 0x0 ; Cylinder 0.
mov CL , 0x2 ; Start reading from sector 2.
mov DH , 0x0 ; Head 0.
mov DL , [DRIVE] ; Read from same drive as boot.
mov BX , SECOND_LOAD_ADDR ; Load data to this position.
int 0x13

mov BX , TEST_LOAD_MSG
call bprint

jmp bios2_code
; Infinity loop.
jmp $


TEST_INIT_MSG:
	db "Initial code loaded", 0xA, 0xD, 0x0

DRIVE:
	db 0x0

; This copies code from files here.
%include "bmodules/bprint.s"

times 510 - ($-$$) db 0x0

; This is magic word that tells BIOS that this is bootable sector.
dw 0xAA55

section .bios2
bits 16

; Code located in second sector.
bios2_code:
	mov bx , TEST_B2CODE_MSG
	call bprint

	; Ininity loop
	jmp $
	
TEST_LOAD_MSG:
	db "Second code loaded", 0xA, 0xD, 0x0

TEST_B2CODE_MSG:
	db "Called from bios2", 0xA, 0xD, 0x0

; Make sure its 512 byte long.
times 512 - ($-$$) db 0x0
