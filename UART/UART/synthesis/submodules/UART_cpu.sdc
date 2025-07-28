# Legal Notice: (C)2024 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_internal_jtag|tckutap}
#set_clock_groups -asynchronous -group {altera_internal_jtag|tckutap}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	UART_cpu 	UART_cpu:*
set 	UART_cpu_oci 	UART_cpu_nios2_oci:the_UART_cpu_nios2_oci
set 	UART_cpu_oci_break 	UART_cpu_nios2_oci_break:the_UART_cpu_nios2_oci_break
set 	UART_cpu_ocimem 	UART_cpu_nios2_ocimem:the_UART_cpu_nios2_ocimem
set 	UART_cpu_oci_debug 	UART_cpu_nios2_oci_debug:the_UART_cpu_nios2_oci_debug
set 	UART_cpu_wrapper 	UART_cpu_jtag_debug_module_wrapper:the_UART_cpu_jtag_debug_module_wrapper
set 	UART_cpu_jtag_tck 	UART_cpu_jtag_debug_module_tck:the_UART_cpu_jtag_debug_module_tck
set 	UART_cpu_jtag_sysclk 	UART_cpu_jtag_debug_module_sysclk:the_UART_cpu_jtag_debug_module_sysclk
set 	UART_cpu_oci_path 	 [format "%s|%s" $UART_cpu $UART_cpu_oci]
set 	UART_cpu_oci_break_path 	 [format "%s|%s" $UART_cpu_oci_path $UART_cpu_oci_break]
set 	UART_cpu_ocimem_path 	 [format "%s|%s" $UART_cpu_oci_path $UART_cpu_ocimem]
set 	UART_cpu_oci_debug_path 	 [format "%s|%s" $UART_cpu_oci_path $UART_cpu_oci_debug]
set 	UART_cpu_jtag_tck_path 	 [format "%s|%s|%s" $UART_cpu_oci_path $UART_cpu_wrapper $UART_cpu_jtag_tck]
set 	UART_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $UART_cpu_oci_path $UART_cpu_wrapper $UART_cpu_jtag_sysclk]
set 	UART_cpu_jtag_sr 	 [format "%s|*sr" $UART_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$UART_cpu_oci_break_path|break_readreg*] -to [get_keepers *$UART_cpu_jtag_sr*]
set_false_path -from [get_keepers *$UART_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$UART_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$UART_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$UART_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$UART_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$UART_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$UART_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$UART_cpu_jtag_sr*]
set_false_path -from *$UART_cpu_jtag_sr*    -to *$UART_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$UART_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$UART_cpu_oci_debug_path|monitor_go
