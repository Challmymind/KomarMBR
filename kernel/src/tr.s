.globl TR_Initialize

.text
    
    TR_Initialize:
        movw $0x28  ,%ax
        ltr %ax
        ret
