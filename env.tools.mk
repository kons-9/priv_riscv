ifndef TOOLS_ENV
TOOLS_ENV:=1

include env.mk

VERILATOR_VERSION:=5.032

CONFIG_GENERATOR:=$(TOOLS_DIR)/config_generator/target/release/config_generator
$(CONFIG_GENERATOR):
	cd $(TOOLS_DIR)/config_generator && cargo build --release

endif
