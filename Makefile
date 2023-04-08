BUILD_DIR = build
LINKERS_DIR = "linkers"
OS_NAME = Komar

# Run this if othing was chosen.
no_selection:
	echo "You need to choose correct build tree"

# BELOW PLACE MAIN BUILDS

# Bios build.
bios: LBUILD_DIR = ${BUILD_DIR}/bios
bios: OBJ_DIR=${LBUILD_DIR}/obj
bios: bios_pre_build
	ld -T ${LINKERS_DIR}/linker_$@.ld -o ${LBUILD_DIR}/$@_${OS_NAME}.img ${shell find ${OBJ_DIR} -type f}

# BELOW PLACE BUILD SPECIFIC PRE BUILDS.

bios_pre_build:
	mkdir -p ${LBUILD_DIR}
	mkdir -p ${OBJ_DIR}
	make -C bios BUILD=${shell pwd}/${OBJ_DIR}

clear:
	rm -r ${BUILD_DIR}
