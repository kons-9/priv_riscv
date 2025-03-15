ifndef VERILATOR-VALIDATION_ENV
VERILATOR-VALIDATION = 1

PROJECT_ROOT:=$(shell git rev-parse --show-toplevel)
include $(PROJECT_ROOT)/env.tools.mk

VERILATOR?=$(shell which verilator)
CURRENT_VERILATOR_VERSION:=$(shell $(VERILATOR) --version | grep -oP 'Verilator \K[0-9]+\.[0-9]+')
# check if verilator is >= 5
ifneq ($(findstring 5.,$(CURRENT_VERILATOR_VERSION)),5.)
$(error Verilator 5.0 or higher is required)
endif

# check if verilator version is equal to VERILATOR_VERSION
ifeq ($(CURRENT_VERILATOR_VERSION),$(VERILATOR_VERSION))
VERILATOR_VERSION_RELATED_FLAGS:=--quiet --assert --trace
else
VERILATOR_VERSION_RELATED_FLAGS:=
# just warning if verilator is not equal to VERILATOR_VERSION
$(warning Verilator version is $(CURRENT_VERILATOR_VERSION), not $(VERILATOR_VERSION). Some flags are not supported, and may cause errors)
endif

endif
