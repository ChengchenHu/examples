set ip_proj_root [pwd]
set ip_proj_name "my_ip"
set ip_proj_top "my_ip"
set ip_proj_part "xc7z020clg484-1"
set ip_proj_company "my_company"

create_project $ip_proj_name $ip_proj_root -part $ip_proj_part -force
import_files $ip_proj_root/src/my_ip.v
set_property "top" $ip_proj_top [get_filesets sources_1]

ipx::package_project -root_dir $ip_proj_root
set_property library {user} [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property ip_repo_paths  $ip_proj_root [current_fileset]
update_ip_catalog

set_property vendor $ip_proj_company [ipx::current_core]
set_property name $ip_proj_name [ipx::current_core]
set_property display_name $ip_proj_name [ipx::current_core]
set_property description $ip_proj_name [ipx::current_core]

ipx::infer_bus_interfaces {{xilinx.com:interface:axis:1.0}} [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]

ipx::check_integrity -quiet [ipx::current_core]
ipx::archive_core $ip_proj_root/$ip_proj_name.zip [ipx::current_core]

close_project

file delete -force $ip_proj_root/$ip_proj_name.data $ip_proj_root/$ip_proj_name.srcs $ip_proj_root/xgui $ip_proj_root/component.xml $ip_proj_root/$ip_proj_name.xpr

