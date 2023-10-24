ifndef BUILD
BUILD = .
endif

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables \

kernel: kernel.o kernel_boot.o
	@echo "Compiling kernel."

kernel.o : kernel.c
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

kernel_boot.o: kernel_boot.s
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS} 
