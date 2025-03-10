ifndef VERILATOR_ENV
VERILATOR_ENV:=1

VERILATOR5:=$(shell which verilator)
# check if verilator version 5 is installed
# verilator --version => Verilator 5.
ifeq (,$(findstring Verilator 5.,$(shell $(VERILATOR5) --version)))
$(error Verilator 5 is not installed)
endif

VERILATOR_WARNINGS?=-Wall -Wno-PINCONNECTEMPTY -Wno-UNUSED -Wno-WIDTH -Wno-SELRANGE -Wno-DECLFILENAME
VERILATOR_SV?=-sv --assert --trace
VERILATOR_SV_TESTBENCH_FLAG?=--timing --binary -exe --main
VERILATOR_CPP_TESTBENCH_FLAG?=--exe --cc
VERILATOR_OPTIMIZATION_FLAG?=-O3 -MMD

ifdef USING_VERILATOR_CPP
VERILATER_FLAGS=$(VERILATOR_SV) $(VERILATOR_OPTIMIZATION_FLAG) $(VERILATOR_WARNINGS) $(VERILATOR_CPP_TESTBENCH_FLAG)
else
VERILATER_FLAGS=$(VERILATOR_SV) $(VERILATOR_OPTIMIZATION_FLAG) $(VERILATOR_WARNINGS) $(VERILATOR_SV_TESTBENCH_FLAG)
endif

endif
