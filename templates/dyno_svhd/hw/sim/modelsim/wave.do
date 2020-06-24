

add wave -group {test_bench} -expand -group {clocks and resets} -radix hex /tse_controller_tb/to_avalonst_source

set hierarchical_path_to_dut "/tse_controller_tb/dut_1"
source "./wave_source.do"

# add wave -group {nios_system_inst} -expand -group {clocks and resets} -radix hex /tse_controller_tb/nios_system_inst/clk_clk
# add wave -group {nios_system_inst} -expand -group {clocks and resets} -radix hex /tse_controller_tb/nios_system_inst/reset_reset_n
# 
# add wave -group {nios_system_inst} -expand -group {mdio} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_mdio_connection_mdc
# add wave -group {nios_system_inst} -expand -group {mdio} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_mdio_connection_mdio_in
# add wave -group {nios_system_inst} -expand -group {mdio} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_mdio_connection_mdio_out
# add wave -group {nios_system_inst} -expand -group {mdio} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_mdio_connection_mdio_oen
# 
# add wave -group {nios_system_inst} -expand -group {rmgi} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_rgmii_connection_rgmii_in
# add wave -group {nios_system_inst} -expand -group {rmgi} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_rgmii_connection_rgmii_out
# add wave -group {nios_system_inst} -expand -group {rmgi} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_rgmii_connection_rx_control
# add wave -group {nios_system_inst} -expand -group {rmgi} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_rgmii_connection_tx_control
# 
# add wave -group {nios_system_inst} -expand -group {status} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_status_connection_set_10
# add wave -group {nios_system_inst} -expand -group {status} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_status_connection_set_1000
# add wave -group {nios_system_inst} -expand -group {status} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_status_connection_eth_mode
# add wave -group {nios_system_inst} -expand -group {status} -radix hex /tse_controller_tb/nios_system_inst/tse_mac_status_connection_ena_10
# 
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_address
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_readdata
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_read
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_writedata
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_write
# add wave -group {nios_system_inst} -expand -group {control} -radix hex /tse_controller_tb/nios_system_inst/tse_mm_control_port_waitrequest
# 
# add wave -group {nios_system_inst} -expand -group {pcs rx clock}  /tse_controller_tb/nios_system_inst/tse_pcs_mac_rx_clock_connection_clk
# add wave -group {nios_system_inst} -expand -group {pcs tx clock}  /tse_controller_tb/nios_system_inst/tse_pcs_mac_tx_clock_connection_clk
# add wave -group {nios_system_inst} -expand -group {receive clock} /tse_controller_tb/nios_system_inst/tse_receive_clock_connection_clk
# 
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_data
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_endofpacket
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_error
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_empty
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_ready
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_startofpacket
# add wave -group {nios_system_inst} -expand -group {st_rx} -radix hex  /tse_controller_tb/nios_system_inst/tse_rx_avalon_st_valid

# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_data
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_endofpacket
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_error
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_empty
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_ready
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_startofpacket
# add wave -group {nios_system_inst} -expand -group {st_tx} -radix hex  /tse_controller_tb/nios_system_inst/tse_tx_avalon_st_valid
# 
# add wave -group {nios_system_inst} -expand -group {rst controller} -radix hex  /tse_controller_tb/nios_system_inst/rst_controller_reset_out_reset
# 
# 
# 
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/areset
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/inclk0
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/c0
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/c1
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/c2
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/c3
# add wave -group {pll} -radix hex  /tse_controller_tb/pll_inst/locked


