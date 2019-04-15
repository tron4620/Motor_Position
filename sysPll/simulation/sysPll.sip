set_global_assignment -entity "sysPll" -library "lib_sysPll" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "sysPll" -library "lib_sysPll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "sysPll" -library "lib_sysPll" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_sysPll" -name SPD_FILE [file join $::quartus(sip_path) "../sysPll.spd"]
set_global_assignment -library "lib_sysPll" -name MISC_FILE [file join $::quartus(sip_path) "../../sysPll.qsys"]

set_global_assignment -library "lib_sysPll" -name MISC_FILE [file join $::quartus(sip_path) "sysPll.v"]
set_global_assignment -library "lib_sysPll" -name MISC_FILE [file join $::quartus(sip_path) "submodules/sysPll_altclkctrl_0.v"]
