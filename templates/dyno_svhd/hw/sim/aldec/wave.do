
wave -vgroup {test_bench} -radix hex /tse_controller_tb/dut_1/Start_xS \
									 /tse_controller_tb/avalon_st_bus \
									 /tse_controller_tb/avalon_mm_bus


set hierarchical_path_to_dut "/tse_controller_tb/dut_1"
source "./wave_source.do"

# help wave

