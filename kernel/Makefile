ifndef BUILD_DIR
BUILD_DIR = .
endif

BUILD = ${BUILD_DIR}/kernel

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables

kernel: kernel.o kernel_boot.o
	@echo "Compiling kernel."
	@make -C src BUILD_DIR=${BUILD}

kernel.o : kernel.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

kernel_boot.o: kernel_boot.s
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS} 
