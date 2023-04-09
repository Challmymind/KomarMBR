ifndef BUILD
BUILD = .
endif

kernel.o : kernel.c
	gcc -o ${BUILD}/$@ $^ -ffreestanding -nostdlib -m32 -c -fno-pie
