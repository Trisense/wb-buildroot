BR2_LRD_PRODUCT="$(sed -n 's,^BR2_DEFCONFIG=".*/\(.*\)_defconfig"$,\1,p' ${BR2_CONFIG})"
BOARD_DIR="$(realpath $(dirname $0))"

echo "${BR2_LRD_PRODUCT^^} POST BUILD script: starting..."

LOCRELSTR="${LAIRD_RELEASE_STRING}"
if [ -z "${LOCRELSTR}" ] || [ "${LOCRELSTR}" == "0.0.0.0" ]; then
	LOCRELSTR="Summit Linux development build 0.${BR2_LRD_BRANCH}.0.0 $(date +%Y%m%d)"
fi
echo "${LOCRELSTR}" > "${TARGET_DIR}/etc/issue"

[ -z "${VERSION}" ] && LOCVER="0.${BR2_LRD_BRANCH}.0.0" || LOCVER="${VERSION}"

echo -ne \
"NAME=\"Summit Linux\"\n"\
"VERSION=\"${LOCRELSTR}\"\n"\
"ID=${BR2_LRD_PRODUCT}\n"\
"VERSION_ID=${LOCVER}\n"\
"BUILD_ID=${LOCRELSTR##* }\n"\
"PRETTY_NAME=\"${LOCRELSTR}\"\n"\
>  "${TARGET_DIR}/usr/lib/os-release"

# Copy the product specific rootfs additions
rsync -rlptDWK --exclude=.empty "${BOARD_DIR}/rootfs-additions/" "${TARGET_DIR}"
cp "${BOARD_DIR}/../rootfs-additions-common/usr/sbin/fw_"* "${TARGET_DIR}/usr/sbin"
rm -f ${TARGET_DIR}/etc/init.d/S20urandom

if grep -q 'BR2_LINUX_KERNEL_VERSION="3.2.102"' ${BR2_CONFIG}; then
	# On pre pinctrl kernels GPIO number is +32
	sed 's/reset_pwd_gpio=24/reset_pwd_gpio=56/' -i ${TARGET_DIR}/etc/modprobe.d/lrdmwl.conf
	sed 's/ 24 / 56 /' -i ${TARGET_DIR}/root/*.sh
	sed 's/ 23 / 55 /' -i ${TARGET_DIR}/root/*.sh
fi

# Fixup and add debugfs to fstab
grep -q "/sys/kernel/debug" ${TARGET_DIR}/etc/fstab ||\
	echo 'nodev /sys/kernel/debug   debugfs   defaults   0  0' >> ${TARGET_DIR}/etc/fstab

echo "${BR2_LRD_PRODUCT^^} POST BUILD script: done."
