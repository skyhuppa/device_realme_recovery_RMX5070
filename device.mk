#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += build.variant.self=$(BUILD_VATIANT_SELF)

DEVICE_PATH := device/realme/RMX5070

PLATFORM_SECURITY_PATCH := 2099-12-31

VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 15 AP3A.240617.008 1742485963264 release-keys" \
    BuildFingerprint=realme/RMX5070IN/RE608EL1:15/UKQ1.231108.001/V.R4T2.1d151b6-1-755d:user/release-keys \
    DeviceProduct=realme

PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Purpose: PRODUCT_SHIPPING_API_LEVEL: Specifies the Android API level (34 = Android 14) with which the device was released.
# PRODUCT_TARGET_VNDK_VERSION / TARGET_VNDK_VERSION: Specifies the Vendor Native Development Kit (VNDK) version used for vendor module compatibility.
# Required: Required for compatibility with Android 14 and VINTF.
# Note: For the Realme P3 5G, these values ​​are correct, as the device runs Android 14.
PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_TARGET_VNDK_VERSION := 34
TARGET_VNDK_VERSION := 34

# Purpose: Enables support for dynamic partitions, which are used in modern Android devices like the Realme P3 5G, for flexible partition management (system, vendor, product).
# Required: Mandatory for devices with A/B partitions and dynamic superpartitions, like the Realme P3 5G.
# Note: Without this flag, the recovery will not be able to correctly work with partitions like system or vendor.
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Required for firstage ---------------------------------#
PRODUCT_PACKAGES += linker.vendor_ramdisk                #
PRODUCT_PACKAGES += linker_hwasan64.vendor_ramdisk       #
PRODUCT_PACKAGES += resize2fs.vendor_ramdisk             #
PRODUCT_PACKAGES += resize.f2fs.vendor_ramdisk           #
PRODUCT_PACKAGES += dump.f2fs.vendor_ramdisk             #
PRODUCT_PACKAGES += defrag.f2fs.vendor_ramdisk           #
PRODUCT_PACKAGES += fsck.vendor_ramdisk                  #
PRODUCT_PACKAGES += tune2fs.vendor_ramdisk               #
PRODUCT_PACKAGES += fstab.volcano.vendor_ramdisk         #
PRODUCT_PACKAGES += fstab.volcano-fips.vendor_ramdisk    #
PRODUCT_PACKAGES += e2fsck.vendor_ramdisk                #
# Required for firstage ---------------------------------#

# Purpose: update_engine_sideload: Binary for applying OTA updates via sideload in recovery (e.g., via adb sideload).
# update_engine: The main binary for processing OTA updates, including A/B updates.
# update_verifier: Utility for verifying the integrity and signature of OTA updates.
# Required: update_engine_sideload — critical for recovery to support OTA installation via sideload.
# Optional: update_engine and update_verifier — may be redundant for recovery, as they are more needed for system builds. Recovery typically only uses update_engine_sideload.
PRODUCT_PACKAGES += update_engine
PRODUCT_PACKAGES += update_engine_sideload
PRODUCT_PACKAGES += update_verifier

# ✅ Required for bootcontrol to function correctly and for slot switching. The library from the Pixel source code.
# recovery/root/system/bin/hw/android.hardware.boot@1.2-service-pixel / android.hardware.boot@1.2-service-pixel
# recovery/root/system/etc/init/android.hardware.boot@1.2-service-pixel.rc / android.hardware.boot@1.2-service-pixel
# recovery/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.2-impl-pixel.so / android.hardware.boot@1.2-impl-pixel
PRODUCT_PACKAGES += android.hardware.boot@1.2-service-pixel
PRODUCT_PACKAGES += android.hardware.boot@1.2-impl-pixel

# Purpose: Enables fastbootd mode in recovery, which allows you to execute fastboot commands (such as fastboot flash) directly from recovery, rather than from the bootloader.
# Necessity: Useful for recovery, especially for dynamic partitions. Recommended to leave enabled.
# Note: The Realme P3 5G does not support fastboot booting from recovery, so fastbootd is essential for flashing and debugging.
PRODUCT_PACKAGES += fastbootd

# Purpose: libion: A library for working with ION (Android Ion Memory Allocator), used to manage graphics buffer memory.
# Necessity: Optional. May be required for the display or recovery GUI to function correctly. Requires testing.
# Note: You indicated that this needs to be tested. Check if the recovery interface works without this library.
TARGET_RECOVERY_DEVICE_MODULES += libion
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libion.so

# Purpose: Enables support for the metadata partition for storing encryption information and other metadata required for dynamic partitions.
# Required: Required for the Pixel 8, as it uses encryption and dynamic partitions.
# Note: Leave this flag enabled to ensure proper operation with encryption (or when disabling it via DFE-NEO).
BOARD_USES_METADATA_PARTITION := true

# Purpose: A library for working with Trusty TEE (Trusted Execution Environment), used for secure operations such as accessing encryption keys.
# Necessity: Useful for recovery if you support data decryption. You have confirmed that it is present in recovery/root/system/lib64.
PRODUCT_PACKAGES += libtrusty

# Purpose: Service for managing VINTF (Vendor Interface) services in vendor_ramdisk.
# Required: Required for VINTF-enabled devices, such as the Realme P3 5G.
PRODUCT_PACKAGES += vndservicemanager

# Purpose: Binary for interacting with vendor services, required for HAL operation.
# Necessity: Required for the correct operation of vendor components.
PRODUCT_PACKAGES += vndservice

# Purpose: Library for transporting HIDL messages between processes in vendor_ramdisk.
# Required: Mandatory for devices with HIDL interfaces.
PRODUCT_PACKAGES += libhidltransport.vendor

# Purpose: DEVICE_MANIFEST_FILE: Specifies the path to the VINTF manifest file, which describes the device's HAL interfaces.
# PRODUCT_ENFORCE_VINTF_MANIFEST: Enables VINTF manifest validation to ensure vendor component compatibility.
# Required: Mandatory for VINTF-enabled devices, such as the Pixel 8.
# Note: Ensure that manifest.xml exists in the specified path and contains the correct HAL descriptions.
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/system/etc/vinit/manifest.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Purpose: A/B slot management utility, allows you to switch the active slot and check their status.
# Necessity: Required for A/B devices, such as the Pixel 8.
PRODUCT_PACKAGES += bootctl

# Purpose: A utility for reading system logs, useful for debugging in recovery.
# Necessity: Useful, but optional. Can be removed if debugging is not required.
PRODUCT_PACKAGES += logcat

# Purpose: A daemon for managing logs in Android.
# Necessity: Optional for recovery, as logging is usually minimal.
PRODUCT_PACKAGES += logd 

# Purpose: Utility for managing SELinux auditing.
# Necessity: Optional. Can be useful for debugging SELinux, but rarely needed in recovery.
PRODUCT_PACKAGES += auditctl

# Purpose: A library for working with POSIX capabilities, used to manage process privileges.
# Necessity: Useful for recovery, especially for SELinux or access control.
PRODUCT_PACKAGES += libcap

# Purpose: Enables Virtual A/B support, which allows for OTA updates without allocating separate space for a second set of partitions.
# Necessity: Required for the Pixel 8, as it uses Virtual A/B for OTA.
# Note: Leave this flag enabled, as it is essential for working with A/B partitions.
# Test ❓
ENABLE_VIRTUAL_AB := true

# PRODUCT_COPY_FILES += \
#     $(DEVICE_PATH)/fox_mod_ui/advanced.xml:recovery/root/twres/pages/advanced.xml \
#     $(DEVICE_PATH)/fox_mod_ui/install.xml:recovery/root/twres/pages/install.xml

# TARGET_RECOVERY_DEVICE_MODULES += vendor.display.config@1.0 
# TARGET_RECOVERY_DEVICE_MODULES += vendor.display.config@2.0

# PRODUCT_PACKAGES += libdisplaycolor # ❓NOT in the package and in the pb files, test
# Most likely the graphics driver, but not for sure ❓
# # recovery/root/system/lib64/vendor.display.config@1.0.so
# # recovery/root/system/lib64/vendor.display.config@2.0.so

# RECOVERY_LIBRARY_SOURCE_FILES += \
#     $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
#     $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so 

# I believe it is not necessary❓
# PRODUCT_PACKAGES += android.hardware.health-service.volcano_recovery

# Not in pb files, and not in the assembly ❓
# PRODUCT_PACKAGES += checkpoint_gc
# Not in pb files, and not in the assembly ❓ It's also not clear why
# PRODUCT_PACKAGES += cppreopts.sh

# RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcap
# RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/auditctl
# RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bootctl
# RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/logcat
# RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/logd

# PRODUCT_COPY_FILES += \
#    $(OUT_DIR)/target/product/RMX5070/prebuilt/modules:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules \
#    $(OUT_DIR)/target/product/RMX5070/prebuilt/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
