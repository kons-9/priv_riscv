ifndef TOOLS_ENV
TOOLS_ENV:=1

PROJECT_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

VERILATOR_VERSION:=5.032

CONFIG_GENERATOR:=$(PROJECT_ROOT)/tools/config_generator/target/release/config_generator
CONFIG_GENERATOR_SRC:=$(shell find $(PROJECT_ROOT)/tools/config_generator/src -name "*.rs")
$(CONFIG_GENERATOR): $(CONFIG_GENERATOR_SRC)
	cd $(TOOLS_DIR)/config_generator && cargo build --release

endif
