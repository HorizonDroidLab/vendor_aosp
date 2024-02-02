# Updater
ifeq ($(filter-out OFFICIAL,$(HORIZON_BUILD_TYPE),)
    PRODUCT_PACKAGES += \
        Updates

    PRODUCT_COPY_FILES += \
        vendor/aosp/prebuilt/common/etc/init/init.horizon-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.horizon-updater.rc
endif
