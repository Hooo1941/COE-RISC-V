proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.cache/wt [current_project]
  set_property parent.project_path C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.xpr [current_project]
  set_property ip_output_repo C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.runs/synth_1/IP2SOC_Top.dcp
  read_ip -quiet C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/imem/imem.xci
  set_property is_locked true [get_files C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/imem/imem.xci]
  read_ip -quiet C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
  set_property is_locked true [get_files C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
  read_xdc C:/Users/Qiu/Desktop/codlab/work/vivado/constraints/Nexys4DDR_CPU.xdc
  link_design -top IP2SOC_Top -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force IP2SOC_Top_opt.dcp
  catch { report_drc -file IP2SOC_Top_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force IP2SOC_Top_placed.dcp
  catch { report_io -file IP2SOC_Top_io_placed.rpt }
  catch { report_utilization -file IP2SOC_Top_utilization_placed.rpt -pb IP2SOC_Top_utilization_placed.pb }
  catch { report_control_sets -verbose -file IP2SOC_Top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force IP2SOC_Top_routed.dcp
  catch { report_drc -file IP2SOC_Top_drc_routed.rpt -pb IP2SOC_Top_drc_routed.pb -rpx IP2SOC_Top_drc_routed.rpx }
  catch { report_methodology -file IP2SOC_Top_methodology_drc_routed.rpt -rpx IP2SOC_Top_methodology_drc_routed.rpx }
  catch { report_power -file IP2SOC_Top_power_routed.rpt -pb IP2SOC_Top_power_summary_routed.pb -rpx IP2SOC_Top_power_routed.rpx }
  catch { report_route_status -file IP2SOC_Top_route_status.rpt -pb IP2SOC_Top_route_status.pb }
  catch { report_clock_utilization -file IP2SOC_Top_clock_utilization_routed.rpt }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file IP2SOC_Top_timing_summary_routed.rpt -rpx IP2SOC_Top_timing_summary_routed.rpx }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force IP2SOC_Top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

