BUILD_DIR = build
LINKERS_DIR = "Linkers"


ifdef BUILD_TYPE

BUILD_TYPE_DIR = ${BUILD_DIR}/${BUILD_TYPE}
OBJ_DIR = ${BUILD_TYPE_DIR}/obj

BUILD: BUILD_PRE
	ld -T ${LINKERS_DIR}/linker_${BUILD_TYPE}.ld -o ${BUILD_TYPE_DIR}/${BUILD_TYPE}.img ${shell find ${OBJ_DIR} -type f}

BUILD_PRE:
	mkdir -p ${BUILD_TYPE_DIR}
	mkdir -p ${OBJ_DIR}
	make -C ${BUILD_TYPE} BUILD=${shell pwd}/${OBJ_DIR}

clear:
	rm -r ${BUILD_TYPE_DIR}

endif
