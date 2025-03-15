ifndef PROJECT_ENV
PROJECT_ENV:=1

include $(PROJECT_ROOT)/env.tools.mk

PROJECT_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
TOOLS_DIR := $(PROJECT_ROOT)/tools
HARDWARE_DIR := $(PROJECT_ROOT)/hardware
SOFTWARE_DIR := $(PROJECT_ROOT)/software
SYNTHESIS_DIR := $(PROJECT_ROOT)/synthesis

endif
