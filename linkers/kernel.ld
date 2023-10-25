OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0xA000;

	.text :
	{
		*(.boot)
		*(.text)
	}
 
	.rodata :
	{
		*(.rodata)
	}
 
	.data :
	{
		*(.data)
	}
 
	.bss :
	{
		*(COMMON)
		*(.bss)
	}

    /DISCARD/ : 
    {
        *(*)
    }

}
