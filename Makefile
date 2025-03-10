.PHONY: all
all: prepare
include env.mk

FORMAT_SRC:=$(shell \find $(HARDWARE_DIR) -name "*.sv" -o -name "*.v" -o -name "*.svh" -o -name "*.vh")

.PHONY: prepare
prepare: verible.filelist

.PHONY: format
format: prepare
	verible-verilog-format --indentation_spaces=4 --column_limit=100 --inplace $(FORMAT_SRC)

.PHONY: lint
lint: prepare
	verible-verilog-lint $(FORMAT_SRC)

############################################
# filelist for verible
############################################
verible.filelist: $(FORMAT_SRC)
	echo $^ | tr ' ' '\n' | sort  > "verible.filelist"
