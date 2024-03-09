#
# Copyright (C) 2024 HorizonDroid
#
# SPDX-License-Identifier: Apache-2.0
#

HORIZON_DATE_YEAR := $(shell date -u +%Y)
HORIZON_DATE_MONTH := $(shell date -u +%m)
HORIZON_DATE_DAY := $(shell date -u +%d)
HORIZON_DATE_HOUR := $(shell date -u +%H)
HORIZON_DATE_MINUTE := $(shell date -u +%M)
HORIZON_BUILD_DATE_UTC := $(shell date -d '$(HORIZON_DATE_YEAR)-$(HORIZON_DATE_MONTH)-$(HORIZON_DATE_DAY) $(HORIZON_DATE_HOUR):$(HORIZON_DATE_MINUTE) UTC' +%s)
HORIZON_BUILD_DATE := $(HORIZON_DATE_YEAR)$(HORIZON_DATE_MONTH)$(HORIZON_DATE_DAY)-$(HORIZON_DATE_HOUR)$(HORIZON_DATE_MINUTE)

HORIZON_PLATFORM_VERSION := 14.0
HORIZON_CODENAME := Lynx
HORIZON_BUILD_VERSION := v2.3

MAINTAINER_LIST = $(shell cat horizon-maintainers/maintainers.list)
DEVICE_LIST = $(shell cat horizon-maintainers/devices.list)

ifeq ($(filter $(HORIZON_BUILD), $(DEVICE_LIST)), $(HORIZON_BUILD))
   ifeq ($(filter $(HORIZON_MAINTAINER), $(MAINTAINER_LIST)), $(HORIZON_MAINTAINER))
      HORIZON_BUILD_TYPE := OFFICIAL
  else
     # the builder is overriding official flag on purpose
     ifeq ($(HORIZON_BUILD_TYPE), OFFICIAL)
       $(error **********************************************************)
       $(error *     A violation has been detected, aborting build      *)
       $(error **********************************************************)
       HORIZON_BUILD_TYPE := COMMUNITY
     else
       $(warning **********************************************************************)
       $(warning *   There is already an official maintainer for $(HORIZON_BUILD)    *)
       $(warning *              Setting build type to COMMUNITY                      *)
       $(warning *    Please contact current official maintainer before distributing  *)
       $(warning *              the current build to the community.                   *)
       $(warning **********************************************************************)
       HORIZON_BUILD_TYPE := COMMUNITY
     endif
  endif
else
   ifeq ($(HORIZON_BUILD_TYPE), OFFICIAL)
     $(error **********************************************************)
     $(error *     A violation has been detected, aborting build      *)
     $(error **********************************************************)
   endif
  HORIZON_BUILD_TYPE := COMMUNITY
endif

ifdef HORIZON_MAINTAINER
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.horizon.maintainer=$(HORIZON_MAINTAINER)
endif

HORIZON_VERSION := HorizonDroid-$(HORIZON_BUILD_VERSION)-$(HORIZON_CODENAME)-$(CUSTOM_BUILD)-$(HORIZON_PLATFORM_VERSION)-$(HORIZON_BUILD_TYPE)-$(HORIZON_BUILD_DATE)

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.horizon.codename=$(HORIZON_CODENAME) \
    ro.horizon.build.date=$(BUILD_DATE) \
    ro.horizon.build_type=$(HORIZON_BUILD_TYPE) \
    ro.horizon.build_version=$(HORIZON_BUILD_VERSION) \
    ro.horizon.device=$(CUSTOM_BUILD) \
    ro.horizon.version=$(HORIZON_VERSION) \
    ro.horizon.maintainer=$(HORIZON_MAINTAINER)
