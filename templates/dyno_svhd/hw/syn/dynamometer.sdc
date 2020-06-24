## Generated SDC file "tse_tutorial.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.1.2 Build 203 01/18/2017 SJ Lite Edition"

## DATE    "Mon Dec 10 00:06:02 2018"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]
create_clock -name {ENET1_RX_CLK} -period 8.000 -waveform { 0.000 4.000 } [get_ports {ENET1_RX_CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {CLOCK_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 5 -divide_by 2 -master_clock {CLOCK_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {pll_inst|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {pll_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {CLOCK_50} [get_pins {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -group [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[1]}] -group [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[2]}] -group [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[3]}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {altera_reserved_tdi}] -to [get_keepers {pzdyqx*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|command_config[9]}] -to [get_registers {*|altera_tse_mac_tx:U_TX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|mac_0[*]}] -to [get_registers {*|altera_tse_mac_tx:U_TX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|mac_1[*]}] -to [get_registers {*|altera_tse_mac_tx:U_TX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|mac_0[*]}] -to [get_registers {*|altera_tse_mac_rx:U_RX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|mac_1[*]}] -to [get_registers {*|altera_tse_mac_rx:U_RX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|frm_length[*]}] -to [get_registers {*|altera_tse_mac_rx:U_RX|*}]
set_false_path -from [get_registers {*|altera_tse_mac_rx:*|pause_quant_val*}] -to [get_registers {*|altera_tse_mac_tx:*|pause_latch*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|pause_quant_reg*}] -to [get_registers {*|altera_tse_mac_tx:U_TX|*}]
set_false_path -from [get_registers {*|altera_tse_register_map:U_REG|holdoff_quant*}] -to [get_registers {*|altera_tse_mac_tx:U_TX|*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|altera_tse_reset_synchronizer:*|altera_tse_reset_synchronizer_chain*|clrn}]


#**************************************************************
# Set Multicycle Path
#**************************************************************

set_multicycle_path -setup -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*}] -to [get_registers *] 5
set_multicycle_path -setup -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] -to [get_registers *] 5
set_multicycle_path -setup -end -from [get_registers *] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] 5
set_multicycle_path -hold -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*}] -to [get_registers *] 5
set_multicycle_path -hold -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] -to [get_registers *] 5
set_multicycle_path -hold -end -from [get_registers *] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] 5


#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from [get_registers *] -to [get_registers {*altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1}] 100.000
set_max_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 100.000
set_max_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_3|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 100.000
set_max_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_rx_min_ff:U_RXFF|altera_tse_a_fifo_opt_1246:RX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:RX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 100.000
set_max_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_13:TX_STATUS|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_13:TX_STATUS|altera_eth_tse_std_synchronizer_bundle:U_SYNC_2|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 100.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|dout_reg_sft*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|eop_sft*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|sop_reg*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -from [get_registers *] -to [get_registers {*altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1}] -100.000
set_min_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] -100.000
set_min_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_3|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] -100.000
set_min_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_rx_min_ff:U_RXFF|altera_tse_a_fifo_opt_1246:RX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:RX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] -100.000
set_min_delay -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_13:TX_STATUS|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_13:TX_STATUS|altera_eth_tse_std_synchronizer_bundle:U_SYNC_2|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] -100.000


#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Net Delay
#**************************************************************

set_net_delay -max 6.000 -from [get_pins -compatibility_mode {*|q}] -to [get_registers {*altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1}]
set_net_delay -max 6.000 -from [get_pins -compatibility_mode {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]|q}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}]
set_net_delay -max 6.000 -from [get_pins -compatibility_mode {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_WRT|g_out[*]|q}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_3|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}]
set_net_delay -max 6.000 -from [get_pins -compatibility_mode {*altera_tse_a_fifo_opt_1246:RX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]|q}] -to [get_registers {*altera_tse_a_fifo_opt_1246:RX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}]
set_net_delay -max 6.000 -from [get_pins -compatibility_mode {*altera_tse_a_fifo_13:TX_STATUS|altera_tse_gray_cnt:U_WRT|g_out[*]|q}] -to [get_registers {*altera_tse_a_fifo_13:TX_STATUS|altera_eth_tse_std_synchronizer_bundle:U_SYNC_2|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}]


#**************************************************************
# Set Max Skew
#**************************************************************

set_max_skew -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 7.500 
set_max_skew -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_opt_1246:TX_DATA|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:TX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_3|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 7.500 
set_max_skew -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_rx_min_ff:U_RXFF|altera_tse_a_fifo_opt_1246:RX_DATA|altera_tse_gray_cnt:U_RD|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_opt_1246:RX_DATA|altera_eth_tse_std_synchronizer_bundle:U_SYNC_1|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 7.500 
set_max_skew -from [get_registers {nios_system:system_inst|nios_system_tse:tse|altera_eth_tse_mac:i_tse_mac|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_a_fifo_13:TX_STATUS|altera_tse_gray_cnt:U_WRT|g_out[*]}] -to [get_registers {*altera_tse_a_fifo_13:TX_STATUS|altera_eth_tse_std_synchronizer_bundle:U_SYNC_2|altera_eth_tse_std_synchronizer:*|altera_std_synchronizer_nocut:*|din_s1*}] 7.500 


#**************************************************************
# Set Disable Timing
#**************************************************************

set_disable_timing -from * -to * [get_cells -hierarchical {QXXQ6833_0}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_0}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_1}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_2}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_3}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_4}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_5}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_6}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_7}]
set_disable_timing -from * -to * [get_cells -hierarchical {BITP7563_0}]
