ifndef BUILD
BUILD = .
endif

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables \
		   -m32

biosboot: biosboot.o biosbootc.o
	@echo "Compiling legacy bios bootstrap."

biosboot.o : biosboot.s
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

biosbootc.o : biosboot.c
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}
