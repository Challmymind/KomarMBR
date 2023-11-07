BUILD_DIR = ${shell pwd}/build
LINKERS_DIR = linkers
OS_NAME = Komar
DISK_IMAGE_SIZE = 1M

# Run this if nothing was chosen.
no_selection:
	@echo "You need to choose correct build tree"

all: link
	@echo "Creating image file."
	@dd of="${BUILD_DIR}/${OS_NAME}.img" \
		if="/dev/zero" \
		bs=1M \
		count=10 \
		conv=notrunc 2> /dev/null
	@dd of="${BUILD_DIR}/${OS_NAME}.img" \
		if="${BUILD_DIR}/images/bios.bin" \
		conv=notrunc 2> /dev/null
	@dd of="${BUILD_DIR}/${OS_NAME}.img" \
		if="${BUILD_DIR}/images/kernel.bin" \
		conv=notrunc \
		seek=9 2> /dev/null

link: build
	@echo "Link files"
	@mkdir -p ${BUILD_DIR}/images
	@ld -T ${LINKERS_DIR}/kernel.ld \
		-o ${BUILD_DIR}/images/kernel.bin \
		${shell find ${BUILD_DIR}/kernel -type f}
	@ld -T ${LINKERS_DIR}/bios.ld \
		-o ${BUILD_DIR}/images/bios.bin \
		-melf_i386 \
		${shell find ${BUILD_DIR}/bios -type f}

build:
	@echo "Build files"
	@mkdir -p ${BUILD_DIR}
	@make -C bios BUILD_DIR=${BUILD_DIR} --no-print-directory
	@make -C kernel BUILD_DIR=${BUILD_DIR} --no-print-directory
