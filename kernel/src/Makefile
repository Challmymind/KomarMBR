ifndef BUILD_DIR
BUILD_DIR = .
endif

BUILD = ${BUILD_DIR}/src

GCCFLAGS = -ffreestanding \
		   -nostdlib \
		   -c \
		   -fno-pie \
		   -fno-asynchronous-unwind-tables \

src_kernel: printb.o idt.o idts.o 	\
			mcpy.o int_handlers.o 	\
			int_handlerss.o
	@echo "Compiling kernel source."

mcpy.o: mcpy.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

int_handlerss.o: int_handlers.s
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

int_handlers.o: int_handlers.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

idts.o: idt.s
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

idt.o: idt.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}

printb.o : printb.c
	@mkdir -p ${BUILD}
	@gcc -o ${BUILD}/$@ $^ ${GCCFLAGS}
