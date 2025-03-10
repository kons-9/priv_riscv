.PHONY: all
all: run

include ../env.mk
include ${PROJECT_ROOT}/env.verilator.mk

include $(HARDWARE_DIR)/riscv64/env.mk

SIM_FLAGS?=-DSIM
CONCURRENT?=$(shell nproc)

TEST_INCLUDE_FLAGS:=$(addprefix -I,${RISCV64_INCLUDE_DIRS}) -I${RISCV64_TEST_DIR}/include -I$(STD_TEST_INCLUDE_DIR)
TEST_SRC:=$(shell \find ${RISCV64_TEST_DIR}/src -name "*.sv")
# remove tb_ prefix from testbench files
TEST_TARGETS:= $(subst tb_,,$(basename $(notdir ${TEST_SRC})))
RUN_TARGETS:=$(addprefix run_,$(TEST_TARGETS))

echo:
	@echo ${RISCV64_DIR}
	@echo ${TEST_SRC}

OUTDIR:=build

.PHONY: run
run: ${RUN_TARGETS}
	@echo "all tests done"

define TEST_RULE
.PHONY: run_$(1)
run_$(1): ${OUTDIR}/Vtb_$(1)
	./$$<
endef

$(foreach test,$(TEST_TARGETS), $(eval $(call TEST_RULE,$(test))))

build/Vtb_%: ${VERILATOR_SRC} src/tb_%.sv
	$(VERILATOR5) ${VERILATER_FLAGS} ${TEST_INCLUDE_FLAGS} $^ --top-module tb_$* -Mdir ${OUTDIR}

.PHONY: clean
clean:
	rm -rf ${OUTDIR}
