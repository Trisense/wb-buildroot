ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_SUPPLICANT_BINARIES_VERSION = 7.0.0.47
SUMMIT_SUPPLICANT_BINARIES_SOURCE =
SUMMIT_SUPPLICANT_BINARIES_LICENSE = GPL-2.0
SUMMIT_SUPPLICANT_BINARIES_SITE = https://github.com/LairdCP/wb-package-archive/raw/master
SUMMIT_SUPPLICANT_BINARIES_EXTRA_DOWNLOADS = summit_supplicant-arm-eabihf-$(SUMMIT_SUPPLICANT_BINARIES_VERSION).tar.bz2

define SUMMIT_SUPPLICANT_BINARIES_INSTALL_TARGET_CMDS
	tar -xjf $(DL_DIR)/$(SUMMIT_SUPPLICANT_BINARIES_EXTRA_DOWNLOADS) -C $(TARGET_DIR) --keep-directory-symlink --no-overwrite-dir --touch
endef

endif

$(eval $(generic-package))
