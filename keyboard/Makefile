# NVBoard + IVerilog Makefile

# How to use NVboard to sim:
# USE: a n c
# mk OR mk all OR mk default # = mk d(default)
# mk nvboard # = mk n(nvboard), start NVBoard
# mk clean	 # = mk c(clean), clean files
# OR:
# mk nvall   # = mk f(fpga all flow), = mk n c

# How to use iverilog to sim:
# USE: f o r w c
# mk ivfgene # = mk l(file list), Generate ivfilesf
# mk ivogene # = mk o(.out file), Generate $(TBTOPNAME).out
# mk ivsim	 # = mk r(run simulation), Run $(TBTOPNAME).out
# mk gtkwave # = mk w(show wave), Run gtkwave
# mk clean	 # = mk c(clean), clean files
# OR:
# mk ivall   # = mk i(iverilog all flow), = mk l o r w

FPGATOPNAME = top
TBTOPNAME = testbench
NXDC_FILES = constr/top.nxdc
INC_PATH ?=

VERILATOR = verilator
# verilator --trace --cc --exe --build -j 4 -Wall csrc/sim_top.cpp vsrc/doubleclick.v	
VERILATOR_CFLAGS += -MMD --trace --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert

IVERILOG = iverilog
IVERILOG_FLAGS += -g2005-sv
# Note: if need include dir or define names:
# +incdir+path
# +define+name=value

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(FPGATOPNAME)

IVBUILD_DIR = ./ivbuild

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS += $(SRC_AUTO_BIND)

# rules for NVBoard
include $(NVBOARD_HOME)/scripts/nvboard.mk

# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(FPGATOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(FPGATOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all: default
	# @echo "make all"
	# original mk all
	# verilator --trace --cc --exe --build -j 4 -Wall csrc/sim_top.cpp vsrc/doubleclick.v	

nvboard: $(BIN)
	@$^

ivfgene:
	find . -type f -regex ".*\.\(v\|sv\)" > $(IVBUILD_DIR)/ivfiles.f

ivogene:
	$(IVERILOG) $(IVERILOG_FLAGS) -o $(IVBUILD_DIR)/$(TBTOPNAME).out -f $(IVBUILD_DIR)/ivfiles.f -s $(TBTOPNAME)

# sim:
# 	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
# 	# @echo "make sim"
# 	./build/mux21

ivsim:
	vvp -n $(IVBUILD_DIR)/$(TBTOPNAME).out -l err.log >> $(IVBUILD_DIR)/ivrun.log
	# ./$(TBTOPNAME)

gtkwave:
	gtkwave $(IVBUILD_DIR)/dump.vcd &
	# gtkwave wave.vcd

nvall: default nvboard

ivall: ivfgene ivogene ivsim gtkwave
	
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(IVBUILD_DIR)/$(TBTOPNAME).out
	rm -f $(IVBUILD_DIR)/dump.vcd
	rm -f $(IVBUILD_DIR)/ivrun.log
	# rm -f wave.vcd

# include ../Makefile

d: default

n: nvboard

f: nvall

l: ivfgene

o: ivogene

r: ivsim

w: gtkwave

i: ivall

c: clean

.PHONY: default all run ivfgene ivogene ivsim gtkwave nvall ivall clean d n f l o r w i c

