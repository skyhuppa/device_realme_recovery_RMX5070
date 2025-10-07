#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_RELEASE_NAME := RMX5070

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_RMX5070.mk

COMMON_LUNCH_CHOICES := \
  twrp_$(PRODUCT_RELEASE_NAME)-user \
  twrp_$(PRODUCT_RELEASE_NAME)-userdebug \
  twrp_$(PRODUCT_RELEASE_NAME)-eng
