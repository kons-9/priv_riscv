ifndef RISCV64_ENV
RISCV64_ENV:=1
RISCV64_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
RISCV64_INCLUDE_DIR := $(RISCV64_DIR)/include
RISCV64_SRC_DIR := $(RISCV64_DIR)/src
RISCV64_TEST_DIR := $(RISCV64_DIR)/test

RISCV64_INCLUDE_FILES := $(\find $(RISCV64_INCLUDE_DIR) -name "*.svh")
RISCV64_SRC_FILES := $(\find $(RISCV64_SRC_DIR) -name "*.sv")

PROJECT_ROOT := $(abspath $(shell git rev-parse --show-toplevel))
include $(PROJECT_ROOT)/env.mk

# add dependencies
include $(HARDWARE_DIR)/env.mk
RISCV64_INCLUDE_DIRS += $(STD_INCLUDE_DIR)
RISCV64_INCLUDE_FILES += $(STD_INCLUDE_FILES)

endif

