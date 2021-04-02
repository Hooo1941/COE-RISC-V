# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.cache/wt [current_project]
set_property parent.project_path C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/Qiu/Desktop/codlab/work/vivado/coe/riscv-studentnosorting.coe
add_files C:/Users/Qiu/Desktop/codlab/work/vivado/coe/prime.coe
read_verilog -library xil_defaultlib {
  C:/Users/Qiu/Desktop/codlab/work/vivado/MIO_BUS.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/MULTI_CH32.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/SEG7x16.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_defines.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_alu.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_controller.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_datapath.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_mem.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_parts.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_pipelined.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_regfile.v
  C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv_fpga_top.v
}
read_ip -quiet c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/memip/memip.xci
set_property used_in_implementation false [get_files -all c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/memip/memip_ooc.xdc]
set_property is_locked true [get_files c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/memip/memip.xci]

read_ip -quiet C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/imem/imem.xci
set_property used_in_implementation false [get_files -all c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/imem/imem_ooc.xdc]
set_property is_locked true [get_files C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/imem/imem.xci]

read_ip -quiet C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
set_property is_locked true [get_files C:/Users/Qiu/Desktop/codlab/work/vivado/xgriscv.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Qiu/Desktop/codlab/work/vivado/constraints/Nexys4DDR_CPU.xdc
set_property used_in_implementation false [get_files C:/Users/Qiu/Desktop/codlab/work/vivado/constraints/Nexys4DDR_CPU.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top IP2SOC_Top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef IP2SOC_Top.dcp

catch { report_utilization -file IP2SOC_Top_utilization_synth.rpt -pb IP2SOC_Top_utilization_synth.pb }
