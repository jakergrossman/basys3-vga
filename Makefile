TOP_MODULE   = vga_top
PART         = xc7a35tcpg236-1
BOARD        = basys3
OUTPUT_DIR   = BUILD

XILINX_ROOT  = /tools/xilinx/2025.1
VIVADO_CMD   = $(XILINX_ROOT)/Vivado/bin/vivado

RTL_SOURCES  = $(wildcard rtl/*.vhd)
CONSTRAINTS  = $(wildcard constraint/*.xdc)

SYNTH_DCP    = $(OUTPUT_DIR)/post_synth.dcp
IMPL_DCP     = $(OUTPUT_DIR)/post_route.dcp
BITSTREAM    = $(OUTPUT_DIR)/$(TOP_MODULE).bit

all: $(BITSTREAM)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

synth.tcl: TCL_ARGS := "$(RTL_SOURCES)" "$(CONSTRAINTS)" $(TOP_MODULE) $(PART) $(OUTPUT_DIR)
impl.tcl: TCL_ARGS := $(SYNTH_DCP) $(OUTPUT_DIR)
bitstream.tcl: TCL_ARGS := $(IMPL_DCP) $(OUTPUT_DIR) $(TOP_MODULE)

$(SYNTH_DCP): $(OUTPUT_DIR) synth.tcl
$(IMPL_DCP): $(SYNTH_DCP) impl.tcl
$(BITSTREAM): $(IMPL_DCP) bitstream.tcl

clean:
	rm -rf $(OUTPUT_DIR)
	rm -rf .Xil
	rm -f *.jou *.log

%.tcl: script/%.tcl
	$(VIVADO_CMD) -mode batch -notrace -source $< \
	  -journal $(OUTPUT_DIR)/$*.jou -log $(OUTPUT_DIR)/$*.log \
	  -tclargs $(TCL_ARGS)
