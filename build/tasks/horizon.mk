#
# Copyright (C) 2024 HorizonDroid
#
# SPDX-License-Identifier: Apache-2.0
#

CL_CYN="\033[36m"
CL_PRP="\033[35m"
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

HORIZON_TARGET_PACKAGE := $(PRODUCT_OUT)/$(HORIZON_VERSION).zip

.PHONY: horizon
horizon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(HORIZON_TARGET_PACKAGE)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(HORIZON_TARGET_PACKAGE)
	$(hide) $(SHA256) $(HORIZON_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(HORIZON_TARGET_PACKAGE).sha256sum
	echo -e ${CL_BLD}${CL_CYN}"===============================-Package complete-==============================="${CL_CYN}
	echo -e ${CL_BLD}${CL_CYN}"Datetime :"${CL_PRP}" `cat $(PRODUCT_OUT)/system/build.prop | grep ro.build.date.utc | cut -d'=' -f2 | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"Size:"${CL_PRP}" `du -sh $(HORIZON_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"Filehash: "${CL_PRP}" `md5sum $(HORIZON_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"Filename: "${CL_PRP} $(HORIZON_TARGET_PACKAGE)${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"ID: "${CL_PRP}" `cat $(HORIZON_TARGET_PACKAGE).sha256sum | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"================================================================================"${CL_CYN}

.PHONY: bacon
bacon: horizon
