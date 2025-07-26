# impl.tcl
# non-project script for implementation

if { $argc != 2 } {
    puts "ERROR: invalid number of arguments"
    puts "usage: impl.tcl synth_dcp output_dir"
    exit 1
}

set synth_dcp  [lindex $argv 0]
set output_dir [lindex $argv 1]

puts ">"
puts ">  **********************************"
puts ">  *         IMPLEMENTATION         *"
puts ">  **********************************"
puts ">"
puts ">   synth input: $synth_dcp"
puts ">"
puts ">"

open_checkpoint $synth_dcp

puts ">"
puts ">  **********************************"
puts ">  *   IMPLEMENTATION::opt_design   *"
puts ">  **********************************"
puts ">"
opt_design

puts ">"
puts ">  **********************************"
puts ">  *  IMPLEMENTATION::route_design  *"
puts ">  **********************************"
puts ">"
route_design

puts ">"
puts ">  **********************************"
puts ">  *    IMPLEMENTATION::reports     *"
puts ">  **********************************"
puts ">"
report_timing_summary -file $output_dir/timing_summary.rpt
report_utilization -file $output_dir/utilization.rpt

puts ">>> writing checkpoint"
puts ">"
puts ">  **********************************"
puts ">  *   IMPLEMENTATION::checkpoint   *"
puts ">  **********************************"
puts ">"
write_checkpoint -force $output_dir/post_route.dcp

puts ">"
puts ">  **********************************"
puts ">  *    IMPLEMENTATION COMPLETE     *"
puts ">  **********************************"
puts ">"
