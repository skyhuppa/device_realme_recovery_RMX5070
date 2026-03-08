#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit device configuration

# Release name
PRODUCT_RELEASE_NAME := RMX5070

DEVICE_PATH := device/realme/$(PRODUCT_RELEASE_NAME)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from device
$(call inherit-product, device/realme/$(PRODUCT_RELEASE_NAME)/device.mk)

$(call inherit-product, $(DEVICE_PATH)/device.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)



# Assert
# TARGET_OTA_ASSERT_DEVICE := $(PRODUCT_RELEASE_NAME)

# PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/realme/$(PRODUCT_RELEASE_NAME)/recovery/root,recovery/root)

# PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root) \
# 	 $(LOCAL_PATH)/prebuilt/dtb:dtb.img

PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := omni_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := realme
PRODUCT_MODEL := realme P3
PRODUCT_MANUFACTURER := realme
