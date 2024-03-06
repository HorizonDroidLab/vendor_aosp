#
# Copyright (C) 2024 HorizonDroid
#
# SPDX-License-Identifier: Apache-2.0
#

include vendor/horizon/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include hardware/qcom-caf/common/BoardConfigQcom.mk
endif

include vendor/horizon/config/BoardConfigSoong.mk
