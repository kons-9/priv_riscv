ifndef UART_ENV
UART_ENV:=1

UART_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))/../
UART_INCLUDE_DIRS := $(UART_DIR)/include
UART_SRC_DIR := $(UART_DIR)/src
UART_TEST_DIR := $(UART_DIR)/test

UART_INCLUDE_FILES := $(shell \find $(UART_INCLUDE_DIR) -name "*.svh")
UART_SRC_FILES := $(shell \find $(UART_SRC_DIR) -name "*.sv")

PROJECT_ROOT := $(abspath $(shell git rev-parse --show-toplevel))
include $(PROJECT_ROOT)/env.mk

# add dependencies
include $(HARDWARE_DIR)/env.mk
UART_INCLUDE_DIRS += $(STD_INCLUDE_DIR)
UART_INCLUDE_FILES += $(STD_INCLUDE_FILES)

endif
