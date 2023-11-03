# Quick summary:
# Legacy bios boots us into Real Mode (16-bit).
# We don't have properly set stack and GDT.
# We have only 510 bytes to use here.
# So to go further we need to set stack, GDT and load more segments from memory.
# What we have is BIOS interrupts that we can use.

.globl __enable_IA_32e_paging
.globl __jmp_kernel
.globl __check_support
.equ PART_2_ADDR       ,0x9000
.equ READ_FROM_DISK    ,0x2
.equ SECTORS_TO_READ   ,0x20
.equ CYLINDER0         ,0x0
.equ SECTOR2           ,0x2
.equ HEAD0             ,0x0
.equ C_PART            ,__c_biosboot

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

    cli # 1. Disable interrupts.
    lgdt __pm_gdt_desc # 2. Load GDT

    # 3. Set CR0 flag
    # To be more precise we are setting up bit 0 of CR0 (called PE),
    # enabling segmentation.
    movl    %cr0    , %eax
    orl     $0x1    , %eax
    movl    %eax    , %cr0


	jmp $0x8,$clear_rm # far jump

    ######## GDT for IA-32 ########
    .p2align 3, 0x58 # according to 3.2 in Intel Programing Manual Vol. 3A base address of GDT should be aligned an 
    # eight byte for best processor performance.
    __pm_gdt_start:
    __pm_gdt_null:
        .long   0x0
        .long   0x0
    __pm_gdt_code:
        .word   0xFFFF      # segment limit     (0-15bits)
        .word   0x0000      # base address      (0-15bits)
        .byte   0x00        # base address      (16-23bits)
        .byte   0b10011010   
        # If i'm correct you must look at it from the last.
        # [4bits] Type: "1010" 
            # ^ Explained: (Code) Execute/Read
        # [1bit] Descriptor type: "1" = code/data
        # [2bits] Descriptor Privilage Level: "00"
        # [1bit] Segment Present: "1:
        .byte   0b11001111
        # [4bits] segment limit (16-19): "1111"
        # [1bit] Avaible for use by system software: "0:
        # [1bit] IA-32e segment: "0"
        # [1bit] Default operation size: "1" = 32bit segment 
        # [1bit] Granularity: "1" = segment size can be above 1MB
        .byte   0x00        # base address      (24-31)
    __pm_gdt_data:
        .word   0xFFFF
        .word   0x0000
        .byte   0x00
        .byte   0b10010010
        # Type explained: "0010" = (Data) Read/Write
        .byte   0b11001111
        .byte   0x00

    __lm_gdt_code:
        .word   0xFFFF      # segment limit     (0-15bits)
        .word   0x0000      # base address      (0-15bits)
        .byte   0x00        # base address      (16-23bits)
        .byte   0b10011010   
        # If i'm correct you must look at it from the last.
        # [4bits] Type: "1010" 
            # ^ Explained: (Code) Execute/Read
        # [1bit] Descriptor type: "1" = code/data
        # [2bits] Descriptor Privilage Level: "00"
        # [1bit] Segment Present: "1:
        .byte   0b10101111
        # [4bits] segment limit (16-19): "1111"
        # [1bit] Avaible for use by system software: "0:
        # [1bit] IA-32e segment: "0"
        # [1bit] Default operation size: "1" = 32bit segment 
        # [1bit] Granularity: "1" = segment size can be above 1MB
        .byte   0x00        # base address      (24-31)
    __lm_gdt_data:
        .word   0xFFFF
        .word   0x0000
        .byte   0x00
        .byte   0b10010010
        # Type explained: "0010" = (Data) Read/Write
        .byte   0b10101111
        .byte   0x00
    __tr_lm:
        .word   0x67
        .word   0xff0
        .byte   0x0
        # This type might be invalid
        .byte   0b10001001
        .word   0x0
        .long   0x0
        .long   0x0

    __pm_gdt_end:
    __pm_gdt_desc:
        .word   __pm_gdt_end - __pm_gdt_start - 1
        .long   __pm_gdt_start



clear_rm:
    .code32

    ######## SET UP SEGMENTS ########
    movw    $0x10   , %ax
    movw    %ax     , %ds 
    # points to data segment. (data segment is offseted by 16 bytes from GDT base)
    movw    %ax     , %ss

	# set es , fs , gs to null selector because we are not using those segments.
	xorw    %ax     , %ax
    movw    %ax     , %es
    movw    %ax     , %fs
    movw    %ax     , %gs

	movl $0x90000 , %esp # set stack to 0x90000.

	call $0x8,$C_PART # call C part.

	jmp . # ininity loop.

######## FUNCTIONS FOR C PART ########
__check_support:
    .code32
    // To check for CPUID we need to check if we are able to swap 21th bit
    // in EFLAGS.
    pushl %ebx
    pushfl

    // Switching byte
    popl %eax
    movl %eax       ,%ebx
    xorl $(1<<21)   ,%eax
    
    // Switched flag
    pushl %eax
    popfl

    // Checking if was it successful
    pushfl
    popl %eax
    xorl $(1<<21)   ,%eax
    cmpl %eax       ,%ebx
    jnz  __check_support_ERROR

    // Recover old EFLAGS
    pushl %ebx
    popfl

    // Check for APIC.
    movl $0x1,%eax
    cpuid
    test $(1<<9)    ,%edx
    jz __check_support_ERROR

    // Check for extended CPUID.
    movl $0x80000000,%eax
    cpuid

    // Check if we can use 80000001 instruction.
    cmpl $0x80000001,%eax
    jb __check_support_ERROR

    // Check for 64bit mode.
    movl $0x80000001,%eax
    cpuid

    // Check 29th bit of EDX
    test $(1<<29)   ,%edx
    jz __check_support_ERROR

    popl %ebx
    ret 

    __check_support_ERROR:
        jmp .

__enable_IA_32e_paging:
    .code32

    // Set CR3
    movl $0x10000   ,%eax
    movl %eax       ,%cr3
    
    // Swap PAE
    movl %cr4       ,%eax 
    orl  $(1<<5)    ,%eax 
    movl %eax       ,%cr4
    
    // Swap LME
    movl $0xC0000080,%ecx
    rdmsr
    orl  $(1<<8)    ,%eax
    wrmsr

    // Swap PG
    movl %cr0       ,%eax
    orl  $(1<<31)   ,%eax
    movl %eax       ,%cr0

	jmp $0x18,$long_mode # far jump

__jmp_kernel:
    .code64
    mov  $0xA000    ,%rax
    jmp  *%rax

long_mode:
    .code64

    ######## SET UP SEGMENTS (IA-32e) ########
    movw    $0x20   , %ax
    movw    %ax     , %ds
    movw    %ax     , %ss

    ret
