OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x9200;

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
