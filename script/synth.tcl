# synth.tcl
# non-project mode synthesis script
#
# usage: vivado -mode batch -source synth.tcl "rtl_files" constraint_file top_module part output_dir

if { $argc != 5 } {
    puts "ERROR: wrong number of arguments"
    puts "usage: synth.tcl \"rtl_files\" constraint_file top_module part output_die"
    exit 1
}

set rtl_files [lindex $argv 0]
set constraint_files [lindex $argv 1]
set top_module [lindex $argv 2]
set part [lindex $argv 3]
set output_dir [lindex $argv 4]

puts ">"
puts ">  **********************************"
puts ">  *         SYNTHESIS START        *"
puts ">  **********************************"
puts ">"
puts ">   rtl files:"
foreach rtl_file [split $rtl_files " "] {
    if {[file exists $rtl_file]} {
	puts ">                 $rtl_file"
    }
}
puts ">"
puts ">   constraints:"
foreach constraint_file [split $constraint_files " "] {
    if {[file exists $constraint_file]} {
	puts ">                 $constraint_file"
    }
}
puts ">"
puts ">   top module:   $top_module"
puts ">"
puts ">   part:         $part"
puts ">"
puts ">"


set_part $part

foreach rtl_file [split $rtl_files " "] {
    if {[file exists $rtl_file]} {
	read_vhdl $rtl_file
    }
}

foreach constraint_file [split $constraint_files " "] {
    if {[file exists $constraint_file]} {
	read_xdc $constraint_file
    }
}

puts ">"
puts ">  **********************************"
puts ">  *     SYNTHESIS::synth_design    *"
puts ">  **********************************"
puts ">"
synth_design -top $top_module

puts ">"
puts ">  **********************************"
puts ">  *   SYNTHESIS::write_checkpoint  *"
puts ">  **********************************"
puts ">"
write_checkpoint -force $output_dir/post_synth.dcp

puts ">"
puts ">  **********************************"
puts ">  *       SYNTHESIS COMPLETE       *"
puts ">  **********************************"
puts ">"
