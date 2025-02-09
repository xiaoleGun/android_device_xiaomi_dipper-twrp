#
# Copyright (C) 2022-2024 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# GSI
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
#

# APEX
PRODUCT_COMPRESSED_APEX := false

TW_EXCLUDE_APEX := true

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

# shipping API
PRODUCT_SHIPPING_API_LEVEL := 27

# fscrypt policy
TW_USE_FSCRYPT_POLICY := 1

# QCOM Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

# recovery configuration
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 511

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# version
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# security patch
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Libraries
TARGET_RECOVERY_DEVICE_MODULES += \
	libion \
	vendor.display.config@1.0 \
	vendor.display.config@2.0 \
	libdisplayconfig.qti

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

# for Android 11+ manifests
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# dynamic partitions?
ifeq ($(FOX_USE_DYNAMIC_PARTITIONS),1)
  PRODUCT_USE_DYNAMIC_PARTITIONS := true
  PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

TW_INCLUDE_FASTBOOTD := true
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd 

PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service

PRODUCT_PROPERTY_OVERRIDES += \
	ro.orangefox.dynamic.build=true \
	ro.fastbootd.available=true \
	ro.boot.dynamic_partitions=true \
	ro.boot.dynamic_partitions_retrofit=true
else
	PRODUCT_PROPERTY_OVERRIDES += ro.orangefox.dynamic.build=false
endif

# keymaster-4.0 build
ifeq ($(FOX_USE_KEYMASTER_4),1)
	OF_DEFAULT_KEYMASTER_VERSION := 4.0
	PRODUCT_PROPERTY_OVERRIDES += ro.fox.keymaster_version=4
else
# default keymaster=3.0
	OF_DEFAULT_KEYMASTER_VERSION := 3.0
	PRODUCT_PROPERTY_OVERRIDES += ro.fox.keymaster_version=3
endif

# copy recovery/root/ from the common directory
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root/,$(TARGET_COPY_OUT_RECOVERY)/root/)

# copy recovery/root/ from the device directory (if it exists)
ifneq ($(wildcard $(DEVICE_PATH)/recovery/root/.),)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root/,$(TARGET_COPY_OUT_RECOVERY)/root/)
endif

# Inherit from the device-specific device.mk (if it exists) as the last in the chain
$(call inherit-product-if-exists, $(DEVICE_PATH)/device.mk)

# initial prop for variant
ifneq ($(FOX_VARIANT),)
  PRODUCT_PROPERTY_OVERRIDES += \
	ro.orangefox.variant=$(FOX_VARIANT)
endif
#
