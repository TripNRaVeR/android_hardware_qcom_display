#Common headers
common_includes := hardware/qcom/display/msm8960/libgralloc
common_includes += hardware/qcom/display/msm8960/liboverlay
common_includes += hardware/qcom/display/msm8960/libcopybit
common_includes += hardware/qcom/display/msm8960/libqdutils
common_includes += hardware/qcom/display/msm8960/libhwcomposer
common_includes += hardware/qcom/display/msm8960/libexternal
common_includes += hardware/qcom/display/msm8960/libqservice

common_header_export_path := qcom/display

#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
common_flags += -Werror

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifneq ($(filter msm8974 msm8x74 msm8226 msm8x26,$(TARGET_BOARD_PLATFORM)),)
    common_flags += -DVENUS_COLOR_FORMAT
    common_flags += -DMDSS_TARGET
endif

ifeq ($(call is-vendor-board-platform,QCOM),true)
common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif

# Executed only on QCOM BSPs
ifeq ($(TARGET_USES_QCOM_BSP),true)
# Enable QCOM Display features
    common_flags += -DQCOM_BSP
endif
ifeq ($(call is-vendor-board-platform,QCOM),true)
# This check is to pick the kernel headers from the right location.
# If the macro above is defined, we make the assumption that we have the kernel
# available in the build tree.
# If the macro is not present, the headers are picked from hardware/qcom/msmXXXX
# failing which, they are picked from bionic.
    common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
    kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif
