# enable tracing and exit on errors
set -x -e

BR2_LRD_PRODUCT="$(sed -n 's,^BR2_DEFCONFIG=".*/\(.*\)_defconfig"$,\1,p' ${BR2_CONFIG})"

echo "${BR2_LRD_PRODUCT^^} POST IMAGE script: starting..."

# Then update SPL with appended keyed DTB
cat "${BINARIES_DIR}/u-boot-spl-nodtb.bin" "${BINARIES_DIR}/u-boot-spl.dtb" > "${BINARIES_DIR}/u-boot-spl.bin"

# wbx3 sd card loading tools
ln -rsf board/laird/scripts-common/mksdcard-wbx3.sh ${BINARIES_DIR}/mksdcard.sh
ln -rsf board/laird/scripts-common/mksdimg-wbx3.sh ${BINARIES_DIR}/mksdimg.sh

[ -n "${VERSION}" ] && RELEASE_SUFFIX="-${VERSION}"

tar -C ${BINARIES_DIR} \
	-chjf ${BINARIES_DIR}/${BR2_LRD_PRODUCT}-laird${RELEASE_SUFFIX}.tar.bz2 \
	--owner=0 --group=0 --numeric-owner \
	u-boot-spl.bin u-boot.itb mksdcard.sh mksdimg.sh

echo "${BR2_LRD_PRODUCT^^} POST IMAGE script: done."
