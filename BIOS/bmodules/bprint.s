; Place address of string to be printed in bx then call this function.

bits 16
bprint:
	mov AH , 0xE

	_bprint_loop:
	mov AL , [BX]
	cmp AL , 0
	jz _bprint_done

	int 0x10
	add BX , 0x1
	jmp _bprint_loop

	_bprint_done:
	ret
