BUILD_DIR = build
LINKERS_DIR = linkers
OS_NAME = Komar
DISK_IMAGE_SIZE = 1M

# Run this if nothing was chosen.
no_selection:
	@echo "You need to choose correct build tree"

# BELOW PLACE KERNEL

kernel: LBUILD_DIR = ${BUILD_DIR}/kernel
kernel: OBJ_DIR=${LBUILD_DIR}/obj
kernel: kernel_pre_build
	@echo "Linking kernel."
	@ld -T ${LINKERS_DIR}/linker_$@.ld -o ${LBUILD_DIR}/$@_${OS_NAME}.bin ${shell find ${OBJ_DIR} -type f}

kernel_pre_build:
	@echo "Creating kernel folders"
	@mkdir -p ${LBUILD_DIR}
	@mkdir -p ${OBJ_DIR}
	@make -C kernel BUILD=${shell pwd}/${OBJ_DIR} --no-print-directory

# BELOW PLACE MAIN SETUPS
bios: LBUILD_DIR = ${BUILD_DIR}/bios
bios: OBJ_DIR=${LBUILD_DIR}/obj
bios: bios_build kernel
	@echo "Creating image file."
	@fallocate -l ${DISK_IMAGE_SIZE} ${BUILD_DIR}/$@.img
	@dd of="${BUILD_DIR}/$@.img" if="/dev/zero" count=20 conv=notrunc 2> /dev/null
	@dd of="${BUILD_DIR}/$@.img" if="${BUILD_DIR}/$@/bios_${OS_NAME}.bin" conv=notrunc 2> /dev/null
	@dd of="${BUILD_DIR}/$@.img" if="${BUILD_DIR}/kernel/kernel_${OS_NAME}.bin" conv=notrunc seek=9 2> /dev/null


# BELOW PLACE MAIN BUILDS

# Bios build.
bios_build: bios_pre_build
	@echo "Linking legacy bios bootstrap."
	@ld -T ${LINKERS_DIR}/linker_$@.ld -o ${LBUILD_DIR}/bios_${OS_NAME}.bin ${shell find ${OBJ_DIR} -type f} -melf_i386

# BELOW PLACE BUILD SPECIFIC PRE BUILDS.

bios_pre_build:
	@echo "Creating bios folders"
	@mkdir -p ${LBUILD_DIR}
	@mkdir -p ${OBJ_DIR}
	@make -C bios BUILD=${shell pwd}/${OBJ_DIR} --no-print-directory
