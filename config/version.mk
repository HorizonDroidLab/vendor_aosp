#
# Copyright (C) 2024 HorizonDroid
#
# SPDX-License-Identifier: Apache-2.0
#

HORIZON_REVISION := v2.3
HORIZON_CODENAME := Lynx
HORIZON_BUILD_DATE := $(shell date +"%d%m%Y-%H%M")

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
       HORIZON_BUILD_TYPE := UNOFFICIAL
     else
       $(warning **********************************************************************)
       $(warning *   There is already an official maintainer for $(HORIZON_BUILD)    *)
       $(warning *              Setting build type to UNOFFICIAL                      *)
       $(warning *    Please contact current official maintainer before distributing  *)
       $(warning *              the current build to the community.                   *)
       $(warning **********************************************************************)
       HORIZON_BUILD_TYPE := UNOFFICIAL
     endif
  endif
else
   ifeq ($(HORIZON_BUILD_TYPE), OFFICIAL)
     $(error **********************************************************)
     $(error *     A violation has been detected, aborting build      *)
     $(error **********************************************************)
   endif
  HORIZON_BUILD_TYPE := UNOFFICIAL
endif

ifdef HORIZON_MAINTAINER
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   org.horizon.maintainer=$(HORIZON_MAINTAINER)
endif

HORIZON_VERSION := HorizonDroid-$(HORIZON_REVISION)-$(HORIZON_BUILD)-$(HORIZON_BUILD_TYPE)-$(HORIZON_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    org.horizon.build.date=$(HORIZON_BUILD_DATE) \
    org.horizon.build.type=$(HORIZON_BUILD_TYPE) \
    org.horizon.codename=$(HORIZON_CODENAME) \
    org.horizon.device=$(HORIZON_BUILD) \
    org.horizon.revision=$(HORIZON_REVISION) \
    org.horizon.version=$(HORIZON_VERSION)
