LOCAL_PATH := vendor/google/ion
LOCAL_PATH_PRODUCT := vendor/google/ion/product

ifeq ($(TARGET_GAPPS_ARCH),)
$(error "GAPPS: TARGET_GAPPS_ARCH is undefined")
endif

ifneq ($(TARGET_GAPPS_ARCH),arm64)
$(error "GAPPS: Only arm64 is allowed")
endif

# app
PRODUCT_PACKAGES += \
    CalculatorGooglePrebuilt \
    CalendarGooglePrebuilt \
    Chrome \
    Drive \
    GoogleContactsSyncAdapter \
    GoogleExtShared \
    GoogleTTS \
    LatinIMEGooglePrebuilt \
    LocationHistoryPrebuilt \
    Longshot \
    Maps \
    MarkupGoogle \
    Photos \
    PixelThemes \
    PrebuiltBugle \
    PrebuiltDeskClockGoogle \
    PrebuiltGmail \
    SoundPickerPrebuilt \
    talkback \
    WallpapersBReel2019 \
    WallpapersUsTwo \
    WebViewGoogle

# Bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation-dark_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation-dark_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
     PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation-dark_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
else
    ifeq ($(TARGET_BOOT_ANIMATION_RES),)
        $(warning "TARGET_BOOT_ANIMATION_RES is undefined, assuming 1080p")
    else
        $(warning "Current bootanimation res is not supported, forcing 1080p")
    endif
    PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
    PRODUCT_COPY_FILES += $(LOCAL_PATH_PRODUCT)/media/bootanimation-dark_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
endif

# files
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/etc,$(TARGET_COPY_OUT_SYSTEM)/etc)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH_PRODUCT)/etc,$(TARGET_COPY_OUT_PRODUCT)/etc)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH_PRODUCT)/media/audio,$(TARGET_COPY_OUT_PRODUCT)/media/audio)

# fonts config
$(call inherit-product, $(LOCAL_PATH_PRODUCT)/fonts/fonts.mk)

# framework
PRODUCT_PACKAGES += \
    com.google.android.dialer.support \
    com.google.android.maps

# include package overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay/common/

# libs
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH_PRODUCT)/lib,$(TARGET_COPY_OUT_PRODUCT)/lib)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH_PRODUCT)/lib64,$(TARGET_COPY_OUT_PRODUCT)/lib64)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH_PRODUCT)/usr,$(TARGET_COPY_OUT_PRODUCT)/usr)

# offline charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# priv-app
PRODUCT_PACKAGES += \
    AndroidMigratePrebuilt \
    AndroidPlatformServices \
    CarrierServices \
    ConfigUpdater \
    ConnMetrics \
    GoogleContacts \
    GoogleDialer \
    GoogleExtServicesPrebuilt \
    GoogleFeedback \
    GooglePartnerSetup \
    GoogleServicesFramework \
    MatchmakerPrebuilt \
    Phonesky \
    PixelLauncher \
    PixelSetupWizard \
    PrebuiltGmsCoreQt \
    SafetyHubPrebuilt \
    SettingsIntelligenceGooglePrebuilt \
    SetupWizardPrebuilt \
    TurboPrebuilt \
    Velvet \
    WallpaperPickerGoogleRelease \
    WellbeingPrebuilt

# props
# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.wallpapers_loc_request_suw=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# Gestures
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.theme=glif_v3_light \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=false

# Sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=The_big_adventure.ogg,The_big_adventure.ogg \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false
