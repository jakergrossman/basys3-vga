# bitstream.tcl
# non-project script for bitstream generation

source script/common.tcl
set argstr "route_dcp top_module output_directory"
narg_check [info script] $argc $argstr

set route_dcp  [lindex $argv 0]
set top_module [lindex $argv 1]
set output_dir [lindex $argv 2]

banner "BITSTREAM::START"

open_checkpoint $route_dcp
write_bitstream -force $output_dir/$top_module.bit

banner "BITSTREAM::FINISH" "bitstream" $top_module.bit

exit
