FIRMWARE_BINARIES_VERSION = 5.0.0.31

STERLING-LWB-FCC=480-0079
STERLING-LWB-ETSI=480-0080
STERLING-LWB-JP=480-0116
STERLING-LWB5-FCC=480-0081
STERLING-LWB5-ETSI=480-0082
STERLING-LWB5-IC=480-0094
STERLING-LWB5-JP=480-0095
LWB-MFG=480-0108
LWB5-MFG=480-0109
WL-FMAC=930-0081
LRD-MWL=laird-sterling-60

FIRMWARE_BINARIES_SOURCE = $(LRD-MWL)-$(FIRMWARE_BINARIES_VERSION).tar.bz2
FIRMWARE_BINARIES_EXTRA_DOWNLOADS = $(STERLING-LWB-FCC)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB-ETSI)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB5-FCC)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB5-ETSI)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB5-IC)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB5-JP)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(LWB-MFG)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(LWB5-MFG)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(STERLING-LWB-JP)-$(FIRMWARE_BINARIES_VERSION).zip \
									$(WL-FMAC)-$(FIRMWARE_BINARIES_VERSION).zip \
									laird-lwb-firmware-mfg-$(FIRMWARE_BINARIES_VERSION).tar.bz2 \
									laird-lwb5-firmware-mfg-$(FIRMWARE_BINARIES_VERSION).tar.bz2
FIRMWARE_BINARIES_LICENSE = GPL-2.0
FIRMWARE_BINARIES_LICENSE_FILES = COPYING
FIRMWARE_BINARIES_SITE = http://devops.lairdtech.com/share/builds/linux/firmware/$(FIRMWARE_BINARIES_VERSION)


define FIRMWARE_BINARIES_EXTRACT_CMDS

endef

define FIRMWARE_BINARIES_CONFIGURE_CMDS

endef

define install-firmware-func
	rm $(@D)/lib -fr;
	cd $(@D) && unzip -u $(BR2_DL_DIR)/$(1)-$(FIRMWARE_BINARIES_VERSION).zip  -d . ;
	cd $(@D) && tar -xjf $(1).tar.bz2;
	cp $(@D)/lib/firmware/* $(TARGET_DIR)/lib/firmware/ -dprf;
endef


define FIRMWARE_BINARIES_480_0079_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB-FCC))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0079),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0079_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0080_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB-ETSI))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0080),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0080_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0081_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB5-FCC))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0081),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0081_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0082_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB5-ETSI))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0082),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0082_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0094_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB5-IC))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0094),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0094_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0095_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB5-JP))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0095),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0095_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0116_INSTALL_TARGET
	$(call install-firmware-func,$(STERLING-LWB-JP))
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0116),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0116_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0108_INSTALL_TARGET
	rm $(@D)/lib -fr;
	cd $(@D) && unzip -u $(BR2_DL_DIR)/$(LWB-MFG)-$(FIRMWARE_BINARIES_VERSION).zip -d .;
	cd $(@D) && tar -xjf laird-lwb-firmware-mfg-$(FIRMWARE_BINARIES_VERSION).tar.bz2;
	cp $(@D)/lib/firmware/* $(TARGET_DIR)/lib/firmware/ -dprf;
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0108),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0108_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_480_0109_INSTALL_TARGET
	rm $(@D)/lib -fr;
	cd $(@D) && unzip -u $(BR2_DL_DIR)/$(LWB5-MFG)-$(FIRMWARE_BINARIES_VERSION).zip -d .;
	cd $(@D) && tar -xjf laird-lwb5-firmware-mfg-$(FIRMWARE_BINARIES_VERSION).tar.bz2;
	cp $(@D)/lib/firmware/* $(TARGET_DIR)/lib/firmware/ -dprf;
endef
ifeq ($(BR2_FIRMWARE_BINARIES_480_0109),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_480_0109_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_930_0081_INSTALL_TARGET
	rm $(@D)/wl_fmac -fr
	cd $(@D) && unzip -u $(BR2_DL_DIR)/$(WL-FMAC)-$(FIRMWARE_BINARIES_VERSION).zip -d .;
	cp $(@D)/wl_fmac $(TARGET_DIR)/usr/bin/ -f;
endef
ifeq ($(BR2_FIRMWARE_BINARIES_930_0081),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_930_0081_INSTALL_TARGET
endif

define FIRMWARE_BINARIES_STERLING_60_INSTALL_TARGET
	rm $(@D)/lib/ -fr;
	tar -xjf $(BR2_DL_DIR)/$(LRD-MWL)-$(FIRMWARE_BINARIES_VERSION).tar.bz2 -C $(@D);
	cp $(@D)/lib/firmware/* $(TARGET_DIR)/lib/firmware/ -dprf;
endef
ifeq ($(BR2_FIRMWARE_BINARIES_STERLING_60),y)
	FIRMWARE_BINARIES_POST_INSTALL_TARGET_HOOKS += FIRMWARE_BINARIES_STERLING_60_INSTALL_TARGET
endif

FIRMWARE_BINARIES_DEPENDENCIES += linux

$(eval $(generic-package))
