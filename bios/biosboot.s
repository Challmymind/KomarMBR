# Quick summary:
# Legacy bios boots us into Real Mode (16-bit).
# We don't have properly set stack and GDT.
# We have only 510 bytes to use here.
# So to go further we need to set stack, GDT and load more segments from memory.
# What we have is BIOS interrupts that we can use.

.equ PART_2_ADDR       ,0x9000
.equ READ_FROM_DISK    ,0x2
.equ SECTORS_TO_READ   ,0x2
.equ CYLINDER0         ,0x0
.equ SECTOR2           ,0x2
.equ HEAD0             ,0x0

######## BIOS1 ########
.section .bios1 , "ax"
    .code16

jmp $0x0, $main # Zero-ing cs register.

# Important don't edit dl reigtser until second boot part.
# It stores drive ID in which bios found this bootsector.
main:
    
    ######## RESET REGISTERS ########
    # It must be done because we can't assume what's already there.
    xor     %ax , %ax
    movw    %ax , %ds
    movw    %ax , %es
    movw    %ax , %ss
    
    ######## LOAD SECOND PART BOOTLOADER ########
    movb    $READ_FROM_DISK     , %ah # Explain
    movb    $SECTORS_TO_READ    , %al # How much data read. ?
    movb    $CYLINDER0          , %ch
    movb    $SECTOR2            , %cl
    movb    $HEAD0              , %dh
    movw    $PART_2_ADDR        , %bx # Where to load new data. ?
    int     $0x13
    
    jmp bios2_code
    
    jmp . # Infinity loop. catches all errors.
    
    
INIT_MSG:
    .asciz "INIT"

.fill 510 - (.-.bios1), 1, 0
.word 0xAA55 # This is magic word that tells BIOS that this is bootable sector.

.section .bios2 , "ax"
    .code16

######## BIOS2 ########
bios2_code:

#	.include "bmodules/bswap_pm_inline.s" # switch to pm.

    cli # 1. Disable interrupts.
    lgdt __pm_gdt_desc # 2. Load GDT

    # 3. Set CR0 flag.
    movl    %cr0    , %eax
    orl     $0x1    , %eax
    movl    %eax    , %cr0


	jmp $0x8,$clear_rm # far jump

    __pm_gdt_start:
    __pm_gdt_null:
        .long   0x0
        .long   0x0
    __pm_gdt_code:
        .word   0xFFFF
        .word   0x0000
    
        .byte   0x00
        .byte   0b10011010
        .byte   0b11001111
        .byte   0x00
    __pm_gdt_data:
        .word   0xFFFF
        .word   0x0000

        .byte   0x00
        .byte   0b10010010
        .byte   0b11001111
        .byte   0x00
    __pm_gdt_end:

    __pm_gdt_desc:
        .word   __pm_gdt_end - __pm_gdt_start - 1
        .long   __pm_gdt_start


clear_rm:
    .code32

    ######## SET UP SEGMENTS ########
    movw    $0x10   , %ax # point to correct segement selector.
    movw    %ax     , %ds
    movw    %ax     , %ss

	# set es , fs , gs to null selector.
	xorw    %ax     , %ax
    movw    %ax     , %es
    movw    %ax     , %fs
    movw    %ax     , %gs


	movl $0x90000 , %esp # set stack to 0x90000.

	call $0x8,$0x9200 # Call kernel.

	jmp . # Ininity loop.


	
LOAD_MSG:
	.asciz "LOAD"

BIOS2_MSG:
	.asciz "BIS2"

# Make sure its 512 byte long.
.fill 512 - (.-.bios2), 1, 0
