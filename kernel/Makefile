ifndef BUILD
BUILD = .
endif

kernel: kernel.o kernel_boot.o
	@echo "Compiling kernel."

kernel.o : kernel.c
	@gcc -o ${BUILD}/$@ $^ -ffreestanding -nostdlib -c -fno-pie -fno-asynchronous-unwind-tables -m32

kernel_boot.o: kernel_boot.s
	@gcc -o ${BUILD}/$@ $^ -ffreestanding -nostdlib -c -fno-pie -fno-asynchronous-unwind-tables -m32
