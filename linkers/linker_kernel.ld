OUTPUT_FORMAT("binary")

SECTIONS {
	. = 0x9200;

	.text :
	{
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
}
