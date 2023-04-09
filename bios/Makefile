ifndef BUILD
BUILD = .
endif

biosboot: biosboot.o
	@echo "Compiling legacy bios bootstrap."

biosboot.o : biosboot.s
	@nasm -o ${BUILD}/$@ $^ -f elf64
