ifndef BUILD
BUILD = .
endif

kernel: kernel.o kernel_boot.o
	@echo "Compiling kernel."

kernel.o : kernel.c
	@gcc -o ${BUILD}/$@ $^ -ffreestanding -nostdlib -m32 -c -fno-pie -fno-asynchronous-unwind-tables

kernel_boot.o: kernel_boot.s
	@nasm -o ${BUILD}/$@ $^ -f elf32
