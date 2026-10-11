# API Level
BOARD_SHIPPING_API_LEVEL := 202504
PRODUCT_SHIPPING_API_LEVEL := 36
PRODUCT_TARGET_VNDK_VERSION := 36

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    dtbo \
    boot \
    vendor_dlkm \
    init_boot \
    system \
    product \
    system_ext \
    vbmeta \
    system_dlkm \
    vendor \
    vbmeta_system \
    odm \
    vendor_boot

# Boot control
# PRODUCT_PACKAGES += \
#    android.hardware.boot@1.2-impl-qti.recovery \
#    bootctrl.volcano.recovery

# TARGET_RECOVERY_DEVICE_MODULES += \
#    libion \
#    libandroidicu

# RECOVERY_LIBRARY_SOURCE_FILES += \
#    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
#    $(TARGET_OUT_SHARED_LIBRARIES)/libandroidicu.so

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Build
PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false

# Enable Fuse Passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/releasekey

# Required modules
TWRP_REQUIRED_MODULES += \
    prebuilt

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# PRODUCT_COPY_FILES += \
#    $(OUT_DIR)/target/product/RMX5070/prebuilt/modules:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules \
#    $(OUT_DIR)/target/product/RMX5070/prebuilt/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
