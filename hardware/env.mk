ifndef STD_ENV
STD_ENV:=1

HARDWARE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
STD_DIR := $(HARDWARE_DIR)/std

STD_INCLUDE_DIR := $(STD_DIR)/include
STD_TEST_INCLUDE_DIR := $(STD_DIR)/test/include

endif
