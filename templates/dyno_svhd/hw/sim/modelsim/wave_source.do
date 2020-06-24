config wave -signalnamewidth 2


set path_to_this_component "${hierarchical_path_to_dut}"


    add wave -noupdate  -group {tse_controller} -expand                          -radix hex $path_to_this_component/CLOCK
    add wave -noupdate  -group {tse_controller} -expand                          -radix hex $path_to_this_component/RESET_N
    
    add wave -noupdate  -group {tse_controller} -expand -group {driver_control}  -radix hex $path_to_this_component/SEND_PACKET
    add wave -noupdate  -group {tse_controller} -expand -group {driver_control}  -radix hex $path_to_this_component/MTU
    add wave -noupdate  -group {tse_controller} -expand -group {driver_control}  -radix hex $path_to_this_component/SPEED_SENSOR
    add wave -noupdate  -group {tse_controller} -expand -group {driver_control}  -radix hex $path_to_this_component/ADC

    add wave -noupdate  -group {tse_controller} -expand  -group {avalon-st}       -radix hex $path_to_this_component/AVALON_ST_SOURCE_IN_1
    add wave -noupdate  -group {tse_controller} -expand  -group {avalon-st}       -radix hex $path_to_this_component/AVALON_ST_SOURCE_OUT_1
    
    add wave -noupdate  -group {tse_controller} -expand  -group {avalon-mm}       -radix hex $path_to_this_component/AVALON_MM_MASTER_IN_1
    add wave -noupdate  -group {tse_controller} -expand  -group {avalon-mm}       -radix hex $path_to_this_component/AVALON_MM_MASTER_OUT_1

    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/Counter_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/next_state
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/Ip_Total_Len
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr1
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr3
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr2
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr5
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr4
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr7
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/ip_hdr6
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_01_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_02_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_03_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_04_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_11_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_12_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_21_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_31_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_41_xD
    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/chksum_xD
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/b1
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/b2
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/b3
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/c1
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/c2
#    add wave -noupdate  -group {tse_controller} -expand -group {internal_signals} -radix hex $path_to_this_component/c3

#### /tse_controller_tb/sum_func_arg1
#### /tse_controller_tb/sum_func_arg2
#### /tse_controller_tb/sum_func_arg3
#### /tse_controller_tb/sum_func_return
#### 
#### 
#### # /tse_controller_tb/dut_1/Tx_Ready_xSI
#### # /tse_controller_tb/dut_1/Tx_Error_xSO
#### # /tse_controller_tb/dut_1/Tx_Valid_xSO
#### # /tse_controller_tb/dut_1/Tx_Sop_xSO
#### # /tse_controller_tb/dut_1/Tx_Eop_xSO
#### # /tse_controller_tb/dut_1/Tx_Empty_xSO
#### # /tse_controller_tb/dut_1/Tx_Data_xD
#### # /tse_controller_tb/dut_1/Tx_Data_xDO


