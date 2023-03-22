# This is linker script that legacy bios boot will use.
OUTPUT_FORMAT("binary")

SECTIONS {
	# Here bios loads our code
	. = 0x7C00;
	.text : 
	{
		*(.bios1)	
	}

}
