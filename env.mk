ifndef PROJECT_ENV
PROJECT_ENV:=1

include $(PROJECT_ROOT)/env.tools.mk

PROJECT_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

HARDWARE_DIR := $(PROJECT_ROOT)/hardware
SOFTWARE_DIR := $(PROJECT_ROOT)/software
SYNTHESIS_DIR := $(PROJECT_ROOT)/synthesis
TOOLS_DIR := $(PROJECT_ROOT)/tools

endif
