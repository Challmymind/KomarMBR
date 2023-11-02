.globl __IDT_setregister
.globl cint_31

.text
    __IDT_setregister:
        lidt __IDT_desc
        ret

    cint_31:
        int $31
        ret
       
.data
    __IDT_desc:
        .word (32*16) - 1
        .long 0x0
