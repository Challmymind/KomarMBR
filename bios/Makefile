ifndef BUILD
BUILD = .
endif

biosboot: biosboot.o
	@echo "Compiling legacy bios bootstrap."

biosboot.o : biosboot.s
	@gcc -o ${BUILD}/$@ $^ -ffreestanding -nostdlib -c -fno-pie -fno-asynchronous-unwind-tables
