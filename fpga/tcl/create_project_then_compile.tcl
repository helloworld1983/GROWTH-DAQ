set root_dir [pwd]

#############################################
# Check existence of subdirectories
#############################################
if { [ file exists sources ] == 1 } then {
  puts "sources directory found"
} else {
  puts "Error: sources subdirectory not found."
  exit
}

#############################################
# Create project
#############################################
create_project project $root_dir/project -part xc7a35tftg256-1 -force
set_property target_language VHDL [current_project]

add_files $root_dir/sources
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
update_compile_order -fileset sources_1

add_files -norecurse $root_dir/ip/fifo8x1k.xcix
add_files -norecurse $root_dir/ip/fifo9x1k.xcix
add_files -norecurse $root_dir/ip/fifo16x1k.xcix
add_files -norecurse $root_dir/ip/ram16x1024.xcix
add_files -norecurse $root_dir/ip/clk_wiz_0.xcix
add_files -norecurse $root_dir/ip/fifo16x2k.xcix
add_files -norecurse $root_dir/ip/fifo16x8k.xcix
add_files -norecurse $root_dir/ip/FIFO8x2kXilinx.xcix
add_files -norecurse $root_dir/ip/EventFIFO.xcix
add_files -norecurse $root_dir/ip/crcRomXilinx.xcix

export_ip_user_files -of_objects [get_files {$root_dir/ip/fifo8x1k/fifo8x1k.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/fifo9x1k/fifo9x1k.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/fifo16x1k/fifo16x1k.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/ram16x1024/ram16x1024.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/clk_wiz_0/clk_wiz_0.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/fifo16x2k/fifo16x2k.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/fifo16x8k/fifo16x8k.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/FIFO8x2kXilinx/FIFO8x2kXilinx.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/EventFIFO/EventFIFO.xci}] -force -quiet
export_ip_user_files -of_objects [get_files {$root_dir/ip/crcRomXilinx/crcRomXilinx.xci}] -force -quiet

update_compile_order -fileset sources_1

file mkdir $root_dir/project/project.srcs/constrs_1
add_files -fileset constrs_1 -norecurse $root_dir/constraint/GROWTH-FY2016_Bitstream.xdc
add_files -fileset constrs_1 -norecurse $root_dir/constraint/GROWTH-FY2016_Timing.xdc
add_files -fileset constrs_1 -norecurse $root_dir/constraint/GROWTH_FY2016_Pins.xdc

#############################################
# Build bitstream file
#############################################
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
