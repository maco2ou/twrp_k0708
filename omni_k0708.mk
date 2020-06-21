#
# Copyright (C) 2018 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, vendor/MediaTek/k0708/k0708-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/MediaTek/k0708/overlay

LOCAL_PATH := device/MediaTek/k0708
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Get the prebuilt list of APNs
$(call inherit-product, vendor/omni/config/gsm.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Otherwise, If you have 32-bit device, add the below line instead of above line
##$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk

# Another common config inclusion
#$(call inherit-product, $(SRC_TARGET_DIR)/product/embedded.mk)


# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

PRODUCT_PACKAGES += \
    charger_res_images \
    charger

PRODUCT_COPY_FILES += \
    device/MediaTek/k0708/recovery/root/etc/recovery.fstab:recovery/root/recovery.fstab


$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
PRODUCT_DEVICE := k0708
PRODUCT_NAME := omni_k0708
PRODUCT_BRAND := MediaTek
PRODUCT_MODEL := K0708
PRODUCT_MANUFACTURER := MediaTek

ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0 \
ro.allow.mock.location=1 \
persist.mtk.aee.aed=on \
ro.debuggable=1 \
persist.service.acm.enable=0 \
persist.sys.usb.config=mass_storage \
ro.bootloader.mode=download \
ro.mount.fs=EXT4 \
ro.persist.partition.support=no \
ro.board.platform=mt6582

PRODUCT_COPY_FILES_OVERRIDES += \
    device/generic/goldfish/fstab.goldfish \
    device/generic/goldfish/init.goldfish.rc \
    device/generic/goldfish/ueventd.goldfish.rc \
    device/generic/goldfish/fstab.goldfish

# Ramdisk
PRODUCT_COPY_FILES += \
#$(LOCAL_PATH)/recovery/root/etc/recovery.fstab:root/etc/recovery.fstab \
$(LOCAL_PATH)/recovery/root/factory_init.project.rc:root/factory_init.project.rc \
$(LOCAL_PATH)/recovery/root/factory_init.rc:root/factory_init.rc \
$(LOCAL_PATH)/recovery/root/init.recovery.mt6582.rc:root/init.recovery.mt6582.rc \
$(LOCAL_PATH)/recovery/root/meta_init.modem.rc:root/meta_init.modem.rc \
$(LOCAL_PATH)/recovery/root/meta_init.project.rc:root/meta_init.project.rc \
$(LOCAL_PATH)/recovery/root/meta_init.rc:root/meta_init.rc \
$(LOCAL_PATH)/recovery/root/ueventd.mt6582.rc:root/ueventd.mt6582.rc \
$(LOCAL_PATH)/recovery/root/fstab.mt6582:root/fstab.mt6582
#$(LOCAL_PATH)/recovery/root/sbin/permissive.sh:root/sbin/permissive.sh

#SELinux
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/file_contexts:root/file_contexts \
    $(LOCAL_PATH)/recovery/root/seapp_contexts:root/seapp_contexts \
    $(LOCAL_PATH)/recovery/root/property_contexts:root/property_contexts

#twrp
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab
