
add wave -noreg -vgroup {test} {/tse_controller_tb/dut_1/Start_xS}

add wave -vgroup "test_bench" -radix hex /tse_controller_tb/avalon_st_bus
#to_avalonst_source
#add wave -vgroup "test_bench" -radix hex /tse_controller_tb/from_avalonst_source


set hierarchical_path_to_dut "/tse_controller_tb/dut_1"
source "./wave_source.do"

# help wave

