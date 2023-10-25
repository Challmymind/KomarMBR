ifndef BUILD_DIR
BUILD_DIR = .
endif

BUILD = ${BUILD_DIR}/src

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables

src_kernel: hello.o
	@echo "Compiling kernel source."

hello.o : hello.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}
