ifndef BUILD_DIR
BUILD_DIR = .
endif

BUILD = ${BUILD_DIR}/bios

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables \
		   -m32

biosboot: biosboot.o biosbootc.o
	@echo "Compiling legacy bios bootstrap."

biosboot.o : biosboot.s
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

biosbootc.o : biosboot.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}
