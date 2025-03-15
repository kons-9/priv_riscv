ifndef PROJECT_ENV
PROJECT_ENV:=1

PROJECT_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(PROJECT_ROOT)/env.tools.mk

TOOLS_DIR := $(PROJECT_ROOT)/tools
HARDWARE_DIR := $(PROJECT_ROOT)/hardware
SOFTWARE_DIR := $(PROJECT_ROOT)/software
SYNTHESIS_DIR := $(PROJECT_ROOT)/synthesis

endif
