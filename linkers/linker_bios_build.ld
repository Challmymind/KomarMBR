# This is linker script that legacy bios boot will use.
OUTPUT_FORMAT("binary")

SECTIONS {
	# This memory must be precisely defined.
	# First sector will be loaded at 0x7C00 and in binary will start at the begining. 
	.bios_sec1 0x7C00 : AT(0x0)
	{
		*(.bios1)
	}
	
	# Second sector will be loaded at 0x9000 and in binary will start from 512 byte offset (size of first sec)
	.bios_sec2 0x9000 : AT(0x200)
	{
		*(.bios2)
	}

    /DISCARD/ : 
    {
        *(*)
    }

}
