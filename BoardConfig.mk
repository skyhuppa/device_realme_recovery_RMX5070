#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/RMX5070

# Assembly system flags (BUILD_BROKEN_, ALLOW_)

# This flag disables the "overriding commands for target", error that occurs.
# Essentially allows the build system to ignore duplicate rules.
# As examples show, it is installed to bypass the "overriding commands for target" error.
BUILD_BROKEN_DUP_RULES := true

# Allows the use of pre-compiled ELF libraries/modules in the PRODUCT_COPY_FILES variable.
# By default, the build prohibits placing ELF files in system/lib etc., and requires declaring them as modules.
# Setting this flag removes the restriction (temporarily "relaxes the check"), as described in the AOSP documentation.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Relaxes the checks on mandatory modules.
# Typically, modules listed in LOCAL_REQUIRED_MODULES and similar variables must exist, otherwise the build will throw an error.
# When this flag is set, the build simply issues a warning and continues ("temporarily relaxes the check for missing modules"
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# Allows for the absence of dependencies.
# Removes the requirement for modules mentioned in LOCAL_REQUIRED_MODULES etc.,
# Similarly BUILD_BROKEN_MISSING_REQUIRED_MODULES. 
# Typically needed if some dependencies ("libraries") are missing, but you want to continue building
ALLOW_MISSING_DEPENDENCIES := true

# (In CORE/board_config.mk) Allows the use of network functions in "broken" modules (time counting can be a hint).
# Set to skip network function build errors early in the build.
BUILD_BROKEN_USES_NETWORK := true


# Architecture and platform parameters

# Specify the primary target architecture and its subvariant. Here, it's ARM64 (AArch64) with additional support for v8.2-A.
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a

# specify a specific CPU model for kernel and runtime compilation.
# Used for optimizations, such as kryo300 when compiling
TARGET_CPU_VARIANT := kryo300
TARGET_CPU_VARIANT_RUNTIME := kryo300

# The main ABI (application binary interface) is 64-bit ARMv8 (arm64-v8a).
# TARGET_CPU_ABI2 := (empty) – second ABI, if needed (on 32-bit devices).
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=

# Define the "secondary" (2nd) architecture. The Pixel 8 has a CPU with different cores (for example, Cortex-A75 and A55), and this block specifies
# 32-bit ARM architecture for 32-bit (arm32) binaries under Cortex-A75.
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_ARCH := arm
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# Tell the system that the device is 64-bit and supports 64-bit applications.
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_IS_64_BIT := true

# Enables the use of the logd daemon (replacing the logcat utility). This is standard for modern builds.
TARGET_USES_LOGD := true

# Specify the platform/SoC code. For example, PRODUCT_PLATFORM := volcano (codename for Realme P3 5G).
# TARGET_BOARD_PLATFORM := $(REALME_BOARD_PLATFORMS) – in your config, it uses a list of Google platforms, where “volcano” is added.
# TARGET_BOARD_PLATFORM_GPU := Adreno 810 – a deprecated parameter that specifies the name of the GPU platform (here Adreno 810).
# It is not used in newer versions of AOSP (it was mentioned for graphics on older devices)
PRODUCT_PLATFORM := volcano
TARGET_BOARD_PLATFORM := $(REALME_BOARD_PLATFORMS)

# bootloader board name, added to android-info.txt.
# If there is no board-info.txt file of its own, the builder inserts the line board=<TARGET_BOOTLOADER_BOARD_NAME>
TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)

# The board-info.txt file used when checking OTA compatibility.
ARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Tells you not to compile or install the bootloader into the final image.
# If you do not want to include bootloader files, set this flag.
TARGET_NO_BOOTLOADER := true
QCOM_BOARD_PLATFORMS := $(PRODUCT_PLATFORM)
BOARD_USES_QCOM_HARDWARE := true

# indicates that the device boots using UEFI (there is no traditional ARM boot.img).
# Some devices does use UEFI boot, so this flag is set in the config.
TARGET_USES_UEFI := true

# Update flags (A/B OTA)
  # Enables support for A/B (seamless) updates in the rescript.
  # Indicates that the device stores two copies of the OS (slot A/B) and updates them without lengthy reflashing.
AB_OTA_UPDATER := true

# Your config lists all the device sections (boot, init_boot, vendor_boot, dtbo, vbmeta, etc.).
# This is similar to Google's example for the Pixel 3 (Crosshatch).
# Each line AB_OTA_PARTITIONS += X adds partition X to the "A/B OTA" list, meaning it will be processed when creating an OTA package.
# Similar syntax is also given in blogs/documentation on A/B updates,
# Where AB_OTA_UPDATER := true means "use A/B updates" and AB_OTA_PARTITIONS lists the partitions involved
# (in the example – boot, system, vendor, etc.).
AB_OTA_PARTITIONS += boot
AB_OTA_PARTITIONS += init_boot
AB_OTA_PARTITIONS += vendor_boot
AB_OTA_PARTITIONS += dtbo
AB_OTA_PARTITIONS += vbmeta
AB_OTA_PARTITIONS += vbmeta_system
AB_OTA_PARTITIONS += vbmeta_vendor
AB_OTA_PARTITIONS += product
AB_OTA_PARTITIONS += system
AB_OTA_PARTITIONS += system_ext
AB_OTA_PARTITIONS += system_dlkm
AB_OTA_PARTITIONS += vendor
AB_OTA_PARTITIONS += vendor_dlkm
AB_OTA_PARTITIONS += modem
AB_OTA_PARTITIONS += vendor_kernel_boot
AB_OTA_PARTITIONS += tzsw
AB_OTA_PARTITIONS += idfw
AB_OTA_PARTITIONS += abl
AB_OTA_PARTITIONS += pvmfw
AB_OTA_PARTITIONS += bl2
AB_OTA_PARTITIONS += gsa
AB_OTA_PARTITIONS += bl31
AB_OTA_PARTITIONS += pbl
AB_OTA_PARTITIONS += gsa_bl1
AB_OTA_PARTITIONS += bl1
AB_OTA_PARTITIONS += gcf

# (OrangeFox) disables the "Snapshot" mode, which takes a snapshot of the partition for the restore function (in your case, it is disabled).
BOARD_USE_DYNAMIC_PARTITIONS  := true
BOARD_RECOVERY_SNAPSHOT := false

# These flags are related to dynamic partitions (super img) and Android's Generic System Image (GSI).
# The Pixel 8 has a dynamic super partition, divided into system, vendor, and others.
# The BOARD_SUPER_PARTITION_SIZE, BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE/partition_list parameters define the size and composition of this "super.img"
# (approximately 8.53 GB). If DEVICE does not use dynamics, these flags are not needed.
BOARD_SUPER_PARTITION_SIZE := 13321109504
BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
BOARD_REALME_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm product
BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 13316915200

# Specify the architecture for building the kernel and installing kernel headers.
# By default, TARGET_KERNEL_HEADER_ARCH copies the value from TARGET_KERNEL_ARCH. Your Pixel 8 is 64-bit (arm64).
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Enables kernel compilation using Clang (Android requires Clang).
# Without this flag, the kernel can be built by GCC by default.
# Setting true ensures the use of Clang. Usage example: kernel compilation guides recommend adding
# TARGET_KERNEL_CLANG_COMPILE := true

# Parameters for the mkbootimg utility that specify pages, offsets, and other settings. These include the 2048-byte kernel page size,
# header version 4, and specific addresses (0x1000000, etc.) that meet the Pixel bootloader requirements.
# These settings are passed to the mkbootimg command via BOARD_MKBOOTIMG_ARGS.
# Their accuracy is critical for booting, but in general, they are left from the original BoardConfig for the device.
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)

# (commented out) - alternative parameters specifying the kernel file name and DTB offset, but you do not use them.
# BOARD_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.lz4
# TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.lz4
BOARD_KERNEL_IMAGE_NAME := Image.lz4
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
# BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbs/dtbo.img
# TARGET_NO_KERNEL_OVERRIDE := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
# BOARD_DTB_OFFSET         := 0x01f00000

# File systems and images
 # forces the build to generate partition image(s) (system.img, vendor.img, etc.) in ext4 format, rather than the legacy YAFFS2/F2FS format by default.
 # As noted by the AOSP developers, the choice of file system for images is determined by these flags (EXT2/3/4)
TARGET_USERIMAGES_USE_EXT4 := true

# adds support for creating F2FS images. Typically, this specifies which partitions should be F2FS.
# Your config then includes BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs, which specifies that the userdata partition should be F2FS,
# and the rest (by default) should be ext4. A build change (2014 commit) showed that when both the ext4 and f2fs flags are set,
# depending on the settings, the build will choose F2FS for the userdata (and ext4 for the rest).
TARGET_USERIMAGES_USE_F2FS := true

# specifies that the contents of vendor/ (images, modules, etc.) should be copied to a separate file vendor.img (a separate partition).
# By default, AOSP uses system/vendor (embeds vendor inside system.img).
# The presence of TARGET_COPY_OUT_VENDOR := vendor forces the build to create a separate vendor.img.
# The official envsetup.mk file specifies: if the variable remains a placeholder after reading BoardConfig, then system/vendor is used;
# if "vendor" is explicitly specified, then a separate image is created. Otherwise, an error will occur.
TARGET_COPY_OUT_VENDOR := vendor

# specify the file systems of the created images: system – ext4, vendor – ext4, userdata – f2fs.
# For dynamic partitions (super), these flags affect internal images when creating system.img, etc. For example,
# Device defaults to ext4 for system/vendor and f2fs for data.
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 201326592

# Flash memory (UFS) block size in bytes. Used for image formatting/alignment.
BOARD_FLASH_BLOCK_SIZE := 262144 # 131072

# Partitions and recovery
  # specifies the pixel format for the recovery interface.
  # The value ABGR_8888 means 32-bit color (Alpha-Blue-Green-Red).
  # Older recovery builds read this flag at compile time and included the corresponding -DRECOVERY_ABGR.
  # In newer AOSP builds, this flag is ignored (the format is set via the ro.recovery.ui.pixel_format property).
  # However, OrangeFox/TWRP can still use it to build the required video driver.
# TARGET_RECOVERY_PIXEL_FORMAT := RGB_565 Nont booted
# TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888 Uses, But orange its Blues, cute
# TARGET_RECOVERY_PIXEL_FORMAT := ARGB_8888 Not useles, black screen
# TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888 Not useles black screen
# TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888 Not useles EXTRAAA GREEEN
# TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888" Not useles EXTRAAA ORANGE
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# path to the fstab file describing the partition table for recovery.
# This file contains a list of mount points (/cache, /data, /system, etc.) and devices.
# The AOSP documentation states that the partition map filename is specified via TARGET_RECOVERY_FSTAB,
# and it is used by both the recovery binary itself and the OTA build tools.
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab

# путь к файлу с перечнем разделов для очистки. Это специфично для TWRP/OrangeFox: 
# файл recovery.wipe содержит список разделов, которые нужно обнулять при штатной очистке (wipe data/factory reset). 
# Пример использования такого флага можно видеть в конфиге OrangeFox для Pixel 7a
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe

# путь в sysfs к яркости дисплея и максимальное/дефолтное значения яркости. Эти переменные нужны TWRP для управления экраном. 
# У Pixel 8 устанавливаются актуальные значения (максимум 3827) для правильной работы ползунка яркости.
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness" # "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 3827
TW_DEFAULT_BRIGHTNESS := 219

# OrangeFox/TWRP UI settings: theme, default language, allow additional languages.
TW_THEME := portrait_hdpi
TW_DEFAULT_LANGUAGE := en
TW_EXTRA_LANGUAGES := true

# disables the standard TWRP USB init scripts to use your own or the device's system
TW_EXCLUDE_DEFAULT_USB_INIT := True

# Enables support for additional utilities in the OrangeFox build: logcat viewing in recovery,
# firmware repackaging tools, the resetprop utility, FastbootD support, etc.
# This adds functionality for debugging and updating.
TWRP_INCLUDE_LOGCAT := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_FASTBOOTD := true

# Disables the use of drivers for some touchscreens (most likely "HeatBeam Touch Panel").
# Sometimes you need to exclude non-standard input devices that are causing problems.
TW_INPUT_BLACKLIST := "hbtp_vm"

# List of kernel module files that should be loaded by the recovery. These include .ko files for sensor drivers (heatmap, goodix, etc.).
# Without these, the sensor may not work in OrangeFox, so they are explicitly loaded
# TW_LOAD_VENDOR_MODULES := "heatmap.ko touch_offload.ko ftm5.ko sec_touch.ko goodix_brl_touch.ko goog_touch_interface.ko"
# TW_LOAD_VENDOR_DLKM_MODULES := "heatmap.ko touch_offload.ko ftm5.ko sec_touch.ko goodix_brl_touch.ko goog_touch_interface.ko"

# Enable support for NTFS (via ntfs-3g) and exFAT (via FUSE) file systems in recovery,
# to enable working with memory cards of these formats
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true

# include various utilities (toolbox instead of ashutils, Python scripts, lightweight tools for dumpstate, etc.) in the recovery build.
TW_USE_TOOLBOX := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_PYTHON := true

# disables automatic screen dimming in recovery (to prevent the screen from going dark when idle).
BOARD_VINTF_CHECK := false
TW_NO_SCREEN_BLANK := true

# Enables logging of events (sensor, buttons, touch gesture) for debugging.
# TWRP_EVENT_LOGGING := true

# specifies the screen refresh rate (120 Hz) for correct rendering of the interface.
TW_FRAMERATE := 120

# use Samsung's vibration feedback algorithms (usually doesn't affect Pixels much, but some builds do).
# TW_USE_SAMSUNG_HAPTICS := true

# Other parameters
  # Set additional kernel command-line parameters (bootconfig).
  # Various debugging and hardware parameters (e.g., androidboot.boot_devices=13200000.ufs, swiotlb, etc.) are specified here.
  # These are specific to the Exynos platform but added to OrangeFox.

VENDOR_CMDLINE := video=vfb:640x400,bpp=32,memsize=3072000 \
                  log_buf_len=2M \
                  nosoftlockup \
                  bootconfig"

BOARD_BOOTCONFIG += androidboot.usbcontroller=11210000.dwc3
BOARD_BOOTCONFIG += androidboot.boot_devices=13200000.ufs
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

# tells the kernel not to be included in the recovery.img image (only in the boot.img).
# A/B devices typically don't have a separate recovery.img, so the kernel doesn't need to be copied to the recovery.
# BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# allows large file systems (e2fsck/dosfsck) when working with exFAT and NTFS.
BOARD_HAS_LARGE_FILESYSTEM := true

# Ignore SELinux neverallow rules when building recovery (not applicable to runtime, only for building).
# Often set to prevent build failures due to SELinux policy conflicts.
SELINUX_IGNORE_NEVERALLOWS := true

# compresses the initramfs (ramdisk) using the LZ4 algorithm (reduces size, requires LZ4 support in the bootloader).
# Pixel 8 loads the LZ4 initramfs.
BOARD_RAMDISK_USE_LZ4 := true

# configures the LUN node path for USB mass storage (used in FastbootD mode).
# For example, /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file is the path to the device file,
# if you want to mount the partition as a USB drive upon connection.
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

# device screen width and height (in pixels). Used in recovery for dialog and interface calculations.
TARGET_SCREEN_WIDTH := 1344
TARGET_SCREEN_HEIGHT := 2992

# vendor name (here realme).
BOARD_VENDOR := realme

# adds "volcano" to the list of supported realme platforms (Realme P3 5G).
GOOGLE_BOARD_PLATFORMS += volcano

# indicates that the device doesn't have a separate recovery image (i.e., recovery runs within vendor_boot or init_boot). For A/B devices, this is usually true.
TARGET_NO_RECOVERY := true

# sets the C locale (English by default) at build time to avoid unexpected locale effects on scripts.
LC_ALL := C

# additional directories in the root partition that need to be preserved during system patches/cleanups.
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist

# (TWRP) Disables "Secure Erase" of a partition if it was considered unsupported.
BOARD_SUPPRESS_SECURE_ERASE := true

# sets the OrangeFox version label (which you gave to the build).
TW_VERSION := skyhuppa

# Enables libresetprop, a library for Magisk-like system property replacement (getprop).
# TWRP can use resetprop to change build.prop values ​​without editing them directly.
TW_INCLUDE_LIBRESETPROP := true

# When using GKI (Generic Kernel Image), some kernel modules are shipped separately.
# This flag excludes GKI modules from autoloading in vendor/modules.
# This flag prevents TWRP from attempting to load GKI modules if they are already integrated.
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# TWRP will wait 6 seconds before reading battery information from sysfs to allow for initialization.
# This applies to newer devices where the battery doesn't appear immediately.
TW_BATTERY_SYSFS_WAIT_SECONDS := 6

# Includes the system.prop file in the recovery build.
# Used to add or override properties that should be applied in the recovery.
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Instructs recovery resources (themes, images, fonts, etc.) to be stored in the vendor_boot partition instead of the boot partition.
# This is especially important for devices with a boot/vendor_boot partition, starting with Android 10+.
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# Specifies that the generic kernel (GKI) is used, not a custom one.
# The builder will not look for Image.gz-dtb, but will use the GKI approach with a separate DTBO/Vendor_boot.
# BOARD_USES_GENERIC_KERNEL_IMAGE := true

# If AVB (Android Verified Boot) is used, this flag tells the system to move the GSI keys to vendor_boot,
# so that AVB works correctly on GSI firmware.
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Enables a build with AVB (Android Verified Boot v2) support.
# TWRP will be built to correctly interact with AVB (e.g., when signing, verifying keys, etc.).
BOARD_AVB_ENABLE := true

# Disables support for APEX modules (a new system component format, starting with Android 10).
# APEX modules are not needed in recovery, and disabling them reduces the size and simplifies the environment.
TW_EXCLUDE_APEX := true

# Enables scheduler boost—prioritizing task execution.
# Allows TWRP to run more responsively, especially during heavy operations.
ENABLE_SCHEDBOOST := true

# Specifies the use of mke2fs (instead of make_ext4fs) to create ext4 filesystems.
# mke2fs is a more modern and flexible tool. It is often used in newer firmware.
TARGET_USES_MKE2FS := true

# Adds the .dtb (device tree blob) to boot.img, rather than separately.
# Relevant for many devices where the bootloader requires the .dtb directly in the boot.
RECOVERY_SDCARD_ON_DATA := true
# BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Size of the dtbo partition (in bytes).
# Value 4194304 = 4MB. Required for proper assembly of dtbo.img.
# BOARD_DTBOIMG_PARTITION_SIZE := 4194304

# Enables cpusets, a mechanism for managing CPU cores (distributing processes across clusters).
# To optimize recovery performance on multi-core chips.
# ENABLE_CPUSETS := true
