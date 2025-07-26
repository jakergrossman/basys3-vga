# synth.tcl
# non-project mode synthesis script

source script/common.tcl

set argstr "\"rtl_files\" \"constraint_files\" top_module part_id output_directory"
narg_check [info script] $argc $argstr

set rtl_files        [lindex $argv 0]
set constraint_files [lindex $argv 1]
set top_module       [lindex $argv 2]
set part             [lindex $argv 3]
set output_dir       [lindex $argv 4]

banner "SYNTHESIS::BEGIN" \
    "top_module" $top_module \
    "part" $part \
    "rtl_files" [split $rtl_files " "] \
    "constraints" [split $constraint_files " "]

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

banner "SYNTHESIS::synth_design"
synth_design -top $top_module

banner "SYNTHESIS::write_checkpoint"
write_checkpoint -force $output_dir/post_synth.dcp

banner "SYNTHESIS::FINISH"

exit
