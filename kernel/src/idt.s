.globl __IDT_setregister

.text
    __IDT_setregister:
        lidt __IDT_desc

        # Disable PIC
        mov $0xff ,%al
        out %al   ,$0xa1
        out %al   ,$0x21

        sti
        ret
       
.data
    __IDT_desc:
        .word (256*16) - 1
        .long 0x0
