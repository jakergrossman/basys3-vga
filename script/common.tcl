# common.tcl
# common TCL routines for other build scripts

proc narg_check {scriptname argc argstr args} {
    set nargs [llength $argstr]
    if { $argc != $nargs } {
	puts "ERROR: $scriptname: wrong number of arguments (got $argc, wanted $nargs)"
	puts "usage: $scriptname $argstr"
	exit [expr { [llength $args] > 0 ? [lindex $args 0] : 1}]
    }
}

# banner.tcl
# routines for printing banner text and files

# get screen size from stty, falling back to 25 rows by 80 columns
proc screen_sz { } {
    if {[auto_execok stty] != ""} {
	set sz [exec stty size]
	if { $sz != "0 0" } {
	    return [exec stty size]
	}
    }
    
    return "25 80"
}

# get screen width
proc screen_w { } {
    return [lindex [split [screen_sz] " "] 1]
}

# get screen height
proc screen_h { } {
    return [lindex [split [screen_sz] " "] 0]
}

# print '*' across width of screen
proc banner_hr { } {
    puts [string repeat "*" [screen_w]]
}


# print file list with label
proc banner_field {label args} {
    if {[llength $args] == 0} {
	return
    }

    set label_line [format "%s: " $label]
    set label_len  [string length $label_line]
    set prefix_len [expr max(16, $label_len)]
    set prefix [string repeat " " $prefix_len]
    set str [format "%-*s%s" $prefix_len $label_line [lindex $args 0]]
    foreach arg [lrange $args 1 end] {
	append str "\n$prefix$arg"
    }
    if {[llength $args] > 1} {
	append str "\n"
    }
    return $str
}

# print banner for FPGA build step
# @header: primary header text
# @args: alternating field names and arrays to print as fields
#
# Example: banner MYHEADER "single_value_field" "value" "multi_value_field" "value1 value2 value3"x
#
# ****************************************
# MYHEADER
# ****************************************
# single_value_field: value
# multi_value_field:  value1
#                     value2
#                     value3
# ****************************************
#
proc banner {header args} {
    set nargs [llength $args]
    if { $nargs % 2 != 0 } {
	puts "ERROR: odd number of args passed to banner"
	exit 1
    }
   
    banner_hr
    puts $header
    if {[llength $args] > 1} {
	banner_hr
    }
    
    set kpos 0
    set vpos 1
    while { $kpos < $nargs } {
	set key [lindex $args $kpos]
	set values [lindex $args $vpos]

	set prefix   [format "%s: " $key]
	set prefixsz [expr max(20, [string length $prefix])]
	set fmt      "%-*s%s"
	puts [format $fmt $prefixsz $prefix [lindex $values 0]]
	foreach val [lrange $values 1 end] {
	    puts [format $fmt $prefixsz "" $val]
	}
	incr kpos 2
	incr vpos 2
    }
    

    banner_hr
    puts ""
}
# message configuration
set_msg_config -severity "INFO" -suppress
