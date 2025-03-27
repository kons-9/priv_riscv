ifndef HARDWARE_ENV
HARDWARE_ENV:=1

HARDWARE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
UTILS_DIR := $(HARDWARE_DIR)/sv_utils

include $(UTILS_DIR)/Makefile.inc

endif
