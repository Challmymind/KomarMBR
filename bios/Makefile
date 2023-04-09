ifndef BUILD
BUILD = .
endif

biosboot.o : biosboot.s
	nasm -o ${BUILD}/$@ $^ -f elf64
