LLAGENT_VERSION = local
LLAGENT_SITE = package/lrd-closed-source/externals/llagent
LLAGENT_SITE_METHOD = local

LLAGENT_DEPENDENCIES = libnl sdcsdk
LLAGENT_MAKE_ENV = CC="$(TARGET_CC)" \
				   CXX="$(TARGET_CXX)" \
				   ARCH="$(KERNEL_ARCH)" \
				   CFLAGS="$(TARGET_CFLAGS)"

define LLAGENT_BUILD_CMDS
	$(MAKE) -C $(@D) clean
		$(LLAGENT_MAKE_ENV) $(MAKE) -C $(@D) LL_PLATFORM=wb
		$(LLAGENT_MAKE_ENV) $(MAKE) -C $(@D) integration-test LL_PLATFORM=wb
endef

define LLAGENT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/src/agent/llagent $(TARGET_DIR)/usr/bin/llagent
	$(INSTALL) -D -m 755 $(@D)/scripts/init.d/S99agent $(TARGET_DIR)/etc/init.d/opt/S99agent
	mkdir -p $(TARGET_DIR)/usr/bin/integration-tests/
	$(INSTALL) -D -m 755 $(@D)/src/platform/laird-sdk/test_radio $(TARGET_DIR)/usr/bin/integration-tests/
	$(INSTALL) -D -m 755 $(@D)/src/platform/wb/test_certman $(TARGET_DIR)/usr/bin/integration-tests/
endef

define LLAGENT_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/llagent
	rm -f $(TARGET_DIR)/etc/init.d/opt/S99agent
endef

$(eval $(generic-package))
