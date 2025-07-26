if { $argc != 3 } {
    puts "ERROR: invalid number of arguments"
    puts "usage: bistream.tcl route_dcp output_dir top_module"
    exit 1
}

set route_dcp [lindex $argv 0]
set output_dir [lindex $argv 1]
set top_module [lindex $argv 2]

puts ">"
puts ">  **********************************"
puts ">  *       BITSTREAM GENERATION     *"
puts ">  **********************************"
puts ">"

open_checkpoint $route_dcp
write_bitstream -force $output_dir/$top_module.bit

puts ">"
puts ">  **********************************"
puts ">  * BITSTREAM GENERATION COMPLETE  *"
puts ">  **********************************"
puts ">"
puts ">  bitstream: $top_module.bit"
puts ">"
puts ">"
