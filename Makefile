TOP_MODULE   = vga_top
PART         = xc7a35tcpg236-1
BOARD        = basys3
OUTPUT_DIR   = BUILD

XILINX_ROOT  = /tools/xilinx/2025.1
VIVADO_EXE   = $(XILINX_ROOT)/Vivado/bin/vivado
define TCL
$(VIVADO_EXE) -mode batch -notrace -source script/$(1).tcl \
  -journal $(OUTPUT_DIR)/$(1).jou -log $(OUTPUT_DIR)/$(1).log \
  -tclargs
endef

RTL_SOURCES  = $(wildcard rtl/*.vhd)
CONSTRAINTS  = $(wildcard constraint/*.xdc)

SYNTH_DCP    = $(OUTPUT_DIR)/post_synth.dcp
IMPL_DCP     = $(OUTPUT_DIR)/post_route.dcp
BITSTREAM    = $(OUTPUT_DIR)/$(TOP_MODULE).bit

.FORCE: bitstream synthesis implementation bitstream

all: bitstream

synthesis: $(SYNTH_DCP)
implementation: $(IMPL_DCP)
bitstream: $(BITSTREAM)

clean:
	rm -rf $(OUTPUT_DIR)
	rm -rf .Xil
	rm -f *.jou *.log

$(SYNTH_DCP): $(RTL_SOURCES) $(CONSTRAINTS) | $(OUTPUT_DIR)
	$(call TCL,synth) "$(RTL_SOURCES)" "$(CONSTRAINTS)" $(TOP_MODULE) $(PART) $(OUTPUT_DIR) \
	  && touch $@ # ensure timestamp is updated

$(IMPL_DCP): synthesis
	$(call TCL,impl) $(SYNTH_DCP) $(OUTPUT_DIR) \
	  && touch $@ # ensure timestamp is updated

$(BITSTREAM): implementation
	$(call TCL,bitstream) $(IMPL_DCP) $(TOP_MODULE) $(OUTPUT_DIR) \
	  && touch $@ # ensure timestamp is updated
