.PHONY: default
default:
include env.mk

ifdef USE_DOCKER
DOCKER:=$(shell which docker)
ifdef USE_ROOT
VERILATOR:=$(DOCKER) run --rm \
			-v $(PROJECT_ROOT):$(PROJECT_ROOT) \
			-w $(UART_TEST_DIR) \
			verilator/verilator:latest
else
VERILATOR:=$(DOCKER) run --rm \
			-v $(PROJECT_ROOT):$(PROJECT_ROOT) \
			-w $(UART_TEST_DIR) \
			unprivileged_verilator:latest
endif
endif

include ${TOOLS_DIR}/makefile/env.verilator-validation.mk
include ${TOOLS_DIR}/makefile/env.verilator.mk

SIM_FLAGS?=-DSIM
CONCURRENT?=$(shell nproc)

TEST_INCLUDE_FLAGS:=$(addprefix -I,${UART_INCLUDE_DIRS}) -I${UART_TEST_DIR}/include -I$(STD_TEST_INCLUDE_DIR)
TEST_SRC:=$(shell \find ${UART_TEST_DIR}/src -name "*.sv")
# remove tb_ prefix from testbench files
TEST_TARGETS:= $(subst tb_,,$(basename $(notdir ${TEST_SRC})))
RUN_TARGETS:=$(addprefix run_,$(TEST_TARGETS))

OUTDIR:=build

PARAMS_FILE:=
.PHONY: prepare
prepare: ${OUTDIR} ${PARAMS_FILE}
${OUTDIR}:
	mkdir -p ${OUTDIR}
${PARAMS_FILE}: ${CONFIG_GENERATOR}
	$(CONFIG_GENERATOR)

.PHONY: run
run: ${RUN_TARGETS}
	@echo "all tests done"

define TEST_RULE
.PHONY: run_$(1)
run_$(1): ${OUTDIR}/Vtb_$(1)
	cd ${OUTDIR} && ./Vtb_$(1)
endef

$(foreach test,$(TEST_TARGETS), $(eval $(call TEST_RULE,$(test))))
echo:
	@echo ${TEST_TARGETS}
	@echo ${UART_SRC_FILES}
	@echo ${UART_DIR}

build/Vtb_%: prepare ${UART_SRC_FILES} src/tb_%.sv
	$(VERILATOR) ${VERILATER_FLAGS} ${TEST_INCLUDE_FLAGS} ${SIM_FLAGS} ${UART_SRC_FILES} src/tb_$*.sv --top-module tb_$* -Mdir ${OUTDIR}

.PHONY: clean
clean:
	rm -rf ${OUTDIR}
