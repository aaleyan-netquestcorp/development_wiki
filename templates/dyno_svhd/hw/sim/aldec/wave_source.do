#config wave -signalnamewidth 2

set path_to_this_component "${hierarchical_path_to_dut}"

    wave -vgroup "dut"   -radix hex $path_to_this_component/CLOCK \
                                    $path_to_this_component/SEND_PACKET \
                                    $path_to_this_component/RESET_N \
                                    $path_to_this_component/ADC \
                                    $path_to_this_component/AVALON_ST_SOURCE_IN_1 \
                                    $path_to_this_component/AVALON_ST_SOURCE_OUT_1 \
                                    $path_to_this_component/AVALON_MM_MASTER_IN_1 \
                                    $path_to_this_component/AVALON_MM_MASTER_OUT_1 \
                                    $path_to_this_component/SPEED_SENSOR
     