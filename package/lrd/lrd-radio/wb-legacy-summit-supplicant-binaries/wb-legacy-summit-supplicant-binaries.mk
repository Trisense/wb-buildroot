ifneq ($(BR2_LRD_DEVEL_BUILD),y)

WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_VERSION = $(call qstrip,$(BR2_PACKAGE_LRD_RADIO_STACK_VERSION_VALUE))
WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_SOURCE =
WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_LICENSE = GPL-2.0
WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_INSTALL_STAGING = YES

WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_EXTRA_DOWNLOADS = summit_supplicant_legacy-arm-eabi-$(WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_VERSION).tar.bz2

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_SITE = https://files.devops.rfpros.com/builds/linux/summit_supplicant/laird/$(WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_VERSION)
else
  WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_SITE = https://github.com/LairdCP/wb-package-archive/releases/download/LRD-REL-$(WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_VERSION)
endif

define WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_INSTALL_STAGING_CMDS
	tar -xjf $($(PKG)_DL_DIR)/$(WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_EXTRA_DOWNLOADS) -C $(STAGING_DIR) --keep-directory-symlink --no-overwrite-dir --touch --wildcards usr/include usr/lib/lib*
endef

define WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_INSTALL_TARGET_CMDS
	tar -xjf $($(PKG)_DL_DIR)/$(WB_LEGACY_SUMMIT_SUPPLICANT_BINARIES_EXTRA_DOWNLOADS) -C $(TARGET_DIR) --keep-directory-symlink --no-overwrite-dir --touch --exclude=usr/include --exclude=usr/lib/libsdc_sdk.so
endef

endif

$(eval $(generic-package))