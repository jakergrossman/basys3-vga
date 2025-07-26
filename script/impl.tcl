# impl.tcl
# non-project script for implementation

source script/common.tcl

set argstr "synth_dcp output_dir"
narg_check [info script] $argc $argstr

set synth_dcp  [lindex $argv 0]
set output_dir [lindex $argv 1]

banner "IMPLEMENTATION::BEGIN" \
    "synth input" $synth_dcp

open_checkpoint $synth_dcp

banner "IMPLEMENTATION::opt_design"
opt_design

banner "IMPLEMENTATION::route_design"
route_design

banner "IMPLEMENTATION::reports" \
    "timing" $output_dir/timing_summary.rpt \
    "utilization" $output_dir/utilization.rpt

report_timing_summary -file $output_dir/timing_summary.rpt
report_utilization -file $output_dir/utilization.rpt

banner "IMPLEMENTATION::write_checkpoint" \
    "checkpoint" $output_dir/post_route.dcp

write_checkpoint -force $output_dir/post_route.dcp

banner "IMPLEMENTATION::FINISH"

exit
