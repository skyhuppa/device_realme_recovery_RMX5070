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

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti.recovery \
    bootctrl.volcano.recovery

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier \

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 15 AP3A.240617.008 1742485963264 release-keys" \
    BuildFingerprint=realme/RMX5070IN/RE608EL1:15/UKQ1.231108.001/V.R4T2.1d151b6-1-755d:user/release-keys
    DeviceProduct=volcano

# PRODUCT_COPY_FILES += \
#    $(call find-copy-subdir-files,*,device/realme/RMX5070/prebuilt/modules,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
#    $(LOCAL_PATH)/prebuilt/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
