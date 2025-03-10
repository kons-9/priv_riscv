.PHONY: all
all: prepare
include env.mk

FORMAT_SRC:=$(shell \find $(HARDWARE_DIR) -name "*.sv" -o -name "*.v")

.PHONY: prepare
prepare: verible.filelist

############################################
# filelist for verible
############################################
verible.filelist: $(FORMAT_SRC)
	echo $^ | tr ' ' '\n' | sort  > "verible.filelist"
