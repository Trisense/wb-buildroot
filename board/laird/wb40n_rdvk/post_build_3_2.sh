BR2_LRD_PRODUCT="$(sed -n 's,^BR2_DEFCONFIG=".*/\(.*\)_defconfig"$,\1,p' ${BR2_CONFIG})"
BOARD_DIR="$(realpath $(dirname $0))"

echo "${BR2_LRD_PRODUCT^^} POST BUILD script: starting..."

# source the common post build script
source "board/laird/post_build_common.sh" "${TARGET_DIR}"

rm -f ${TARGET_DIR}/etc/init.d/S95bluetooth.bg
rm -f ${TARGET_DIR}/etc/init.d/S40wifi
rm -f ${TARGET_DIR}/etc/init.d/S99lighttpd
rm -f ${TARGET_DIR}/etc/init.d/S03cryptodev
rm -f ${TARGET_DIR}/etc/init.d/S37usbhost 

# Copy the product specific rootfs additions
rsync -rlptDWK --exclude=.empty "${BOARD_DIR}/rootfs-additions/" "${TARGET_DIR}"

# On pre pinctrl kernels GPIO number is +32
sed 's/reset_pwd_gpio=24/reset_pwd_gpio=56/' -i ${TARGET_DIR}/etc/modprobe.d/lrdmwl.conf
sed 's/ 24 / 56 /' -i ${TARGET_DIR}/root/*.sh
sed 's/ 23 / 55 /' -i ${TARGET_DIR}/root/*.sh

# Fixup and add debugfs to fstab
grep -q "/sys/kernel/debug" ${TARGET_DIR}/etc/fstab ||\
	echo 'nodev /sys/kernel/debug   debugfs   defaults   0  0' >> ${TARGET_DIR}/etc/fstab

echo "${BR2_LRD_PRODUCT^^} POST BUILD script: done."