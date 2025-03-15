.PHONY: default
default: prepare
THIS_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include env.mk

OUTDIR:=build

prepare: $(CONFIG_GENERATOR)
	mkdir -p ${OUTDIR}
	$(CONFIG_GENERATOR)

.PHONY: clean
clean:
	rm -rf ${OUTDIR}
